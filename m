Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 19 Apr 2017 16:51:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: bjorn.andersson@sonymobile.com
Cc: linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver
Message-ID: <20170419135151.ho3jodg6fsnmsz4m@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Bjorn Andersson,

The patch 1511cc750c3d: "Bluetooth: Introduce Qualcomm WCNSS SMD
based HCI driver" from Aug 12, 2016, leads to the following static
checker warning:

	net/bluetooth/hci_core.c:3349 hci_send_frame()
	error: double free of 'skb'

net/bluetooth/hci_core.c
    68  static int btqcomsmd_send(struct hci_dev *hdev, struct sk_buff *skb)
    69  {
    70          struct btqcomsmd *btq = hci_get_drvdata(hdev);
    71          int ret;
    72  
    73          switch (hci_skb_pkt_type(skb)) {
    74          case HCI_ACLDATA_PKT:
    75                  ret = rpmsg_send(btq->acl_channel, skb->data, skb->len);
    76                  hdev->stat.acl_tx++;
    77                  hdev->stat.byte_tx += skb->len;
    78                  break;
    79          case HCI_COMMAND_PKT:
    80                  ret = rpmsg_send(btq->cmd_channel, skb->data, skb->len);
    81                  hdev->stat.cmd_tx++;
    82                  break;
    83          default:
    84                  ret = -EILSEQ;
    85                  break;
    86          }
    87  
    88          kfree_skb(skb);
    89  
    90          return ret;
    91  }
    92  

This function is called from:

net/bluetooth/hci_core.c
  3320  static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
  3321  {
  3322          int err;
  3323  
  3324          BT_DBG("%s type %d len %d", hdev->name, hci_skb_pkt_type(skb),
  3325                 skb->len);
  3326  
  3327          /* Time stamp */
  3328          __net_timestamp(skb);
  3329  
  3330          /* Send copy to monitor */
  3331          hci_send_to_monitor(hdev, skb);
  3332  
  3333          if (atomic_read(&hdev->promisc)) {
  3334                  /* Send copy to the sockets */
  3335                  hci_send_to_sock(hdev, skb);
  3336          }
  3337  
  3338          /* Get rid of skb owner, prior to sending to the driver. */
  3339          skb_orphan(skb);
  3340  
  3341          if (!test_bit(HCI_RUNNING, &hdev->flags)) {
  3342                  kfree_skb(skb);
  3343                  return;
  3344          }
  3345  
  3346          err = hdev->send(hdev, skb);
  3347          if (err < 0) {
  3348                  BT_ERR("%s sending frame failed (%d)", hdev->name, err);
  3349                  kfree_skb(skb);

It expects that "skb" is freed on success but not on failure.  I think
ti_st_send_frame() has a similar bug.

  3350          }
  3351  }

regards,
dan carpenter
