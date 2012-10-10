Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Fix L2CAP PSM bind issue
Date: Wed, 10 Oct 2012 22:09:26 +0530
Message-id: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Problem: If we bind a particular PSM with source address as BDADDR_ANY,
then we are able to bind the same PSM with adapter address(or any other
address), which is incorrect.

Solution: Added check for comparing the stored source address and
given source address against BDADDR_ANY, so that irrespective of
BADADDR_ANY or any adapter address, a particular PSM will be allowed
to bind only once.

Details: After successful binding, both the PSM and the source device
address are stored in a global list. Before binding to a new PSM, the
old PSM and the source address from the gobal list are compared against
the new PSM and source device address for make the PSM binding unique.

Before this fix, If we pass the different device addresses, for the same
PSM, both the binding are successful. Further an incoming connection to
that particular PSM goes to incorrect profile (first binded). This PSM
binding issues can be easily reproducible using the l2test utility as
shown below.

Bind to a PSM without the device address
-sh-4.1# l2test -w -P 4097
l2test[2792]: Waiting for connection on psm 4097 ...

In another terminal, bind to same PSM with device address
-sh-4.1# l2test -w -P 4097 -i hci0
l2test[2787]: Waiting for connection on psm 4097 ...

Here we can see the binding is successful for both cases for the same
PSM. After this fix the binding for a particular PSM is allowed only
once.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
This patch resolves the HDP incoming connection issue when Obexd is
running in background. Both uses dynamic PSM range. Obex over l2cap
bind with source address as BDADDR_ANY and HDP binds with source address
as the adapter address. Both bindings for the same PSM are getting
success.

 net/bluetooth/l2cap_core.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d42cdb1..ace7cd8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -113,7 +113,16 @@ static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src)
 	struct l2cap_chan *c;
 
 	list_for_each_entry(c, &chan_list, global_l) {
-		if (c->sport == psm && !bacmp(&bt_sk(c->sk)->src, src))
+		if (c->sport != psm)
+			continue;
+
+		/* Exact match */
+		if (!bacmp(&bt_sk(c->sk)->src, src))
+			return c;
+
+		/* BDADDR_ANY match */
+		if (!bacmp(&bt_sk(c->sk)->src, BDADDR_ANY) ||
+		    !bacmp(src, BDADDR_ANY))
 			return c;
 	}
 	return NULL;
-- 
1.7.9.5

