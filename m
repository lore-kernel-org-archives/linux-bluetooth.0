Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1919373.99Va0DTt5V@athlon>
References: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
	<1919373.99Va0DTt5V@athlon>
Date: Mon, 30 Dec 2013 15:34:26 +0200
Message-ID: <CABBYNZKB=avGuPqhAzG2Wfgn+ZuFjbKBXK_Vk8gGGuLfLy4s3Q@mail.gmail.com>
Subject: Re: [RFC BlueZ 1/9] android: Add initial code for audio IPC
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 30, 2013 at 3:26 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> Hi Luiz,
>
> On Monday 30 December 2013 14:34:07 Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This add initial code for listen and accept connections on the abstract
>> socket defined for the audio IPC.
>> ---
>>  android/hal-msg.h |  1 +
>>  android/ipc.c     | 53
>> +++++++++++++++++++++++++++++++++++++++++++++++------ android/ipc.h     |
>> 3 +++
>>  3 files changed, 51 insertions(+), 6 deletions(-)
>>
>> diff --git a/android/hal-msg.h b/android/hal-msg.h
>> index c351501..b14eced 100644
>> --- a/android/hal-msg.h
>> +++ b/android/hal-msg.h
>> @@ -24,6 +24,7 @@
>>  #define BLUEZ_HAL_MTU 1024
>>
>>  static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
>> +static const char BLUEZ_AUDIO_SK_PATH[] = "\0bluez_audio_socket";
>>
>>  struct hal_hdr {
>>       uint8_t  service_id;
>> diff --git a/android/ipc.c b/android/ipc.c
>> index 9e8ccc3..6cdbf60 100644
>> --- a/android/ipc.c
>> +++ b/android/ipc.c
>> @@ -49,6 +49,7 @@ static struct service_handler services[HAL_SERVICE_ID_MAX
>> + 1];
>>
>>  static GIOChannel *cmd_io = NULL;
>>  static GIOChannel *notif_io = NULL;
>> +static GIOChannel *audio_io = NULL;
>>
>>  static void ipc_handle_msg(const void *buf, ssize_t len)
>>  {
>> @@ -145,7 +146,8 @@ static gboolean notif_watch_cb(GIOChannel *io,
>> GIOCondition cond, return FALSE;
>>  }
>>
>> -static GIOChannel *connect_hal(GIOFunc connect_cb)
>> +static GIOChannel *connect_hal(const char *path, size_t size,
>> +                                                     GIOFunc connect_cb)
>>  {
>>       struct sockaddr_un addr;
>>       GIOCondition cond;
>> @@ -167,11 +169,11 @@ static GIOChannel *connect_hal(GIOFunc connect_cb)
>>       memset(&addr, 0, sizeof(addr));
>>       addr.sun_family = AF_UNIX;
>>
>> -     memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
>> +     memcpy(addr.sun_path, path, size);
>>
>>       if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
>> -             error("IPC: failed to connect HAL socket: %d (%s)", errno,
>> -                                                     strerror(errno));
>> +             error("IPC: failed to connect HAL socket %s: %d (%s)", &path[1],
>> +                                                     errno, strerror(errno));
>>               g_io_channel_unref(io);
>>               return NULL;
>>       }
>> @@ -218,7 +220,8 @@ static gboolean cmd_connect_cb(GIOChannel *io,
>> GIOCondition cond, return FALSE;
>>       }
>>
>> -     notif_io = connect_hal(notif_connect_cb);
>> +     notif_io = connect_hal(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
>> +                                                     notif_connect_cb);
>>       if (!notif_io)
>>               raise(SIGTERM);
>>
>> @@ -227,7 +230,8 @@ static gboolean cmd_connect_cb(GIOChannel *io,
>> GIOCondition cond,
>>
>>  void ipc_init(void)
>>  {
>> -     cmd_io = connect_hal(cmd_connect_cb);
>> +     cmd_io = connect_hal(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
>> +                                                     cmd_connect_cb);
>>       if (!cmd_io)
>>               raise(SIGTERM);
>>  }
>> @@ -338,3 +342,40 @@ void ipc_unregister(uint8_t service)
>>       services[service].handler = NULL;
>>       services[service].size = 0;
>>  }
>> +
>> +static gboolean audio_connect_cb(GIOChannel *io, GIOCondition cond,
>> +                                                     gpointer user_data)
>> +{
>> +     DBG("");
>> +
>> +     if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
>> +             error("Audio IPC: socket connect failed, terminating");
>
> This message is misleading since we should raise(SIGTERM) to terminate.
>
> But I wonder if we should really terminate on audio IPC failure...
> That is failing on IPC error is OK (since that is a bug in our code anyway),
> but on not being able to connect we could simply fail to register a2dp HAL.
> Same goes with socket being closed - in such case we could fail any request to
> a2dp HAL until connection is recovered.

Yep, the terminating part of the message is misleading it should not
really exit just fail to initialize a2dp.

>> +             audio_ipc_cleanup();
>> +             return FALSE;
>> +     }
>> +
>> +     cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
>> +
>> +     g_io_add_watch(audio_io, cond, cmd_watch_cb, NULL);
>> +
>> +     info("Audio IPC: successfully connected");
>> +
>> +     return FALSE;
>> +}
>> +
>> +void audio_ipc_init(void)
>> +{
>> +     audio_io = connect_hal(BLUEZ_AUDIO_SK_PATH, sizeof(BLUEZ_AUDIO_SK_PATH),
>> +                                                     audio_connect_cb);
>> +     if (!cmd_io)
>
> audio_io here?

Yep, that is a bug.

-- 
Luiz Augusto von Dentz
