Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D721FD7
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777112; cv=none; b=kiYQ37EGa5Ukc8ypZCGMQoqpdXm+Tp9fDOA3rLQhnoRc5AADPk7nNIvmnziX8CYoDxAr1Mi0Azhp4P0tQhetq/pVshcGZOIRAIEo805m5/Fh21VE57IERisbG3XegdrrSTktfXBSkwx4mktssgK7AiKg6ygJ99jeHJlEbJoHCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777112; c=relaxed/simple;
	bh=RoATdOmJbDk9lrGtQq/f7oUJyMn08wYFoa+EP3m5fKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lYBF+PFeUTIl+VYsuUr2jreG9q2jz+zZXqGJ/w8zkwP7fPTgwrejqzlEzkvg4rbAeqJ2UU4MAvdReXozr+IgF44PouMU4O5eKpnu5+LBjQZ48kYF2g6GD2rBtiee+m/ND/0/MZYUCk3aLjxEAbVLnJ216lovqfKbwVu9yZJDOoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ksi6cHu1; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ksi6cHu1"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4c01ca67504so569141e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 14:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707777108; x=1708381908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=Ksi6cHu16xf/xQhUxp9sEUpnKtdmpWaTSOk/3vtUTM2zrBr30+TyCqRPoGJpIl/YUX
         F1RrfX5J4VekPE2cvJnCN7Axhf/06YSDwk0i1PQDic5ok9tf14HR2AcEZkFGfzT/6V0J
         4j4AS7+ZMBgD558s8TFZmgOf2QEQ1HOBhYAB3eD3AnG8TqiImLiYp1l4dbIqgo7bQ1BR
         Rk6d0smaVbvpiP/BSvPJjdGyK4htCuFFhQ1TRzMpcfC9+sRXjuFMh4UDZqj4knogs9mQ
         eeLcMYNOsZfFZOIdBHNVTsvfrG4I8u4ccjXqiBCbri4EN+94Wc4Bvvxmvqj1wuFSPyPX
         zJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777108; x=1708381908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2q7tQ1TG4hNxpIKUh7oxpZsvECnxvXqaKYzpr2ZN7o=;
        b=lABr5/DxS/uWQlBRi59HrEjHaEZNHSzCYdGdGctP0hIIUc70Y9b+rDD+l+UuM+mCRd
         o+6Whupx2s4hKGbax103pElhRgYqhQO2tXFMiDCKd+kB3YwncOev1d33El2Ytd+vt5GH
         unI9uBMejMMaw92zRH8KYoBb1sItqRxZtj9HsxBtNn9psHM4kC0nWoVNc9GqJtEoBm1Z
         kBdO9lLAtpIpuQm0bSgaENFkQoOF+LVA44GT/ZaBfSmrntVPZSgMTdej87qCSif0rsFE
         JyfA7Uzn16gk+zOnbZX8t6pEqvtVVrEJ/s8t/F0QNZY/AjMw8TjAiwXshAA9Tbqbl18x
         UwqA==
X-Gm-Message-State: AOJu0YzOTf6mVdnu3tCSBBjJFLuikS1GPV6xzOqGWNSablm1qNOdTdzn
	PZmr+9P2K0Z2sy1QggU0g/9RNqyJO+W3tADBQ4+YiZa0UELisk9TF7Fd2JDk
X-Google-Smtp-Source: AGHT+IFoJkDo6eiM/FSfKICoUMzxjfVkma9RjZ7JMJY8yGLdpoHABc266vy4ffDEUBzamz3qHSclfw==
X-Received: by 2002:a1f:6201:0:b0:4c0:1bb6:33c with SMTP id w1-20020a1f6201000000b004c01bb6033cmr3618398vkb.12.1707777108416;
        Mon, 12 Feb 2024 14:31:48 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id z13-20020ac5c18d000000b004c0460eeea3sm840483vkb.43.2024.02.12.14.31.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:31:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/3] hog-lib: Don't destroy UHID device on detach
Date: Mon, 12 Feb 2024 17:31:44 -0500
Message-ID: <20240212223146.4142264-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_hog_detach not to destroy UHID device which means the
device node don't need to be recreated in case of reconnections which
speeds up the process.

Fixes: https://github.com/bluez/bluez/issues/737
---
 profiles/input/hog-lib.c | 48 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 7ff1ede3db35..67492a63eca3 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1309,11 +1309,35 @@ static bool cancel_gatt_req(const void *data, const void *user_data)
 	return g_attrib_cancel(hog->attrib, req->id);
 }
 
+static void uhid_destroy(struct bt_hog *hog)
+{
+	int err;
+	struct uhid_event ev;
+
+	if (!hog->uhid_created)
+		return;
+
+	bt_uhid_unregister_all(hog->uhid);
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	err = bt_uhid_send(hog->uhid, &ev);
+
+	if (err < 0) {
+		error("bt_uhid_send: %s", strerror(-err));
+		return;
+	}
+
+	hog->uhid_created = false;
+}
+
 static void hog_free(void *data)
 {
 	struct bt_hog *hog = data;
 
 	bt_hog_detach(hog);
+	uhid_destroy(hog);
 
 	queue_destroy(hog->input, free);
 	queue_destroy(hog->bas, (void *) bt_bas_unref);
@@ -1823,29 +1847,6 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	return true;
 }
 
-static void uhid_destroy(struct bt_hog *hog)
-{
-	int err;
-	struct uhid_event ev;
-
-	if (!hog->uhid_created)
-		return;
-
-	bt_uhid_unregister_all(hog->uhid);
-
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_DESTROY;
-
-	err = bt_uhid_send(hog->uhid, &ev);
-
-	if (err < 0) {
-		error("bt_uhid_send: %s", strerror(-err));
-		return;
-	}
-
-	hog->uhid_created = false;
-}
-
 void bt_hog_detach(struct bt_hog *hog)
 {
 	GSList *l;
@@ -1879,7 +1880,6 @@ void bt_hog_detach(struct bt_hog *hog)
 	queue_remove_all(hog->gatt_op, cancel_gatt_req, hog, destroy_gatt_req);
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
-	uhid_destroy(hog);
 }
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
-- 
2.43.0

