Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLthL6K2UgbmDq0nfAf56xei1t-9_cVDDqU19Qq=1i7yg@mail.gmail.com>
References: <1418382690-9741-1-git-send-email-s.nageshmurt@samsung.com>
	<CABBYNZLthL6K2UgbmDq0nfAf56xei1t-9_cVDDqU19Qq=1i7yg@mail.gmail.com>
Date: Fri, 12 Dec 2014 14:18:27 +0200
Message-ID: <CABBYNZJGpEuwEWyUD-ockRpCfkSspynRDuW7U3oKgKxs_T2NDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] audio/sink: Fix crash when err is NULL
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sagar,

On Fri, Dec 12, 2014 at 2:09 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Sagar,
>
> On Fri, Dec 12, 2014 at 1:11 PM, Sagar Nageshmurthy
> <s.nageshmurt@samsung.com> wrote:
>> When a2dp connection fails because of IO error setup error can be NULL
>> if the err is already handled by finalize_resume(setup).
>>
>> (gdb) p *(struct a2dp_setup *)0xb6f98150
>> $8 = {session = 0xb6c12000, sep = 0xb6c49d30, rsep = 0x0, stream = 0x0,
>>           err = 0x0, setconf_cb = 0, caps = 0x0, reconfigure = 17,
>>             start = -1225164896, cb = 0xb6d70288, ref = 16}
>>
>> (gdb) bt
>> 0 0xb6f92108 in ?? ()
>> 1 0xb6efcd88 in finalize_config (data=0xb6f98150)
>>     at profiles/audio/a2dp.c:222
>> 2 0xb6f004a8 in handle_unanswered_req (session=0xb6f9a650,
>>     sep=<value optimized out>, state=AVDTP_STATE_IDLE)
>>     at profiles/audio/avdtp.c:967
>> 3 avdtp_sep_set_state (session=0xb6f9a650, sep=<value optimized out>,
>>     state=AVDTP_STATE_IDLE) at profiles/audio/avdtp.c:1163
>> 4 0xb6e16fb8 in g_slist_foreach (list=<value optimized out>,
>>     func=0xb6f005e5 <release_stream>, user_data=0xb6f9a650) at gslist.c:840
>>
>> daemon.debug : src/device.c:device_profile_connected() a2dp-sink Input/output error (5)
>> daemon.debug : profiles/audio/a2dp.c:abort_cfm() Source 0xb6f8fba8: Abort_Cfm
>> daemon.debug : profiles/audio/a2dp.c:setup_unref() 0xb6f98150: ref=1
>> daemon.err : No reply to Open request
>> daemon.debug : profiles/audio/a2dp.c:open_cfm() Source 0xb6f8fba8: Open_Cfm
>
> That is weird, we actually set an error on handle_unanswered_req it
> should never be NULL under this circumstances, it is also weird that
> you got an error to a2dp-sink I wonder if there were in fact 2 stream
> ongoing? Also if you check the setup reference it says it is 1 but gdb
> says it is 16 so I wonder what is going on here, maybe some memory
> corruption?

The session is also different 0xb6f9a650 vs 0xb6c12000 from gdb,
perhaps you can attempt to reproduce with valgrind, try something like
this:

sudo DBUS_VERBOSE=1 G_SLICE=always-malloc
G_DEBUG=gc-friendly,resident-module valgrind --trace-children=yes
--track-origins=yes --show-possibly-lost=no --leak-check=full
./bluetoothd -nEC -d

Then attempt to reproduce the crash, valgrind will automatically
generate the backtrace if a crash would happen.

>
>> ---
>>  profiles/audio/sink.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
>> index f475709..7fa9430 100644
>> --- a/profiles/audio/sink.c
>> +++ b/profiles/audio/sink.c
>> @@ -191,7 +191,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
>>
>>         avdtp_unref(sink->session);
>>         sink->session = NULL;
>> -       if (avdtp_error_category(err) == AVDTP_ERRNO
>> +       if (err && avdtp_error_category(err) == AVDTP_ERRNO
>>                                 && avdtp_error_posix_errno(err) != EHOSTDOWN)
>>                 btd_service_connecting_complete(sink->service, -EAGAIN);
>>         else
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
