Return-Path: <cyrus@holtmann.org>
From: Anupam Roy <anupam.r@samsung.com>
To: vinicius.gomes@intel.com
Cc: sachin.dev@samsung.com, linux-bluetooth@vger.kernel.org
Subject: Re: RE: [PATCH] tools/obex-client-tool.c: Fix memory leak in
 obex-client-tool
Date: Fri, 24 Jul 2015 10:25:34 -0400
Message-id: <1437747934-15750-1-git-send-email-anupam.r@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

>------- Original Message -------
>Sender : Vinicius Costa Gomes<vinicius.gomes@intel.com>
>Date : Jul 24, 2015 22:59 (GMT+09:00)
>Title : RE: [PATCH] tools/obex-client-tool.c: Fix memory leak in obex-client-tool
>
>Hi,
>
>Anupam Roy <anupam.r@samsung.com> writes:
>
>Hi,
>
>Anupam Roy <anupam.r@samsung.com> writes:
>
>> ping
>>
>>> -----Original Message-----
>>>From: Anupam Roy <anupam.r@samsung.com>
>>>To: linux-bluetooth@vger.kernel.org
>>>Cc:sachin.dev@samsung.com; anupam.r@samsung.com
>>>Date: Fri, 26 Jun 2015 08:58:33 -0400
>>>Subject: [PATCH] tools/obex-client-tool.c: Fix memory leak in obex-client-tool
>>>
>>>GOptionContext object should be freed in case socket connection
>>>fails and program execution is terminated.
>>>
>
>The code looks fine.
>
>(But I didn't get the first email)
Below is the link for the first e-mail.
http://thread.gmane.org/gmane.linux.bluez.kernel/63140
However, I will resend the patch. Thanks
>
>
>Cheers,
>--
>Vinicius
>--
Best Regards,
-Anupam Roy


