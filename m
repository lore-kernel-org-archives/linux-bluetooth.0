Received: from mail-b.studer.dev (mail-b.studer.dev [3.21.136.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10017322DA1
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.21.136.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702183; cv=none; b=hcmd6qYVxxnW3MstKSQsFHH8Qe2Cm9+LbLmIE1BWPQVxNpAJlIaRJ5/opVrhQBudZDWecAWU/dODTa7eHbCGnPHeR6iRnY1ZRwend07mFcQizo+hVQeAwdR0sf6lvz+Q/3/Bs5Y9MinPHp+2GgBC39nwWMMx520XFPYluuohmzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702183; c=relaxed/simple;
	bh=EPXoaoRHMvjN3Gijk9qwNSBN61oEuuJ2AoXpzmuNSuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxtrONqOI4HPjMb/XvrARkNFokIKY7w+xJw5YiWTy0ih+Z8Ifq0gdIwJ86E0FpUDpRr3a7DGtqWUvU1Vvep1ckgqTuMayERSvgA+/Ms/JIPHUNPrmB1HsluErCXbRfrKzqktuAFlJyTa4lqRHQAicPMvKnGsuE6DCIIa0wobuW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=studer.dev; spf=pass smtp.mailfrom=studer.dev; dkim=pass (2048-bit key) header.d=studer.dev header.i=@studer.dev header.b=qdUodavZ; arc=none smtp.client-ip=3.21.136.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=studer.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=studer.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=studer.dev header.i=@studer.dev header.b="qdUodavZ"
Received: from mail.studer.dev (mail.studer.dev [168.62.161.121])
	by mail-b.studer.dev (Postfix) with ESMTPSA id 9933540024
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 18:27:36 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=studer.dev; s=hmail;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding;
	bh=vCcxI9AT6ZOQorPVfdfOttI0gUyEfSelZOyQFsvdfdQ=;
	b=qdUodavZdlNE4q42n1r7H5ndKLbz5iCzj4Jui2uSsGfvmlNzj0AFaxlDH/HS2P/s0XAHCwQDL+hIJG/2Y3RRgK8yuU+QSk53wvEY7S6v1oORisMORwG9MoLMFSLRUoTEMuNx888lW18ytxIMnd5ab9co61iQBI5ul7tHSVCXLuB+l0w4k+saDSr7sXDVv4U4UMT8zJ1kw6cZKVBbADnPaHCSAXV7z29ho3OkT/f7ytS/eJS2gwKbgvtfZq
	lmjDPDNYTBbS4Yy7b1iGfcUVXQIo1OwgexTAUovfDiBHm/M+sgVQAUJmv4jULR82+c/7Ozj+GwyF7l1ZIwrx/sN8rimQ==
Received: from alex-framework.localdomain (Unknown [38.42.217.75])
	by mail.studer.dev with ESMTPSA
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
	; Fri, 12 Sep 2025 18:27:35 +0000
From: Alex Studer <alex@studer.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Alex Studer <alex@studer.dev>
Subject: [PATCH BlueZ] profiles/audio/a2dp: Clear suspend timer on A2DP stream free
Date: Fri, 12 Sep 2025 14:20:34 -0400
Message-ID: <20250912182033.1260032-2-alex@studer.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an A2DP stream is created in start_ind, a timer is set, suspending
the AVDTP stream if there have been no users within 5 seconds. However,
if the AVDTP stream transitions to the IDLE state before the timer
fires, the A2DP stream is freed without the timer being cleared. This
meant that when the timer fired, it tried to suspend a stream with a
pointer that was previously freed and so segfaulted.

This commit fixes that by ensuring that suspend_timer is cleared before
freeing the A2DP stream.

This was causing random segfaults when connecting my Sony WH-1000XM5
headphones.

Signed-off-by: Alex Studer <alex@studer.dev>
---
 profiles/audio/a2dp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 661843a89..4e1362913 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -636,6 +636,11 @@ static void a2dp_stream_free(void *data)
 {
 	struct a2dp_stream *stream = data;
 
+	if (stream->suspend_timer) {
+		timeout_remove(stream->suspend_timer);
+		stream->suspend_timer = 0;
+	}
+
 	avdtp_unref(stream->session);
 	free(stream);
 }
-- 
2.51.0


