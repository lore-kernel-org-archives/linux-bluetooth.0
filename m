Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7298137C49
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228888; cv=none; b=RQ87hLoWIQ0FgnZ5yWyFNl9hzJ+2esODJi92Q5SdxTn5f5fgOgwak5a6AT4T+APApKVDFShOjNuZznv3EFpbw4CkEedvBZPG/KDt7zAwL+isSYde6ZZ+DtyLxeoAR106iEGS271PZXtX0KUmHfiWfakIontz8JpblcADr1A76fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228888; c=relaxed/simple;
	bh=xcPq72idBxazIW/Hj7WW5ABxhBL97UTnV46Sv/VZtA4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+M60N09Gt3IFa08OYfKkxBldNSMudeu22eKpDcKDbkCQlrfKV8FEHaLDVCidbDgQcRbbbV+a6opejPDRj8T99bTFx0bp+tQLupZTFXP7+sHX+IDMs38gP/3L0vg0WG2Wb3xvEcI2GPUxqAdSmK0j2Knw4Fnkx9woLDXraiDKv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3E1eABs; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3E1eABs"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4820c2dd6d7so328832137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716228884; x=1716833684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxItAwRiuLRgNwYlc5PmmODJU6saxMWdAp9zjjn/Nhg=;
        b=M3E1eABs+ll9Kl4rfpmZ7h73x7o5L5NkPFvqfN5ugsxZa/hlFJqaR/6gQde0JFeDfq
         S4sShGFHp+k0L7RfB6Q1uy5Juc732bxRrxJU4+qFfAdtkDOinP7/8BSyKcOMXHP4iTA0
         Ryo+B8EZDOQoFJIEy9q3rVmm7RZpf0hKJTvILMcpOB1NOUYqK6+JtBsnhQPFCiXe/Zms
         r0jeRfG0JQA4wZ/iICqb5RL01FgrSHeXzq5HY8RtNeEH72AeQUasvqz1UFDQumgH5kuc
         aH3oYkwBbd5gz42nkSPtmGDmZZNK2yx6C1fMJwnf0AbGbcgNlwr80rRkUtTlLkdaKhKB
         +IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716228884; x=1716833684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxItAwRiuLRgNwYlc5PmmODJU6saxMWdAp9zjjn/Nhg=;
        b=XVmRpNqpbgp1miTlzyk8BSioQgL6GXihJ4Y33P7TxslAhe1c4ygiCQZX4YSF7Cb0kE
         BK1IHiqSUHdaHzdeHZHc+myg7e8yBnPNutZwXsybeiaCwmFp6oOP8cFprnYnv4+37a0V
         GIgFeQmymD4B7zJpfsa5x/vplCp+JTfFi1Y2//TfKSxIqVGnuSX0xRtAGXSdGYeEr0dw
         ob0GKNJwih1/4l6qyTmk5OzAGhOtcvMI1yk1GJxn/HI/7CSQQO1ckA0vAna//Xc68MFc
         1aNe+wRdZeXCpkIEl1xocaUUs+WHw8mgksT9HwxhX+PKZ1dw6adQ5jQVstcdtNkqUdx9
         Bxgw==
X-Gm-Message-State: AOJu0YzQSzlJkyF+pdriWU3KusydX1a8qsruIeKEV5SPR5HU1FUTCMOj
	+F7yhCAIcK1HYVqRHjvFq6ysK45i5AUKfobBK16utPDX41sn4EBlRLsb0g==
X-Google-Smtp-Source: AGHT+IH3rWJt6k4bm6a6cc6kZXHNYhCNlKFZIgqlWbKgfvpPOa+j2c6i0omuv2hsORptIARjQzRGSg==
X-Received: by 2002:a05:6102:3e0e:b0:486:11ff:65b2 with SMTP id ada2fe7eead31-48611ff67b1mr13836802137.29.1716228882385;
        Mon, 20 May 2024 11:14:42 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-7f9000e33fesm3232549241.39.2024.05.20.11.14.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 11:14:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] hog-lib: Add force parameter to bt_hog_detach
Date: Mon, 20 May 2024 14:14:38 -0400
Message-ID: <20240520181439.1407634-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520181439.1407634-1-luiz.dentz@gmail.com>
References: <20240520181439.1407634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds force parameter to bt_hog_detach which indicates if the
bt_uhid_destroy shall be called.
---
 android/hidhost.c        | 2 +-
 profiles/input/hog-lib.c | 9 ++++++---
 profiles/input/hog-lib.h | 2 +-
 profiles/input/hog.c     | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index b4e5c527fafc..e0e3ecf92676 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -796,7 +796,7 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 		if (dev->hog) {
 			bt_hid_notify_state(dev,
 						HAL_HIDHOST_STATE_DISCONNECTED);
-			bt_hog_detach(dev->hog);
+			bt_hog_detach(dev->hog, true);
 			return;
 		}
 		goto fail;
diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 2d8d0f359e57..964acc716041 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1232,7 +1232,7 @@ static void hog_free(void *data)
 {
 	struct bt_hog *hog = data;
 
-	bt_hog_detach(hog);
+	bt_hog_detach(hog, true);
 	uhid_destroy(hog);
 
 	queue_destroy(hog->bas, (void *) bt_bas_unref);
@@ -1747,7 +1747,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	return true;
 }
 
-void bt_hog_detach(struct bt_hog *hog)
+void bt_hog_detach(struct bt_hog *hog, bool force)
 {
 	GSList *l;
 
@@ -1759,7 +1759,7 @@ void bt_hog_detach(struct bt_hog *hog)
 	for (l = hog->instances; l; l = l->next) {
 		struct bt_hog *instance = l->data;
 
-		bt_hog_detach(instance);
+		bt_hog_detach(instance, force);
 	}
 
 	for (l = hog->reports; l; l = l->next) {
@@ -1780,6 +1780,9 @@ void bt_hog_detach(struct bt_hog *hog)
 	queue_remove_all(hog->gatt_op, cancel_gatt_req, hog, destroy_gatt_req);
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
+
+	if (force)
+		uhid_destroy(hog);
 }
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
diff --git a/profiles/input/hog-lib.h b/profiles/input/hog-lib.h
index a79648976e79..abca829bee92 100644
--- a/profiles/input/hog-lib.h
+++ b/profiles/input/hog-lib.h
@@ -22,7 +22,7 @@ struct bt_hog *bt_hog_ref(struct bt_hog *hog);
 void bt_hog_unref(struct bt_hog *hog);
 
 bool bt_hog_attach(struct bt_hog *hog, void *gatt);
-void bt_hog_detach(struct bt_hog *hog);
+void bt_hog_detach(struct bt_hog *hog, bool force);
 
 int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
 int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type);
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index d50b823213b5..2db52d1a2fcb 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -206,7 +206,7 @@ static int hog_disconnect(struct btd_service *service)
 {
 	struct hog_device *dev = btd_service_get_user_data(service);
 
-	bt_hog_detach(dev->hog);
+	bt_hog_detach(dev->hog, false);
 
 	btd_service_disconnecting_complete(service, 0);
 
-- 
2.45.1

