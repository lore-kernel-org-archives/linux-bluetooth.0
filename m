Return-Path: <gustavo@embeddedor.com>
Date: Wed, 19 Jul 2017 17:49:31 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] bluetooth: btwilink: remove unnecessary static in
 bt_ti_probe()
Message-ID: <20170719224931.GA16225@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Remove unnecessary static on local variable hst.
Such variable is initialized before being used,
on every execution path throughout the function.
The static has no benefit and, removing it reduces
the object file size.

This issue was detected using Coccinelle and the
following semantic patch:

@bad exists@
position p;
identifier x;
type T;
@@

static T x@p;
...
x = <+...x...+>

@@
identifier x;
expression e;
type T;
position p != bad.p;
@@

-static
 T x@p;
 ... when != x
     when strict
?x = e;

In the following log you can see the difference in the object file size.
This log is the output of the size command, before and after the code
change:

before:
   text    data     bss     dec     hex filename
   4029    2528     128    6685    1a1d drivers/bluetooth/btwilink.o

after:
   text    data     bss     dec     hex filename
   4007    2472      64    6543    198f drivers/bluetooth/btwilink.o

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/bluetooth/btwilink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 85a3978..0cdb896 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -276,7 +276,7 @@ static int ti_st_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 static int bt_ti_probe(struct platform_device *pdev)
 {
-	static struct ti_st *hst;
+	struct ti_st *hst;
 	struct hci_dev *hdev;
 	int err;
 
-- 
2.5.0
