Return-Path: <cyrus@holtmann.org>
Message-ID: <271e0890aa8b7c3d71c72d8d2a053476.squirrel@mungewell.org>
Date: Wed, 15 Jul 2015 01:52:21 -0400
Subject: Re: Reaching out again for serious bug in sixaxis plugin
From: simon@mungewell.org
To: "Sergey Kondakov" <virtuousfox@gmail.com>
Cc: "Bastien Nocera" <hadess@hadess.net>,
	linux-bluetooth@vger.kernel.org,
	"Antonio Ospite" <ospite@studenti.unina.it>,
	"Szymon Janc" <szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> My suggestion would be to display/capture the hidraw interface and see if
>> the missing data is present there. This can be done as root with --
>> $ hexdump -v -e '49/1 "%02x " "\n"' < /dev/hidraw0
>> --
>> The '49' is the byte count, and might be wrong (working from memory).
> Now that's the real answer !
> I tried that and seen this one odd line in the middle about the time
that stick axises have spiked with bogus values:
> 01 00 00 00 00 00 79 7f 7b 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 03 05 16 ff be 00 1b 33 af 77 01 c0 00 02 ea 01 90 01 e6
01
> 01 00 00 00 00 00 79 7f 7b 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 03 05 16 ff be 00 1b 33 af 77 01 c0 00 02 e9 01 90 01 e7
01
> 01 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00
> 01 00 00 00 00 00 79 7f 7b 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 03 05 16 ff be 00 1b 33 af 77 01 c0 00 02 e9 01 8f 01 e7
01
> 01 00 00 00 00 00 79 7f 7b 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 03 05 16 ff be 00 1b 33 af 77 01 c0 00 02 ea 01 90 01 e6
01
> No idea what that means.

This is the raw HID data from the device, it contains a bit field for the
buttons and values for the analogue sticks/buttons. You can see which is
which by pressing/wiggling them.

The line starting '01 ff' is peculiar as it is not normal output. I do not
know the significance of the 'ff', where the rest of the lines start '01
00'.

I did see a few occurrences of similar behavior
--
root@blind-fury:/home/simon# hexdump -v -e '49/1 "%02x " "\n"' <
/dev/hidraw1 | grep -e '01 ff' -B 1 -A 1
01 00 00 00 00 00 79 01 93 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 03 05 16 ff cc 00 00 33 bf 77 00 40 fe 01 ef 01 8e 01 02 00
01 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
01 00 00 00 00 00 11 1c bf 75 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 03 05 16 ff cc 00 00 33 bf 77 00 40 ff 01 f0 01 8f 01 02 00
--

The same 'funny' data (recorded at same time as above) is seen with hcidump.
[Byte order for Accelerometers is swapped by hid-sony module]
--
$ hcidump -x
...
> ACL data: handle 11 flags 0x02 dlen 54
    L2CAP(d): cid 0x0041 len 50 [psm 0]
      A1 01 00 00 00 00 00 79 01 93 00 00 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00 03 05 16 FF CC 00 00 33 BF 77
      00 40 01 FE 01 EF 01 8E 00 02
> ACL data: handle 11 flags 0x02 dlen 54
    L2CAP(d): cid 0x0041 len 50 [psm 0]
      A1 01 FF 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00
> ACL data: handle 11 flags 0x02 dlen 54
    L2CAP(d): cid 0x0041 len 50 [psm 0]
      A1 01 00 00 00 00 00 11 1C BF 75 00 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00 03 05 16 FF CC 00 00 33 BF 77
      00 40 01 FF 01 F0 01 8F 00 02
--

Oddly (or perhaps not) these 'funny' packets show up more frequently if I
exercise the LEDs
--
root@blind-fury:/sys/class/leds/0005:054C:0268.0002::sony1# echo heartbeat
> trigger
--

For reference this is seen with Bluez git, kernel 4.1rc7 on Xubuntu 15.04.
I am unable to use 4.2 as there's another bug affecting me.

I did not see this on 3.19 (stock kernel for system), but will recheck later.
Simon




