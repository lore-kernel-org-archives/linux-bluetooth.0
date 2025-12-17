Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496C2957C2
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990118; cv=none; b=GZWHRYurEz8eI7c0XPJDQut060GFmMFbx4b7B7InNVROsiAeGvCrDtKf2sKV5zhADuGyqypiDtfj9mV/gqm34tt8dhMIy0pIxPhaum1zOXwEMm2jd5PDpCUjUFIYvP6p02Wz5SKZgEb55j0PFSze5nEIPop+GqvDYVI34vco2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990118; c=relaxed/simple;
	bh=HrNVwnI3h+JE98zMgyY1XLkm+vyYhg/mlLwxiO6uwgc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IrIvjNY04S4kddj/Wx35uNXixB7/JAd8Zh3POkL+KDtrHn3BJJgfZjS/mwmXxao4Ar6mizIrQEDsISfp7JemtdI1hAZ5rdbziwPz3zrgaSrhoYT+fciOGNjaDmzCqG3K4qfzLZ3CSdAZMvJL/ZDn3Wk/dj4STBEvIRReGdL8aL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S+SoSCMX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S+SoSCMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1765990112;
	bh=HrNVwnI3h+JE98zMgyY1XLkm+vyYhg/mlLwxiO6uwgc=;
	h=From:To:Subject:Date:From;
	b=S+SoSCMXLrfcMeU0l1iAcKIDxzzqE7vn3J4WI3si6h1l73Me0QAqvNm1jOjRHnKeZ
	 f4Ds8QlWYn28FWogeTIOEmiLv6VLBz4avRQX3EJxcHH6ca6y89iOFZlc4X0GNVzsmx
	 kGSHthQ+Fji7vSvmsoLMfbqpYkEq8r2hhjvGRAvUmzIe/PdG4Zrik0VfxwcI2j8Ohd
	 Xqzt+Gha1CDxKRP/cUluiAdrT77YdFYKHdrMiuPLSTHHNOT7hEQ/nkD/+3tLOUCDR1
	 yj8A1yrmhIT/+y2C1XpHQDcDfmA5lERdPmVkvQfcAGY7uPc5w+W90XO/IkolTMsbqV
	 puIbRZ/uZmsPg==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-aF44-1001-41cf-E9a9-dE42-A168.rev.sfr.net [IPv6:2a02:8428:af44:1001:41cf:e9a9:de42:a168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8633917E0506
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 17:48:32 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] audio/hfp-hf: Add Operator name support
Date: Wed, 17 Dec 2025 17:48:18 +0100
Message-ID: <20251217164820.277845-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 profiles/audio/hfp-hf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index d25cda389..384480c9e 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -108,6 +108,13 @@ static void hfp_hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
 	}
 }
 
+static void hfp_hf_update_operator(const char *operator_name, void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	telephony_set_operator_name(dev->telephony, operator_name);
+}
+
 static void hfp_hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 							void *user_data)
 {
@@ -125,6 +132,7 @@ static void hfp_hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
 static struct hfp_hf_callbacks hf_session_callbacks = {
 	.session_ready = hfp_hf_session_ready_cb,
 	.update_indicator = hfp_hf_update_indicator,
+	.update_operator = hfp_hf_update_operator,
 };
 
 static void hfp_disconnect_watch(void *user_data)
-- 
2.43.0

