Return-Path: <cyrus@holtmann.org>
Message-id: <F01A0FD1DC634EA58767E05BC990B2BC@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1342449675-2842-1-git-send-email-jaganath.k@samsung.com>
 <20120724133520.GA19450@x220.ice.intel.com>
In-reply-to: <20120724133520.GA19450@x220.ice.intel.com>
Subject: Re: [PATCH v5] Bluetooth: Override status if local user rejects pairing
Date: Wed, 25 Jul 2012 15:19:55 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

--------------------------------------------------
From: "Johan Hedberg" <johan.hedberg@gmail.com>
Sent: Tuesday, July 24, 2012 7:05 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v5] Bluetooth: Override status if local user rejects 
pairing

> Hi Jaganath,
>
> On Mon, Jul 16, 2012, Jaganath Kanakkassery wrote:
>> In case if pairing is failed, user cannot differentiate from the status
>> whether failure is caused by local rejection or remote rejection
>> because authentication failure is coming in both the cases.
>>
>> This patch overrides the status from controller with "Cancelled"
>> in case of local rejection.
>>
>> This patch will be useful if user can take some action based on local
>> or remote rejection
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> ---
>> v5 -> Used STATUS_CANCELLED instead of STATUS_REJECTED
>> Added a new flag in hci conn for auth cancel instead of
>> a new member in struct
>>
>>  include/net/bluetooth/hci_core.h |    3 ++-
>>  net/bluetooth/hci_event.c        |   19 +++++++++++++++----
>>  net/bluetooth/mgmt.c             |   18 ++++++++++++++++--
>>  net/bluetooth/smp.c              |    3 ++-
>>  4 files changed, 35 insertions(+), 8 deletions(-)
>
> Technically the patch looks quite good now. Thanks for implementing the
> fix proposals. I had a chat with Marcel and we'd like to have a more
> detailed explanation of the exact use case where you need this (i.e.
> describe what your agents, etc. are doing and why they can't do what you
> want with the current behavior). Also a hcidump showing the local and
> remote rejection error codes would be good.

I will change the commit message and describe more about the exact
use case of this patch.

Thanks,
Jaganath 

