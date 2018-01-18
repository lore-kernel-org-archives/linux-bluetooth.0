Return-Path: <joerg.krause@embedded.rocks>
Message-ID: <1516264205.13152.5.camel@embedded.rocks>
Subject: Re: [PATCH RESEND] Bluetooth: btbcm: Add entry for BCM4343A0 UART
 bluetooth
From: =?ISO-8859-1?Q?J=F6rg?= Krause <joerg.krause@embedded.rocks>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, "Gustavo F. Padovan"
 <gustavo@padovan.org>
Date: Thu, 18 Jan 2018 09:30:05 +0100
In-Reply-To: <C5CA8B97-C593-4B0F-9D73-EF9DAFA4B782@holtmann.org>
References: <20180117232706.25077-1-joerg.krause@embedded.rocks>
	 <C5CA8B97-C593-4B0F-9D73-EF9DAFA4B782@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, 2018-01-18 at 08:45 +0100, Marcel Holtmann wrote:
> Hi Joerg,
> 
> > RESEND because of missing the correct Ccs. Original patch is [0].
> > 
> > This patch adds the device ID for the bluetooth chip used in the
> > AMPAK AP6212 WiFi+Bluetooth module. The AP6212 is used on several
> > BananaPi boards, e.g. M2-Ultra.
> > 
> > The AP6212 is a combo module, where the WiFi chip is identified as
> > BCM43430A0 whereas the Bluetooth chip identifies itself as 4343A0. Note,
> > the missing '0' before the 'A0'.
> > 
> > The AP6212 needs a firmware blob. Loading the provided firmware file
> > from the BananaPi vendor, the adapter name is printed as
> > 'BCM4343A0 26MHz AP6212_CL1-0061':
> > 
> > '''
> > hci0:	Type: Primary  Bus: UART
> > 	BD Address: 43:43:A0:12:1F:AC  ACL MTU: 1021:8  SCO MTU: 64:1
> > 	UP RUNNING
> > 	RX bytes:3076 acl:0 sco:0 events:278 errors:0
> > 	TX bytes:39726 acl:0 sco:0 commands:279 errors:0
> > 	Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
> > 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> > 	Link policy: RSWITCH SNIFF
> > 	Link mode: SLAVE ACCEPT
> > 	Name: 'BCM4343A0 26MHz AP6212_CL1-0061'
> > 	Class: 0x000000
> > 	Service Classes: Unspecified
> > 	Device Class: Miscellaneous,
> > 	HCI Version: 4.1 (0x7)  Revision: 0xf2
> > 	LMP Version: 4.1 (0x7)  Subversion: 0x2122
> > 	Manufacturer: Broadcom Corporation (15)
> > '''
> > 
> > [0] https://www.spinics.net/lists/linux-bluetooth/msg71876.html
> > 
> > Signed-off-by: Jörg Krause <joerg.krause@embedded.rocks>
> > ---
> > drivers/bluetooth/btbcm.c | 1 +
> > 1 file changed, 1 insertion(+)
> 
> can you use git-send-email so that I get a patch that is not base64 encoded. Otherwise I can not apply it.

I did use git-send-email, but you're right, I set the transferencoding
to base64. Shall I use 8bit instead?

Best regards,
Jörg Krause
