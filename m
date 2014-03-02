Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Adam Warski <adam@warski.org>
In-Reply-To: <CAJdJm_PN3xGjdNOtr3o-J0SJ8N6MJXBChUCwOWOZBrdFKDBfGA@mail.gmail.com>
Date: Sun, 2 Mar 2014 16:07:52 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <407CD6A9-AFA8-4A8A-BA2C-882D7A64EF40@warski.org>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org> <CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com> <A4DDF6F3-8DD4-4CF7-A5C0-205F5B4EE489@warski.org> <CAJdJm_PN3xGjdNOtr3o-J0SJ8N6MJXBChUCwOWOZBrdFKDBfGA@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the analysis :) I guess I’m more of a beginner in the area and moving slower.
I also tried with bluez 5.13 (as .15 contains some LE changes), but same thing happens.

> Maybe you already did your own investigation, but here goes my findings:
> 
> When opening the dump file on a hex editor, we can see that this first
> bogus packet starts (skipping BTSnoop's own header) at offset 0x45a4
> (with bytes "3E 2A 02 01 ..."). At offset 0x45b4 we can see that the
> packet becomes truncated by missing these bytes (based on previous
> correct packets):
> 
> 1A FF 4C 00 02 15 B9 40 7F 30 F5 F8 46 6E AF F9
> 
> From now on, the packets become garbage because they are "shifted" due
> to these missing bytes.
> 
> I think we can rule out any problems on the hcidump/btmon tools (as
> the raw logs come directly from the kernel), so I see two
> possibilities here:
> 
> 1) There might be a bug in HCI packet reassembly logic (either in
> hci_core.c or btusb.c).
> 
> 2) (most likely) your BT dongle may be broken (i.e. generating
> truncated USB packets from time to time)

The root cause seem to be the “--duplicates --passive” flags. According to the BLE spec the duplicates are filtered out in the Link Layer part. Do I understand correctly that that’s on the hardware side?

If I just run “hcitool lescan --passive”, I see the advertisement only once, and nothing else happens - which includes no truncated packets. So the --duplicates flag seems to be the culprit.

> So my suggestion would be to try with a different dongle, preferably
> of a different chipset vendor. Note that "TP-Link" is just the brand
> name, you can confirm the chipset using lsusb or (even better)
> "hciconfig hci0 -a" (check "Manufacturer" field).

I messed up the model number, looked at the wrong dongle, TP-Link is the WiFi one ;)
The bluetooth one is an IOGear GBU521 (http://www.iogear.com/product/GBU521/).

I don’t have another dongle right now (I tried a different IOGear, but same thing), but I’ll try setting a VM on my laptop/getting a different USB dongle.

> Can you also provide the "lsusb" and "hciconfig hci0 -a" output (feel
> free to modify the BT address for privacy reasons)? I think it is
> important to have this archived so similar reports can be traced to
> this hardware and firmware.

Sure:
$ sudo hciconfig hci0 -a
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:01:81:C6:E8:82  ACL MTU: 1021:8  SCO MTU: 64:1
	UP RUNNING
	RX bytes:547 acl:0 sco:0 events:27 errors:0
	TX bytes:384 acl:0 sco:0 commands:27 errors:0
	Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH SNIFF
	Link mode: SLAVE ACCEPT
	Name: 'BCM20702A'
	Class: 0x000000
	Service Classes: Unspecified
	Device Class: Miscellaneous,
	HCI Version: 4.0 (0x6)  Revision: 0x1000
	LMP Version: 4.0 (0x6)  Subversion: 0x220e
	Manufacturer: Broadcom Corporation (15)

$ lsusb
Bus 001 Device 002: ID 0424:9512 Standard Microsystems Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 003: ID 0424:ec00 Standard Microsystems Corp.
Bus 001 Device 004: ID 0bda:8179 Realtek Semiconductor Corp.
Bus 001 Device 005: ID 0a5c:21e8 Broadcom Corp.

> Another good source of information is the kernel debug logs. Collect
> it by enabling dynamic debugging:
> 
> # dmesg -c  # just to clear the kernel log buffer
> # echo 'module bluetooth +pf' | cat > /sys/kernel/debug/dynamic_debug/control
> # echo 'module btusb +pf' | cat > /sys/kernel/debug/dynamic_debug/control
> # btmon -w lescan.dump # So we can correlate the kernel log with the
> actual packets
> # hcitool lescan --duplicates # Run on another terminal, until packets
> become corrupt
> # dmesg > dmesg.txt
> # echo 'module bluetooth -pf' | cat > /sys/kernel/debug/dynamic_debug/control
> # echo 'module btusb -pf' | cat > /sys/kernel/debug/dynamic_debug/control
> # gzip dmesg.txt (if it is too big)
> 
> Then send dmesg.txt.gz + lescan.dump to the list. You may want to mask
> out your BT address on the log as well.

I mounted debugfs but as I don’t have dynamic_debug I guess I have to recompile the kernel with the appropriate flag. This will take a while ;)

Adam

-- 
Adam Warski

http://twitter.com/#!/adamwarski
http://www.softwaremill.com
http://www.warski.org

