Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140103105642.GA9809@aemeltch-MOBL1>
References: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
	<20140103105642.GA9809@aemeltch-MOBL1>
Date: Fri, 3 Jan 2014 13:09:16 +0200
Message-ID: <CABBYNZ+SZBURBr+UxZVgDakHRa0e2MtkudWHJEi+dZKSCdUd8A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 01/10] android/ipc: Add initial code for audio IPC
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jan 3, 2014 at 12:56 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Luiz,
>
> On Thu, Jan 02, 2014 at 01:58:25PM +0200, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This add initial code for listen and accept connections on the abstract
>> socket defined for the audio IPC.
>> ---
>> v2: Split audio IPC services for HAL services and fix invalid messages or
>> disconnections causing the daemon to exit. The audio HAL is independent of
>> bluetooth and should only affect A2DP service.
>>
>>  android/hal-msg.h |  1 +
>>  android/ipc.c     | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>>  android/ipc.h     |  3 +++
>>  3 files changed, 76 insertions(+), 6 deletions(-)
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
>> index 9e8ccc3..4c5a77e 100644
>> --- a/android/ipc.c
>> +++ b/android/ipc.c
>> @@ -49,6 +49,7 @@ static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
>>
>>  static GIOChannel *cmd_io = NULL;
>>  static GIOChannel *notif_io = NULL;
>> +static GIOChannel *audio_io = NULL;
>>
>>  static void ipc_handle_msg(const void *buf, ssize_t len)
>>  {
>> @@ -145,7 +146,8 @@ static gboolean notif_watch_cb(GIOChannel *io, GIOCondition cond,
>>       return FALSE;
>>  }
>>
>> -static GIOChannel *connect_hal(GIOFunc connect_cb)
>> +static GIOChannel *ipc_connect(const char *path, size_t size,
>> +                                                     GIOFunc connect_cb)
>>  {
>
> Does it make sense for better understanding to split patch to two parts:
> one is changing connect_hal to ipc_connect and another adding audio ipc?

Well, it is quite self contained and the functionality doesn't change
much as Im just passing the path of the socket to function that is
static instead of copying connect_hal so I considered it too trivial
to have it separated. Note that sometimes we do bother to split even
trivial changes when the patches get way too big and convoluted to be
able to spot this minor details, this patch though has less than 100
lines changes.

-- 
Luiz Augusto von Dentz
