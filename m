Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0423F6C2E
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743221; cv=none; b=uLJan2FWs8Pi7S7CFcaqkWHp9OIMxWdBB6czgDdSqGHpHcRVmKBPv33McqmaKnxeYs7B5JpehQBPhg28a5ZAsXkzcTUt53gq7Pwab9ZYtNk2NDYr2zPYMZZjNC1FBMT9fwnRDSCUg+IQOp+UE2N6sDqPI2hXYL8VxWagLZSFeu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743221; c=relaxed/simple;
	bh=2F+TH1TM1acXvmLfa2fLN5mrNnqXNYeDm2GaQ5xlfQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KlRN/MLBW/R1jjLrtlYgfKwpztQXnXVnxAppvB/5OKARX34pNkfeGdS5pSYJHKI2GRFi8pAsVFjHuPwC7o0Yp+DirQUK0f1Ur+ExycSgbB0VCj0U29kBaRTgcPw9PbJfUUeymycK8H6MAj51JzGe0+rryHxTv3zzLhX+NIaSa1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC+bJWyH; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC+bJWyH"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-73770fd1cd9so737305137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782743219; x=1783348019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDZ2JtdsIg0YMG6AxdlQ7+ijohmZbDaNAfUnxVkAxWk=;
        b=LC+bJWyHH4N5JnSW++xTinurIBk3vRel2noPwnrKNcaGhi58f+Hbd0aoU1BFiEZ8Pg
         zOvg+LmxLGK904p/etWeywGhYMt+2FAfMOvHDORozNtS143AVVVMT8w2qb/8ifHtLV3j
         EF/BxXb1Bm5SrI4oQ1vSrgtXQETtF0ro15jxvzwBb2Nhg6njkaP4MN33REAWnzSD4ILm
         mH+8IsxUd7dYpYFpaM8/eFw9m4YYZpxm1fxnPLoeU9xMvwFcGBjg8z2EXchdW6laAVge
         KM7404g/B0+t/14ZQ588kXa9ya1TJ5fBwrMBM5W8uHOp/WQ5rCCJlDuKKXuBPHH7r0iJ
         mt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743219; x=1783348019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDZ2JtdsIg0YMG6AxdlQ7+ijohmZbDaNAfUnxVkAxWk=;
        b=Hi91qvZoUu7Ed6AYN/YrJqcu7rHvljDOqvGhrSraYtcZkoaPZMeTaXZrD1/rmGdCXe
         cVF9cJzEvmP7GKBwmtq+5pzdZ2uRfurMurOpM765pTsilxN2jqnSyv42z6w47F6l2nYb
         GTJN3pe3KLUnn5ZhM7TsKyiLOaXfQ/Hwv+2kfSwkUDDFBfm2yC9A+zGx7DJDmNML3H+e
         d76VKqeFCxm6MRzXkaZPG+MXI3tE6sv7Pk8w+4HIAHyrqZH++omOcmfE9SZ6n3LqbSR3
         2u6RRaUTl5gU5nC1YnAipRqKkc7wou5pZuu7fO/+MLLWsUGbAGR1qvD92t7hvnsRKwDL
         Tvlw==
X-Gm-Message-State: AOJu0YwFDmGBBOTgQ8Y9nyI0jUIi8iZ2Iuq8jz2U+rZDhpas044U5Qep
	vXOEgzCefXmDoIe8jC6sJwr9HzS1aEBPQxJXYvJr/DsWQTPJb6D2XB2SoKLU8vdN
X-Gm-Gg: AfdE7ckD667TaDF9CzAUYJDTyZKf8jM//Ncs2rUsYH59Y8uBMKb/T59bqyy1QrO1p0z
	AytnJOIKxfHCtQa1AensBu9heRcfZ7Ypke1hvp2rRPbGZzR0YVK+rNbs9ZvaoOXjqGHjveB/lgr
	uQlHYvhP63w25ZNnRZy34E1oItQ21XpopWvCx/Pg2zjo2Pa0iLhR74Vrw4jmiNzXZLBr0bJSw3G
	zptRCU1SlskPvTcWidKmff/56ec1HJQmFSYHOPmrNoQUPWnr/ksRbPt/rVl3zO6oGsFDkFJSoJp
	+eDrEz7D3vJOVxNqt2BlzpvnI1OZiZ4xd0HlrpE0LhPxTV6SlYAK4SvLEB5Ro/P8e/b2Ad+DnIK
	mJnVa5abw4qr88tEO9qrajUIVBrrX8GZlrmoxqUk8JnBx0xlf/l6T/2PEMSk2bqoOiY2eTdyGJW
	0cb0IEhTbTT02VZX67UA9SWdAyPqbsZEr7vJocY66dvrKWnWqGvNFsQxRlZ9BZzUW/fikDzKPzY
	VBryjBCvzRt4J7g5Q==
X-Received: by 2002:a05:6102:5093:b0:738:9dd5:9b03 with SMTP id ada2fe7eead31-7389dd59bb4mr1551478137.20.1782743218916;
        Mon, 29 Jun 2026 07:26:58 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-738f72b4cf2sm1350695137.7.2026.06.29.07.26.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:26:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/5] bass: Fix possible crash on bass_update_bis_sync
Date: Mon, 29 Jun 2026 10:26:45 -0400
Message-ID: <20260629142649.966025-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bass_update_bis_sync does use bass_remove_bis which may end up
removing the current entry causing a crash on entry->next, to avoid
that prefetch the next entry.
---
 profiles/audio/bass.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index a5ef80fbc835..533d45babfeb 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -2014,11 +2014,15 @@ static void bass_update_bis_sync(struct bass_delegator *dg,
 	const struct queue_entry *entry;
 
 	/* Check if existing setups if BIS needs to be added/removed */
-	for (entry = queue_get_entries(dg->setups); entry;
-				entry = entry->next) {
+	for (entry = queue_get_entries(dg->setups); entry;) {
 		struct bass_setup *setup = entry->data;
 		uint8_t state;
 
+		/* Prefetch next entry since the likes of bass_remove_bis can
+		 * end up removing the next entry.
+		 */
+		entry = entry->next;
+
 		state = bt_bap_stream_get_state(setup->stream);
 
 		DBG("stream %p: BIS %d state %s(%u)", setup->stream, setup->bis,
-- 
2.54.0

