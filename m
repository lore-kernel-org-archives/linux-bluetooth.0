Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/2] gobex: fix automatically including SRM header in CONNECT responses
Date: Sun, 22 Jan 2012 23:07:33 +0200
Message-Id: <1327266453-1077-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

GOEP 2.0 test specification forbids the server to include SRM headers in
CONNECT response:

  "3.16 TP/SRM/BI-03-C Process an OBEX CONNECT request (incorrectly)
  containing a SRM header:

  • Expected Outcome
  Pass Verdict:
  – On receiving the invalid SRM header in the OBEX_CONNECT request, the
  IUT responds with a SUCCESS without a SRM header.
  – OBEX/L2CAP channel is established.
  Fail Verdict:
  – On receiving the invalid SRM header in the OBEX_CONNECT request, the
  IUT does not respond with a SUCCESS and/or includes a SRM header in the
  response.
  – OBEX/L2CAP channel is not established or OBEX/RFCOMM channel is
  established."
---
 gobex/gobex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 03da84f..0853a9b 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -588,6 +588,7 @@ gboolean g_obex_send(GObex *obex, GObexPacket *pkt, GError **err)
 	switch (obex->rx_last_op) {
 	case G_OBEX_OP_CONNECT:
 		prepare_connect_rsp(obex, pkt);
+		break;
 	case G_OBEX_OP_GET:
 	case G_OBEX_OP_PUT:
 		prepare_srm_rsp(obex, pkt);
-- 
1.7.7.5

