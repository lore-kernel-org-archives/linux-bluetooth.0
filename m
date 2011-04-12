Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 12 Apr 2011 14:36:01 +0300
Message-ID: <BANLkTinfkhcfYu_L+5B_LkQVZyp8VdnnBw@mail.gmail.com>
Subject: Wrong timeout when connecting to device with removed pairing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Apparently this is a regression caused by commit
769be974d0c7b4fe1a52f9cdaad22259b60953f7 - [Bluetooth] Use ACL config
stage to retrieve remote features, when receiving pincode request in a
new connection the state will be BT_CONFIG so HCI_PAIRING_TIMEOUT is
never set to the connection, this could be reproduced by removing a
link key in the remote side and trying to connect:

2011-04-05 12:11:37.070953 < HCI Command: Authentication Requested
(0x01|0x0011) plen 2
    handle 1
2011-04-05 12:11:37.071686 > HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
2011-04-05 12:11:37.071838 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:1F:E1:EB:B9:CB
2011-04-05 12:11:37.075073 < HCI Command: Link Key Request Reply
(0x01|0x000b) plen 22
    bdaddr 00:1F:E1:EB:B9:CB key 92BA9EAD06542B0600457C609B8F5395
2011-04-05 12:11:37.075775 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:1F:E1:EB:B9:CB
2011-04-05 12:11:37.087005 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:1F:E1:EB:B9:CB
2011-04-05 12:11:39.038849 < ACL data: handle 1 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x00a9 scid 0x0040
2011-04-05 12:11:39.100647 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 1
2011-04-05 12:11:39.100830 > ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00a9 scid 0x0040
2011-04-05 12:11:40.433624 > HCI Event: Auth Complete (0x06) plen 3
    status 0x13 handle 1
    Error: Remote User Terminated Connection
2011-04-05 12:11:40.437774 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x13
    Reason: Remote User Terminated Connection

I think the following patch might fix it:

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3fbfa50..abdc4de 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1973,10 +1973,14 @@ static inline void hci_pin_code_request_evt(struct
hci_dev *hdev, struct sk_buff
        hci_dev_lock(hdev);

        conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-       if (conn && conn->state == BT_CONNECTED) {
-               hci_conn_hold(conn);
+       if (conn) {
                conn->disc_timeout = HCI_PAIRING_TIMEOUT;
-               hci_conn_put(conn);
+
+               /* Update disconnect timer */
+               if (conn->state == BT_CONNECTED) {
+                       hci_conn_hold(conn);
+                       hci_conn_put(conn);
+               }
        }

Comments?

-- 
Luiz Augusto von Dentz
Computer Engineer
