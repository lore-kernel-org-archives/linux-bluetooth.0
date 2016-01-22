Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: PS3 controller (SIXAXIS) never gets into "IdleTimeout"
To: Antonio Ospite <ao2@ao2.it>
References: <569E872A.2010302@mailbox.org>
 <20160119234026.0db2304963ec8bfc99665ff1@ao2.it>
Cc: linux-bluetooth@vger.kernel.org
From: Manuel Reimer <manuel.reimer@mailbox.org>
Message-ID: <56A24FAF.3000203@mailbox.org>
Date: Fri, 22 Jan 2016 16:50:07 +0100
MIME-Version: 1.0
In-Reply-To: <20160119234026.0db2304963ec8bfc99665ff1@ao2.it>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 01/19/2016 11:40 PM, Antonio Ospite wrote:
>> Seems like the controller keeps sending axis information even if the
>> axis aren't touched at all.
>>
>
> IIRC this is because the controller has a lot of axes and they end up in
> the multi touch range (ABS_MT_*) which apparently sends event
> continuously.
>
> I remember I did some experiments about remapping the axes to a more
> meaningful setup and there were some improvements but that work
> depended on some experimental changes to the linux input layer from
> David Herrmann (the ABS2 proposal) and I do not know if the latter ever
> reached mainline. This is a linux-input topic BTW.

I guess that those are just the numbers, used by Sony, directly sent 
out, right?

> If you disconnect the device from bluez (either from an applet or from
> command line) the sixaxis should turn off.
>
> JFYI a possible hardware way is to keep pushed the PS button for some
> seconds, this also should turn the sixaxis off.

Both ways work. Thank you.

Just to be sure if this is not another linux-input topic:

If I first connect my PS3 controller via bluetooth, then all LEDs are 
turned off after some flashing. I think a better default configuration 
would be to set the first LED to be on. If all are off it is not obvious 
that the controller is turned on...

Thanks in advance

Best regards,

Manuel
