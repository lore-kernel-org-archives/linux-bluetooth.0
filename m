Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: =?koi8-r?Q?=E1=D2=D4=C5=CD=20=E2=C9=DA=C0=CB=CF=D7?= <bizon_art@mail.ru>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <E1EHH9S-0008Z1-00.bizon_art-mail-ru@f13.mail.ru>
Subject: [Bluez-devel] It may be a bug in hcidump
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 19 Sep 2005 12:37:26 +0400

Hello All.

Marcel Holtmann written that he "no longer decoding hex numbers"
I`m decide update my sistem.
Bluez libs and tools from 2.17 to 2.21
hcidump from 1.10 to 1.25

I run my application and hcidump.
Output from hcidump -X -V

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:A0:96:1F:A1:78 class 0x005f04 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:A0:96:1F:A1:78 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:A0:96:1F:A1:78 role 0x01
    Role: Slave
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:A0:96:1F:A1:78
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x0c ncmd 1
    Error: Command Disallowed
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:A0:96:1F:A1:78
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:A0:96:1F:A1:78
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:A0:96:1F:A1:78
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:A0:96:1F:A1:78 len 16 pin ''
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:A0:96:1F:A1:78
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:A0:96:1F:A1:78 key 8F5FD4B8EC74031C5010664805F49BF7 type 0
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 40 bdaddr 00:A0:96:1F:A1:78 type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 40 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:A0:96:1F:A1:78 mode 1
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 40
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 40 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 4
    bdaddr  len 160 pin ''
Segmentation fault

The previos version of hcidump was work fine.
My C lib is uClibc-0.9.26. kernel 2.6.13.1-omap1
My application is simple:

int bt_l2cap_open_dev(int iDevNom)
{
	struct sockaddr_l2 L2capAddr;
	int iSockFd;
	iSockFd = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
	if (iSockFd == -1) {
		TRACE1("opening L2CAP socket: %s", strerror(errno));
		return -1;
	};
	L2capAddr.l2_bdaddr = *BDADDR_ANY;
	L2capAddr.l2_family = AF_BLUETOOTH;
	L2capAddr.l2_psm    = htobs(SDP_PSM); // I sigth this valuer in Tsimbal code
	if(0 > bind(iSockFd, (struct sockaddr *)&L2capAddr, sizeof(L2capAddr)))
	{
		TRACE1("binding L2CAP socket: %s", strerror(errno));
		return -1;
	}
	int opt;
	opt |= L2CAP_LM_RELIABLE;
	opt |= L2CAP_LM_AUTH;
	opt |= L2CAP_LM_SECURE;
	if (0 > setsockopt(iSockFd, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)))
	{
		TRACE1("setsockopt: %s", strerror(errno));
		return -1;
	}
	return iSockFd;
};

int main()
{
	int iL2CAPSockFd, iIncoming, iClient;
	iL2CAPSockFd = bt_l2cap_open_dev(0)
	iClient = listen(iL2CAPSockFd, 5);
	if (iClient < 0)
	{
		TRACE("L2CAP thread can`t start");
		exit(1);
	}
	while(TRUE)
	{
		iIncoming = accept(iL2CAPSockFd, (struct sockaddr*) &IncomL2capAddr ,\
			&iSockAddrL2capLen);
		if(bt_l2cap_interface_start(iIncoming))
		{
			TRACE("L2CAP thread can`t start");
			//exit(1);
			sleep(1);
		};
	};
	TRACE("L2CAP thread start");
	return;	
}

Regards
Artem.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
