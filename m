Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AD3C30
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418950; cv=none; b=PusuVLMYg1xU7lulpURQhWkUUEwZilsJRy+VxzFg+E6GVkRgUOZWIZ2n38v9HiUqsLEXW7vqKZC9DY/765d8FHm3L6nFTSHtdeP2mC1vIp3s/PCMh5xHCuX0T8oheDbkiB3+5QPqk8iPmjMOykQ6QJq/ud3jNBRy0/ng2+uXkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418950; c=relaxed/simple;
	bh=3yWGUG/nKLU3YOKevyOpcCito/St79BH0C9W/Puu5vI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WO1Tkq8kttOBkq1mMFV/R1YYVmItONyBnhbS5aa36D+bb+ON1eUHS8+Q1nY6cBpFcWnpUjhM1iESSUfxqXXx7bN+LBOJG69NbhP+vClCvXuwZ/6NzCBWQaDwD5Hl/AdoWdC0Kto1yEwdbamjVJDa39xT2KqamgQn+uwg4X+5Mkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd3j/1r7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd3j/1r7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCBEAC4CEEB;
	Wed,  2 Jul 2025 01:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751418949;
	bh=3yWGUG/nKLU3YOKevyOpcCito/St79BH0C9W/Puu5vI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Xd3j/1r7vCMAPELUwRqHDR5ENhaMOrpSY9KGOxpKvvSvdLhDdcx3Zs86jHmMpozLJ
	 vO+zJDpj6n3YO1S70uNCnKcOwK1vMS1NKrhsOKHxlBtivCUOV1T9AKmDpp/B0MZwQe
	 PUySO4MeiPVzvpKrvj0wIEmRN8vr6BSa6Vd9+rhOPuke6m1pOzYhonHMkMlx22G5Cr
	 xmNRMKVRekeNRsltl10jUh7o0sNWkpoQ44/aKvb35MCBmNG8OqyCa6RWmbbV5iP0ar
	 HSXtr4gYVtODK0z5/L1HlmcvE7mksHdwg1xiI5MwFNVGPER60Sf9apr1K5aqHDmGxV
	 RodgeeMSIcV1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D26C8303D;
	Wed,  2 Jul 2025 01:15:49 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 02 Jul 2025 09:15:45 +0800
Subject: [PATCH BlueZ bluez v3] shared/bap: Add stream state check in
 stream_disable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-bap_for_big_sync_lost-v3-1-d314b60abf7a@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAECIZGgC/4XNTQ6CMBAF4KuYWVszLVDElfcwhvQXmgAlLRKRc
 HdJV7owLt+8zPdWiCY4E+FyWCGY2UXnhz1kxwOoVgyNIU7vGRiyAjnLiRRjbX2opWvquAyq7ny
 cCM/ykiteVlpK2H/HYKx7JvcGsnuYF9z3c+vi5MOS1maayj/wTAklqG2FAm1RaLyKvvONUyfl+
 2TO7MPJ8JfDCBKaV1RyPCstim9n27Y3oWchXgsBAAA=
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751418945; l=2119;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=Li/oG8Hx4idNZ2lePbfz9FOElYrLqbI0dzXwuZBAwXI=;
 b=HBPMJPbCqpIcvpCHxZOQKOt6PknxpqcevJw8a+ImqiIZ+eZ2UKFTdoCDNGhqL0gcxFAFBafD2
 JN1+zfkUcz+D7cnGRPZfuhoqEJ5gsXAQLzCB1E/kxSsWcYnuiOMfDkG
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Add a state check so that stream_disable() is a no-op when the stream
is not in ENABLING or STREAMING state. This prevents unexpected state
transitions or redundant operations during cleanup.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v3:
- Optimizing the code
- Link to v2: https://patch.msgid.link/20250630-bap_for_big_sync_lost-v2-0-1491b608cda5@amlogic.com

bap for big sync lost

To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Signed-off-by: Yang Li <yang.li@amlogic.com>

Changes in v2:
- Add state check in stream_disable.
- Add type check in stream_io_disconnected.
- Link to v1: https://patch.msgid.link/20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com
---
 src/shared/bap.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 40e1c974b..1790b277b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2131,14 +2131,20 @@ static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
 
 	ascs_ase_rsp_success(rsp, stream->ep->id);
 
-	/* Sink can autonomously transit to QOS while source needs to go to
-	 * Disabling until BT_ASCS_STOP is received.
-	 */
-	if (stream->ep->dir == BT_BAP_SINK)
-		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
-
-	if (stream->ep->dir == BT_BAP_SOURCE)
-		stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
+	switch (stream->ep->state) {
+		case BT_ASCS_ASE_STATE_ENABLING:
+		case BT_ASCS_ASE_STATE_STREAMING:
+			if (stream->ep->dir == BT_BAP_SINK)
+				stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
+			else if (stream->ep->dir == BT_BAP_SOURCE)
+				/* Sink can autonomously transit to QOS while source needs to go to
+				* Disabling until BT_ASCS_STOP is received.
+				*/
+				stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
+			break;
+		default:
+			break;
+	}
 
 	return 0;
 }

---
base-commit: 55a6763cde8a2309fd23a96479ee4cf2fc23a442
change-id: 20250624-bap_for_big_sync_lost-63476c679dbb

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


