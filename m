Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213611;
	b=2CrAkfPbJlqzYiv1xpxPjIekLQahzldhHg71SqdS/WvZZfVj6M1INJRrCodqKLMw6MEA
	 fZlIyAgbXLaOBs58+V5pFqpZK/xDYSTY4m91HFOMxrys5qYrmf6viXIjyklFtwTSaQBei
	 +HJCtx/g9XfDjOj87o8zHHNpKA+bQNocXx5fUuqh7W3tVRWGQKX5os8xEtiuXNOceU7G1
	 5NHwCvk5pWWBT4y8reS9n4qxO4mX66cR7oeOJAYLIHTj/LGqoCj9OFdfrqEC3+Vjh4mqL
	 B0EFgLGjKr9JevaMuSG34d0yv6iUdI+ui+80LhFCJGavl35LkWPGbudkwi3Dg9s20jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u082h5nsg1QYpIeH5d7X+8TgQiC6KbFuw9Ai+aJAWkA=;
	b=tGRV5xp2JeCnNrjGdWyJ3dfc2ZN7rV7uf+wlfPe8gQkRh37UMPNUEYnMiY8+Fsulg42/
	 ZrLE7mKmMhwwS//jbNIQaWdNEBdDqfioaReweOZ7VmbFHpLnNZG40GyHIAmUzFvkYLtoK
	 HR/5RODMcrEAEutdmU11s62CH81MVZQL6QV8S1/dQNgj4+86se+q310aWTZVmI1pJLaZ4
	 CTRCMK2VtAjMy1MYvzXbX6G+1DGJnZkkoIU8Eb6TwHBg1va7OwUezgKim8SgTm7i81QaS
	 PLqfxPk4Xs+PBYLBGKGwI6vTshy5Yl8iMawCvgAOhoTPkPRqvyk7uptBD9nS6C1IOyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Je+yMkSW;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E2606A33E
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 881E2606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Je+yMkSW
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb5e3cbf45so876415e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795213605; x=1795818405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u082h5nsg1QYpIeH5d7X+8TgQiC6KbFuw9Ai+aJAWkA=;
        b=Je+yMkSW6MEKHqBPEUokwk4MwWsSSxsEWbHbQg290hLJE+Sj+26GDRVuJfkKmwolxp
         mwYIopSVA/WgsgSw18qkuSSYTAsMrjbaojWWkpWPXbgOA0iYQWWnzb/pPn4OnosJLgd8
         p5bkxLieiobTyyTKEqCWhSKeXP0c1oAdp7INeZ3kN8ARWJysUeC3Nd9b33uiJmPpZIDT
         N/58LQl2FbYkbQlDIeE0E/2LUTDmwr8OK4iLiQ2Q3ErJrpYAQyD4UKJj3Y2xhfg4fBAN
         67j5jdjK5qSWT0xOZUDmE3t0iPaYhfP4beSOG/vQig6ETtTzQdyTRkTpma6bAQTsWfmu
         osJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213605; x=1795818405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u082h5nsg1QYpIeH5d7X+8TgQiC6KbFuw9Ai+aJAWkA=;
        b=z/eg0lti/tOldsSNaWDH1/uCPbAFuuZH3/dAUWlT/c1bREfpxGulSvVBcO1x0tCefH
         wD2ddSPTeATvfsIpEvb/nckbJxZ69i9l0VFR29niozBw3WZUU57PY0PCbAApt4sKoZWQ
         x5Z2uZxb7RaUkC/W0cdWi1Pl2wwKzAqebhkn07qffeAp7QIJSstkZ7851X+1/i0IM05n
         wr+nCgX/m+vmb3SFRByzddK5x15YtAXFSLnHgMNcPMRl/of1YDyzcGN0km/5o3k9eRoB
         hAijjLdRULPQchLpOLHuWfjr5PV1sSLMj3ncCwSI8qCPTpNeUxsRkC9jD2AzIrgbeTHd
         l2DQ==
X-Gm-Message-State: APuU4Z/VqNpnsnBxO9MB2ah88t+9K2eYvl2aI8LHd6d+wmce9yhWxjJ/
	EHdw7m1ef1P7oqEutW/GCO9k8wKyHnZJ2qu56pwepnFjrPMrncurp405zFVJtw==
X-Gm-Gg: AYBFou1Ob4nhhEZCATByJoT9iD0PAml+9njVxnqIW3xeaJEuwkuO8YueBPGtn1vTAFl
	+l1F0uQuWJ8nAXhUGYyH42zLBiSVRq6Vd81+Effz7o7w7RLlaWCQdPhtQHE+xrB+ifnRNdA388u
	qhE83M6xOF4+otrVlbKYMtJlFsKLVCwHUzccs/KeqJY3Fu0fxuqys6ILj1TnlrnrYJpHqqCYVal
	QKB6NOYGOWaB8P5nbznLU/KQVvIeP5P6TY8IsIBaBAqXW4C7er4uzOm2BOdznJvVxsVlfS223b/
	WaQU9dQfOgEnKeomlL7D3NWTUP1v/OScC8SuwNySQfhV1g9zhBb8ywSmI3TToeh6u2Udow1Y8PR
	m4/Pm6xONG0e3MRFX5wGur1wFDILQl67Lt18Hc4eya39QYUYJbD5HXT9QdmyFvsFdRWIGacl7Sw
	AXoRIRMYDenxHycx3fHeBoQDUH3e//RY++nXk8yoGG9sAE9zmg/kzFvDTAL7Yz0OxWfkZem7nVm
	mh33F0N3uRKTvq1tX6s1WJl3YrYzUsSJL16TMxsbyFv+fN+AKm5nkSmJJoPwdyHXCTBCq9WdO0q
	bLFFxnO8om+wVLuBjdzy/B+rK2QIJqN3+wJWQnw2UrNqlNmo
X-Received: by 2002:a05:600c:2059:b0:4bb:7ae0:30bf with SMTP id 5b1f17b1804b1-4bb887fd0f1mr71133025e9.2.1795213605013;
        Fri, 20 Nov 2026 14:26:45 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b39e:f00:df5c:2a51:ff8a:45b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm23698785e9.2.2026.11.20.14.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:26:44 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ 5/5] monitor: Fix decoding of Public Broadcast Announcements
Date: Fri, 20 Nov 2026 23:26:24 +0100
Message-ID: <20261120222624.150321-6-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120222624.150321-1-rolandschober1968@gmail.com>
References: <20261120222624.150321-1-rolandschober1968@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

print_pbp_announcement() takes the result of util_iov_pull_u8() the
wrong way round: a well formed announcement is reported as "invalid
features", and an empty one is decoded from uninitialised variables,
which can hand a NULL pointer to bt_bap_debug_metadata().

Check the metadata length against the remaining data as well.

Fixes: 3171f7fd3685 ("monitor: Add decoding support for Public Broadcast Announcements")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 042a2ecb6..7fdab7cc5 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4101,7 +4101,7 @@ static void print_pbp_announcement(const uint8_t *data, uint8_t data_len)
 	iov.iov_base = (void *) data;
 	iov.iov_len = data_len;
 
-	if (util_iov_pull_u8(&iov, &feat)) {
+	if (!util_iov_pull_u8(&iov, &feat)) {
 		print_text(COLOR_ERROR, "  invalid features");
 		return;
 	}
@@ -4113,7 +4113,7 @@ static void print_pbp_announcement(const uint8_t *data, uint8_t data_len)
 		print_text(COLOR_UNKNOWN_SERVICE_CLASS,
 					"  Unknown feature (0x%2.2x)", mask);
 
-	if (util_iov_pull_u8(&iov, &len)) {
+	if (!util_iov_pull_u8(&iov, &len)) {
 		print_text(COLOR_ERROR, "  invalid metadata length");
 		return;
 	}
@@ -4122,6 +4122,11 @@ static void print_pbp_announcement(const uint8_t *data, uint8_t data_len)
 		return;
 
 	meta.iov_base = util_iov_pull_mem(&iov, len);
+	if (!meta.iov_base) {
+		print_text(COLOR_ERROR, "  invalid metadata");
+		return;
+	}
+
 	meta.iov_len = len;
 
 	bt_bap_debug_metadata(meta.iov_base, meta.iov_len, print_ltv,
-- 
2.47.3

