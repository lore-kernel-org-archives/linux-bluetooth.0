Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120425194852.GB2781@joana>
References: <CAK678xgXnf-bgBRGU+tyNdnUv4VoGM+XyH15W0jw8h3Wypi+_A@mail.gmail.com>
	<20120425194852.GB2781@joana>
Date: Thu, 26 Apr 2012 07:07:54 +0300
Message-ID: <CAK678xiBPbdnx=U4tV4Zj0=0vraU1RwyEpxe3W7fy7TA6gTqVQ@mail.gmail.com>
Subject: Re: Bug report: bluetoothd broken for a USB dongle since bluez 4.85
From: coekbe <coekbe@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Apr 25, 2012 at 10:48 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Can you also send the output of hciconfig -a?

Sure. Here it is (with my bluetooth address hidden):

-----------------------------------------------
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 02:03:05:07:11:13  ACL MTU: 384:8  SCO MTU: 64:8
	UP RUNNING PSCAN
	RX bytes:978 acl:0 sco:0 events:27 errors:0
	TX bytes:355 acl:0 sco:0 commands:26 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF PARK
	Link mode: SLAVE ACCEPT
	Name: 'localhost-0'
	Class: 0x420100
	Service Classes: Networking, Telephony
	Device Class: Computer, Uncategorized
	HCI Version: 1.1 (0x1)  Revision: 0x7a6
	LMP Version: 1.1 (0x1)  Subversion: 0x7a6
	Manufacturer: Cambridge Silicon Radio (10)
-------------------------------------------------------


Perhaps the following is the correct patch (works with my device):

-----------------------------------------------------------------
--- bluez-4.99/plugins/hciops.c.orig	2012-03-05 11:03:57.000000000 +0200
+++ bluez-4.99/plugins/hciops.c	2012-04-26 06:38:53.105166053 +0300
@@ -565,7 +565,7 @@ static void set_event_mask(int index)
 	}

 	if (dev->features[3] & LMP_RSSI_INQ)
-		events[4] |= 0x04; /* Inquiry Result with RSSI */
+		events[4] |= 0x02; /* Inquiry Result with RSSI */

 	if (dev->features[5] & LMP_SNIFF_SUBR)
 		events[5] |= 0x20; /* Sniff Subrating */
-------------------------------------------------------------------

Above the code that I quoted there's another "event[4] |= 0x02" with the comment
"Inquiry Result with RSSI". Surely it cannot be both 0x02 and 0x04?
The bluetooth spec 1.2 suggests 0x02 is correct.

Regards,
Colin
