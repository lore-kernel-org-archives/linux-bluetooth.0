Return-Path: <cyrus@holtmann.org>
Subject: Re: Broken SDP parsing?
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1236301226.3602.2314.camel@cookie.hadess.net>
References: <1236301226.3602.2314.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Sun, 08 Mar 2009 14:46:26 +0000
Message-Id: <1236523586.16880.141.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-03-06 at 01:00 +0000, Bastien Nocera wrote:
> Heya,
> 
<snip>
> The first 2 chars in the IEEE1284 ID are supposed to be the length of
> the string. This should enable me to make the CUPS backend's discovery
> work again.

This isn't quite enough it seems.

>>From DiscoverDevices on org.bluez.Device:
	<attribute id="0x0300">
		<text value="" />
	</attribute>

>>From "sdptool search --xml --bdaddr 00:0C:55:5E:07:E1 HCRP":
	<attribute id="0x0300">
		<text value="&#00;UMFG:HP;MDL:Photosmart 380
series_BT;CMD:PCL,DW-PCL,DESKJET,DYN;CLS:PRINTER;DES:385;" />
	</attribute>

But even in the first case, hcidump says:
              aid 0x0300 (SrvVersion)
                 str 00 55 4d 46 47 3a 48 50 3b 4d 44 4c 3a 50 68 6f 74
6f 73 6d 61 72 74 20 33 38 30 20 73 65 72 69 65 73 5f 42 54 3b 43 4d 44
3a 50 43 4c 2c 44 57 2d 50 43 4c 2c 44 45 53 4b 4a 45 54 2c 44 59 4e 3b
43 4c 53 3a 50 52 49 4e 54 45 52 3b 44 45 53 3a 33 38 35 3b

So the record is received through to bluetoothd, but it discards it for
some reason. Any ideas?

Note that I've already removed all mentions of the device
in /var/lib/bluetooth.

Cheers

