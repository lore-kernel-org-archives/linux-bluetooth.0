Return-Path: <charles@bueche.ch>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Charles Bueche <charles@bueche.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Olivier Bornet <Olivier.Bornet@smartdata.ch>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1071342247.1548.6.camel@pegasus>
References: <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070380907.19169.55.camel@saag> <1070482683.18058.6.camel@bluez.bueche.ch>
	 <1070483755.24159.114.camel@pegasus> <20031204085314.GA1780@smartdata.ch>
	 <1071001915.13464.33.camel@bluez.bueche.ch>
	 <20031209224217.GE26896@smartdata.ch>
	 <1071043970.8979.5.camel@bluez.bueche.ch>
	 <20031210083002.GG26896@smartdata.ch>
	 <1071330995.4307.27.camel@bluez.bueche.ch>
	 <1071333541.27252.177.camel@pegasus>
	 <1071341513.4307.36.camel@bluez.bueche.ch>
	 <1071342247.1548.6.camel@pegasus>
Content-Type: text/plain
Message-Id: <1071410118.5988.8.camel@bluez.bueche.ch>
Mime-Version: 1.0
Date: Sun, 14 Dec 2003 14:55:18 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel and Olivier,

it works. Shame on me. Your remark about my empty link policy googled me
to another hcid.conf, and I suddenly saw mine, which was wrongly
configured, and worst, *hcid wasn't started*.

I'm running gentoo, and for some reason, there are no startup script for
bluetooth, so I was starting it by hand (hciconfig hci0 up).

Now, my mouse isn't jumpy at all anymore. The only glitch left is that I
have to press its "connect" button just after starting bthid if I want a
link. Is there a way to get this automated ?

I don't like to criticize about missing docs, because I have the same
problem at my main contract as Solaris admin (too many things to do to
write proper docs). However, bluez suffer a bit from that problem. They
are loads of small HOWTOs, but I miss a sort of white paper to explain
bluetooth in general. Any pointer is welcome.

Meanwhile, I'm still ready to test new versions of bthid or its future
replacement. Thanks a lot for your help. As soon as my last prob is
worked out (auto-connect of MX900), I'll finish my
"yet-another-bluez-mini-HOWTO" :-)

Charles

On Sat, 2003-12-13 at 20:04, Marcel Holtmann wrote:
> Hi Charles,
> 
> > it's a CSR, it's included in my Dell Inspiron 8600. The I8600 is recent,
> > but of course it tells nothing about the included bluetooth module. Here
> > are the details :
> > ---
> > # hciconfig -a
> > hci0:   Type: USB 
> >         BD Address: 00:10:C6:22:54:AF ACL MTU: 192:8  SCO MTU: 64:8
> >         UP RUNNING PSCAN ISCAN 
> >         RX bytes:88278 acl:5562 sco:0 events:305 errors:0
> >         TX bytes:3779 acl:170 sco:0 commands:54 errors:0
> >         Features: 0xff 0xff 0x0f 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> >         Link policy: 
> >         Link mode: SLAVE ACCEPT 
> >         Name: 'laptopcb (0)'
> >         Class: 0x000000
> >         Service Classes: Unspecified
> >         Device Class: Miscellaneous, 
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x235 LMP Ver: 1.1 (0x1) LMP Subver:
> > 0x235
> >         Manufacturer: Cambridge Silicon Radio (10)
> > 
> > ---
> > I don't know how to find the firmware version. I have a dual boot with
> > XP, so I could look there if there is now way in Linux.
> 
> this is a HCI 16.5 with 128 bit encryption and it should work fine. The
> problematic part is maybe that you have no link policy set. The minimum
> options should be rswitch and sniff. Please use
> 
> 	http://www.holtmann.org/linux/bluetooth/btdfu-0.2.tar.gz
> 
> to extract your firmware and send it to me.
> 
> Regards
> 
> Marcel
-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer
