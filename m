Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6561E1E04
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154551; cv=none; b=eUOuHojcZDvQMJx9GbcOXNJgpMIW/IN7e8ci6vpJgMq2m7qBiY26iDso1l0MgcQfEQBsD3SVhzSQ/V9G/+/2ZyVFThOjoASNeqeKs+aceh27xFlGivGDsysGTNWWlCKlqrp55Xi/kR5UFjRAzy6NFzj5YhJxzGxkovuXS25LqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154551; c=relaxed/simple;
	bh=/gyPFoUoLyYFE1ySA6I8l+lJiBo9cgY2O/YeF+HBzkE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Acg99XLxuukLXJ73MNRkaqF5VEgw1I+l33D0uwhGIO2lh++yXWarqmUepJBl+X5Ff+80LXM3TjiwJtn8CNWzx7xsVcHTEsCWU/XetPhdEa5jqNXASOzGAb4XK/1edjjhRcr2FPMsv2+cUT25qiof7PDpdOpqi/Heij8BguTzZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pxwuSV3O; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pxwuSV3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766154547;
	bh=/gyPFoUoLyYFE1ySA6I8l+lJiBo9cgY2O/YeF+HBzkE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pxwuSV3O1LkZmwjdjgCt0OJcIkdbNNTOWBMOgY+rjF7d6euXT00h6d+GitBcw0T0h
	 PzGGbdXbhx2a5JfokhM3tzj6zk0g5BUpvYVzZtfNwE8pipC57eSb940RQcfpc6cyVR
	 YD+Wz8znqkBnSdzRdC6cVAxCqLZRIm17rczpgSt+/yS3EUIIw+vrNIMuAS5KQI8K/4
	 HvldsKUMZp2ONEqQIPxb1hSG/wYyePOF59hXgfIvykuRgM5PJBvnGx+BkBmAvBQqya
	 UCSLGIwQPjot/F7tLCJxvl86inTCNMd36DMsXE0PzQLnPxlobmRNpfsSRn7OI8n8qC
	 F5A7VUmU+2YEg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-2e1C-31AC-4A84-8c5a.rev.sfr.net [IPv6:2a02:8428:af44:1001:2e1c:31ac:4a84:8c5a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 79CFC17E0465
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 15:29:07 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] audio/hfp-hf: Add in-band ringtone flag support
Date: Fri, 19 Dec 2025 15:29:02 +0100
Message-ID: <20251219142902.559714-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219142902.559714-1-frederic.danis@collabora.com>
References: <20251219142902.559714-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This flags is set by remote phone when it wants to play the ringtone
through the audio channel.
---
 profiles/audio/hfp-hf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index a3263c018..ca40c46d0 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -138,6 +138,13 @@ static void hfp_hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
 	}
 }
 
+static void hfp_hf_update_inband_ring(bool enabled, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	telephony_set_inband_ringtone(dev->telephony, enabled);
+}
+
 static void hfp_hf_update_operator(const char *operator_name, void *user_data)
 {
 	struct hfp_device *dev = user_data;
@@ -230,6 +237,7 @@ static struct hfp_hf_callbacks hf_session_callbacks = {
 	.session_ready = hfp_hf_session_ready_cb,
 	.update_indicator = hfp_hf_update_indicator,
 	.update_operator = hfp_hf_update_operator,
+	.update_inband_ring = hfp_hf_update_inband_ring,
 	.call_added = hfp_hf_call_added,
 	.call_removed = hfp_hf_call_removed,
 	.call_status_updated = hfp_hf_call_status_updated,
-- 
2.43.0

