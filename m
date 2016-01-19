Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 19 Jan 2016 23:40:26 +0100
From: Antonio Ospite <ao2@ao2.it>
To: Manuel Reimer <manuel.reimer@mailbox.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: PS3 controller (SIXAXIS) never gets into "IdleTimeout"
Message-Id: <20160119234026.0db2304963ec8bfc99665ff1@ao2.it>
In-Reply-To: <569E872A.2010302@mailbox.org>
References: <569E872A.2010302@mailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 19 Jan 2016 19:57:46 +0100
Manuel Reimer <manuel.reimer@mailbox.org> wrote:

> Hello,
>

Hi Manuel,

> I want to use my PS3 controller on my Linux system. This, so far, seems 
> to work pretty well, but if I forget to turn off the controller when 
> leaving my PC, then the battery keeps discharging until it is finally empty.
> 
> There is a setting "IdleTimeout" in "input.conf", but at least for me 
> this doesn't work for the PS3 controller.
> 
> I think the reason is, that the controller keeps sending information 
> even if it is placed on my desk and noone is touching it. If I run 
> "evtest" on the event device, created for the controller, then I get 
> something like this (only short snippet):
> 
> Event: time 1453228629.616457, -------------- SYN_REPORT ------------
> Event: time 1453228629.651514, type 3 (EV_ABS), code 1 (ABS_Y), value 124
> Event: time 1453228629.651514, type 3 (EV_ABS), code 61 (ABS_MT_TOOL_Y), 
> value 491
> Event: time 1453228629.651514, -------------- SYN_REPORT ------------
> Event: time 1453228629.683436, type 3 (EV_ABS), code 1 (ABS_Y), value 123
> Event: time 1453228629.683436, type 3 (EV_ABS), code 2 (ABS_Z), value 132
> Event: time 1453228629.683436, type 3 (EV_ABS), code 61 (ABS_MT_TOOL_Y), 
> value 490
> Event: time 1453228629.683436, -------------- SYN_REPORT ------------
>
> Seems like the controller keeps sending axis information even if the 
> axis aren't touched at all.
>

IIRC this is because the controller has a lot of axes and they end up in
the multi touch range (ABS_MT_*) which apparently sends event
continuously.

I remember I did some experiments about remapping the axes to a more
meaningful setup and there were some improvements but that work
depended on some experimental changes to the linux input layer from
David Herrmann (the ABS2 proposal) and I do not know if the latter ever
reached mainline. This is a linux-input topic BTW.

> Is there any chance to add some handling into bluez to get the 
> controller disabled, even if it keeps sending information in "idle state"?
>

If you disconnect the device from bluez (either from an applet or from
command line) the sixaxis should turn off.

JFYI a possible hardware way is to keep pushed the PS button for some
seconds, this also should turn the sixaxis off.

Ciao ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
