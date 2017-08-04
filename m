Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Nicolas Werner <nicolas.werner@gmx.net>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC][PATCH BlueZ] sixaxis: Differing device name between usb and bluetooth connection
Date: Fri, 04 Aug 2017 22:29:04 +0200
Message-ID: <11841060.dynqo2U1Dt@gentooasus>
In-Reply-To: <2299304.XBxEXHNB4J@gentooasus>
References: <2299304.XBxEXHNB4J@gentooasus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Samstag, 4. Februar 2017, 19:16:28 CEST schrieben Sie:
> BlueZ sets the device name of Dual Shock 3 controller to "PLAYSTATION(R)3
> Controller". When you connect the same controller via USB it is set to "Sony
> PLAYSTATION(R)3 Controller".
> 
> It seems that at least some games fail to recognize the controller as a Dual
> Shock 3/sixaxis controller and don't load the default mapping for
> PlayStation controllers, if the name doesn't contain the Sony part. Also I
> don't see a reason to use a different name, when connecting via Bluetooth.
> 
> I noticed this with "The Binding of Isaac: Rebirth" and it seems, that Steam
> also recognizes the controller better after the patch, although I'm not
> confident, if I can parse the controller configuration dialog correctly. I
> don't know, if this breaks anything, because it depends on the current
> name.
> 
> The attached patch changes the device name set when pairing to match the
> device name, when connected via USB.
> 
> Nicolas Werner
> 
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -56,7 +56,7 @@
>         uint16_t version;
>  } devices[] = {
>         {
> -               .name = "PLAYSTATION(R)3 Controller",
> +               .name = "Sony PLAYSTATION(R)3 Controller",
>                 .source = 0x0002,
>                 .vid = 0x054c,
>                 .pid = 0x0268,

It seems I'm not the only one with this issue as I recently found this issue 
(https://bugzilla.kernel.org/show_bug.cgi?id=195225) in the kernel bug 
tracker. It looks like dual shock 4 controllers have a similar issue.

I asked on IRC and someone recommended to ping this message. Again, I would 
appreciate some comments on this issue and it would be great if this issue 
could be fixed.

Regards
	Nicolas Werner

