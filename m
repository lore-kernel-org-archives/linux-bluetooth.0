Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Unknown answer
From: Marcel Holtmann <marcel@holtmann.org>
To: zubiwat <zubiwat@poczta.onet.pl>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001101c414a2$2d426540$fcca010a@lysydziadek>
References: <000e01c4145d$904fa7f0$fcca010a@lysydziadek>
	 <1080462748.2281.92.camel@pegasus>
	 <001101c414a2$2d426540$fcca010a@lysydziadek>
Content-Type: text/plain
Message-Id: <1080477828.2281.108.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 28 Mar 2004 14:43:48 +0200

Hi Maciej,

> Please this is the last - really. How do you decode this because 0e after 04
> means an error. After 04 shouldn't be 00 as a command succeeded. How do you
> look into specification to find out the answer?
> I swear it's the last question, because it will solve my problems.

actually your problem is reading the HCI specification. It is all there
and the HCI part is one of the easier parts of Bluetooth.

So do it step by step and take this as an example

	04 0E 0A 01 09 10 00 04 00 20 DD 09 00


	04 = H:4 specific and means this is a HCI event

	0E 0A = HCI event header

		struct hci_event_hdr {
	        	uint8_t         event;
		        uint8_t         plen;
		} __attribute__ ((packed));

		0E = HCI command complete event
		0A = Event len (= 10 bytes)

	01 09 10 = HCI command complete event

		struct hci_command_complete_evt {
		        uint8_t         ncmd;
		        uint16_t        opcode;
		        /* variable length part */
		        uint8_t         param[0];
		} __attribute__ ((packed));

		01 = Number of command packets (HCI flow control)
		09 10 = Command opcode (OCF & OGF)

	00 04 00 20 DD 09 00 = HCI read BD_ADDR response

		struct hci_read_bd_addr_rp {
		        uint8_t         status;
		        bdaddr_t        bdaddr;
		} __attribute__ ((packed));

		00 = Status (= OK)
		04 00 20 DD 09 00 = BD_ADDR

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
