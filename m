Return-Path: <cyrus@holtmann.org>
Message-ID: <48DB29BF.2040603@nokia.com>
Date: Thu, 25 Sep 2008 09:03:43 +0300
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: ext Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] DUT mode support for kernel
References: <48DA1762.7050206@nokia.com> <1222281757.6481.0.camel@californication>
In-Reply-To: <1222281757.6481.0.camel@californication>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

ext Marcel Holtmann wrote:
> Hi Ville,
> 
>>
>> With this patch against bluetooth-2.6 tree the DUT mode is enabled by 
>> echoing "enabled\n" to new sysfs entry. Maybe some other interface 
>> should be used instead?
> 
> just remove the whole sysfs crap around it. Listen to the command status
> from the DUT change and then still use hcitool cmd for entering it.

OK. New patch without sysfs crap will follow soon. I was just one step 
too far and was thinking about removal of raw hci sockets :)

-- 
Ville
