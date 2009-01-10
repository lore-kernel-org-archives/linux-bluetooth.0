Return-Path: <cyrus@holtmann.org>
Date: Sat, 10 Jan 2009 17:59:59 +0000 (GMT)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: "packet types" wrong in libbluetooth
In-Reply-To: <1231604005.5229.5.camel@californication>
References: <1231595402.312160.19752.nullmailer@galant.ukfsn.org>
 <1231597284.5229.2.camel@californication>  <1231603296.653256.942.nullmailer@galant.ukfsn.org>
 <1231604005.5229.5.camel@californication>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1231610399.472890.11276.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 10 Jan 2009, Marcel Holtmann wrote:
> the Create Connection displays the actual bits set. And that is how it
> suppose to be. The above line means EDR disabled. You set the bitmask
> and that the meaning of some bits is disabled instead of enabled is a
> different story.

Well I see what you are saying

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:19:63:B4:99:17 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5

The actual bitwise value is clearly shown as "0xcc18". That the human
readable output does not show the correct meaning by design seems weird.

(imho of course :)
iain
