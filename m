Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20D15C144
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726518160; cv=none; b=afouSGpNgTNe8eCcoiUtx26tnF5Q7pRQ+taBskOs8VOTArUVjlxe2CQSjLjNVQoQdp+l+41OeM5l+myvB7d0kk8ypDJiXiCet1OdyEygHk3hVb6uxXGg0wY/iakWR98xkdVtad0UVnlZ79hAylbc4W5A6XXI6dwXBpLcJWG1mq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726518160; c=relaxed/simple;
	bh=6CcWVFhhALjAQb68K9CEWPdTT4vRo2TpieLlHO2XqQc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TGF2d5MEtLkjldmUupyWuGupFl6Aph231kT0wsh6c3Cf6HmVC9aEIUqzYa8B9zYBoLxxF2EX53NTBEAp2104G63e6nyfkiepUbTVGq1hg/1x31Axu1neMCF8wVt0ouSTz95EDrtjKxrWzIUl6MfkW9r3leU3OVUIQ6FoFIJQaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZM5KkSvF; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM5KkSvF"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-846c59979efso1141738241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726518156; x=1727122956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0V5QxGJamaqDzKzBXNt0ZvCE1c6LLIyUmotVbOQDSPg=;
        b=ZM5KkSvFHDD5fHnQZ0uPdoJbvPdZQ1CcbNx90fjSAWGU9J/FArFK/y+LRrTw5ojjeZ
         IF6op4wOHvvxyKRoSCz+uAxawpfY+wiNX52xBX3rZoKYiga7kKwOX2joqfJoQiwvlsGk
         en60jQA/mapWar0QJE/zynyzb2gnxIqP+FyrOXVpG54DRA5kY1Au7w5bvQZkD02b8REW
         mtagSxR0IFY6mQeEyipNEh3Pb3vz4jNv6WdhbKeqJd1eOpeeYUukawrpfY/RSC8sl9dC
         fq20Py4lI6MIcgPwBwSzMU0Bk07FebT6xF5VXhR6wMxGF/rLQm7BRfKdYvS4IJAjstyK
         VMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726518156; x=1727122956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0V5QxGJamaqDzKzBXNt0ZvCE1c6LLIyUmotVbOQDSPg=;
        b=O5TeL+CbLWATP9yrhQeXfhfSblBJ1rva2Zy9aMnuCMw6lpNn4FtAn7adHdK0BeIgce
         VpmQ7FedK2Hi4sucWb9o4brOY5aJdhqWVUmRZPxBpDKvzN6xDFq1w9Xcb7bCdWOVSovT
         a4Ej4P3e2czR32RWjzwJ5yNCTuVcxIlskrbSfoYvBXHpIIhpsJyb//+3k4JWfCd5oko7
         fFcPNqXmeFDh1LoAwaYUs0YmawOVHd23T3bMzMsWTPl3YdyFzt9FFhN03j0yhj/bVeNV
         iFZ/HeTovmwez9WeMVujsXZiwt85mrijfNgjRZ/lKrHhKsubI1Y6FbrhsW8ZiC3WPomX
         UNcA==
X-Gm-Message-State: AOJu0YyUdtRVhVigVumOwBGfKrbZ06Mw1AkkCySC+T2XYAEM9s5X+eF1
	EbrXiFwGA8u0M0Ligw5TV74WvIWNNWi5ItY1BW2onNQqKflMfiQnooOJ3w==
X-Google-Smtp-Source: AGHT+IHEx+CSPGIlorWggYO6OQa2obdO9wZXa9NzRQ7GZKmLLoaxd5Kp4FcemtdoTRSVxkTiAwSSeg==
X-Received: by 2002:a05:6102:41a3:b0:498:efe0:f91d with SMTP id ada2fe7eead31-49d4159bd13mr12942881137.19.1726518155944;
        Mon, 16 Sep 2024 13:22:35 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8493978cdbbsm687180241.4.2024.09.16.13.22.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 13:22:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] shared/uhid: Fix not crash after bt_uhid_unregister_all
Date: Mon, 16 Sep 2024 16:22:31 -0400
Message-ID: <20240916202232.231417-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following crash which happens when
bt_uhid_unregister_all is called from a notification callback:

Invalid read of size 8
   at 0x1D9EFF: queue_foreach (queue.c:206)
   by 0x1DEE58: uhid_read_handler (uhid.c:164)
 Address 0x51286d8 is 8 bytes inside a block of size 16 free'd
   at 0x48478EF: free (vg_replace_malloc.c:989)
   by 0x1DA08D: queue_remove_if (queue.c:292)
   by 0x1DA12F: queue_remove_all (queue.c:321)
   by 0x1DE592: bt_uhid_unregister_all (uhid.c:300)

Fixes: https://github.com/bluez/bluez/issues/952
---
 src/shared/uhid.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index ed21e1399ba7..20bd26781799 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -42,6 +42,7 @@ struct bt_uhid {
 	int ref_count;
 	struct io *io;
 	unsigned int notify_id;
+	bool notifying;
 	struct queue *notify_list;
 	struct queue *input;
 	uint8_t type;
@@ -56,6 +57,7 @@ struct uhid_notify {
 	uint32_t event;
 	bt_uhid_callback_t func;
 	void *user_data;
+	bool removed;
 };
 
 static void uhid_replay_free(struct uhid_replay *replay)
@@ -134,6 +136,28 @@ static int bt_uhid_record(struct bt_uhid *uhid, bool input,
 	return 0;
 }
 
+static bool match_removed(const void *a, const void *b)
+{
+	const struct uhid_notify *notify = a;
+
+	return notify->removed;
+}
+
+static void uhid_notify(struct bt_uhid *uhid, struct uhid_event *ev)
+{
+	/* Add a reference to the uhid to ensure it doesn't get freed while at
+	 * notify_handler.
+	 */
+	bt_uhid_ref(uhid);
+
+	uhid->notifying = true;
+	queue_foreach(uhid->notify_list, notify_handler, ev);
+	uhid->notifying = false;
+	queue_remove_all(uhid->notify_list, match_removed, NULL, free);
+
+	bt_uhid_unref(uhid);
+}
+
 static bool uhid_read_handler(struct io *io, void *user_data)
 {
 	struct bt_uhid *uhid = user_data;
@@ -161,7 +185,7 @@ static bool uhid_read_handler(struct io *io, void *user_data)
 		break;
 	}
 
-	queue_foreach(uhid->notify_list, notify_handler, &ev);
+	uhid_notify(uhid, &ev);
 
 	return true;
 }
@@ -292,13 +316,30 @@ static bool match_not_id(const void *a, const void *b)
 	return notify->id != id;
 }
 
+static void uhid_notify_removed(void *data, void *user_data)
+{
+	struct uhid_notify *notify = data;
+	struct bt_uhid *uhid = user_data;
+
+	/* Skip marking start_id as removed since that is not removed with
+	 * unregister all.
+	 */
+	if (notify->id == uhid->start_id)
+		return;
+
+	notify->removed = true;
+}
+
 bool bt_uhid_unregister_all(struct bt_uhid *uhid)
 {
 	if (!uhid)
 		return false;
 
-	queue_remove_all(uhid->notify_list, match_not_id,
+	if (!uhid->notifying)
+		queue_remove_all(uhid->notify_list, match_not_id,
 				UINT_TO_PTR(uhid->start_id), free);
+	else
+		queue_foreach(uhid->notify_list, uhid_notify_removed, uhid);
 
 	return true;
 }
@@ -588,7 +629,7 @@ resend:
 		return 0;
 	}
 
-	queue_foreach(uhid->notify_list, notify_handler, ev);
+	uhid_notify(uhid, ev);
 
 	return 0;
 }
-- 
2.46.0

