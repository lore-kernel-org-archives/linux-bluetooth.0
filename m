Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EAA322B69
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990119; cv=none; b=Wo7q8SPyyO67fILq0dEPVL2t8Aca1HUT1cf6VBZqDmkfTOBq5863rESvSUFgKC6oIR6xkR9VnZBFRjtnqOpSZPx4DJtXECOHsZEcW9YL++SHNAjlTbfuJh9dy9Ti2tI0V6/Zg0zm+o2ofi+IEryc+lIGj7xTI46uODsGl5SiV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990119; c=relaxed/simple;
	bh=oMsFr9wpTOHWGBAvZ9ElxAtc/EEiTsZR1+wcMDqMsSk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmoZz2998zwc6ClL06SdiIE1tnyr93FjuAS0njZdMNGH7cxiidBckxD0UGbl6CronPsf9vKUscA54DZWsO6wVKJYPEDIzmUNy+hajH+KTpqjUOMCByRq4KDOqFUqf3BEBWGwGJbljU+iw5FZFVZXTxeLpUKrz1SKN76phtY1Ggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cvNH+9N6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cvNH+9N6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1765990113;
	bh=oMsFr9wpTOHWGBAvZ9ElxAtc/EEiTsZR1+wcMDqMsSk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cvNH+9N6WdkTTAuC513S6u7rpfvFdP+is8/rkS2AgCif0AA4CKTrCGUK8N1vGnWca
	 t8biBMXbQGAiMbnfAFES8qGzr0Oyd9NmzrVR3sAsuRLsOhVdmtKrM/FuiTNkIqy9c3
	 PadtbWM8r5tzZaVZMkWlAqvIZqwJ2tKjm1H02D9X4FAcTT3PYib68hGszM9yOjGxTv
	 Agjj1ykpC3gq6D4sXaMOFMHXOT0GIl4mty9H02PUYJKRHkQLPebx3PE4rBjngu1Lvy
	 P7Df6uIG1622mWZ7ZaKBnpxmDOsqIZ50+BWWGdqkTBq19474cXf+NczZcKu1qeJScv
	 QXd0vsQaL2amg==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-aF44-1001-41cf-E9a9-dE42-A168.rev.sfr.net [IPv6:2a02:8428:af44:1001:41cf:e9a9:de42:a168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2ACF517E10F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 17:48:33 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] audio/hfp-hf: Add in-band ringtone flag support
Date: Wed, 17 Dec 2025 17:48:20 +0100
Message-ID: <20251217164820.277845-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217164820.277845-1-frederic.danis@collabora.com>
References: <20251217164820.277845-1-frederic.danis@collabora.com>
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
index 81d5f4437..3c4218da3 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -137,6 +137,13 @@ static void hfp_hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
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
@@ -235,6 +242,7 @@ static struct hfp_hf_callbacks hf_session_callbacks = {
 	.session_ready = hfp_hf_session_ready_cb,
 	.update_indicator = hfp_hf_update_indicator,
 	.update_operator = hfp_hf_update_operator,
+	.update_inband_ring = hfp_hf_update_inband_ring,
 	.call_added = hfp_hf_call_added,
 	.call_removed = hfp_hf_call_removed,
 	.call_status_updated = hfp_hf_call_status_updated,
-- 
2.43.0

