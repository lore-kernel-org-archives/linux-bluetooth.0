Return-Path: <david@lechnology.com>
Subject: Re: [PATCH 2/3] bluetooth: hci_ll: add constant for vendor-specific
 command
To: Marcel Holtmann <marcel@holtmann.org>
Cc: devicetree <devicetree@vger.kernel.org>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1512357682-8911-1-git-send-email-david@lechnology.com>
 <1512357682-8911-3-git-send-email-david@lechnology.com>
 <5C65FB74-D7FD-4653-993A-5A68AD844A41@holtmann.org>
From: David Lechner <david@lechnology.com>
Message-ID: <55fff19a-c30f-88f0-afb2-6c0b9bad25a7@lechnology.com>
Date: Thu, 7 Dec 2017 15:29:02 -0600
MIME-Version: 1.0
In-Reply-To: <5C65FB74-D7FD-4653-993A-5A68AD844A41@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 12/04/2017 12:23 AM, Marcel Holtmann wrote:
> Hi David,
> 
>> This adds a #define for the vendor-specific HCI command to set the
>> baudrate instead of using the bare 0xff36 multiple times.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>> drivers/bluetooth/hci_ll.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
> 
> patch has been applied to bluetooth-next tree.
> 

I am new to the bluetooth tree, so just to be sure... does this mean I 
should not include this patch in v2 of this series since this patch has 
been applied?
