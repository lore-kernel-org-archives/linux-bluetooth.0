Return-Path: <cyrus@holtmann.org>
Subject: Re: Problem with an Apple bluetooth keyboard
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: "Daniel O'Connor" <doconnor@gsoft.com.au>
In-Reply-To: <20110305005651.GC9005@joana>
Date: Sat, 5 Mar 2011 12:30:30 +1030
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <54ACF959-8CC7-4DE2-BC06-91A841FCF828@gsoft.com.au>
References: <AA50FBAC-6B8B-4D61-83A0-0B8D4B24B967@gsoft.com.au> <20110305005651.GC9005@joana>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 05/03/2011, at 11:26, Gustavo F. Padovan wrote:
>> Is there some command I can run to re-probe it as a work around? Or perhaps some debugging I can enable to find out exactly what is going wrong.
> 
> Send to us the output of "hciconfig -a" before you unplug the dongle.

Output is as follows:

hci0:	Type: USB
	BD Address: 00:10:DC:57:76:BE ACL MTU: 192:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:689 acl:0 sco:0 events:22 errors:0
	TX bytes:86 acl:0 sco:0 commands:22 errors:0
	Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: 
	Link mode: SLAVE ACCEPT 
	Name: 'MythTV'
	Class: 0x4a0000
	Service Classes: Networking, Capturing, Telephony
	Device Class: Miscellaneous, 
	HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver: 0x110
	Manufacturer: Cambridge Silicon Radio (10)

Thanks.

--
Daniel O'Connor software and network engineer
for Genesis Software - http://www.gsoft.com.au
"The nice thing about standards is that there
are so many of them to choose from."
  -- Andrew Tanenbaum
GPG Fingerprint - 5596 B766 97C0 0E94 4347 295E E593 DC20 7B3F CE8C






