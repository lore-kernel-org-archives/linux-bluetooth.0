Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A4DDF6F3-8DD4-4CF7-A5C0-205F5B4EE489@warski.org>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org>
	<CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com>
	<A4DDF6F3-8DD4-4CF7-A5C0-205F5B4EE489@warski.org>
Date: Sat, 1 Mar 2014 15:11:47 -0400
Message-ID: <CAJdJm_PN3xGjdNOtr3o-J0SJ8N6MJXBChUCwOWOZBrdFKDBfGA@mail.gmail.com>
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Adam Warski <adam@warski.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

On Sat, Mar 1, 2014 at 5:34 AM, Adam Warski <adam@warski.org> wrote:
>> Can you save the raw dump using "hcidump -w output.dump"  (or using
>> btmon -w) and send to the list? It is easier to analyze, as the parser
>> may be bogus.
>
> Sure. The problems start at 63.120548.
> The dump is here: http://www.warski.org/btmon_ibeacons.dat

Maybe you already did your own investigation, but here goes my findings:

When opening the dump file on a hex editor, we can see that this first
bogus packet starts (skipping BTSnoop's own header) at offset 0x45a4
(with bytes "3E 2A 02 01 ..."). At offset 0x45b4 we can see that the
packet becomes truncated by missing these bytes (based on previous
correct packets):

1A FF 4C 00 02 15 B9 40 7F 30 F5 F8 46 6E AF F9

>From now on, the packets become garbage because they are "shifted" due
to these missing bytes.

I think we can rule out any problems on the hcidump/btmon tools (as
the raw logs come directly from the kernel), so I see two
possibilities here:

1) There might be a bug in HCI packet reassembly logic (either in
hci_core.c or btusb.c).

2) (most likely) your BT dongle may be broken (i.e. generating
truncated USB packets from time to time)

So my suggestion would be to try with a different dongle, preferably
of a different chipset vendor. Note that "TP-Link" is just the brand
name, you can confirm the chipset using lsusb or (even better)
"hciconfig hci0 -a" (check "Manufacturer" field).

Can you also provide the "lsusb" and "hciconfig hci0 -a" output (feel
free to modify the BT address for privacy reasons)? I think it is
important to have this archived so similar reports can be traced to
this hardware and firmware.

Another good source of information is the kernel debug logs. Collect
it by enabling dynamic debugging:

# dmesg -c  # just to clear the kernel log buffer
# echo 'module bluetooth +pf' | cat > /sys/kernel/debug/dynamic_debug/control
# echo 'module btusb +pf' | cat > /sys/kernel/debug/dynamic_debug/control
# btmon -w lescan.dump # So we can correlate the kernel log with the
actual packets
# hcitool lescan --duplicates # Run on another terminal, until packets
become corrupt
# dmesg > dmesg.txt
# echo 'module bluetooth -pf' | cat > /sys/kernel/debug/dynamic_debug/control
# echo 'module btusb -pf' | cat > /sys/kernel/debug/dynamic_debug/control
# gzip dmesg.txt (if it is too big)

Then send dmesg.txt.gz + lescan.dump to the list. You may want to mask
out your BT address on the log as well.

>
> Thanks,
> Adam

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
