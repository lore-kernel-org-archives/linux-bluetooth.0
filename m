Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2212E2DF2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648438; cv=none; b=JUTOEAk4M5DvTRPAMHzQq14EpzDZa375h4aXZXAP/9Chh6PA4k2nmAUvcRNl5Zu06BU0O2Jh581F7u9PWLuV+WDYzw3SD1ep4Ecpp2N5LdaesIIGgHOIpZhiQWNOcuXgSuErWlk0QY+1KkP1qFUnktiN26DxWx1ZUFDW8lR3e3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648438; c=relaxed/simple;
	bh=tE1cY5MR4/f3aUkVlwTtu+fpAj9Swm11LIiT2+/7QCg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlfRBnICswiKBPDT+zAEdmS/S3uzN4I6gJx7rUPTMubI32KAt4KmlyB6K4pzdd8cmls18VHNpWLLPMj5wVyyCCW2VbsQYYzdHq+8PzDZkmRY3ajKDM2lZEl7g367jpREXkcKS4cGKBzQfXok23DVpcWl7BB5kCklXXVVvc5KsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNujn7td; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNujn7td"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54a80b26f88so456906e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648435; x=1761253235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfJ2dG+HquH4BCpJ12ouSN5OILoMhFECXBgdYDhcsik=;
        b=jNujn7tdGBMXbDfcCqhiVXk0qtvadi+/jfsrYqOaI6QcoX3pIXAQhF0dnEvSOQ6dYh
         zEbEBMX0jxmSJGeov96mg6IUsx/dOVL8QfXFrpNXu6hW94nNiuVllYrLogQYO0cfvY36
         UrQpK7YH0U5osvGFLMAbWrd9pozVCSYogc0AJiXJGnM8Li3tSPQkP1q+WIskjZyeC04+
         c6J2DMa1rpd0/X9wxHvWtS4AWsRLnHU6wHvC4Rdtc4XCj3XAoidZ0YB6l/eo5uywLeFO
         0ukZs7dX2dt166uSdNNyZhW7wp1J2ePiivbJwnclx3TZpKafd9O+pWj1Boviqswm1ZDM
         EdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648435; x=1761253235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfJ2dG+HquH4BCpJ12ouSN5OILoMhFECXBgdYDhcsik=;
        b=D5tFRjwkIsJiixC13lce1CylXRo2elDwZnZk99eVREDtzNr+Z7czh6OG7HKy9vwx2k
         yTJQSyrDerdbx31XR4OdD8UQcwHfuFaogl+h5B6zXSPybenxKNE3i1Jb2nurZfRGqTIA
         AZqdD8+zQvEkziC6gEbPeZz6PnKfOYu0XtnE09h5/n9y2MGoKUr3Sb9nzHMKGymAJXd+
         fes1/RWmcItjYRdteXonlRDrlpwxz1dfmEWETx2nG9pJUCeZV7oCu7Pne1kOi9lFdMNu
         20I8Dnuw7EyHMfZxzFjb1gu0eisueojqEpK/LafgMW59zx5hspDYWo18sV3btZYFs8c7
         uiWQ==
X-Gm-Message-State: AOJu0YwxNnLuDYRWHYmunTN5IFUg2HQF5q7qViPPtTWyBAtqS1hItG7h
	i89uevF10CJbjadhB0G6i7lcvMnwCgS/vkmozUuvbfSrbriI55OAfv1U2SzvP/NZ
X-Gm-Gg: ASbGncvuPoG2MFLcvuwD4BsoFSY0A05vNiB1TANQzdWxWiHXf2GpfI1v0gWM/7l5uuS
	pM2e7xH3wqlsSQgvoUyF0bxm6GeJ0zG5y6LUcIRkbDtsYtlzOV4SHwf8qe2woz2OokbMgEsgDAh
	O3OBws6zwc+AO3ZcNgKwXCmHYX3Q9yRLrR1Ph0xK35b77qy7P2BYPvnuelyr0gcLdVxipmx41Hp
	TX23f67ei/igF2bcQw7CrNOq1oZ8aCIsDeBsfN0p8RbJnJxvaXpDX+O1rJQwjLz4NbuLx2hAtx7
	yNGoRY+7qb+5aLJtg0DzdEJdkRivNsALTCPtqqVXBrzqEkhQb93WMMVM0e+c2coa7GmTIGTS2iG
	Ee5/ZOQHFDQEXwlF2qeFfK2m/GuufCDZU8JidmXdWNTOQEpC9nEjUqh9zNLjLa9ssFFidmYh2nm
	UfMUBgJ9D6MloiqQ==
X-Google-Smtp-Source: AGHT+IH68XRTRBMfVKRr7K6ca4eIDNwfZzC52EzSRmJrWstRWsCXgbg1xOjs+mD6PSMDbg/4n6Mppw==
X-Received: by 2002:a05:6122:a13:b0:530:7bd4:1761 with SMTP id 71dfb90a1353d-5564ef1e5c6mr723883e0c.11.1760648435209;
        Thu, 16 Oct 2025 14:00:35 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 05/13] shared/bap: Add bt_bap_get_db
Date: Thu, 16 Oct 2025 17:00:11 -0400
Message-ID: <20251016210019.191878-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
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

