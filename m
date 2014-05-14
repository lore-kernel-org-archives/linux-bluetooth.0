Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140514082120.GC27218@aemeltch-MOBL1>
References: <1400001769-6690-1-git-send-email-luiz.dentz@gmail.com>
	<20140514082120.GC27218@aemeltch-MOBL1>
Date: Wed, 14 May 2014 12:55:34 +0300
Message-ID: <CABBYNZLA89ybWJWjBS36AJ1HMuYJzVozU3TZ2ZeZ_=VEeHPuDQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] android/handsfree: Fix Connect SCO command
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, May 14, 2014 at 11:21 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Luiz,
>
> On Tue, May 13, 2014 at 08:22:49PM +0300, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This command should not trigger SCO connection since there is already a
>> command Connect Audio dedicated to do that.
>
> Do you handle incoming connections?
>
> Best regards
> Andrei Emeltchenko
>
>> ---
>>  android/handsfree.c | 53 ++++++++++++++++++++++++-----------------------------
>>  1 file changed, 24 insertions(+), 29 deletions(-)
>>
>> diff --git a/android/handsfree.c b/android/handsfree.c
>> index cb5e657..7ca0ba8 100644
>> --- a/android/handsfree.c
>> +++ b/android/handsfree.c
>> @@ -861,30 +861,6 @@ done:
>>       hfp_gw_send_info(device.gw, "+BCS: %u", type);
>>  }
>>
>> -static void send_sco_fd(GIOChannel *chan)
>> -{
>> -     if (sco_ipc) {
>> -             int fd = g_io_channel_unix_get_fd(chan);
>> -             GError *err = NULL;
>> -             uint16_t mtu = 48;
>> -             struct sco_rsp_connect rsp;
>> -
>> -             if (!bt_io_get(chan, &err, BT_IO_OPT_MTU, &mtu,
>> -                                                     BT_IO_OPT_INVALID)) {
>> -                     error("Unable to get MTU: %s\n", err->message);
>> -                     g_clear_error(&err);
>> -             }
>> -
>> -             DBG("fd %d mtu %u", fd, mtu);
>> -
>> -             rsp.mtu = mtu;
>> -
>> -             ipc_send_rsp_full(sco_ipc, SCO_SERVICE_ID,
>> -                                     SCO_OP_CONNECT, sizeof(rsp), &rsp,
>> -                                     fd);
>> -     }
>> -}
>> -
>>  static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
>>  {
>>       if (err) {
>> @@ -914,7 +890,6 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
>>                                                       sco_watch_cb, NULL);
>>
>>       device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
>> -     send_sco_fd(chan);
>>  }
>>
>>  static bool connect_sco(void)
>> @@ -2592,14 +2567,34 @@ static void disable_sco_server(void)
>>
>>  static void bt_sco_connect(const void *buf, uint16_t len)
>>  {
>> +     int fd;
>> +     GError *err;
>> +     struct sco_rsp_connect rsp;
>> +
>>       DBG("");
>>
>> -     if (device.sco) {
>> -             send_sco_fd(device.sco);
>> -             return;
>> +     if (!device.sco)
>> +             goto failed;
>> +
>> +     err = NULL;
>> +     if (!bt_io_get(device.sco, &err, BT_IO_OPT_MTU, &rsp.mtu,
>> +                                                     BT_IO_OPT_INVALID)) {
>> +             error("Unable to get MTU: %s\n", err->message);
>> +             g_clear_error(&err);
>> +             goto failed;
>>       }
>>
>> -     connect_audio();
>> +     fd = g_io_channel_unix_get_fd(device.sco);
>> +
>> +     DBG("fd %d mtu %u", fd, rsp.mtu);
>> +
>> +     ipc_send_rsp_full(sco_ipc, SCO_SERVICE_ID, SCO_OP_CONNECT,
>> +                                                     sizeof(rsp), &rsp, fd);
>> +
>> +     return;
>> +
>> +failed:
>> +     ipc_send_rsp(sco_ipc, SCO_SERVICE_ID, SCO_OP_STATUS, SCO_STATUS_FAILED);
>>  }
>>
>>  static const struct ipc_handler sco_handlers[] = {
>> --
>> 1.9.0

Pushed.


-- 
Luiz Augusto von Dentz
