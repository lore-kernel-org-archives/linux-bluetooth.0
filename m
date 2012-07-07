Return-Path: <cyrus@holtmann.org>
Message-id: <55F9050C8BBB49778701FA33482309E7@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1341551602-1493-1-git-send-email-jaganath.k@samsung.com>
 <20120706091827.GA10494@x220.ger.corp.intel.com>
In-reply-to: <20120706091827.GA10494@x220.ger.corp.intel.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: Refactor PIN code rejection to use
 user_pairing_resp()
Date: Sat, 07 Jul 2012 18:37:02 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

--------------------------------------------------
From: "Johan Hedberg" <johan.hedberg@gmail.com>
Sent: Friday, July 06, 2012 2:48 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Bluetooth: Refactor PIN code rejection to use 
user_pairing_resp()

> Hi Jaganath,
>
> On Fri, Jul 06, 2012, Jaganath Kanakkassery wrote:
>> Reuse user_pairing_resp() to send PIN code negative reply.
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> ---
>>  net/bluetooth/mgmt.c |  155 
>> +++++++++++++++++++++++---------------------------
>>  1 files changed, 72 insertions(+), 83 deletions(-)
>
> Would it be possible for you to do this patch without moving around the
> functions? It'd make it easier to see that only the relevant bits are
> changed.

Ok, I will the revert movement of the function pin_code_reply() and raise 
v3.

Thanks,
Jaganath 

