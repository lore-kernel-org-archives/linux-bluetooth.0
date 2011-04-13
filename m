Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <braghave@codeaurora.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Wed, 13 Apr 2011 13:56:28 +0300
Subject: RE: About the BT_SECURITY_HIGH support in Bluez stack
Message-ID: <99B09243E1A5DA4898CDD8B70011144810861C42D7@EXMB04.eu.tieto.com>
References: <6274c94659d0fd65491ca3370cf69db4.squirrel@www.codeaurora.org>
 <91156ff5702cf87ea80f2285c5c92855.squirrel@www.codeaurora.org>
In-Reply-To: <91156ff5702cf87ea80f2285c5c92855.squirrel@www.codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

>> I was looking at the archived conversations below,
>>
>> http://marc.info/?t=128290950000001&r=1&w=2
>>
>> I see, there is some effort in adding  this BT_SECURITY_HIGH suuport 
>> in to the bluez stack, which is a mandatory for the BT SAP profile.
>>
>> Could you please, let me know what is the plan to release these 
>> patches as part of Bluez?
>>
>> These patches seem to be suffecient. But, may need to add another 
>> D-Bus property to emit to the UI layers to take 16 character 
>PIN code.

Those patches are obsolete as this part has changed significantly. 
Most of this should be supported in kernel and not bluez now.

Waldek