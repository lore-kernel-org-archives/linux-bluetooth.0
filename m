Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110316191540.GC2151@joana>
References: <4D7BB10B.3080100@gmail.com>
	<1300301086-22653-1-git-send-email-padovan@profusion.mobi>
	<20110316184639.GA2151@joana>
	<AANLkTimNeqvBMnb55x10LrwXncx1CnV=OLBUCBJXaGpx@mail.gmail.com>
	<20110316190154.GB2151@joana>
	<4D810B4E.7040702@gmail.com>
	<20110316191540.GC2151@joana>
Date: Wed, 16 Mar 2011 13:02:17 -0700
Message-ID: <AANLkTi=NCL2mWhLfnjD85Zp2y9SYFf6Dx5K0A8ckK7CX@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix HCI_RESET command syncronization
From: Justin Mattock <justinmattock@gmail.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org, mmvinni@yahoo.com, edt@aei.ca
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> No, it's based on bluetooth-next (2.6.39). But you can drop the hci_cmd_timer
> part while testing it. It's not needed unless you have and hci_reset cmd
> timeout.
>
> --
> Gustavo F. Padovan
> http://profusion.mobi
>

o.k. works over here..
Tested-by: Justin P. Mattock <justinmattock@gmail.com>

here is an updated patch for the current Mainline if anybody needs it:

---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/hci_core.c    |    1 +
 net/bluetooth/hci_event.c   |    4 +++-
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 29a7a8c..c4f4c42 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -76,6 +76,7 @@ enum {
 	HCI_INQUIRY,

 	HCI_RAW,
+	HCI_RESET,
 };

 /* HCI ioctl defines */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9c4541b..07a1a4c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -522,6 +522,7 @@ int hci_dev_open(__u16 dev)
 		atomic_set(&hdev->cmd_cnt, 1);
 		set_bit(HCI_INIT, &hdev->flags);

+		set_bit(HCI_RESET, &hdev->flags);	
 		//__hci_request(hdev, hci_reset_req, 0, HZ);
 		ret = __hci_request(hdev, hci_init_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a290854..a63bcf0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -183,6 +183,8 @@ static void hci_cc_reset(struct hci_dev *hdev,
struct sk_buff *skb)

 	BT_DBG("%s status 0x%x", hdev->name, status);

+	clear_bit(HCI_RESET, &hdev->flags);
+
 	hci_req_complete(hdev, HCI_OP_RESET, status);
 }

@@ -1464,7 +1466,7 @@ static inline void hci_cmd_status_evt(struct
hci_dev *hdev, struct sk_buff *skb)
 		break;
 	}

-	if (ev->ncmd) {
+	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		if (!skb_queue_empty(&hdev->cmd_q))
 			tasklet_schedule(&hdev->cmd_task);
-- 
1.7.4.1


-- 
Justin P. Mattock
