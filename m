Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111A3158D8D
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724100792; cv=none; b=GqvfnMKFJxDZKr+Gv4W+bNrSquypl/x7Bo+S8mTgFDZuFaWM4ZOxhCnMTa+XLLHT7QbMxvQDk/pbYgO9EsNlrn+9AZxy3GoJ7jApj/l+FgxdRJj2YunA1wh+VUN5W6KgGP5aY6ZhEG/Yk0DOZ922KSW1LYPzIQgfh5LbMPx+5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724100792; c=relaxed/simple;
	bh=pjQP/CuiMZHWVY/JfVSX3Yx0VjTLUtqFrfzohRJxkGM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0ZukBefYIVhS4IIwHp0LDb5I3VPBUmY6b0tC0GCjwEkR2jIXbS8mtbQPgBZsdACWIz6vpZK2nVqqXMQ6imlRVx5JyD7wNjSSGCYQREtHW5onXcwJjuPTYRkHT9H0lohnnAXQTxcF5oNfu1Te2m+ezZ9fqO4+km3sLg1v+2cv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX7lxW0V; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX7lxW0V"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f2c8e99c0fso1602461e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724100788; x=1724705588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weM2o/FJseL1E57zA4/JUAE+buZRqS1b0drKnHzV1SY=;
        b=iX7lxW0VSnIgWYPU0+mUfxHm+IET6Cgz9pZKNBALoRMXBvQaxY2AaFlU4uo87hv6PF
         q6tTJARFB4X17/OQckd+ueZhfCasi+lcvVF6Ux9Kxkp3FMoEzz2kjPO5anUXSTU2csdp
         y+vm8kwmngKHdWqm8qWlYvZGyt+NhhcFOXHeLGodbpTSFNcWc4HhFpMX+X7pC8hya6DD
         +1ffzosPNwi40PxHuUKrjpDs2U4JZboDNAytti8NQmn9fkQY5Gdj0jeXl08zLGdAX+nw
         UJhYhPugjx/OpOKp1aymujgshcZekjtwhM4QjL8M6Jw1INingSOHmzjBYpvnUxA7pO5I
         93qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724100788; x=1724705588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weM2o/FJseL1E57zA4/JUAE+buZRqS1b0drKnHzV1SY=;
        b=cyOy9vc5/C0TZ45Z+Cyefs9vfEt6hW4k4B42ZXNypT3Fj5p2aSKuQP1oIdpnK/jcR0
         LFo/g3CZ/MoMJgkaGE/6xLdKCN3/CZjB83ZOY78Onsyk0J9PhNyCFWzFn0vLpk1flwW7
         zW6ny2giAolO5iYkQOItsYL5ulGOuEHJTe5llyxcoPi93U74/ZnR62A4eu/qM/mveCje
         NwiZS/ow0U+SPYCLHc2tSTvnDN2Qt+O2B3kPh6/GjJELmlKlh24R08ZN7tuNTkkR7H5z
         CBOPYVodBVikoKKRCbeJBddpOhiWVrkj6vOEADxkoU03nq9tr+i8T0V0VhXOq2hSn8rr
         NQdw==
X-Gm-Message-State: AOJu0Yx50OseSLfU1gat35hJiPutagr1Zk/HYqdyxwXFyX4uhWTcZbCp
	uuCQBPXf1dCyUn5S8ZVIQDEqQz8KXcCmXgXzl3NZ1D1hGESCr+CLoXi5zg==
X-Google-Smtp-Source: AGHT+IEWuhiODu8VSM9SvdejNmZqFix0bCKOdFxv0x36rxTLffQ0l4k1BRp5EIAxuB1iFL8IeU4RYg==
X-Received: by 2002:a05:6122:3c84:b0:4f5:1ea3:736f with SMTP id 71dfb90a1353d-4fc6c9f392dmr15381188e0c.13.1724100788170;
        Mon, 19 Aug 2024 13:53:08 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b9cb136sm1155049e0c.50.2024.08.19.13.53.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 13:53:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] hog-lib: Add logging when bt_uhid_new fails
Date: Mon, 19 Aug 2024 16:53:04 -0400
Message-ID: <20240819205304.60594-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819205304.60594-1-luiz.dentz@gmail.com>
References: <20240819205304.60594-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If bt_uhid_new fails there is likely a problem with uHID module or
bluetoothd don't have previleges to access /dev/uhid.
---
 profiles/input/hog-lib.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 729603702e5f..22599f71a394 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1421,23 +1421,29 @@ static struct bt_hog *hog_new(int fd, const char *name, uint16_t vendor,
 					uint8_t type,
 					struct gatt_db_attribute *attr)
 {
+	struct bt_uhid *uhid;
 	struct bt_hog *hog;
 
+	if (fd < 0)
+		uhid = bt_uhid_new_default();
+	else
+		uhid = bt_uhid_new(fd);
+
+	if (!uhid) {
+		DBG("Unable to create UHID");
+		return NULL;
+	}
+
 	hog = g_try_new0(struct bt_hog, 1);
 	if (!hog)
 		return NULL;
 
 	hog->gatt_op = queue_new();
 	hog->bas = queue_new();
-
-	if (fd < 0)
-		hog->uhid = bt_uhid_new_default();
-	else
-		hog->uhid = bt_uhid_new(fd);
-
 	hog->uhid_fd = fd;
+	hog->uhid = uhid;
 
-	if (!hog->gatt_op || !hog->bas || !hog->uhid) {
+	if (!hog->gatt_op || !hog->bas) {
 		hog_free(hog);
 		return NULL;
 	}
-- 
2.46.0

