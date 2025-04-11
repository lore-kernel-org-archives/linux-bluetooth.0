Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5D280A42
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744401392; cv=none; b=X64OYKQM0M72ZRNbTa1urt+32/T52bhIVXipWjWWdyk6bANtXnFaXCOv2eXM7B4f93N1/GLSHH/yjZ2ZUV1QA2qFOXxfxlUPbH6OHXqqekDbXTP2JBjBaEKOWbWhdkry1xWYKFCTReVhJWTGtBrpoWmZbsodTTRtqf+5Y/rlOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744401392; c=relaxed/simple;
	bh=r32oAtmJV4GUBVTcyRweY8W3ZwcYF9lzM96+0PEcaBo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XuRKoU7zqMYnJlqPCwjmLRJ6oM6uwQ17R4+Tw4xKUOBLNrVeHtFoRCFG4qj/L7EerWA5ZqRECOb3YooeNsYeWfxufL11DlwkPLjnEDXOl2RkZIedeImJRsGicEImO3rV/0yvCNeCyi8Dfjx+VrW8vbzLAU5UoF5wU2O+1LmtkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmHU0afo; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmHU0afo"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-527b70bd90dso1115180e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744401389; x=1745006189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aO8ssM0dfDJUhN473dOwaJoGRWoeMmAGYDR1boXBPUI=;
        b=dmHU0afo6W/ZauUMDxe8ibTEg2+JvOeAFz866AbWjQy3MGAQmUZo4m8saTSNP47z9l
         vS+RjEPBtz2J84oRlI8YjAUgI1xAhIRdq+fqne/pqwIpeAxIGLToUDzEQVatYT4DuIp4
         wDBtzb0B36E6LnjbaIPYAvOqQwoxbmvPp5DDjEdGSjBEdJqJ6PfzR1bVfL/lfyunJ1Q3
         KOnpy8gjJYSocOHCscSTOVVQINAlQ9yMfTJZGQS1loPXl6hXopddHmRbCTuPsl4bhg8o
         97CiilTmIjmuAQ0svKwTr7Qt1qf9BBrMce3eh22XARs9rRnfHyJRKPT5zqrdtAnoM3Pc
         cMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744401389; x=1745006189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aO8ssM0dfDJUhN473dOwaJoGRWoeMmAGYDR1boXBPUI=;
        b=JbYwWd/f4UEK0NE07zXzgiutZiYxrjMkydWuYAGmGs2rzUguabbCxTN9yGscrh9yf4
         NAnGWFiIrP0HYOZlc+HQlsoVSEGXW8jiYCN+eSkYDSEr2OgMJaLbsaYJDhYg1wKQZwB4
         tLIL7W2AEIDIfIvCPVUNOjOW0b4s9TJLUP9FxGEtgDgRjCErjCz1pwWuUfB9Zl7buir1
         CvE79a+IaE2jKBe2x+wbYQdU8huzzSQ9On+11TsE8doF2OmJEeKDTM+vrzLUNgE6BoyB
         CBR+XK12hg95W2RQ5svSuD/asCCuYLmRQvvoT1lN8DeD5oQcMiy50t9Enx31Gw28dg2u
         L2xQ==
X-Gm-Message-State: AOJu0YzQsDznUp07XZYeR/pZ54U67u2IZEP0iD7frs4ME8z9Mm9vCoZx
	XqLIVeTzfD59zJjl3Jlj2hlDRueBvDkLva4a9gG8UymsxNtyGbiHfs5M86AG
X-Gm-Gg: ASbGnctk5liGFFdsIDsj2IEpZ6Jj1CI2QUNFQWgQYSRVuTzY179JYdIZoymOz/OdXl4
	oa+uRm/AJvdLeL3JCyRDiGuMdORmnzsph5omf1Ebh4BOQiUuuaBlK5EvdAQXJxjLv6VqQKxOT/O
	FjW0HsN3Ol+GOcfiJ+FASruN3dOuw6wqA1e+ROWH3m01nhYoXpzlkr1LOuYHStz4wAZMcQ7H0qF
	WoCYI7K5bMTHMtaPnF/maS+bC4EVrddKWUP83WMUItEIw2tO+iUoTMwKA2zqOeDgyYD7WNqRaeJ
	CzILlsjn9/BHTy1OGz5OYa2F9TjH7k4D5NZRTXy1CqdTpKL5m72l9h/la7Hh7L5a+3wD9rwt5AF
	uij+xMVqbzQ==
X-Google-Smtp-Source: AGHT+IHUIlRFiZVwvttO7JjNFUn6gEb8hzWLEoLIrSd4i9N3U9GbtQe1kMJhcY5iymRmcCRI2Y/lqg==
X-Received: by 2002:a05:6122:250c:b0:520:6773:e5bf with SMTP id 71dfb90a1353d-527c347aa6dmr2661224e0c.1.1744401388992;
        Fri, 11 Apr 2025 12:56:28 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abd4cde2sm1226555e0c.10.2025.04.11.12.56.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 12:56:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] bap: Fix not setting SID for broadcast receiver
Date: Fri, 11 Apr 2025 15:56:26 -0400
Message-ID: <20250411195626.109307-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

SID most be set otherwise 0x00 is assume which may not be what the
broadcast source is using over the air. but since we don't have access
to the SID of the advertisement in userspace mark de SID as invalid
(0xff) so the kernel fill it up while scanning when creating the PA
sync.
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index fd9b751cc1bf..24763666ce96 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2813,6 +2813,7 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 static int pa_sync(struct bap_data *data)
 {
 	GError *err = NULL;
+	uint8_t sid = 0xff;
 
 	if (data->listen_io) {
 		DBG("Already probed");
@@ -2833,6 +2834,7 @@ static int pa_sync(struct bap_data *data)
 		btd_device_get_bdaddr_type(data->device),
 		BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 		BT_IO_OPT_QOS, &bap_sink_pa_qos,
+		BT_IO_OPT_ISO_BC_SID, sid,
 		BT_IO_OPT_INVALID);
 	if (!data->listen_io) {
 		error("%s", err->message);
-- 
2.49.0

