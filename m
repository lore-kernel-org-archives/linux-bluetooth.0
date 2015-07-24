Return-Path: <cyrus@holtmann.org>
From: Anupam Roy <anupam.r@samsung.com>
To: szymon.janc@tieto.com
Cc: sachin.dev@samsung.com, linux-bluetooth@vger.kernel.org
Subject: RE: RE: [PATCH] android/client/if-hl.c:Handle failure from malloc()
 request
Date: Fri, 24 Jul 2015 07:52:50 -0400
Message-id: <1437738770-13840-1-git-send-email-anupam.r@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>------- Original Message -------
>Sender : Szymon Janc<szymon.janc@tieto.com>
>Date : Jul 21, 2015 22:22 (GMT+09:00)
>Title : Re: [PATCH] android/client/if-hl.c:Handle failure from malloc() request
>
>Hi Anupam,
>
>On Tuesday 21 of July 2015 09:01:17 Anupam Roy wrote:
>> Ping
>
>I looks like I never got the original patch. Could you resend it?
>(seems like you hit timeframe when my gmail was experiencing issues with vger 
>server and I had to resubscribe to mailing list)
>
Yes sure, I have re-sent the same patch. Kindly have a look. Thanks.
http://thread.gmane.org/gmane.linux.bluez.kernel/63442

>> > -----Original Message-----
>> >
>> >From: Anupam Roy 
>> >To: linux-bluetooth@vger.kernel.org
>> >Cc:sachin.dev@samsung.com; anupam.r@samsung.com
>> >Date : Jun 23, 2015 21:04 (GMT+09:00)
>> >Title : [PATCH] android/client/if-hl.c:Handle failure from malloc() request
>> >
>> >
>> >In case malloc() request fails, just print error message
>> >and return. Dereferencing reg.mdep_cfg in case of failure
>> >can lead to crash.
>> >---
>> >
>> > android/client/if-hl.c | 4 ++++
>> > 1 file changed, 4 insertions(+)
>> >
>> >diff --git a/android/client/if-hl.c b/android/client/if-hl.c
>> >index e0818ba..bd05671 100644
>> >--- a/android/client/if-hl.c
>> >+++ b/android/client/if-hl.c
>> >@@ -201,6 +201,10 @@ static void register_application_p(int argc, const
>> >char **argv)>
>> > reg.number_of_mdeps = atoi(argv[6]);
>> > 
>> > reg.mdep_cfg = malloc(reg.number_of_mdeps * sizeof(bthl_mdep_cfg_t));
>> >
>> >+ if (!reg.mdep_cfg) {
>> >+ haltest_error("malloc failed ");
>> >+ return;
>> >+ }
>> >
>> > mdep_argc_init = 7;
>> > 
>> > for (i = 0; i < reg.number_of_mdeps; i++) {
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>-- 
>BR
>Szymon Janc
>
BR,
-Anupam Roy



