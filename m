Return-Path: <cyrus@holtmann.org>
From: "Andrew Kohlsmith (mailing lists account)" <aklists@mixdown.ca>
To: linux-bluetooth@vger.kernel.org
Subject: odd cid change in l2cap negotiation
Date: Sun, 13 Jun 2010 17:28:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201006131728.36687.aklists@mixdown.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Good afternoon,

I'm working on a small embedded system with its own stack and using BlueZ on 
Ubuntu 9.04 (4.32 according to apt-cache).

I am using a very stupid l2cap test program (listed below) to just open a 
connection to psm 0x1001 and send "Hello, World!".

The embedded system receives the L2CAP connection request from BlueZ (scid of 
0x0040) and responds by sending a configuration request. It uses dcid 0x0040.  
BlueZ responds to the configuration request with a successful configuration 
response, but it sets the scid to 0x0000 and I can't for the life of me figure 
out why.

The raw HCI packets (obtained from hcidump) are as follows:

BlueZ connection request:
02 2a 20 0c 00 08 00 01 00 02 02 04 00 01 10 40 00

Embedded configure request:
02 2a 20 10 00 0c 00 01 00 04 02 08 00 40 00 00 00 01 02 96 00

BlueZ configure response:
02 2a 20 12 00 0e 00 01 00 05 02 0a 00 00 00 00 00 00 00 01 02 96 00

BlueZ configure request:
02 2a 20 0c 00 08 00 01 00 04 03 04 00 00 00 00 00

As you can see, the connection request is using scid 0x0040 to psm 0x1001, and 
the configure request coming back to BlueZ is using dcid 0x0040. The BlueZ 
configure response (and subsequent request) are using channel id 0x0000. Why is 
this?

If I patch out the embedded system's L2CAP handler code to accept the 
configuration response coming from the wrong cid BlueZ continues by sending the 
data packet ("Hello, World!" but again, to dcid 0x0000...

Why is BlueZ flipping the channel ID like this? I am assuming that I am making 
a mistake somewhere as BlueZ gets a LOT more use than this embedded stack, but 
I can't figure out what this is happening for nor how to correctly work with 
it.

Regards,
Andrew

l2captest program:
$ cat tools/l2captest/l2capclient.c 
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/l2cap.h>

int main(int argc, char **argv)
{
        struct sockaddr_l2 addr = { 0 };
        int s, status;
        char *message = "Hello, world!\n";
        char dest[18] = "11:22:33:44:55:66";

        if(argc < 2) {
                fprintf(stderr, "usage: %s <bt_addr>\n", argv[0]);
                return 1;
        }

        strncpy(dest, argv[1], 18);

        // allocate a socket
        s = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);

        // set the connection parameters (who to connect to)
        addr.l2_family = AF_BLUETOOTH;
        addr.l2_psm = htobs(0x1001);
        str2ba(dest, &addr.l2_bdaddr);

        // connect to server
        status = connect(s, (struct sockaddr *)&addr, sizeof(addr));

        // send a message
        if(status == 0) {
                status = write(s, message, 15);
        }

        if( status < 0 ) perror("uh oh");

        close(s);
        return 0;
}

hcidump -XV -t output:
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
2010-06-13 17:27:08.423268 < HCI Command: Create Connection (0x01|0x0005) plen 
13
    bdaddr 11:22:33:44:55:66 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2010-06-13 17:27:08.495324 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2010-06-13 17:27:09.703325 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 11:22:33:44:55:66 type ACL encrypt 0x00
2010-06-13 17:27:09.703363 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 42
2010-06-13 17:27:09.740326 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2010-06-13 17:27:09.741324 > HCI Event: Page Scan Repetition Mode Change 
(0x20) plen 7
    bdaddr 11:22:33:44:55:66 mode 1
2010-06-13 17:27:09.742327 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
2010-06-13 17:27:09.745327 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2010-06-13 17:27:09.745343 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 11:22:33:44:55:66 mode 2 clkoffset 0x0000
2010-06-13 17:27:09.749324 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2010-06-13 17:27:09.754206 > HCI Event: Read Remote Supported Features (0x0b) 
plen 11
    status 0x00 handle 42
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
2010-06-13 17:27:09.754227 < ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2010-06-13 17:27:09.759326 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2010-06-13 17:27:09.777323 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 11:22:33:44:55:66 name 'inPulse'
2010-06-13 17:27:09.824448 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 2 result 1
      Not supported
2010-06-13 17:27:09.824469 < ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 4097 scid 0x0040
2010-06-13 17:27:09.830326 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2010-06-13 17:27:10.195699 > ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 150
2010-06-13 17:27:10.195724 < ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0000 flags 0x00 result 0 clen 4
      MTU 150
2010-06-13 17:27:10.195728 < ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0000 flags 0x00 clen 0
2010-06-13 17:27:10.201327 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1
2010-06-13 17:27:10.203324 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 42 packets 1

(after a long pause, it times out)

2010-06-13 17:27:50.422951 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 42 reason 0x13
    Reason: Remote User Terminated Connection
2010-06-13 17:27:50.426338 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2010-06-13 17:27:50.430344 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x16
    Reason: Connection Terminated by Local Host
