Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY107-F22A1A1C4932DC8BBF0358D80590@phx.gbl>
From: "julien giraudi" <ju_lausanne@hotmail.com>
To: bluez-users@lists.sourceforge.net
Date: Fri, 28 Jul 2006 11:34:38 +0000
Mime-Version: 1.0
Subject: [Bluez-users] FW: Re:  RfCOMM connection problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,


Thanks for your reply.

I am asking you this question because I am using a Bluez Rfcomm server.
One SDK from Broadcom is available for free:

http://www.broadcom.com/products/bluetooth_sdk.php


My question was about rfcomm layer and services and you guys seem to be =

expert in bluetooth so you may have play around with bluetooth of ipaqs and =

bluez servers...
I read that it was not possible at all to use the microsoft API cause Ipacs =

are using broadcom stack.

My problem may come from the security handshake...but I don't know how to =

fix it.
I though the security parameters should be set by the server but according =

to the Broadcom specification...both client and server should set them.

The problem is that on the client side, using broadcom SDK, setting securit=
y =

parameters requires a service name...that 's what i don't get. How to get a =

service from the bluez server and must i use a service??
A program in java on a sony ericsson works fine with your Bluez =

server...only simple socket programming. I just want to do the same with my =

ipac in C/C++



This is my master project...and I really need to fix this, I am sure it is =

not a big deal...but I am novice in this field


Thanks a lot for your help


Regards
Julien




---------------------------------------------------------------------------=
-----------------------------------------------------------

Hi Julien,

>I just want to connect my ipac to a RFcomm Bluez linux server through
>bluetooth. I only want to send some "char arrays" through a socket to the =

>linux
>machine. (i.e. use Write() of widcomm stack for ipac) I would like to
>know if it should be possible to create such a connection at the Rfcomm
>layer without using a higher level protocol (FTP,OBEX,...)?
>
>i.e. for the moment I use the following command:
>
>obj2.OpenClient(1,addr) ;
>
>Can we assign the channel 1 like this or must I use the function
>"obj2.AssignScnValue (p_service_guid,1)" ?
>I do not want to use this function since I don't want to use any
>service...

you are not seriously asking Widcomm related questions on a Linux
mailing list. How should we know? The Widcomm SDK is not available for
free.

>It is trying to connect to the Bluez server and gives me the following
>response using hcidump:

Do you mind sending this with an email client that doesn't screw up
pre-formatted text.

>It seems that the server does even not receive the tentative of
>connection of my client. The Disconnection packet DISC is sent by the
>client, like a timeout.

Your client sends the DISC. Fix your client and try again.

Regards

Marcel


---------------------------------------------------------------------------=
--------------------------------------------------------

Hello,



I just want to connect my ipac to a RFcomm Bluez linux server through =

bluetooth.
I only want to send some "char arrays" through a socket to the linux =

machine. (i.e. use Write() of widcomm stack for ipac) I would like to know =

if it should be possible to create such a connection at the Rfcomm layer =

without using a higher level protocol (FTP,OBEX,...)?

i.e. for the moment I use the following command:

obj2.OpenClient(1,addr) ;

Can we assign the channel 1 like this or must I use the function =

"obj2.AssignScnValue (p_service_guid,1)" ?
I do not want to use this function since I don't want to use any service...



It is trying to connect to the Bluez server and gives me the following =

response using hcidump:

HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
>HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>HCI Event: Command Status (0x0f) plen 4 HCI Event: Connect Complete (0x03) =

>plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>HCI Event: Page Scan Repetition Mode Change (0x20) plen 7 HCI Event: =

>Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>HCI Event: Command Status (0x0f) plen 4 ACL data: handle 0x0029 flags 0x02 =

>dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041 < ACL data: handle 0x0029 flag=
s =

0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
>HCI Event: Connection Packet Type Changed (0x1d) plen 5 HCI Event: Number =

>of Completed Packets (0x13) plen 5 HCI Event: Max Slots Change (0x1b) plen =

>3 ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1691
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0 < ACL =

data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
    MTU 1024
>HCI Event: Number of Completed Packets (0x13) plen 5 HCI Event: Number of =

>Completed Packets (0x13) plen 5 ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
>ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c < ACL data: handle =

0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
>HCI Event: Number of Completed Packets (0x13) plen 5 ACL data: handle =

>0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd < ACL data: handle =

0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
>HCI Event: Number of Completed Packets (0x13) plen 5 ACL data: handle =

>0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041 < ACL data: handle 0x002=
9 =

flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
>HCI Event: Number of Completed Packets (0x13) plen 5 HCI Event: Disconn =

>Complete (0x05) plen 4



It seems that the server does even not receive the tentative of connection =

of my client. The Disconnection packet DISC is sent by the client, like a =

timeout.



Here is the server code Bluez:

#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>

int main(int argc, char **argv)
{
    struct sockaddr_rc loc_addr =3D { 0 }, rem_addr =3D { 0 };
    char buf[1024] =3D { 0 };
    int s, client, bytes_read;
    int opt =3D sizeof(rem_addr);

    // allocate socket
    s =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

    // bind socket to port 1 of the first available
    // local bluetooth adapter
    loc_addr.rc_family =3D AF_BLUETOOTH;
    loc_addr.rc_bdaddr =3D *BDADDR_ANY;
    loc_addr.rc_channel =3D (uint8_t) 1;
    bind(s, (struct sockaddr *)&loc_addr, sizeof(loc_addr));

    // put socket into listening mode
    listen(s, 1);

    // accept one connection
    client =3D accept(s, (struct sockaddr *)&rem_addr, &opt);

    ba2str( &rem_addr.rc_bdaddr, buf );
    fprintf(stderr, "accepted connection from %s\n", buf);
    memset(buf, 0, sizeof(buf));

    // read data from the client
    bytes_read =3D read(client, buf, sizeof(buf));
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
        BOOL test_connection =3D obj2.IsConnected(&addr);
        fprintf(fp3,"Connection Statut %d",test_connection);
        obj1.Close();




Please tell me what is wrong and why the connection fails



Thanks a lot



Julien

_________________________________________________________________
Retrouvez tout en un clin d'=9Cil avec Windows Desktop Search ! =

http://desktop.msn.fr/


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
