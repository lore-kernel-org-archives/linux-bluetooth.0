Return-Path: <cyrus@holtmann.org>
Message-ID: <5067ED60.1080202@ti.com>
Date: Sun, 30 Sep 2012 08:57:36 +0200
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v4 01/10] battery: Add generic device battery documentation
References: <1348470919-25567-1-git-send-email-chen.ganir@ti.com> <1348470919-25567-2-git-send-email-chen.ganir@ti.com> <20120928105937.GA14450@x220>
In-Reply-To: <20120928105937.GA14450@x220>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,
On 09/28/2012 12:59 PM, Johan Hedberg wrote:
> Hi Chen,
>
> On Mon, Sep 24, 2012, chen.ganir@ti.com wrote:
>> +BlueZ D-Bus Battery API description
>> +****************************************
>
> Please keep the "underline" consistent with the length of the text above
> it.
>
>> +	Texas Instruments, Inc. <chen.ganir@ti.com>
>
> What's this supposed to be? If you want a copyright statement here then
> make it of the proper format. Author info is not needed as we have the
> AUTHORS file and the commit history.
>
Would you please specify what is the proper copyright message format ? 
doc/adapter-api.txt, doc/health-api.txt have two different styles. 
doc/oob-api.txt has a third style (AUTHOR <author@email> for COMPANY),
doc/media-api.txt for example does not have any copyright information. 
In addition - you say author information is not required, yet all other 
copyright messages contain this. Is this a new policy ? If so, please 
specify the proper copyright message.


>> +Device Battery hierarchy
>> +=====================================
>
> Same thing with the consistency of the "underline"
>
Ok.

>> +Service		org.bluez
>> +Interface	org.bluez.Battery
>> +Object path	[variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATTYYYY
>> +YYYY is numeric value between 0 and 9999.
>
> I don't think you need a separate comment for the "YYY". We don't have
> that for the "XX" stuff either.
>
Ok.

>> +		array{object} Batteries [readonly]
>
> I guess you should mark this with [experimental] since it'll be removed
> with the advent of ObjectManager.
>
What is the difference between the Batteries property and the services 
or UUIDs property in device-api.txt ? Should all of them get marked with 
experimental ?
> Johan
>


-- 
BR,
Chen Ganir
Texas Instruments
