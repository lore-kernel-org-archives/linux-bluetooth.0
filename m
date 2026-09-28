Received: from mail-vs2-f15.google.com (mail-vs2-f15.google.com [74.125.227.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDB4DE728
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625671; cv=none; b=Zk5TMJdvrqreJRkN5DMeZ152tPETvNe3GigqCFm7wVqyo/5jWOxvsp3cC4W+SsnaPNsG9k1mP9hYeDcxYxU80JxQC6s5gELfk5GdiWrJpGWjUycnbbBNYw+YOa4Hyei8Bjtn4V8J7k63d29oJZMrto+OrxQxSgRRHt6rVr7K/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625671; c=relaxed/simple;
	bh=WdDlv7DtXGfYiWwuDvRrF+i2+2dkTDDZtICXFcObAsA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEFcJFwWuLAdyKOiWmYtpSuV+Vi5m8P6RkyrKaf844kcimhb7I2koBhLSckAI9TcmG1TtAEo1AIxZ1P7DKNmhU4h9PQPV0xrEkb4XF9Ld1R5F6nKpWHzXuUY2HMDA4A2svzg8KZ/mq/qHpTHMfiutBOAF/nYWHaxodasPd/izXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPy2VKrh; arc=none smtp.client-ip=74.125.227.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPy2VKrh"
Received: by mail-vs2-f15.google.com with SMTP id 71dfb90a1353d-5c981b0d59cso2432484e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625668; x=1791230468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f/HCjL1eVZMUyMHJv9Y5tyeQ0OaBYhV2GuJ1H/y6S1E=;
        b=RPy2VKrhe3vFn9blDEu+P/0yAEm9FTQk3JvGT6R439XiQ8BUyuqNwpgqafIug6znMh
         OTcW1vdHhCXB1FIa9583TBpgc2VYzd1+0MmbCOeXXxEmNwWCzuYKHFIxsavfFHojFlTj
         5abic4kS6Uu0qfBwNSDf3lIamjmp3CoGEhVTINvNY6Brh3JxaWGi716c/5A5cWs5/477
         AxXi2UqAZ/J38jS7A6sknfkuGQNJpO7WlrAhAyEKmSajc4Xd5jTu1xv0HQPpWtceS5nb
         wZVXMc9U08umLElPZyb5vixXa2DIB6Wp4/lDzVpHIFoEVR8atBSjcNNqNAdlXui61pVk
         QYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625668; x=1791230468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=f/HCjL1eVZMUyMHJv9Y5tyeQ0OaBYhV2GuJ1H/y6S1E=;
        b=TRsh6QYDI2sktyMgt877HKE4264KOmHjd0jUPPGC/kKfJDTPwhch5gFJ0mQgI0eFdh
         D4zzWyKDB9BncVHCXkMw15Nvat5nkVcePUgyutPdo3/dZQ61a+sUaQVcoI9Ke62mQb+c
         3MFbseQSWfni73Fl0AniSoywAhsDy32uAYKWtF3W9mGqZsDagUfMISq9zLDSFHPDK0NO
         Z+CeDXm8ZmT9jdJzYBIOcgXROVsdshaO18BsRP4N4oihBO/mwExBaV/oCpoaA1Qdk39A
         iHNNPjbasvwpNYrxuCoQUbnX+NzeKdj2tZCQ2I2iUR3LYKcCWuS5I53/qCRvgU2WNAfm
         A/uA==
X-Gm-Message-State: AFq9FYKsF97+5r0Bghecd9GwTicEtkab8vXkwTde7P72cbq3BFlUCsUd
	BGTfiVxeeN90r314rSjqXZmoL7oqV7yA/13smCYtYKPZ84IyWiWbUkCEBHfwcRsfBFQ=
X-Gm-Gg: AYBFou2uGKvq0IVTUNq6I0H28UMa6VimQsGhVnjkX+Cs9d65AefE91aL55dYykNpgDD
	WngcllXevWDgxP0Oa9VopA3cXTIRduHL9HdafReKj+UWn1ddH2k0/FO4FH3TllB4x6Mzri+sy9F
	bl4p2W8OoGs0YgK4RA69stuqTJm9mHlgsKCOr+FVOTiSOqfuwoGbRTm5HWsCnkXfyNvfQwMISXw
	/ijaoX4227fMjrfue8tJ2LZlQgeiT5kW4VvC7Pcq5CN0kXdZxZVnHEIZMrgq+UzDI1x6V3rRlft
	dAUVwgjo7cgB+UiftnMAHZ79tOTRJrqUjeN4O7SLhAowQMmDiORMs9kFX8TApoI8xWWFOdALR4V
	KSmD2tp41P9QQzxUC1Ysy0EYj+9edrZHRjcz3OvEVvcREnvTY6y77/SyusYRa/dh01GND9hqdVF
	LEWE/FTqYcu2mmhCxSKv2Qwm8lUaL1E9M5VEY61s7NPByBbasqiJ33To5QnAC9vmJmkDeq1bv4u
	3QIXyC5QGTAEzBVE17NjYDbwEIKbTCjY1JN6VNKW8mpkHm2oZiEgnuz+uWb41x6
X-Received: by 2002:a05:6122:21a1:b0:5c9:c60e:3a3d with SMTP id 71dfb90a1353d-5cb0bf50ba8mr6375742e0c.21.1790625668202;
        Mon, 28 Sep 2026 13:01:08 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.01.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:01:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 13/23] shared/gatt-client: Fix calling idle callbacks again while notifying
Date: Mon, 28 Sep 2026 16:00:19 -0400
Message-ID: <20260928200031.1209311-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The idle callbacks are called while being removed from the queue, so if
one of them makes the client idle again, e.g. if a request it sends
fails right away, they are called again while the queue is being
iterated, corrupting it:

 Invalid read of size 8
    at queue_remove_if (queue.c:285)
    by queue_remove_all (queue.c:321)
    by notify_client_idle (gatt-client.c:187)
    ...
  Address is 8 bytes inside a block of size 16 free'd
    at free
    by queue_remove_if (queue.c:292)
    by queue_remove_all (queue.c:321)
    by notify_client_idle (gatt-client.c:187)
    by request_unref (gatt-client.c:206)
    by bt_gatt_client_read_long_value (gatt-client.c:3140)

Detach the callbacks from the client before calling them.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/gatt-client.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index b3bc62220e16..5135283e4526 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -180,11 +180,21 @@ bt_gatt_client_ref_safe(struct bt_gatt_client *client)
 
 static void notify_client_idle(struct bt_gatt_client *client)
 {
+	struct queue *idle_cbs;
+
 	client = bt_gatt_client_ref_safe(client);
 	if (!client)
 		return;
 
-	queue_remove_all(client->idle_cbs, idle_notify, NULL, idle_destroy);
+	/* Detach the callbacks before calling them, as a callback may make
+	 * the client idle again, e.g. if a request it sends fails right away,
+	 * which would otherwise call them again while being removed.
+	 */
+	idle_cbs = client->idle_cbs;
+	client->idle_cbs = queue_new();
+
+	queue_remove_all(idle_cbs, idle_notify, NULL, idle_destroy);
+	queue_destroy(idle_cbs, NULL);
 
 	bt_gatt_client_unref(client);
 }
-- 
2.55.0

