Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860615820F
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694451; cv=none; b=TyxWXDKZL1mq3u/IWJt2X/wzlJf27/WQI2K5gc7hwbAZzQ+tbVBs9Gw/e3sHAo+5pfDBpgx4yiJpYlnAD6t1oSxTeH6n/M5+rB4++EL6WvR9jZg4iG9LWwVggz56OwtNBDwRJJGA3/oPUK4s/uO92E/d1+56IcOXQzeUz7h7zfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694451; c=relaxed/simple;
	bh=bEtBSs/PzR4Jfnc4B/zXoqmXngHqsX2i2hGZo8/0Ask=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrPPwexGtH4WC65MTKH0rCKIpEYtvzCwTWME8XxhY19Ny2n/RsOOMJXw1oL0c09M0aqL5U1OB+5DATUWs9GacToVhg1ABV0qXcJR9HGhCcZ5532eO9WXluUEdzcchvV5xZzYc5ittTD7vG+F2ZQdmCoFklDi1utrxf6/Gck+7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKNEAeAW; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKNEAeAW"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4dab344ace5so1115180e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 13:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712694448; x=1713299248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOH3ubTnedfhHdPof6cho9QbE7XQXN+fhPilDPmv3G4=;
        b=ZKNEAeAWt0N/WTTWuUoAGcc1YGv9hmv9qWHaLUorCUDUOd34IfLF/kRoS2RrKZhPfl
         uhT//CEWKmMCcnTf74lHbEGsubkrJDjy7KPVj+IqBll/xTn58SlhKV1BT+Zka/ra03vf
         9BGndpggLzC6CmUhH7eg3RAAJwQy9X8Hkjgh0brWzoOmTmfxYHX8oIc0rGi8IjZ4vb+g
         ncwyw7KvZppuQ35zIvtB0YHvxW6ySIjxGFceDAiaKKhFZl5ez+hHQWSTiiUGcLUxFYaR
         V9rA+53IWCmrgaCDzZtAjxALaIdtirQs6DTjcjEz2LQim9xCoayijBsvT/cla1TUd5uj
         m6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694448; x=1713299248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOH3ubTnedfhHdPof6cho9QbE7XQXN+fhPilDPmv3G4=;
        b=FWkTpPByiIIbcTJZSRGDQvljxobxWiI8y4DF/pgTQBOiq2mMqertcxl2QRYCzyt84u
         1Qg0IzdUlO8A7/gp2mEm6erlaqj4hgZKu+zbn4pkJwthN1rDEF/ErH952PvfncWbRpIh
         bwK9hw//HptVApl5DMzh+nVTFsQoPNFTLje0CY3YuwXdUhM49LFPh3bbAKGwc1nS8TC9
         3KwAgX2pA7yPfXOTNG5Xvguta72P6XRQZl2wp/GaCofvu3vkRaRKGvIFAm5IRJBMXjD3
         fHSe89MAvTA/sZVOItuuh1VGAS2708hUY+dSaDLBm61JbDvpvoAvFmP2tnJqnHPzvtpR
         F8kw==
X-Gm-Message-State: AOJu0YxSq8A55JjbX/IlzzF+0uomfVlv9rn4ABF0D9sGI5knyJUzKmj5
	YovRujUVf4RaiSn8BCDnlzOxK8xni3JQoNz09c5muD02wvYWF3j7Wervpa9b
X-Google-Smtp-Source: AGHT+IH3qAlGZwa0wxhU6wB3vW7r1N+zD027AaQh1WceFA9u568aTKuyFSJ1PUejLuONb1IuSRqXMA==
X-Received: by 2002:a05:6122:91e:b0:4da:9d3e:a7df with SMTP id j30-20020a056122091e00b004da9d3ea7dfmr1232097vka.5.1712694448108;
        Tue, 09 Apr 2024 13:27:28 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id s184-20020a1ff4c1000000b004d42135c509sm1435323vkh.5.2024.04.09.13.27.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 13:27:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] hog-lib: Destroy uHID device if there is traffic while disconnected
Date: Tue,  9 Apr 2024 16:27:20 -0400
Message-ID: <20240409202720.3894858-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409202720.3894858-1-luiz.dentz@gmail.com>
References: <20240409202720.3894858-1-luiz.dentz@gmail.com>
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
 profiles/input/hog-lib.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 0291adb6eb23..d94a3ff102ef 100644
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
 
@@ -1204,19 +1220,6 @@ static bool cancel_gatt_req(const void *data, const void *user_data)
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

