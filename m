Return-Path: <dave.sailer@paytec.com>
Subject: Re: [Bluez-users] problem with keyboard/mouse
From: Dave Sailer <dave.sailer@paytec.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Charles Bueche <charles@bueche.ch>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098453181.4704.80.camel@pegasus>
References: <1098441508.11708.12.camel@dsailer>
	 <1098443444.4704.46.camel@pegasus> <1098447645.11708.17.camel@dsailer>
	 <1098449746.4704.56.camel@pegasus>
	 <20041022152443.251405a6@bluez.bueche.ch>
	 <1098453181.4704.80.camel@pegasus>
Content-Type: text/plain
Message-Id: <1098455340.11706.26.camel@dsailer>
Mime-Version: 1.0
Date: Fri, 22 Oct 2004 10:29:00 -0400
List-ID: <bluez-users.lists.sourceforge.net>

I tried that yesterday. I moved the old source out of the way and
re-emerged 2.6.8.1. I could try 2.6.9 gentoo and the patch.... joy, more
compiling.


On Fri, 2004-10-22 at 09:53, Marcel Holtmann wrote:
> Hi Charles,
> 
> > to add my grain of salt : I run 2.6.9-gentoo with patch-2.6.9-mh1.gz,
> > and I see no problem at all. I have however no Microsoft hardware, only 
> > a Logitech MX900 mouse.
> 
> this is not a hardware problem. I think the kernel source code got
> corrupted and the compilation produced bad code. He must start from a
> clean kernel source.
> 
> However if the HID boot protocol mode is enough, then the 2.6.8 kernel
> includes everything you need.
> 
> Regards
> 
> Marcel
> 
