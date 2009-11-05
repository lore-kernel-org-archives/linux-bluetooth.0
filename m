Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Nov 2009 19:43:54 +0000 (GMT)
To: Julius Schwartzenberg <julius@zgod.cjb.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Logitech Bluetooth mouse batteries drain quickly
In-Reply-To: <4AF2B5EB.40202@zgod.cjb.net>
References: <4AEF6F94.4080209@zgod.cjb.net> <1257239216.552583.1029.nullmailer@galant.ukfsn.org> <4AF2B5EB.40202@zgod.cjb.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1257450234.926723.29928.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 5 Nov 2009, Julius Schwartzenberg wrote:

> Yes, it's indeed not days, but months. Here is the output from hcitool:
> Link policy settings: RSWITCH HOLD SNIFF PARK
>
> So this looks good I guess?

guess so

> When I look at the info, I get this:
> Requesting information ...
>         BD Address:  00:07:61:DF:0D:C7
>         Device Name: Bluetooth Laser Travel Mouse
>         LMP Version: 2.0 (0x3) LMP Subversion: 0x229
>         Manufacturer: Broadcom Corporation (15)
>         Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
>                 <encryption> <slot offset> <timing accuracy> <role switch>
>                 <sniff mode> <RSSI> <power control> <enhanced iscan>
>                 <interlaced iscan> <interlaced pscan> <AFH cap. slave>
>
> Could the problem be related to the "power control" feature which may not be
> fully used right now?

No, that relates to Link Manager Protocol which is carried out entirely
within the controller and I don't think there is any way for the host to
influence any decisions regarding that..

My suggestion is to use rechargeables. They will likely last longer than
alkalines, and I normally have spares already charged (use AA for bicycle
lights) so it never really bothered me to have a flat..

iain


