Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBEB8529A
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814627; cv=none; b=pCAAG8Rxn6T5YNucMiAuITD6PYgmD42NkTqyTDsB57USHYIhfUV7mMZafxEoG5woRQ683hfTiqaNU6X8E7esumkNTKQWf9KQ+6vgKwcmf2GnTpqR/EnCh4VgQERl5/J8V74ZWPws7Jd1KNZqgU/P8WatXkWb9C5gyPStv1737gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814627; c=relaxed/simple;
	bh=gyuyQ/aK4rZwWgwe0gruyYcDUQyzIfPAlXAzVb6Vozg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObGy5PEi1SiU+Pwdiy7HprnbyA79XuAN0VYFi8Xy+FZoBUxPykJ4Ko2tUXtLiBJ4jbfpbwFMoFBDt3b+4PP7EfsIT6mJ7cn4ed0dkLBUs40c/PYhKDXd4X7eY9jnf1VtQx4elYfJku9fU90QY5TW0GP8UgOM4kL4okcYCc5qBxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke3Wxw+x; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke3Wxw+x"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59a7682486aso544103eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 11:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706814624; x=1707419424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfocMJ4OgAO3HX5ciQuRwEHA66Qb0abBxdrZu7QgJK8=;
        b=Ke3Wxw+x1A0YaqZmGxC5ie1Zk7kAL6noDc0t/aCJEX94FUrVGTJYSlaqIcvX1EFz3d
         JvEMvnPu+IqFhwvljb1bkP58pZKt9jrwTLIUx8ppTlyWbo7UpOTFaDpLkORTu2GJHgVZ
         +52yY8saXRlAvt1JgVhzeGWmBozfrVxvDwSV3jB4FK18U2XwXDlu7jb5wE5O4FyfTw2z
         p6CNJyOjouzcaySfiKNdgnqMa9mC8hfH7HnYeA9A8bAl4joewsbHt5B7OGaDAwMPAW9d
         JFouGrnj/xDeBpdqMBEO8xkX1ldtIQwlh+ixOB86LvSQ5yumXK4EHkMjm8lGV0dyRO6d
         xq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814624; x=1707419424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfocMJ4OgAO3HX5ciQuRwEHA66Qb0abBxdrZu7QgJK8=;
        b=nJtVgQVrOWAc9eYWnMbNVbQpb0Lkg7Fomo7I9qpyB9fIHCDFd010TvOBn7d3fyNsH2
         pADUsie4COW/UloRYWabiPwEfT8c1JkUs+T0JH9FPAjHYsi5fl2thWALFu3qYmfQQfxp
         yHJW+dRhsDp06FOR2N9McI3G9wJmGtQQWLFJTYNBI4w3drUqtWH1rfFx8GzArLE1elDV
         VjFhuCQ2RuYmXiuuV/uLXDp0zOmQKow/hlG93qOltfkGYlsSWCiS0VXidz60wqx4auhd
         tRLli8pgxCkQAXyDZmk/z/WGlsuLO5U6/m3nWrsgJBuYVcrSP1/nOHt9A1KaZiTVr01t
         KLUA==
X-Gm-Message-State: AOJu0Ywh+hlxTHqRRvkA2vY57+UMUrVi/AT9IBCQbpRqdH/4B4J1uuFv
	KvFLns/1tvs1piOU82fOcXFQTxbztTlVIxINwuy9xB5lm5D0GkgnmR6pafNy
X-Google-Smtp-Source: AGHT+IHio+u3quunxNJBTesdFHZYxJAFYMlS49XEsZH1oydtct2EGjuWRWZfNk6OyUmConeNA+kwqg==
X-Received: by 2002:a4a:b249:0:b0:599:e74c:ce3a with SMTP id i9-20020a4ab249000000b00599e74cce3amr3120505ooo.7.1706814623989;
        Thu, 01 Feb 2024 11:10:23 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id db16-20020a056130239000b007d2e2f14bd4sm35912uab.29.2024.02.01.11.10.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:10:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/8] shared/bap: Allow using bt_bap_attach for broadcast
Date: Thu,  1 Feb 2024 14:10:12 -0500
Message-ID: <20240201191016.1122194-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201191016.1122194-1-luiz.dentz@gmail.com>
References: <20240201191016.1122194-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables use of bt_bap_attach for broadcast by checking if there is
a client or ATT instance.
---
 src/shared/bap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 851d6a5facc3..ce8d35f86af3 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4156,7 +4156,8 @@ bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client)
 	queue_foreach(bap_cbs, bap_attached, bap);
 
 	if (!client) {
-		bap_attach_att(bap, bap->att);
+		if (bap->att)
+			bap_attach_att(bap, bap->att);
 		return true;
 	}
 
-- 
2.43.0

