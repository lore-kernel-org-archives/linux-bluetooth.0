Return-Path: <cyrus@holtmann.org>
Message-id: <E3660838E8D64186924BA81A32F30682@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
References: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
 <1349891245.27233.153.camel@aeonflux>
Subject: Re: [PATCH 1/4] Bluetooth: Fix L2CAP PSM bind issue
Date: Thu, 11 Oct 2012 16:49:50 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=UTF-8; reply-type=original
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Syam Sidhardhan" <s.syam@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Sent: Wednesday, October 10, 2012 11:17 PM
Subject: Re: [PATCH 1/4] Bluetooth: Fix L2CAP PSM bind issue


> Hi Syam,
>
>> Problem: If we bind a particular PSM with source address as BDADDR_ANY,
>> then we are able to bind the same PSM with adapter address(or any other
>> address), which is incorrect.
>
> why is this incorrect? Explain that to me.
>

Here there is a correction required in the commit message.

As per my understanding the a particular PSM can be binded only once
for a single adapter address. Kindly correct me if I'm wrong here.

As I mentioned in the additional comment part of the patch, there is
a PSM conflict happens between the Obexd and HDP, because of the
source address differences. With this patch, it's getting resolved and
I'm able to run Obexd and HDP simultaniously.

The otherway to fix it, is in userspace. Always provide the source adapter
address during the PSM binding, rather than providing BDADDR_ANY.

If this patch code changes are valid, then I can send a seperate version 
patch with
the following corrected commit message description.

"Problem: If we bind a particular PSM with source address as BDADDR_ANY,
then we are able to bind the same PSM with adapter address." ...

Kindly let me know.

Thanks,
Syam. 
