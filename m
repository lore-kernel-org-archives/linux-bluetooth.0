Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Sep 2011 10:08:04 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: waldemar.rymarkiewicz@tieto.com
Cc: linux-bluetooth@vger.kernel.org
Subject: re: Bluetooth: Add secure flag for mgmt_pin_code_req
Message-ID: <20110921070804.GA5982@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Waldemar Rymarkiewicz,

This is a semi-automatic email about new static checker warnings.

Thu Apr 28 12:07:59 2011 +0200
a770bb5aea84: "Bluetooth: Add secure flag for mgmt_pin_code_req"

Leads to the following Smatch complaint:
net/bluetooth/hci_event.c +2189 hci_pin_code_request_evt()
	 error: we previously assumed 'conn' could be null (see line 2177)

net/bluetooth/hci_event.c
  2176		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
  2177		if (conn && conn->state == BT_CONNECTED) {
                    ^^^^
conn can be NULL.

  2178			hci_conn_hold(conn);
  2179			conn->disc_timeout = HCI_PAIRING_TIMEOUT;
  2180			hci_conn_put(conn);
  2181		}
  2182	
  2183		if (!test_bit(HCI_PAIRABLE, &hdev->flags))
  2184			hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
  2185						sizeof(ev->bdaddr), &ev->bdaddr);
  2186		else if (test_bit(HCI_MGMT, &hdev->flags)) {
  2187			u8 secure;
  2188	
  2189			if (conn->pending_sec_level == BT_SECURITY_HIGH)
                            ^^^^^^^^^^^^^^^^^^^^^^^
dereferenced unconditionally here.

  2190				secure = 1;
  2191			else

regards,
dan carpenter
