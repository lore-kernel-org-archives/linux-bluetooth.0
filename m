Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Jun 2009 10:18:44 -0400
From: =?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>
To: linux-bluetooth@vger.kernel.org
Subject: eSCO->SCO fallback still doesn't work for me
Message-ID: <20090601141844.GA5018@toroia.fbriere.dyndns.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I don't know if I'm the unlucky owner of yet another broken Bluetooth
adapter, but I still can't get eSCO->SCO fallback to work, even with
2.6.30-rc7.  Attempting to connect to my headset yields:

	ALSA lib pcm_bluetooth.c:464:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION failed : Input/output error(5)

While my syslog shows:

	hcid[6085]: Audio API: received BT_GETCAPABILITIES_REQ
	hcid[6085]: Audio API: sending BT_GETCAPABILITIES_RSP
	hcid[6085]: Audio API: received BT_SETCONFIGURATION_REQ
	hcid[6085]: config sco - device = 00:0b:2e:03:07:1b access_mode = 2
	hcid[6085]: connect(): Protocol not supported (93)
	hcid[6085]: Unable to lock headset
	hcid[6085]: config failed
	hcid[6085]: Audio API: sending BT_SETCONFIGURATION_RSP

Only by ripping out eSCO support completely[*] can I manage to connect.


I'm attaching the (binary) HCI dump of such a failed connection.  Here's
the output of hciconfig, as well as the relevant part of /proc/usb:

hci0:	Type: USB
	BD Address: 00:10:60:A5:27:84 ACL MTU: 192:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:2414 acl:32 sco:0 events:72 errors:0
	TX bytes:996 acl:30 sco:0 commands:34 errors:0
	Features: 0xff 0xff 0x8f 0xf8 0x18 0x18 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'toroia-0'
	Class: 0x080100
	Service Classes: Capturing
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x639 LMP Ver: 1.1 (0x1) LMP Subver: 0x639
	Manufacturer: Cambridge Silicon Radio (10)

	T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
	D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
	P:  Vendor=0a12 ProdID=0001 Rev=15.93
	C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=100mA
	I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
	E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
	E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
	E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
	I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
	E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
	E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
	I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
	E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
	E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
	I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
	E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
	E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
	I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
	E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
	E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
	I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
	E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
	E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
	I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
	E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
	E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms


Let me know if I can be of any help.


[*] The disable_esco parameter doesn't work for me.  This only turns off
    the one lmp_esco_capable() in net/bluetooth/sco.c, which is not
    enough; there are two more in net/bluetooth/hci_conn.c which will
    make any connection attempt fail.  (There are also two others in
    net/bluetooth/hci_event.c, but they don't appear to have any
    impact.)

-- 
/*
 * Buddy system. Hairy. You really aren't expected to understand this
 *
 */
		-- From /usr/src/linux/mm/page_alloc.cA

--45Z9DzgjV8m4Oswq
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="hci.dump"
Content-Transfer-Encoding: base64

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
AAAAAAAA

--45Z9DzgjV8m4Oswq--
