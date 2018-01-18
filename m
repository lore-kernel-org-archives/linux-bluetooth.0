Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH RESEND] Bluetooth: btbcm: Add entry for BCM4343A0 UART
 bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180118092155.3595-1-joerg.krause@embedded.rocks>
Date: Thu, 18 Jan 2018 10:25:00 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>
Message-Id: <98813AEE-B05E-4170-A75A-BEE7D99DCF62@holtmann.org>
References: <20180118092155.3595-1-joerg.krause@embedded.rocks>
To: =?utf-8?Q?J=C3=B6rg_Krause?= <joerg.krause@embedded.rocks>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joerg,

> RESEND using Content-Transfer-Encoding: 8bit instead of base64.
> 
> This patch adds the device ID for the bluetooth chip used in the
> AMPAK AP6212 WiFi+Bluetooth module. The AP6212 is used on several
> BananaPi boards, e.g. M2-Ultra.
> 
> The AP6212 is a combo module, where the WiFi chip is identified as
> BCM43430A0 whereas the Bluetooth chip identifies itself as 4343A0. Note,
> the missing '0' before the 'A0'.
> 
> The AP6212 needs a firmware blob. Loading the provided firmware file
> from the BananaPi vendor, the adapter name is printed as
> 'BCM4343A0 26MHz AP6212_CL1-0061':
> 
> '''
> hci0:	Type: Primary  Bus: UART
> 	BD Address: 43:43:A0:12:1F:AC  ACL MTU: 1021:8  SCO MTU: 64:1
> 	UP RUNNING
> 	RX bytes:3076 acl:0 sco:0 events:278 errors:0
> 	TX bytes:39726 acl:0 sco:0 commands:279 errors:0
> 	Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> 	Link policy: RSWITCH SNIFF
> 	Link mode: SLAVE ACCEPT
> 	Name: 'BCM4343A0 26MHz AP6212_CL1-0061'
> 	Class: 0x000000
> 	Service Classes: Unspecified
> 	Device Class: Miscellaneous,
> 	HCI Version: 4.1 (0x7)  Revision: 0xf2
> 	LMP Version: 4.1 (0x7)  Subversion: 0x2122
> 	Manufacturer: Broadcom Corporation (15)
> '''
> 
> Signed-off-by: Jörg Krause <joerg.krause@embedded.rocks>
> ---
> drivers/bluetooth/btbcm.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

