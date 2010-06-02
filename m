Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 17/32] Analize remote record looking for psm
Date: Wed,  2 Jun 2010 15:19:13 +0200
Message-Id: <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c      |    1 +
 health/hdp_util.c |   52 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 88e7235..7f25144 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -462,6 +462,7 @@ static void connect_health_instance(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
+	info("psm = 0x%x, version = 0x%x", ccpsm, version);
 	device_get_address(device->dev, &dst);
 	mcap_create_mcl(hdpi->mi, &dst, ccpsm, &gerr, hdp_mcl_connect_cb,
 								cb_data);
diff --git a/health/hdp_util.c b/health/hdp_util.c
index 5ba61dc..c54f55c 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -884,29 +884,51 @@ gboolean hdp_get_data_exchange_spec(const sdp_record_t *rec, guint8 *val)
 	return TRUE;
 }
 
+static gboolean get_prot_desc_entry(sdp_data_t *entry, int type, guint16 *val)
+{
+	sdp_data_t *iter;
+	int proto;
+
+	if (!entry || (entry->dtd != SDP_SEQ8))
+		return FALSE;
+
+	iter = entry->val.dataseq;
+	if (!(iter->dtd & SDP_UUID_UNSPEC))
+		return FALSE;
+
+	proto = sdp_uuid_to_proto(&iter->val.uuid);
+	if (proto != type)
+		return FALSE;
+
+	iter = iter->next;
+	if (iter->dtd != SDP_UINT16)
+		return FALSE;
+	if (val) {
+		*val = iter->val.uint16;
+	}
+	return TRUE;
+}
+
 gboolean hdp_get_prot_desc_list(const sdp_record_t *rec, guint16 *psm,
 							guint16 *version)
 {
-	if (!(psm || version))
+	sdp_data_t *pdl, *p0, *p1;
+
+	if (!psm && !version)
 		return TRUE;
 
-	/* TODO:
-	sdp_data_t *pdl, *l;
+	pdl = sdp_data_get(rec, SDP_ATTR_PROTO_DESC_LIST);
+	if (pdl->dtd != SDP_SEQ8)
+		return FALSE;
+
+	p0 = pdl->val.dataseq;
 
-	exspec = sdp_data_get(rec, SDP_ATTR_PROTO_DESC_LIST);
-	if (exspec->dtd != SDP_SEQ8)
+	if (!get_prot_desc_entry(p0, L2CAP_UUID, psm))
+		return FALSE;
+	p1 = p0->next;
+	if (!get_prot_desc_entry(p1, MCAP_CTRL_UUID, version))
 		return FALSE;
 
-	for (l = pdl->val.dataseq; l; l = l->next) {
-		if (l->dtd != SDP_SEQ8)
-			continue;
-		epl = get_feature(epl, l->val.dataseq);
-	}
-	*/
-	if (psm)
-		*psm = 0x1001;
-	if (version)
-		*version = 0x0100;
 	return TRUE;
 }
 
-- 
1.6.3.3

