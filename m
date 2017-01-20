Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] audio/avctp: Match opcode when parsing responses
Date: Fri, 20 Jan 2017 15:43:29 +0200
Message-Id: <20170120134331.25438-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The transaction may not be unique given the fact that notifications can
take all the outstanding transaction which may cause transactions to be
reused as explained in the errata:

https://www.bluetooth.org/errata/errata_view.cfm?errata_id=3812
---
 profiles/audio/avctp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 2a43d32..0807be1 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -808,6 +808,10 @@ static void control_response(struct avctp_channel *control,
 	GSList *l;
 
 	if (p && p->transaction == avctp->transaction) {
+		req = p->data;
+		if (req->op != avc->opcode)
+			goto done;
+
 		control->processed = g_slist_prepend(control->processed, p);
 
 		if (p->timeout > 0) {
@@ -822,6 +826,7 @@ static void control_response(struct avctp_channel *control,
 								control);
 	}
 
+done:
 	for (l = control->processed; l; l = l->next) {
 		p = l->data;
 		req = p->data;
@@ -829,6 +834,9 @@ static void control_response(struct avctp_channel *control,
 		if (p->transaction != avctp->transaction)
 			continue;
 
+		if (req->op != avc->opcode)
+			continue;
+
 		if (req->func && req->func(control->session, avc->code,
 					avc->subunit_type, p->transaction,
 					operands, operand_count,
-- 
2.9.3

