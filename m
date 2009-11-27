Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1258568114.2003.128.camel@violet>
References: <c6e9632c0911131047s565cc191w84d22bc1dff710a0@mail.gmail.com>
	 <1258286232.3299.27.camel@violet>
	 <c6e9632c0911170853g5ef4061cr75c42c71a1a87b7d@mail.gmail.com>
	 <1258491418.2003.37.camel@violet>
	 <c6e9632c0911171318l1b60fa85h55b3e6083777d516@mail.gmail.com>
	 <c6e9632c0911180959p3e56668aqc298a673baea7350@mail.gmail.com>
	 <1258568114.2003.128.camel@violet>
Date: Fri, 27 Nov 2009 19:11:26 +0100
Message-ID: <c6e9632c0911271011p1268ee8ek16e389fc779e0d77@mail.gmail.com>
Subject: Re: Getting/setting Inquiry trasmit power level unsolved
From: Natale Vinto <ebballon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I tried it with a Fujitsu-Siemens BlueCore4-External flashed with a 2.1
> firmware. That was the one I had laying on my desk.
I've tried then with a Belkin F8T017 v2.1 + EDR usb dongle Class 1 on
Ubuntu 2.6.31.6 Bluez 4.51
hciconfig hci0 commands gives me

        'Read Inquiry Transmit Power Level'
        'Write Inquiry Transmit Power Level'

So now hciconfig hci0 inqtpl :

hci0:   Type: USB
        BD Address: 00:19:0E:XX:XX:XX ACL MTU: 1021:8 SCO MTU: 64:1
        Inquiry transmit power level: 0

but hciconfig hci0 inqtpl 1 nothing . Analyzing packets on on hci0 I
got the same result as you in the previous mail but while reading TPL,
but while trying to write TPL for example to level 4 I got this with
hciconfig hci0 inqtpl 4

# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Write Inquiry Response Transmit Power Level (0x03|0x0059) plen 1
    level 4
> HCI Event: Command Complete (0x0e) plen 4
    Write Inquiry Response Transmit Power Level (0x03|0x0059) ncmd 1
    status 0x00

keeping TPL to 0 level. I'm waiting another Belkin that should be CSR
based as linked on CSR website, is F8T016 and is Class 2, hoping will
work, but I would know: does TPL work only for Class 1? Is 0 a valid
level?

Best Regards


-- 
Natale
