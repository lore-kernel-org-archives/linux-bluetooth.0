Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 19:31:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Add error handling for managment
 command handlers
Message-ID: <20101216173150.GA23500@jh-x301>
References: <1292267227-22028-1-git-send-email-johan.hedberg@gmail.com>
 <1292267227-22028-2-git-send-email-johan.hedberg@gmail.com>
 <20101216165242.GC5927@vigoh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <20101216165242.GC5927@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gustavo,

On Thu, Dec 16, 2010, Gustavo F. Padovan wrote:
> > +	if (err < 0)
> > +		goto done;
> > +
> >  	err = msglen;
> 
> 
> I think
> 	if (!err)
> 		err = msglen;
> 
> 
> is better.

Agreed. Here's an updated patch. I used "err == 0" since that seems to
be more common at least in Marcel's user space projects for non-boolean
variable tests.

Johan

--sm4nu43k4a2Rpi4c
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Bluetooth-Add-error-handling-for-managment-command-h.patch"

>From 1b37152df73d9480382263f3e17c3856e8f403f3 Mon Sep 17 00:00:00 2001
From: Johan Hedberg <johan.hedberg@nokia.com>
Date: Fri, 10 Dec 2010 12:06:16 +0200
Subject: [PATCH] Bluetooth: Add error handling for managment command handlers

The command handlers for bluetooth management messaging should be able
to report errors (such as memory allocation failures) to the higher
levels in the call stack.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/mgmt.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d15bf67..e336fc1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -29,7 +29,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
 
-static void cmd_status(struct sock *sk, u16 cmd, u8 status)
+static int cmd_status(struct sock *sk, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -39,7 +39,7 @@ static void cmd_status(struct sock *sk, u16 cmd, u8 status)
 
 	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_ATOMIC);
 	if (!skb)
-		return;
+		return -ENOMEM;
 
 	hdr = (void *) skb_put(skb, sizeof(*hdr));
 
@@ -52,6 +52,8 @@ static void cmd_status(struct sock *sk, u16 cmd, u8 status)
 
 	if (sock_queue_rcv_skb(sk, skb) < 0)
 		kfree_skb(skb);
+
+	return 0;
 }
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
@@ -87,11 +89,12 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	switch (opcode) {
 	default:
 		BT_DBG("Unknown op %u", opcode);
-		cmd_status(sk, opcode, 0x01);
+		err = cmd_status(sk, opcode, 0x01);
 		break;
 	}
 
-	err = msglen;
+	if (err == 0)
+		err = msglen;
 
 done:
 	kfree(buf);
-- 
1.7.2.3


--sm4nu43k4a2Rpi4c--
