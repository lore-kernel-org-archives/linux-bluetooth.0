Return-Path: <charles@bueche.ch>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Charles Bueche <charles@bueche.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Olivier Bornet <Olivier.Bornet@smartdata.ch>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1071333541.27252.177.camel@pegasus>
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
Content-Type: text/plain
Message-Id: <1071341513.4307.36.camel@bluez.bueche.ch>
Mime-Version: 1.0
Date: Sat, 13 Dec 2003 19:51:53 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

it's a CSR, it's included in my Dell Inspiron 8600. The I8600 is recent,
but of course it tells nothing about the included bluetooth module. Here
are the details :
---
# hciconfig -a
hci0:   Type: USB 
        BD Address: 00:10:C6:22:54:AF ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:88278 acl:5562 sco:0 events:305 errors:0
        TX bytes:3779 acl:170 sco:0 commands:54 errors:0
        Features: 0xff 0xff 0x0f 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: 
        Link mode: SLAVE ACCEPT 
        Name: 'laptopcb (0)'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous, 
        HCI Ver: 1.1 (0x1) HCI Rev: 0x235 LMP Ver: 1.1 (0x1) LMP Subver:
0x235
        Manufacturer: Cambridge Silicon Radio (10)

---
# hciconfig hci0 features
hci0:   Type: USB 
        BD Address: 00:10:C6:22:54:AF ACL MTU: 192:8  SCO MTU: 64:8
        Features: 0xff 0xff 0x0f 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park mode> <RSSI> <channel quality> <SCO link> 
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> 
                <CVSD> <paging scheme> <power control> <transparent SCO>

---
# hciconfig hci0 version
hci0:   Type: USB 
        BD Address: 00:10:C6:22:54:AF ACL MTU: 192:8  SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x235 LMP Ver: 1.1 (0x1) LMP Subver:
0x235
        Manufacturer: Cambridge Silicon Radio (10)

---
# hciconfig hci0 revision
hci0:   Type: USB 
        BD Address: 00:10:C6:22:54:AF ACL MTU: 192:8  SCO MTU: 64:8
        Unknown firmware


I don't know how to find the firmware version. I have a dual boot with
XP, so I could look there if there is now way in Linux.

Charles

On Sat, 2003-12-13 at 17:39, Marcel Holtmann wrote:
> Hi Charles,
> 
> > Thanks for your answer. I don't run GPM, so the problem isn't from
> > there. But you gave me another idea : I loaded my modules, started the
> > patched bthid, exited X, and tried gpm in console. I got the same
> > problem !!! The mouse is jumpy as well. I think I can now exclude Xfree
> > from the potential problem.
> 
> what kind of Bluetooth adapter do you use? I had some problem with CSR
> chips and old firmwares.
> 
> > I guess bthid is producing the jumpy mouse. I tried to checkout the CVS
> > version, but I'm lost with autoconf and friends. I guess I will have to
> > wait for Marcel's new snapshot.
> 
> Run the bootstrap script first ;)
> 
> Regards
> 
> Marcel
-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer
