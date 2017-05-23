Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 23 May 2017 08:34:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, Laura Abbott <labbott@redhat.com>
Subject: [bug report] Bluetooth: Fix memory leaking when hdev->send returns
 an error
Message-ID: <20170523053400.GA3371@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel Holtmann,

The patch cdc52faac5f3: "Bluetooth: Fix memory leaking when
hdev->send returns an error" from Jul 6, 2014, leads to the following
static checker warning:

	net/bluetooth/hci_core.c:3385 hci_send_frame()
	warn: 'skb' was already freed.

net/bluetooth/hci_core.c
  3377          if (!test_bit(HCI_RUNNING, &hdev->flags)) {
  3378                  kfree_skb(skb);
  3379                  return;
  3380          }
  3381  
  3382          err = hdev->send(hdev, skb);
  3383          if (err < 0) {
  3384                  BT_ERR("%s sending frame failed (%d)", hdev->name, err);
  3385                  kfree_skb(skb);
  3386          }


The ti_st_send_frame() frees skb on error.  I'm surprised this bug
wasn't found by KAsan when we found acf91ec384dd ("Bluetooth: btwilink:
Save the packet type before sending").

I don't totally understand how skb is freed on the success path either.
bfusb_send_frame(), dtl1_hci_send_frame() and btqcomsmd_send() have
calls to kfree_skb() but I can't find the calls in bpa10x_send_frame()
or the other ->send functions.

regards,
dan carpenter
