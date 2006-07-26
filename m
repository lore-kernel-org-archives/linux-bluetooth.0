Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 26 Jul 2006 10:03:23 +0530
Message-ID: <22B6B486891D6241B8E3D800F393CE0F7E13AC@BGEEXC07.asiapacific.cpqcorp.net>
From: "Giraudi, Julien (HP Labs India)" <julien.giraudi@hp.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] RfCOMM connection problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hello,


I just want to connect my ipac to a RFcomm Bluez linux server through
bluetooth. 
I only want to send some "char arrays" through a socket to the linux
machine. (i.e. use Write() of widcomm stack for ipac) I would like to
know if it should be possible to create such a connection at the Rfcomm
layer without using a higher level protocol (FTP,OBEX,...)?

i.e. for the moment I use the following command:

obj2.OpenClient(1,addr) ; 

Can we assign the channel 1 like this or must I use the function
"obj2.AssignScnValue (p_service_guid,1)" ?
I do not want to use this function since I don't want to use any
service...


It is trying to connect to the Bluez server and gives me the following
response using hcidump:

HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4 HCI Event: Connect Complete 
> (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7 HCI Event: 
> Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Command Status (0x0f) plen 4 ACL data: handle 0x0029 flags 
> 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041 < ACL data: handle 0x0029
flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
> HCI Event: Connection Packet Type Changed (0x1d) plen 5 HCI Event: 
> Number of Completed Packets (0x13) plen 5 HCI Event: Max Slots Change 
> (0x1b) plen 3 ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1691
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0 < ACL
data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
    MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5 HCI Event: Number

> of Completed Packets (0x13) plen 5 ACL data: handle 0x0029 flags 0x02 
> dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c < ACL data:
handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5 ACL data: handle 
> 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd < ACL data:
handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5 ACL data: handle 
> 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041 < ACL data: handle
0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5 HCI Event: 
> Disconn Complete (0x05) plen 4


It seems that the server does even not receive the tentative of
connection of my client. The Disconnection packet DISC is sent by the
client, like a timeout.
  

Here is the server code Bluez:

#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>

int main(int argc, char **argv)
{
    struct sockaddr_rc loc_addr = { 0 }, rem_addr = { 0 };
    char buf[1024] = { 0 };
    int s, client, bytes_read;
    int opt = sizeof(rem_addr);

    // allocate socket
    s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

    // bind socket to port 1 of the first available
    // local bluetooth adapter
    loc_addr.rc_family = AF_BLUETOOTH;
    loc_addr.rc_bdaddr = *BDADDR_ANY;
    loc_addr.rc_channel = (uint8_t) 1;
    bind(s, (struct sockaddr *)&loc_addr, sizeof(loc_addr));

    // put socket into listening mode
    listen(s, 1);

    // accept one connection
    client = accept(s, (struct sockaddr *)&rem_addr, &opt);

    ba2str( &rem_addr.rc_bdaddr, buf );
    fprintf(stderr, "accepted connection from %s\n", buf);
    memset(buf, 0, sizeof(buf));

    // read data from the client
    bytes_read = read(client, buf, sizeof(buf));
    if( bytes_read > 0 ) {
        printf("received [%s]\n", buf);
    }

    // close connection
    close(client);
    close(s);
    return 0;
}

 
Here is a part of my client code where addr is the server adresse: 

	CRfCommPort obj2;
	obj2.OpenClient(1, addr) ;
	Sleep (5000) ; 
	BOOL test_connection = obj2.IsConnected(&addr);
	fprintf(fp3,"Connection Statut %d",test_connection);
	obj1.Close();



Please tell me what is wrong and why the connection fails


Thanks a lot


Julien

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
