Return-Path: <cyrus@holtmann.org>
Subject: Re: Memory leak on failed connection attempt
From: Tomas Targownik <ttargownik@geicp.com>
Reply-To: ttargownik@geicp.com
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20110616212645.GF2594@joana>
References: <1306997293.1926.83.camel@rnd3> <20110602135720.GB2790@joana>
	 <1308035004.1926.611.camel@rnd3> <1308180155.1926.640.camel@rnd3>
	 <20110616212645.GF2594@joana>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 20 Jun 2011 13:15:23 +1000
Message-ID: <1308539723.2042.34.camel@rnd3>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2011-06-16 at 18:26 -0300, Gustavo F. Padovan wrote:
> Hi Tomas,
> [...]
> I also need the hcidump output of this.
>

Hi Gustavo, 

When running this command, with the remote dongle physically unplugged-
root@mydevice:~# pand --role GN --service PANU --connect
00:0A:94:02:A5:7A

The hcidump output is-
HCI sniffer - Bluetooth packet analyzer ver 2.1
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:94:02:A5:7A ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 65535 bdaddr 00:0A:94:02:A5:7A type ACL encrypt
0x00
    Error: Page Timeout


I noticed that the leak does not occur on the first run of this command.
The leak appears on the second, and all subsequent runs. The hcidump
output is the same in each case. 

Thank you, 
Tomas Targownik






