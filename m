Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF104174A
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726518228; cv=none; b=HDcHAmZgLZS+UKdVof+jmcqyKaW2jwNsGbviuwEOA9s5qf3gK0imyoNVl4Zugb2OWP9MTSCptmQ6c8YoB+8X4fop0VS2IfUoJ4lAJJEk+7MtPHsFefbEZwgcHmRBI+vGUEUn8uBx/SP6kDQkg85cj7/WoAma/y1Nmlxk9PVXd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726518228; c=relaxed/simple;
	bh=6CcWVFhhALjAQb68K9CEWPdTT4vRo2TpieLlHO2XqQc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bDTKjSFUmA4TdJgYEEMMA3H18VffzCzGrmun+PEK2kpICLJNwku7jamM3c9B5YYe9sW3/UQ8Uuj4ngpR8rDfVZ1ZaqvZipg26sk62ZcsRrmQy/DZGjf/nvvZDxuiw5tcU++OalqOfifQDLgNIv9kjHgMdUVuxDves8n1JrvKsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOCvv+pe; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOCvv+pe"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-846bc787b3dso943586241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726518225; x=1727123025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0V5QxGJamaqDzKzBXNt0ZvCE1c6LLIyUmotVbOQDSPg=;
        b=HOCvv+pegBQuAagbr/2kf9zYt0Ohlew5bER28mP20fgFhqrAykx17JVwBxk65YDLaK
         hN7eG3cB2qFAjgkoWeyhnhoiO0F+b+uVl8FxXoXn2WFei3F+HFR00O7waJ2nLMzaAZ4J
         8xtkJpM/IPKcYVy/59f6lZxneJyXe1zWQlTLPORg65YptiSssnxrt1gfOr3ZDB+j65P7
         reLgn2fNn0O4qo1vjUzMSx+T6wTStXwJX4eM9CSDHElUWxH3TWg/Kp9qQDGoeM81iVWC
         vUvUpi1npn4x0urASiErYgcL/pc/+MJCcCM2K92T+PGDDRUw6W4nlTVhtpROjZterMz1
         ggww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726518225; x=1727123025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0V5QxGJamaqDzKzBXNt0ZvCE1c6LLIyUmotVbOQDSPg=;
        b=pEoVgVgNiKGQmDFQQ/UhiuSe3qfR/BzS9XrO48mhLanJX5m31bE5LyLXvD2IHFUWE2
         Sk5DX5vsz6fdxJBePoOTQBrrQHQxs5JlTMxVSPp8kg0uXuLGa2t6VEausdgqGewhxSs8
         3a6hD50zTktsef+RcQOH45ESZc50stEInDIRLcXDtj7I9HPSspiRePf2WgXjf5vSvMOr
         gpwOaba72hDCvGa2jqFdCsng7g3wD4kQqB2xU6g/gD+IeK5RMndvLzo3HCFSZTlIq0J2
         +/EOuJ3AlbZOZ9U40gXeUsotvqUx0GanVdYKRtW69Fta8gdLTT2FeXi73f9Ka05teulD
         CCsQ==
X-Gm-Message-State: AOJu0YyZ+stA/4sb3RzhIaUxPqdpgCMLPppr2pSEYEwcJcPVlQNOimAP
	6nJh8nxa9xXiZfZL0vGKnqYLPjXVl9Y4uKh5v+94krfEPwnyxMuKApXYtg==
X-Google-Smtp-Source: AGHT+IFFBEPwKZ2MLPuv5BvvMd7xlUE7GvEceMhWW966pBvzkgG3Eo2D30mMzLINxXXeo3TqSX4axg==
X-Received: by 2002:a05:6122:1d15:b0:4ec:f996:5d84 with SMTP id 71dfb90a1353d-50344b4b1c5mr9165102e0c.2.1726518225016;
        Mon, 16 Sep 2024 13:23:45 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5035b929ec9sm622787e0c.9.2024.09.16.13.23.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 13:23:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] shared/uhid: Fix crash after bt_uhid_unregister_all
Date: Mon, 16 Sep 2024 16:23:40 -0400
Message-ID: <20240916202341.238735-1-luiz.dentz@gmail.com>
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

