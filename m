Return-Path: <cyrus@holtmann.org>
Message-ID: <49F57811.8010906@nokia.com>
Date: Mon, 27 Apr 2009 12:17:05 +0300
From: Roger Quadros <ext-roger.quadros@nokia.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] bluetooth: hci_sysfs: Ensure sysfs add/del is pre-empt
 safe
References: <49F05193.7070609@nokia.com> <1240486951.15894.5.camel@localhost.localdomain> <49F0561E.3030206@nokia.com> <49F577D6.6090607@nokia.com>
In-Reply-To: <49F577D6.6090607@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Roger Quadros wrote:
> ext Roger Quadros wrote:
>> Marcel Holtmann wrote:
>>> Hi Roger,
>>>
>>>> Subject: [PATCH] bluetooth: hci_sysfs: Ensure sysfs add/del is 
>>>> pre-empt safe
>>>>
>>>> Uses different work_struct variables for add_conn() and del_conn(). 
>>>> Uses
>>>> single work queue instead of two for adding and deleting connections.
>>>>
>>>> It eliminates the following error on a pre-emptible kernel.
>>>
>>> patch looks good to me. Can you just please replace the work queue name
>>> with "bluetooth" instead if "btworkq". Looks more saner to me.
>>>
>>> Regards
>>>
>>> Marcel
>>>
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> Hi Marcel,
>>
>>   I've renamed "btworkq" to "bluetooth" as per your suggestion.
>> Patch is below.
>>
>> cheers!
>> -roger
>>
>> From: Roger Quadros <ext-roger.quadros@nokia.com>
>> Date: Thu, 23 Apr 2009 14:05:19 +0300
>> Subject: [PATCH v2] bluetooth: hci_sysfs: Ensure sysfs add/del is 
>> pre-empt safe
>>
>> Uses different work_struct variables for add_conn() and del_conn(). Uses
>> single work queue instead of two for adding and deleting connections.
>>
>> It eliminates the following error on a pre-emptible kernel.
>>
>> [  204.358032] Unable to handle kernel NULL pointer dereference at
>> virtual address 0000000c
>> [  204.370697] pgd = c0004000
>> [  204.373443] [0000000c] *pgd=00000000
>> [  204.378601] Internal error: Oops: 17 [#1] PREEMPT
>> [  204.383361] Modules linked in: vfat fat rfcomm sco l2cap sd_mod
>> scsi_mod iphb pvr2d drm omaplfb ps
>> [  204.438537] CPU: 0    Not tainted  (2.6.28-maemo2 #1)
>> [  204.443664] PC is at klist_put+0x2c/0xb4
>> [  204.447601] LR is at klist_put+0x18/0xb4
>> [  204.451568] pc : [<c0270f08>]    lr : [<c0270ef4>]    psr: a0000113
>> [  204.451568] sp : cf1b3f10  ip : cf1b3f10  fp : cf1b3f2c
>> [  204.463104] r10: 00000000  r9 : 00000000  r8 : bf08029c
>> [  204.468353] r7 : c7869200  r6 : cfbe2690  r5 : c78692c8  r4 :
>> 00000001
>> [  204.474945] r3 : 00000001  r2 : cf1b2000  r1 : 00000001  r0 :
>> 00000000
>> [  204.481506] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
>> Segment kernel
>> [  204.488861] Control: 10c5387d  Table: 887fc018  DAC: 00000017
>> [  204.494628] Process btdelconn (pid: 515, stack limit = 0xcf1b22e0)
>>
>> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
>> ---
>>  include/net/bluetooth/hci_core.h |    3 ++-
>>  net/bluetooth/hci_sysfs.c        |   37 
>> ++++++++++++++++---------------------
>>  2 files changed, 18 insertions(+), 22 deletions(-)
>>
> 

hi Marcel,

  What is the fate of this patch?

regards,
-roger
