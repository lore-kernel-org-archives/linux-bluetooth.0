Return-Path: <cyrus@holtmann.org>
Subject: Re: Security mode 3 pairing acceptor broken with current
 bluetooth-testing
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090508234902.GA6615@jh-x301>
References: <20090508234902.GA6615@jh-x301>
Content-Type: text/plain
Date: Fri, 08 May 2009 17:08:03 -0700
Message-Id: <1241827683.4903.78.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> I'm getting the following with latest bluetooth-testing kernel when
> accepting a connection when either device is in security mode 3:
> 
> $ hcidump -V -r secmode3-acp.dump
> HCI sniffer - Bluetooth packet analyzer ver 1.42
> btsnoop version: 1 datalink type: 1002
> > HCI Event: Connect Request (0x04) plen 10
>     bdaddr 00:24:7D:XX:XX:XX class 0x5a020c type ACL
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 00:24:7D:XX:XX:XX role 0x00
>     Role: Master
> > HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> > HCI Event: Role Change (0x12) plen 8
>     status 0x00 bdaddr 00:24:7D:XX:XX:XX role 0x00
>     Role: Master
> > HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:24:7D:XX:XX:XX
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>     bdaddr 00:24:7D:XX:XX:XX
> > HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
>     status 0x00 bdaddr 00:24:7D:XX:XX:XX
> > HCI Event: PIN Code Request (0x16) plen 6
>     bdaddr 00:24:7D:XX:XX:XX
> < HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
>     bdaddr 00:24:7D:XX:XX:XX

what is the time between the PIN code request and the cancel command?

--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -171,7 +171,7 @@ static void hci_conn_timeout(unsigned long arg)
        switch (conn->state) {
        case BT_CONNECT:
        case BT_CONNECT2:
-               if (conn->type == ACL_LINK)
+               if (conn->type == ACL_LINK && conn->out)
                        hci_acl_connect_cancel(conn);
                else
                        hci_acl_disconn(conn, 0x13);

The above patch might fixes it. However without the timing between the
commands, I don't know what triggers it.

Regards

Marcel


