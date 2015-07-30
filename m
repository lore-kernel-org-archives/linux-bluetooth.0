Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 3/8] Bluetooth: Unwind l2cap_sock_shutdown()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55A76D51.6000607@mentor.com>
Date: Thu, 30 Jul 2015 13:51:55 +0200
Cc: linux-bluetooth@vger.kernel.org, Joshua_Frkuska@mentor.com
Message-Id: <D45D17F0-3869-4F54-AE6B-B5AF1192695E@holtmann.org>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com> <1435078779-4436-4-git-send-email-Dean_Jenkins@mentor.com> <20150713110731.GA21598@t440s.lan> <55A3F5F8.4070800@mentor.com> <20150716080840.GA28234@t440s.lan> <55A76D51.6000607@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

>>>> Do you think you'll be able to fix this as well as the missing
>>>> mutex_lock(&conn->chan_lock) issue this week? Otherwise we'll need to
>>>> consider reverting your patches since it's quite clear we can't make any
>>>> bluetooth-next pull requests with the current state of the tree.
>>> I think it would be wise to revert the changes as I am unable to guarantee
>>> that I get time to propose a fix during this week. I will try to work on a
>>> v3 patchset based on your feedback.
>> I went ahead and pushed a rebased tree with your patches 3/8, 4/8 and
>> 5/8 removed. The other five were either harmless or good fixes. So
>> if/when you have new patches please base them against the new tree.
>> 
>> 
> Thanks for the information. I shall endeavour to fix the locking issues but it will take me some days.

any updates?

Regards

Marcel

