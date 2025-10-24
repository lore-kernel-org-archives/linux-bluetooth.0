Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F13D2F746A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338457; cv=none; b=ZNrE9SMIH3tWWO+Incn/3mBMkLucQWrnDhhrab7SgFGC3hB2l92JYBRrqXm5qT+tMp58QKxoMbF6L13DcevS5MHicI6/X0ijeoF+MHqH700vBcXY/9R06atRZi0Rd+6E6v2zAJ9CVdeudoqimEEYrXNeefm5KkNvz+Zfp4wApv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338457; c=relaxed/simple;
	bh=tE1cY5MR4/f3aUkVlwTtu+fpAj9Swm11LIiT2+/7QCg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YG8ou5tumgQ0rEPMw/xUqMRZ+6mXoZHb8oDZioQWapuJ/FwDBQar9SrzH1RFVsa5C2ZatzK/jHnNNOE1/Mr+KavEhIFDTxnwVNW2IPngLiAP8EGYEaTnRVG3Vfz+L4ZMJajvTTj+BDsodMw0DQHMXOKqH20u5p4XLb6Nkhn6GbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs8praSk; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs8praSk"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54bbc2a8586so905647e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338453; x=1761943253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfJ2dG+HquH4BCpJ12ouSN5OILoMhFECXBgdYDhcsik=;
        b=Cs8praSkGCwoDGJPkh7HYJoQV3Olg4+7EZ7gkG/CdtaS+7OGuOETdQvKSDZ0jspg6a
         oD3YXTibYKZlNOJ0/D6X7juYJ8hwKOy3oTC5gfKZN29XaP3dI7ry7IzmHeUCmiupLr3y
         1MWpbKBm6Q0OhJKxJujQyu379LqSAnqDQkn5c8EQJmwp+RHLkQCboZmn6owrHoO2dvJ0
         BiuWZothXoYl5017VoOvy8k+ochIt8CsyXCcHtNjPbZC8PR1NdW/Ndsq9CCO91xDGa+I
         cNCYzQXmGg8Oka2Gdc2zArShr4wKkXyvDEnnGhXaooAG6eeXsQsndxrlyPRQMDpeEcQv
         lnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338453; x=1761943253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfJ2dG+HquH4BCpJ12ouSN5OILoMhFECXBgdYDhcsik=;
        b=nmJ8aqBhGAd59UjLSnG3KFw6Z9mPWwbv/Tqxskbwxe8SgtBnzfOG9+rkT+R8ybWwb2
         V9XiwNkuy4tyCxK0ua7TAOFMbAnjc6AKm77uG/c/JWHxzehaD/EbXpytc0QiQ2W9MGfi
         BkiA1bwT+n5fdH2olx1kayLS3KCNPXkyyMXw5zPK36Texyff2al3vhU+GVgz7VuMXRgC
         wSJPko4OLnvZw3F/dPSb1913Le8qXLXZLFCzWlMoUsINVtVvwSDMs05R4fFQEtDGEeb5
         4RbVJJSc0mvgBEXmHEd/bRpi4D1iXktu1FX7rczNWTdqH1eAZPSsQOe/KT43N++E1jXb
         7+Mw==
X-Gm-Message-State: AOJu0YzGr7Muvi936oTt3ieikkX88YAcbGkrsVrWzBsrJQ9fi9e+1xXz
	zSyuReLUbAV9q8HSiIAGFGjS+BGpL4Y8UQBn73UjHH05mRfKeDIr4B4otHb+ig==
X-Gm-Gg: ASbGnctcnqQ5/jObnoiTQhfNhx1Ev8BNlVQr4DmoxJQoSGR/dH9HdEtYttwp+632U4C
	ibipdSG0m9zhMnu2bVAwH21TqriLiuUMQgcq98ZCR5ywvRSeJR4W+RLtrFSzEnIcjJTMRtiHFTj
	+EAECFEgAPwY7EVo7DbUMf6DRqyV7yQrUFIaqJdkqXtTWTgwiy1nw+JIW3SOsgiBpmNIB0qn3JZ
	3iFywL5RWTgKs1YCvOpu8kF2NMcn8TQPqFlWfWlcuw8I4iBSwVin/TAFyut4FNCeJOtsQoFwdlQ
	iPtdukS/RWzS7dhsdMpUN0WGPHfF5vPPPLiyHxTmyJiYzhbpwsN9wO7dOL53ICX8RYENzTWZNdE
	6TBKadwD77308qNHcZtoqpKuctBQE/e9WQfDCfVanr/yHWfKeJrIGRFJtYb9ASRIwyOP+4QAZlh
	yF711ys/VBE7HYgg==
X-Google-Smtp-Source: AGHT+IFYuu3zv+zBSofpKmR2wanP607sD7RLcf/EnVxT7V1e/r5jouNciJHeZYQb5mE2LyqTouhHLA==
X-Received: by 2002:a05:6122:da1:b0:557:c841:14dd with SMTP id 71dfb90a1353d-557c8411534mr2396715e0c.16.1761338453419;
        Fri, 24 Oct 2025 13:40:53 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.40.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:40:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 03/12] shared/bap: Add bt_bap_get_db
Date: Fri, 24 Oct 2025 16:40:30 -0400
Message-ID: <20251024204039.693918-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_bap_get_db which can be used to access the gatt_db passed
to bt_bap_new.
---
 src/shared/bap.c | 11 +++++++++++
 src/shared/bap.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index fd52db3160a2..c564297518d6 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4653,6 +4653,17 @@ struct bt_att *bt_bap_get_att(struct bt_bap *bap)
 	return bt_gatt_client_get_att(bap->client);
 }
 
+struct gatt_db *bt_bap_get_db(struct bt_bap *bap, bool remote)
+{
+	if (!bap)
+		return NULL;
+
+	if (remote)
+		return bap->rdb ? bap->rdb->db : NULL;
+
+	return bap->ldb ? bap->ldb->db : NULL;
+}
+
 struct bt_bap *bt_bap_ref(struct bt_bap *bap)
 {
 	if (!bap)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index fba8b6b17884..efeed604dcaa 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -128,6 +128,8 @@ void *bt_bap_get_user_data(struct bt_bap *bap);
 
 struct bt_att *bt_bap_get_att(struct bt_bap *bap);
 
+struct gatt_db *bt_bap_get_db(struct bt_bap *bap, bool remote);
+
 struct bt_bap *bt_bap_ref(struct bt_bap *bap);
 void bt_bap_unref(struct bt_bap *bap);
 
-- 
2.51.0

