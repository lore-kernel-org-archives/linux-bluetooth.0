Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCEB23A0
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131845; cv=none; b=HV1hL7pwydutq66ouafIiqPgppR5H7fWs04KWyWOuee/hvfhKQSsCXUsXUHWYkro6mk9lbhzyDNpwplnPSMvVeir56hbt2uW5Q7IhquGH4ggryCSbqgbrikNAKaGGecx9k1EZBU4cH1/O9uPJB4t1gJicMWpZK9kGaIwcWTzRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131845; c=relaxed/simple;
	bh=AcaAaHwr3ThLvruY3CDw4UpTWbigSiLdtvaK7PZv464=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ft05eq1bFu5WFRr35E4RIZC2BPAWe5LrACG+M+Ka6McjGXRkHtZvabWokSKf05SBA6mhJ8wJpvEu06cVBN5LoxHNty6ye1cWMO+DRavAK1tiwEaVRkmL0jSXinbK5jWpeVdVzVE1WsiinIWFX+cOH7CJhJdd8ehFU+/XRNre59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERnFC8KD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERnFC8KD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C17DFC4CED0;
	Mon,  6 Jan 2025 02:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736131844;
	bh=AcaAaHwr3ThLvruY3CDw4UpTWbigSiLdtvaK7PZv464=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ERnFC8KD1CmCcgxZhkXyGDVidrDCQUbmn8VpfmqGwZyXLRyfW6e+5xsTEJHYmXQEI
	 EM3pfRGAnQoENzTExu1M88D1yhRXswN0pcwOte8LLMFG3nS6XAVfGgFRf+X/q96wDX
	 TfC8QCr30YFHm+kZ6E8nBPIg3hbIzf5mIjmApD8sj/vNbRS99AeYok8CG4rep25xJT
	 cPv1wZUW/tMZNhjNGbRLWRE/P/1PPc2eiS/K7hGiMeNL+BRB1BHydAafn8M2dCKWkO
	 0OXUNYi2I0u90lZmFL0Qa/jtyxPcN2Ra6ed3JGUDvJ9WoTeXC3kEJfP6r0OymfWPIR
	 +XMMHmVOM9I/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBC2E77197;
	Mon,  6 Jan 2025 02:50:44 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Mon, 06 Jan 2025 10:50:33 +0800
Subject: [PATCH BlueZ bluez] bap: fixed issue of muting music silent after
 pause and resume.
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-upstream-v1-1-a16879b78ffd@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAPhEe2cC/x3MSwqAIBRG4a3EHSdoVGBbiQZmf3WhF5oRSXtPG
 n5wOJE8HMNTk0VyuNjzviWoPCM7m22C4CGZCllUUslahMOfDmYVClYb6NoOpqSUHw4j3/+qpX4
 JeKh73w/ykkCDYQAAAA==
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736131842; l=3358;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=0vJza6mORdA09fG39CPF0TZT9NAGC+UO9Oed6hi3bPM=;
 b=pWEyFH+FovdewVUB8NJxC/3swuzP3b3j+tGRFi4lyJh+rCZGQk1ZBkq2nex7ogqvNJ6Pcj+jG
 I9lYtIydM9pCP1dgB2sm0AlOmcj1vuP2P244/62z+TZX/x+sREAnJ/b
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

CIS sink need caching the Codec Configured when releasing by Pixel,
state machine is releasing -> Codec. If streamming -> idle, CIS sink
was silent after resume music.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 src/shared/bap.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 167501282..a7f5dec92 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1063,6 +1063,28 @@ static void stream_notify_metadata(struct bt_bap_stream *stream)
 	free(status);
 }
 
+static void stream_notify_release(struct bt_bap_stream *stream)
+{
+	struct bt_bap_endpoint *ep = stream->ep;
+	struct bt_ascs_ase_status *status;
+	size_t len;
+
+	DBG(stream->bap, "stream %p", stream);
+
+	len = sizeof(*status);
+	status = malloc(len);
+
+	memset(status, 0, len);
+	status->id = ep->id;
+	ep->state = BT_BAP_STREAM_STATE_RELEASING;
+	status->state = ep->state;
+
+	gatt_db_attribute_notify(ep->attr, (void *) status, len,
+					bt_bap_get_att(stream->bap));
+
+	free(status);
+}
+
 static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
 {
 	if (!bap || !bap->ref_count || !queue_find(sessions, NULL, bap))
@@ -1634,7 +1656,7 @@ static bool stream_notify_state(void *data)
 	struct bt_bap_stream *stream = data;
 	struct bt_bap_endpoint *ep = stream->ep;
 
-	DBG(stream->bap, "stream %p", stream);
+	DBG(stream->bap, "stream %p status %d", stream, ep->state);
 
 	if (stream->state_id) {
 		timeout_remove(stream->state_id);
@@ -1655,6 +1677,9 @@ static bool stream_notify_state(void *data)
 	case BT_ASCS_ASE_STATE_DISABLING:
 		stream_notify_metadata(stream);
 		break;
+	case BT_ASCS_ASE_STATE_RELEASING:
+		stream_notify_release(stream);
+		break;
 	}
 
 	return false;
@@ -1936,9 +1961,7 @@ static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
 	/* Sink can autonomously transit to QOS while source needs to go to
 	 * Disabling until BT_ASCS_STOP is received.
 	 */
-	if (stream->ep->dir == BT_BAP_SINK)
-		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
-	else
+	if (stream->ep->dir == BT_BAP_SOURCE)
 		stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
 
 	return 0;
@@ -2068,17 +2091,11 @@ static unsigned int bap_ucast_metadata(struct bt_bap_stream *stream,
 
 static uint8_t stream_release(struct bt_bap_stream *stream, struct iovec *rsp)
 {
-	struct bt_bap_pac *pac;
-
 	DBG(stream->bap, "stream %p", stream);
 
 	ascs_ase_rsp_success(rsp, stream->ep->id);
 
-	pac = stream->lpac;
-	if (pac->ops && pac->ops->clear)
-		pac->ops->clear(stream, pac->user_data);
-
-	stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
 
 	return 0;
 }
@@ -6172,8 +6189,10 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
 
 	DBG(stream->bap, "stream %p io disconnected", stream);
 
-	bt_bap_stream_set_io(stream, -1);
+	if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
+		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 
+	bt_bap_stream_set_io(stream, -1);
 	return false;
 }
 

---
base-commit: dfb1ffdc95a00bc06d81a75c11ab5ad2e24d37bf
change-id: 20250106-upstream-1ec9ae96cda4

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


