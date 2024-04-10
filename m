Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6A179206
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757737; cv=none; b=uskLQoaooXmqCkzgpDIKRlhuLkrRUSZU/AQCVUjKoWqQKzwdGvXsDu0VUnUfud+8gTSR27QobEKQ1yK14dmWYXaSeoBuXN96Wa2Ur8ubvX6zXa4t6eRxWOR3hL6q1r8Rv7Oh8D8yHlDVLDKu0o20sw6wmf4GJbfP391+RYFIr80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757737; c=relaxed/simple;
	bh=ODgoe/SbsjLJwPOVANXXfSxVfs9NajiC5bhbWaRZ5FY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbUHIqngC1p+J0QjodyU2NsaqObDTzGyJV1hhuPEHSt7COarDGMqH23+wGWdlsm4mvIl2+ixbaFrDeXsTFcEtkgxsKkx/IlDn0QNirxmi5+EhkTYjhEuZ8iTUvno/8PIwaaJ5Oi6tkV5Ko7P8FHEpyRsuuas7smyv2fTLF4fpiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aifgxLIj; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aifgxLIj"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69b21b11173so19282796d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712757734; x=1713362534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlPPoFA4kIS8orhrFOQTgWYnFKgrAIT9g1HLOJOhjiM=;
        b=aifgxLIj7ITiVM+VuVgTdH1nWxnWsiMgYAlNSYXxqbqzrHLVcIz0uUT6dZB+OY54ZB
         UoK1mEjnrWWxru6WRltwoBtrnA1iVg3wOAni1pq1WtYFJAESiNyY/PLdCyHlgCPd3gat
         bLqHvBPI35ewi/owHgr2g+1Wf7lZ17hfDB7NFy+sW+DZh93gW+c8wAXut51XC1T+Asqs
         uh0mDQlnfyuUqIL3MZsw8fuUES2MtXq+ekypuA4QCY/qVlQUf9/W/2iNQgqEy5iiD6OP
         XYgSYDnGGkIwVZ/3FfyjtaEHZCdQP85fDdKp+nzKBHPgh4rWu7IiVXQjD37RL8elXbga
         UVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757734; x=1713362534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlPPoFA4kIS8orhrFOQTgWYnFKgrAIT9g1HLOJOhjiM=;
        b=stbma72cqdMuV9uD96aiIyKQvhaC1ZGs/b2WiCAsUcsnsEYJEdpHfIqCeGHIpXvED3
         b3XtLJN33GqFyevL24uVEujwBJK1iT9MCXMmuUmLKwDxQTtL/mq2VGDQDuL6TltpcyNs
         gGavLGD6+sCGQi3q3Y78UIuBlJn9BKUtHd/8SeOWqpqHmyuIMKLOPaeIECu0w/qG0hML
         nMYVLzRTxC3Ya4zUtR9DbF9TQfGSrE/f8nIfXqtgaTdhAf0kTn6Fe9TyZw+1TmDfdFE3
         /+V3E1Lxzq7JqETJ7nVE8OvyDXiF96SrqoydN8FPvJIGE1o2iFmbIchPfJHzmaF1q6n4
         xkgg==
X-Gm-Message-State: AOJu0YyugQxmUv9kKuUF57f7Jvn9LtqySCzl8SkscjQMBUp6hdzhry6h
	+eMSf4Ge/ASuAEgs8Fur7M44NmV3SgXr/eCRLnZN/IJ2CSGgICleMv7Vw7eo
X-Google-Smtp-Source: AGHT+IEdRxxsP3VhyPQU+9/UdxzrWNLGKtfLEdVW1YioWPKVCm0Vdxp7H0Sj6XLGghx1WT8rtPL5vA==
X-Received: by 2002:a05:6214:108e:b0:69b:4341:6477 with SMTP id o14-20020a056214108e00b0069b43416477mr1099740qvr.26.1712757733896;
        Wed, 10 Apr 2024 07:02:13 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id k21-20020ab07555000000b007e3199adc5dsm1382051uaq.0.2024.04.10.07.02.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:02:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/4] hog-lib: Destroy uHID device if there is traffic while disconnected
Date: Wed, 10 Apr 2024 10:02:05 -0400
Message-ID: <20240410140205.4056047-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410140205.4056047-1-luiz.dentz@gmail.com>
References: <20240410140205.4056047-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to destroy input device if there is an attempt to
communicate with it while disconnected.
---
 profiles/input/hog-lib.c | 47 +++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 0291adb6eb23..2d8d0f359e57 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -825,6 +825,19 @@ static void set_report_cb(guint8 status, const guint8 *pdu,
 		error("bt_uhid_set_report_reply: %s", strerror(-err));
 }
 
+static void uhid_destroy(struct bt_hog *hog)
+{
+	int err;
+
+	bt_uhid_unregister_all(hog->uhid);
+
+	err = bt_uhid_destroy(hog->uhid);
+	if (err < 0) {
+		error("bt_uhid_destroy: %s", strerror(-err));
+		return;
+	}
+}
+
 static void set_report(struct uhid_event *ev, void *user_data)
 {
 	struct bt_hog *hog = user_data;
@@ -833,6 +846,14 @@ static void set_report(struct uhid_event *ev, void *user_data)
 	int size;
 	int err;
 
+	/* Destroy input device if there is an attempt to communicate with it
+	 * while disconnected.
+	 */
+	if (hog->attrib == NULL) {
+		uhid_destroy(hog);
+		return;
+	}
+
 	/* uhid never sends reqs in parallel; if there's a req, it timed out */
 	if (hog->setrep_att) {
 		g_attrib_cancel(hog->attrib, hog->setrep_att);
@@ -856,11 +877,6 @@ static void set_report(struct uhid_event *ev, void *user_data)
 		--size;
 	}
 
-	if (hog->attrib == NULL) {
-		err = -ENOTCONN;
-		goto fail;
-	}
-
 	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
 				report->id, report->value_handle);
 
@@ -928,6 +944,14 @@ static void get_report(struct uhid_event *ev, void *user_data)
 	struct report *report;
 	guint8 err;
 
+	/* Destroy input device if there is an attempt to communicate with it
+	 * while disconnected.
+	 */
+	if (hog->attrib == NULL) {
+		uhid_destroy(hog);
+		return;
+	}
+
 	/* uhid never sends reqs in parallel; if there's a req, it timed out */
 	if (hog->getrep_att) {
 		g_attrib_cancel(hog->attrib, hog->getrep_att);
@@ -1204,19 +1228,6 @@ static bool cancel_gatt_req(const void *data, const void *user_data)
 	return g_attrib_cancel(hog->attrib, req->id);
 }
 
-static void uhid_destroy(struct bt_hog *hog)
-{
-	int err;
-
-	bt_uhid_unregister_all(hog->uhid);
-
-	err = bt_uhid_destroy(hog->uhid);
-	if (err < 0) {
-		error("bt_uhid_destroy: %s", strerror(-err));
-		return;
-	}
-}
-
 static void hog_free(void *data)
 {
 	struct bt_hog *hog = data;
-- 
2.44.0

