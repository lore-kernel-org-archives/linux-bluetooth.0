Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55BB1AC8B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876995; cv=none; b=e0mTFJiX2ed5+LA7P4pve4cYFj6eqbWD9pyWg3TvBK+RYZGX74TdgitW8qFxHUZVq1IFoChO63vmFLmi0xTYQJw69dsqkfwtZnoYOlnGOaRh2nmtrzJaSdZ2bKB+fFNXiA3lxP3X2PVR8NZe03eciDTl16ISSPVFnt9/Wb2BGeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876995; c=relaxed/simple;
	bh=+b3f+ItAmvAzQVJkeZHn72B93bi8+H7qXbZNTKiqIX8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gmvCOjOE3L07bXJF26J19r25Z9Z4hluFoo9JTQXBEdf1z9DM15fkQLXPPGWyKio9VvXkPdJWITYacdc4DIyN8IKTO0JIzlHYU1aQA1SU1AMWfvGnVSWyIK3mHus80NplrCCUI5DpLBj2frD+70cCDLMVC9lg3iAHkTjMqzCVrNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeXXK6En; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeXXK6En"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4fce352bd28so2015448e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724876992; x=1725481792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=STPIKupUU2lWIURZGibexPn64YQiI1MC+pmg/544A5k=;
        b=BeXXK6EnLR/1aw3Wh7Kx9i7WM8eh0RgJKF2plaGaJoi9bhIdw7F56gMOYHcvYo3Rjn
         Wfy8D+SDeZ+PLR/ia966DNSJadsFgARObiAB0GnkEE+IeVk8bHFmuN5WZgk+G1RTapir
         sQ0Jo36Gk+6Bwk3E58rWW/g9j/ewddViXoZKpS4nCE2jqimNCQh1fp3E2LUYsV+spxEV
         //XgLj/bKYNMtCWC5P8S7WLvvkLBbGdT+PkpfNdw0JB9UQLUjW9/6vBBpy+bzKYqME/N
         LZKuNsVx9a595gb+3ew/8gpTA8kJD8FWbKjuPsGlMez6Tb83v9ow0dnnP5UjM2d3Eq/y
         HdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724876992; x=1725481792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STPIKupUU2lWIURZGibexPn64YQiI1MC+pmg/544A5k=;
        b=fyLYnVmCGjX93vLbilacAApZUdRPkjnsu/SBzJi9K2Y8/ZR84zhCuk5onrxBoljbSc
         CIIrpLr+T2sLTJbGDwk7ofFhM01AeNJq05A3tAvUUp3ztikAd0sz7rUbYgOmmFPSCbOf
         s43sD8xGkFKe/bN58RDGWxLGIDvVcMrslSi8ZJ1IK8/KlRbfEi4S50YrRMJ+wIGRaK7E
         XzA4Ch+iACw5TZxNXj0ESxhJ/vKg3/SlwJIh8P+myWddZ/AzSpXa/WJtT/zFBHVCGmNZ
         nlaxzBOLWZPyab82++26t5/ckAl1vkfSOxX5WAE6uwg4v5Q8LN6f5K5aouXW0kR/448g
         11kg==
X-Gm-Message-State: AOJu0YwT6V+WyMN2vYU85+6vxqtUKoXSSD1to/dsChf7cHda0VjA4er1
	BhOCPPpwLz979yoTdPXerqsZOXquOuAd3JdeoFVQMfonG+4MvYNMTbi8Iw==
X-Google-Smtp-Source: AGHT+IHC4G9GV6RypFCTt+K80Ah9RizINyCzlcA6O6sBuudJC9H3+nMCTFFE83hHb/qKcZErbRjxcA==
X-Received: by 2002:a05:6122:221b:b0:4f6:ae34:9659 with SMTP id 71dfb90a1353d-4ffe4ba0cc4mr732454e0c.5.1724876991769;
        Wed, 28 Aug 2024 13:29:51 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fd0823c83esm1364378e0c.5.2024.08.28.13.29.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:29:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] shared/uhid: Fix unregistering UHID_START on bt_uhid_unregister_all
Date: Wed, 28 Aug 2024 16:29:49 -0400
Message-ID: <20240828202949.924451-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

uhid->start_id shall not be unregistered in case of
bt_uhid_unregister_all as that is considerer a internal notification
not under controller of the users.
---
 src/shared/uhid.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 98d6198c7d0a..ed21e1399ba7 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -284,12 +284,22 @@ bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id)
 	return true;
 }
 
+static bool match_not_id(const void *a, const void *b)
+{
+	const struct uhid_notify *notify = a;
+	unsigned int id = PTR_TO_UINT(b);
+
+	return notify->id != id;
+}
+
 bool bt_uhid_unregister_all(struct bt_uhid *uhid)
 {
 	if (!uhid)
 		return false;
 
-	queue_remove_all(uhid->notify_list, NULL, NULL, free);
+	queue_remove_all(uhid->notify_list, match_not_id,
+				UINT_TO_PTR(uhid->start_id), free);
+
 	return true;
 }
 
-- 
2.46.0

