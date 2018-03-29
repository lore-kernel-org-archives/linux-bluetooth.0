Return-Path: <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] Revert "Bluetooth: btmrvl: support sysfs initiated
 firmware coredump"
To: Marcel Holtmann <marcel@holtmann.org>
References: <1522184620-1695-1-git-send-email-arend.vanspriel@broadcom.com>
 <6DE6EDF0-488F-477D-A978-A19232594961@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5ABCA6AF.6050502@broadcom.com>
Date: Thu, 29 Mar 2018 10:41:19 +0200
MIME-Version: 1.0
In-Reply-To: <6DE6EDF0-488F-477D-A978-A19232594961@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 3/28/2018 11:37 AM, Marcel Holtmann wrote:
> Hi Arend,
>
>> This reverts commit 118c193d9699ffc1c897c38a1d314f38543c8e1c. A discussion
>> about the driver callback ended with the idea to change the return type of
>> the callback to void. That change would lead to build error in linux-next
>> so let's remove this change and resubmit later according the new callback
>> definition.
>>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> ---
>> Hi Marcel,
>>
>> Still noticed the patch in bt-next/master so decided to sent this formal
>> revert patch.
>
> I rebased the tree now to take this patch out. Thanks for reminding me.

Better safe than sorry.

Thanks,
Arend
