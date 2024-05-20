Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498504C66
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220031; cv=none; b=R5N8GrEB057XgC0Kureu4aRUZCQyz80n0jbyc4z/Y49lL5dFk+8Fe0qiYVFWgzMc35R90Ibzx4gHHvquaJO2f2QyvGl5tpaCQgVK8VWsbdPGd1/q3m/nSbZ3Fs24T8kiz8ctdvABn1/GwTIyKgSZ5QMF16Dr75uZrGHyDj+zjUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220031; c=relaxed/simple;
	bh=uAJlaostxS4wcx2wGIjhyCimuc04boOuS4q4HmimRTE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7kl7jOd627j9zYQU/eEqPz/NygCN2doyTQwH5glgdbo5mm5fchW1WUajXjwetPt+5KotoKpUxPaFRBdvprYuJlbQ6Yk39I95ndjSWNcGnQowUpCGGSCM5kV1i5lDcB7OCkGO0sNWKyLzAHvmAC8vP+2UytGPfgU8B/yEUd6azk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdf34C19; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdf34C19"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-47ef7e85cf0so555738137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716220028; x=1716824828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=io+XkLjqjWSdss++ZkBeTRiwYWoE00GvHcsp08fNOZk=;
        b=Bdf34C19jpJpAn4YqVXLkEP6L7e529giB4Tz9B9TxGmek5O0y4f3gUowcWCV5vqxC/
         jQRNYDbKf3m7/fdrJlfuM3DWtPvDY2dv7t3iRuIrS0Ag9MRZzS79au4FXKv6KRW8oYvv
         CuquDsuRbPskuxf+Yn/uEZvvwK96dVDApkWiQWpvuyOVZXGnh33q/zKqBBorSUx4Nj55
         eQhePkSYsvoi7OsujeD4jmj/kdxy65isxYHpYzt9QjXV41vtkD7JoCpiYVKJlzhkCQv9
         3xSKHHdLQeRg6IsCNbaLPVG3KFowD+MIrLwHOkoh6o1unvErQWYwVpEmu9melxKY0Cjx
         aokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716220028; x=1716824828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io+XkLjqjWSdss++ZkBeTRiwYWoE00GvHcsp08fNOZk=;
        b=qm06Z2v0QVMt+Am34ep31Mn0HCbxBF4edXHlaAykWgAZuC6UviUZzuy0ZNTvD3YrUe
         AIsMNcPipvQeeBm6bRky6oeQyIcWKZJERzSftSnJMW0v4g95GWHdsvdfzYGGvZPBdGyd
         oU7OBOwtnQLS4ySvL3DgH28c7CPRDanzbmm3yaotiJuMcIHSHfD9i3RsUGmv3v05FtzO
         3KqQ59QjhNze27o7QRFMaRCRD2EODVinjJpl9GgCiUNJ1NI7lNx+lODdplEzOe9uHnWh
         eFtdAbT3xReNre7+TN64at4eqXseULPdUnAKz/xWFvP88xVeLSvieiucaMQAIRrgOOnR
         1Trg==
X-Gm-Message-State: AOJu0Ywi355o1bxlnipwkrS4oePvqVpHmpHHH8SxYFJZl0QQb5NsD9/E
	o3XeYdAcA8TSxdzuUXRQ96G/JTlHLzWifteEu/tGddT734aBsvWZSN+yKQ==
X-Google-Smtp-Source: AGHT+IEwkk0fCWIn26GBaG53dKB1bqKO3pF/8Fc70RN/Q70eUsMhafjtYyCUjKdhd91segxHdpN2/Q==
X-Received: by 2002:a05:6102:1623:b0:47c:2b38:4847 with SMTP id ada2fe7eead31-48077e8214amr29756270137.26.1716220028247;
        Mon, 20 May 2024 08:47:08 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cb008d2sm3370154137.2.2024.05.20.08.47.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:47:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] hog-lib: Add force parameter to bt_hog_detach
Date: Mon, 20 May 2024 11:47:02 -0400
Message-ID: <20240520154703.1219758-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520154703.1219758-1-luiz.dentz@gmail.com>
References: <20240520154703.1219758-1-luiz.dentz@gmail.com>
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
 profiles/input/hog-lib.c | 9 ++++++---
 profiles/input/hog-lib.h | 2 +-
 profiles/input/hog.c     | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

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

