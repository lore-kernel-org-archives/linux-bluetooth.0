Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=NmMoT2vM=kCvq6JryT5f-MeTWrg@mail.gmail.com>
References: <BANLkTi=NmMoT2vM=kCvq6JryT5f-MeTWrg@mail.gmail.com>
From: Takeshi Hamasaki <hmatrjp@users.sourceforge.jp>
Date: Tue, 14 Jun 2011 00:48:28 +0900
Message-ID: <BANLkTikBv9nbvEfrPjSjf15yWhuFJ33jJw@mail.gmail.com>
Subject: Re: Pairing fails on kernel 2.6.39 with "Command Disallowed" error,
 while on 2.6.26 it works fine
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/6/10 Takeshi Hamasaki <hmatrjp@users.sourceforge.jp>:
> # hcitool info 00:1A:7D:60:4A:AA
> Requesting information ...
>        BD Address:  00:1A:7D:60:4A:AA
>        Device Name: MM-BTSH24
>        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00

This result changed after I added some lines in function
hci_conn_check_pending() in net/bluetooth/hci_conn.c in kernel 2.6.39,
following change make ACL connection and it lets succeed the command:

# hcitool info 00:1A:7D:60:4A:AA
Requesting information ...
        BD Address:  00:1A:7D:60:4A:AA
        Device Name: MM-BTSH24
        LMP Version: 2.1 (0x4) LMP Subversion: 0x14fa
        Manufacturer: Cambridge Silicon Radio (10)
        Features page 0: 0xff 0xfe 0x0f 0xc6 0x8b 0xef 0x59 0x83
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO> <EDR ACL 2 Mbps>
                <EDR ACL 3 Mbps> <inquiry with RSSI> <extended SCO>
                <EV4 packets> <EV5 packets> <AFH cap. slave> <3-slot EDR ACL>
                <5-slot EDR ACL> <sniff subrating> <pause encryption>
                <AFH cap. master> <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps>
                <3-slot EDR eSCO> <extended inquiry> <simple pairing>
                <encapsulated PDU> <non-flush flag> <LSTO> <inquiry TX power>
                <extended features>
        Features page 1: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00

------------------- changes in hci_conn.c -----------from here
void hci_conn_check_pending(struct hci_dev *hdev)
{
	struct hci_conn *conn;

	BT_DBG("hdev %s", hdev->name);

	hci_dev_lock(hdev);

	conn = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
	if (conn)
		hci_acl_connect(conn);
+       else {
+               conn = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONFIG);
+               if (conn) {
+                       BT_DBG("I couldn't find BT_CONNECT2 but
BT_CONFIG: address %s", batostr( &(hdev->bdaddr) ) );
+                       hci_acl_connect(conn);
+               }
+       }
	hci_dev_unlock(hdev);
}
------------------- changes in hci_conn.c -----------to here

>From enum definition in bluetooth.h:
BT_CONNECT2 = 6
and
BT_CONFIG = 7

Why the status was BT_CONFIG and was not BT_CONNECT2?


Anyway, it doesn't help to create connection to the headset device:
# hcitool cc 00:1A:7D:60:4A:AA

hcidump shows:

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:1A:7D:60:4A:AA ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0b ncmd 1
    Error: ACL Connection Already Exists

So I'm not sure the change is right or not.
Any suggestions?
-- 
Takeshi Hamasaki
