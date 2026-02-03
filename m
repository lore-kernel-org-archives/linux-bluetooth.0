Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191626AC3
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150612; cv=none; b=XXAFMuc6AShJ9n88hSVhTGqN199e1nH+QDP/eK6nVQwsm1l/CStNaF1Mk78quyilWndn8bXE0lO5zN/+gDuVI1xv9glffVrMY3v7q98lUETgBWT7myPqiodSCdcwNQp2GvkKw7C0VDIINApDPE2PzwYUmHq0K7S0aLT0rMYZGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150612; c=relaxed/simple;
	bh=aFU3Roir1exw1kr9BMZm9uYRDeBCeZcxKXMDOsS1wIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ubdb9HS4JwMfusetWF9y5VqNNXpim6d0NcDjjI09WWFg75AnVplU7oso9RyN3MoIUtYL5fnLCo3KRr4LJ9ybNcBUpYQt+gm8ZmpqAkeyW8Xz5T0Z824lAlmgCfw7tzeRQ8KtgYRxWSuO4xR5a9cmecPOmochYmHqbP7J+3MHkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5fYOW3n; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5fYOW3n"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56638fca064so2016679e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Feb 2026 12:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770150610; x=1770755410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8oCd9LTyRcr0PL2VlKTNm5lDpKKRxj5YrVdufoBAm3I=;
        b=e5fYOW3ntxanO5O5zwzwEfjzrVmRSzA0JAieQ5DGjdvcNrUdXfyjLiojIafhkHehWC
         Zhd9rBSB75TGWue4XcshATq73NhOiJXehdyxEURRMeZmhyTHd8uCymrE014tCQZ4HBbT
         fdY+RgyudqJgoyrx+v2cTeuP/ffi0dd/y1QrQm/EN/IMO529m9x6RQ317E6XV7ncv6KI
         SYTCQUDWiqu2DuszAx36fkCN+5GqahviAbvH7buRRNQ369msnK1Q5aMJFzpL0qa/7dK4
         wie9vlHji7QOy+m6mEmfwtcy+hGfdyHKTNuXJQajfL+aOBn01wrapl0F1y3K3ciR/lJR
         UFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770150610; x=1770755410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oCd9LTyRcr0PL2VlKTNm5lDpKKRxj5YrVdufoBAm3I=;
        b=UVpA9TNXXNsPlfq3z5epkQ2hS/kAQg+TIWhXSQ9/GsvZRnNASE6EvRZev8N2BtNBHg
         JpH8TmAom7AQ53DYILoflvJE1SslAlaRwzijDrEFo7tS1m4RxmhCVIGHsGuQ+DXAtBFG
         3Ezh6y/WkiDsn8fU2AMuNTt9pzkOPU37RM7nDvSjR1bROx1adUiqXMrjRguZpYdqaMTi
         1CTgc0mNiwRltHeKz3W1nyhG5AKZIEl8bs29viFDS6H+MRuViA/N/zqtgDIaOLGmQ9du
         CdCKEN84G2aAUvlG1aZxCAsUQAoODwd2/cSG9YUIAisbRAHLxzV8KNcIsxOl1uEC+BXW
         6vBQ==
X-Gm-Message-State: AOJu0YwFeXpgac5enUi0Ng/PelklZ2zvVs45jE6o8IHY3sjWFyOc6S2U
	48yf6EASftsYHhgZVv5WhRqSqA0BS0eNc4K06EssxrjB5vbRp0kP8rmenBf6tQ==
X-Gm-Gg: AZuq6aLlFQJNqitBgBjA/TwozZNGTpqe5NqtZdaM/hESGzunWwC9Sjt3t0dTo7yoS5q
	V+dlEr6SUyvHN2eYkyq9ppqtpSjea3yqT1+6ngjp6ipSTLce8uuXItcr2mtLXbiTVrgyLFvqubc
	c45iLKvxzy32tINq/nNdH1Pe3/wiQ/DVM2sM+pABvTP4XaekQULRTjCBOJDO7N9kdQXlqFHYMOJ
	4hzqICSEV69ki88SYMMLdNE++saxhOa22CT6hGweF8+3+Q0XPKAsO1Y1LInud2i1ZxZl1F7+IeK
	BKr2QYHkj7+z8KZzIcjnGl1AHAcAa/hGzzHyj16BUlPoNOAVLEFPE17VKrL3iBaqEloKs2dRzFX
	9d4b/5ckXK94Rt2iled0cFwwHY6bj5n3fcOCVlsvBlWyLmVbJfhtxLmlmQ9eOxLc/w7r3Ferkd6
	+USYcULMy58cC3O1NZCzLrW8uh5sQD81SZSghDfhAgqXmQI7B3T0A/UjD2TXsECxDcLW4QiOUsx
	T0wdg==
X-Received: by 2002:a05:6122:1d08:b0:563:8339:6201 with SMTP id 71dfb90a1353d-566e810a30bmr279219e0c.17.1770150609826;
        Tue, 03 Feb 2026 12:30:09 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-566e80fbce4sm314353e0c.8.2026.02.03.12.30.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 12:30:09 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
Date: Tue,  3 Feb 2026 15:30:03 -0500
Message-ID: <20260203203003.2110409-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes responding with an invalid result caused by checking the
wrong size of CID which should have been (cmd_len - sizeof(*req)) and
on top of it the wrong result was use L2CAP_CR_LE_INVALID_PARAMS which
is invalid/reserved for reconf when running test like L2CAP/ECFC/BI-03-C:

> ACL Data RX: Handle 64 flags 0x02 dlen 14
      LE L2CAP: Enhanced Credit Reconfigure Request (0x19) ident 2 len 6
        MTU: 64
        MPS: 64
        Source CID: 64
< ACL Data TX: Handle 64 flags 0x00 dlen 10https://github.com/bluez/bluez/issues/1865
      LE L2CAP: Enhanced Credit Reconfigure Respond (0x1a) ident 2 len 2
        Result: Reserved (0x000c)

So this fix the check and introduce the error L2CAP_RECONF_INVALID_CID
(0x0003).

Link: https://github.com/bluez/bluez/issues/1865
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h | 2 ++
 net/bluetooth/l2cap_core.c    | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ec3af01e4db9..6f9cf7a05986 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -493,6 +493,8 @@ struct l2cap_ecred_reconf_req {
 #define L2CAP_RECONF_SUCCESS		0x0000
 #define L2CAP_RECONF_INVALID_MTU	0x0001
 #define L2CAP_RECONF_INVALID_MPS	0x0002
+#define L2CAP_RECONF_INVALID_CID	0x0003
+#define L2CAP_RECONF_INVALID_PARAMS	0x0004
 
 struct l2cap_ecred_reconf_rsp {
 	__le16 result;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b628b0fa39b2..7f1d80086655 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5316,8 +5316,8 @@ static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
 	if (!enable_ecred)
 		return -EINVAL;
 
-	if (cmd_len < sizeof(*req) || cmd_len - sizeof(*req) % sizeof(u16)) {
-		result = L2CAP_CR_LE_INVALID_PARAMS;
+	if (cmd_len < sizeof(*req) || (cmd_len - sizeof(*req)) % sizeof(u16)) {
+		result = L2CAP_RECONF_INVALID_CID;
 		goto respond;
 	}
 
-- 
2.52.0

