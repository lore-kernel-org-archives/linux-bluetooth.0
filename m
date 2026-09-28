Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63FB4E9C08
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616777; cv=none; b=sYLb1nnAlMuFuykqPKbf/NiaSs5HgnarRf4akwE9eB+AUvAQrR9D/LW67ZiaeLDyHzAEtVEPWFQpeIysjGiMv1987pO+momil/MMPfp+e9Kis8jEfgNlI5BFfFmj/dRrvrnwod1HRptoEu7svg5C5lNkRTzuF0U51YfHzV/ZEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616777; c=relaxed/simple;
	bh=QRen8Kt6s9QWCE0zTVaWP4z2qIdNg8LcxyPOpyGlJ08=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxYd250qzPQwJ5gxBy32ZTKzYn9iXv8rxq5QwSkalUpn5bAK1kisda+Gixfa6ibvKUO6ewx+l9qhNVm/RTbeYT2z9bYaaeV3syOdy7TPxj5LSUflFrjBsonrbM6fnv86DRC90idCwZywyggcS/cMdDS8flCAgZmS3kS5YutARI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWrIsgsf; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWrIsgsf"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-7b3c2da275fso1022199137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616774; x=1791221574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pUaN9KPTk7t2VZMQgT7JDLA2N5WkGD/6mdC+l6C9rws=;
        b=YWrIsgsfQd6XWJscdMYw+0jqNmgtxUpbJ2fGCPTuUToUZzJdvSsXp77k1bsteuM+BP
         a91bqGZA66v2MZvIVXfegSfrutaHDiQi9rMLcMzNdX9DO4hMUos3u0JzePY5iIT4toUc
         pruJPmDMow9Oi4qOGBhv113BcBZK94AXi+7ufd08GWdLjr/sJEKdwC4kW18g5D8wGHRs
         PtUl0rLMFqohrPXLRZaP+EbFrLt2GLHQrwvJRzxWPiFInYo7V7VpAka9tcp/aG6g2k4n
         NIgDj1DwnUNEsXHpMLjx4fnVRrOeFwPQ4/NjvIoEOicvzfVQ08ccyzlf146ALJuqhIBV
         TYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616774; x=1791221574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pUaN9KPTk7t2VZMQgT7JDLA2N5WkGD/6mdC+l6C9rws=;
        b=J7zi1WuYfkthj322JOdsHnfBN/SH6nG4Qd6YGTL0ZwyQXxt3WjvIhkJtdjg9CvEBJm
         Eme03O+2fxDOeamy5k1cFmvuh1sf1NuRRi+LlscpXYUdVVcAvM/bM7ID/blVqvE/++GN
         4mw5qfRjwxEF0ujY9hsa7Unw9WG6YXufCrtSgTm8vtwpXtlJGgDzh/poXt5zxjGWCTgL
         0T6JhfkFtp+CgdhcngYLwvoe9wx0HJQ+TqJ50cWyCkKlznrHoDOqwB+bJOIW8LfXPyhO
         jjNtiaEUGvi+Ey5guU5SnVO6M3p4H9dSkQST94vqr5GGTQMTMvcGtSdxxKJG+vIRBHqy
         ltvg==
X-Gm-Message-State: AFq9FYLKqM0T8NMKgHpmhT5glPEeN8ZrHu0e6dQSnBE4N3Rqjq1WSR3/
	n2UzzEXn7WYeefJfmijPQRlnS0rqadnHyC/ImnB1VryBS9hDDRdXkSXUAGcYi3hZ/Pk=
X-Gm-Gg: AYBFou1cdFzmaY6Ai0MhzvCupVktlo/86PAHPk9Q3xM3fHfxprMw+sX52AV4zGqsCta
	3I8eb1D5LBdYdVFIj5oFLivCB7PzyOV6+a/pRA6e/aMvANixgCrCFWUQOJmatlr7IEjuGQxxtFJ
	m2JEBjCubJfdUqgzemSN54OxuaVRFFvy3cQp5Ybt00aFmzOtAMmQ0wbVr/fZ5IFh+QzoSJA2WWh
	8dRANSAYCGGTPWT/1Hf/YOIgUwaDlG5TEzriGI1DBLw27CQ/biPVFt7vZpMQp+K6SoELfXILRel
	fdarplsFrsa1vwMGEpE7vTpAvgw+UnxYopiEVSV51f4RkmuzrsGeXiFejxhoXafXH7e0sgXA1Rf
	I2bLZc92pEIIJ7O+1K480uz/pgfLyM5HjZY3sQ2shbwEY4QEjsZm9ssGfEHc0g85RsHS6ESebrw
	Zg1u5cxLNErylcnfZczOw9PM5zS4fsnCsO1jee+ilrAfnrFDzPmJQAoDRJG00fnL8JZ0vvtCrTE
	yio2lJEHlA/agHIlvc1orU4uiJww8fGJHiYXOCvkfFTIPZdFTcp5OjVre+OUwqG
X-Received: by 2002:a05:6102:4421:b0:7a4:e550:eeb9 with SMTP id ada2fe7eead31-7af1e6eddedmr5223418137.22.1790616773746;
        Mon, 28 Sep 2026 10:32:53 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.32.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:32:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 01/21] shared/gatt-client: Fix calling destroy after unregistering notify
Date: Mon, 28 Sep 2026 13:32:20 -0400
Message-ID: <20260928173243.1073509-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_gatt_client_unregister_notify resets the callbacks of the
notification but not its destroy callback, which is called once the
notify_data is freed. If a procedure is still pending at that point,
e.g. the write of the CCC to disable the notifications, it holds a
reference to notify_data so destroy is called later, once the user data
may have been freed, e.g. the reports of HoG:

 ERROR: AddressSanitizer: heap-use-after-free
 #11 report_notify_destroy profiles/input/hog-lib.c:359
 #12 attrib_callbacks_destroy attrib/gattrib.c:130
 #13 notify_data_unref src/shared/gatt-client.c:256
 #15 destroy_write_op src/shared/gatt-client.c:3189
 #16 request_unref src/shared/gatt-client.c:201
 #17 destroy_att_send_op src/shared/att.c:215
 #18 bt_att_cancel src/shared/att.c:1925
 #19 cancel_request src/shared/gatt-client.c:2783
 ...
 #21 bt_gatt_client_cancel_all src/shared/gatt-client.c:2811
 #22 bt_gatt_client_free src/shared/gatt-client.c:2290

Call destroy when unregistering instead, once done with notify_data and
holding a reference to the client in case destroy drops the last one.

As destroy is now called when unregistering, reply to StartNotify before
freeing the notify client when enabling the notifications fails, since
it frees the operation the reply is for.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/gatt-client.c        |  7 +++++--
 src/shared/gatt-client.c | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 3baf95c4f79c..d94dc9d7fbf6 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1488,12 +1488,15 @@ static void register_notify_cb(uint16_t att_ecode, void *user_data)
 	struct characteristic *chrc = client->chrc;
 
 	if (att_ecode) {
+		/* Reply first, as freeing the client unregisters the
+		 * notification, which frees op with its destroy callback.
+		 */
+		create_notify_reply(op, false, att_ecode);
+
 		queue_remove(chrc->notify_clients, client);
 		queue_remove(chrc->service->client->all_notify_clients, client);
 		notify_client_free(client);
 
-		create_notify_reply(op, false, att_ecode);
-
 		return;
 	}
 
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 92ad7c39c115..b3bc62220e16 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -3842,6 +3842,8 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id)
 {
 	struct notify_data *notify_data;
+	bt_gatt_client_destroy_func_t destroy;
+	void *user_data;
 
 	if (!client || !id)
 		return false;
@@ -3858,7 +3860,26 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 	notify_data->callback = NULL;
 	notify_data->notify = NULL;
 
+	/* Call destroy once unregistered, as the user data may be freed then,
+	 * while notify_data may still be referenced by a pending procedure,
+	 * e.g. the write of the CCC, which would otherwise call it later.
+	 */
+	destroy = notify_data->destroy;
+	user_data = notify_data->user_data;
+	notify_data->destroy = NULL;
+
+	/* The client may be freed by destroy, e.g. if the user data holds
+	 * its last reference.
+	 */
+	bt_gatt_client_ref(client);
+
 	complete_unregister_notify(notify_data);
+
+	if (destroy)
+		destroy(user_data);
+
+	bt_gatt_client_unref(client);
+
 	return true;
 }
 
-- 
2.55.0

