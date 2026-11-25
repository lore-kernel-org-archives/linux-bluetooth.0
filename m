Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626159;
	b=MT2QTY2y8SeHnSTz0wgFJnNLT62tgTMccJ8iaxT2Ea6jg4Km+2AaxPbOhH6mBcqHfGnf
	 OpkEGEszErs6YOVYT7jFu9Ua3VCADP9+AaMlHpUUMG6U35q+rtSmB4+GRfEcAc1WBz3uN
	 As1X2K0SUYYiZ8FlqJwDDypGT+FiaomCqx34xyD5Rh5/gC/nvMiN4E0qfbg5w26F73qFU
	 fZ3S33vZ5zV/Ry8vmaZXgL87jDXNNfxT55J84QF4gZ8qI5Rbkp8hEctBU4y95yToacrcp
	 IaZJPAWnmSlOOvf1QQnd7mOLACH43TK/yjKBzdzT0wOvSP9lK5Dlbv36PhdGJf8nQEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ACm/1lBurqTbaxgVxmrrWHht2nButX8psnhEdW3dQdw=;
	b=P93txZrNHoC9ou79Fcm3uZVBJ+aFyyE2mJ1l1t1tAMYZk5cRt8lMW41BPlzLhETPwozH
	 b/MvSCfPSs8pq1qfacDFgNW/6m4koilGxP4Wbsiuq4pQqzTBCAYG78H38rJA5aQo6Qfhr
	 9P5/pO36C8IFUZu7gR79x60To24jPojHIBeYlcURW7S+bdgMSunwdDuekxan9Pd1iDZJj
	 2itLfQZEHWIuYvzMg7im7WZy4O+UvLjMQGbykNbtW8tQb1qYMQ7vjP810RhKZ18SRmDn2
	 5C0KLWkiDjXi9KkvCsd/m0zF3ppOo2u6CxBFLoUu1WZlbKZrvX0dcgd40j9qIvO3pMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=dhfra0Ba;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E823606A330
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E823606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=dhfra0Ba
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso3462837f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626158; x=1796230958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACm/1lBurqTbaxgVxmrrWHht2nButX8psnhEdW3dQdw=;
        b=dhfra0Balbt/e4dgHw8FoR5DEvU4CBXTNOKIVHqXMMnFoxcPqN5GHlFnW9RfNcXZ5D
         zDBxpLQqYQRGDtK/hwofiDASsP9xOU9E0+vwAUt0o6ZHZ7odEzIabL8nFwqlma/tvECq
         ttfZnPhZ5hK8j+Id6pfTqF4msC9la4VzH4CNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626158; x=1796230958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACm/1lBurqTbaxgVxmrrWHht2nButX8psnhEdW3dQdw=;
        b=TF86wB7M2zrzz8j+qHLBMbThYcCrIQgWQSk5NO0/6kYbsodr65R/o1sfML6uKSR4x6
         HwlhJDnO+4o8SEwXoTPeMaYr9y9Qtj0MbQYoRDfQkP++tmwtHglSfXp+7DYQycgrcuMr
         UDAi2U6i8Pr5lW7pacsu/tJA9C0GGki6D8qxL/XxQ8XlsTwvB+Al6sidgBwn+1mmAJI/
         k7WMxuWQHAWoKq/6pjJS7FXrVt0bBV3PghFq46fjMkXvjGmBP4VeZ5HTFdoaA8B1Wm7t
         /hbfPegOfx7FgM4AvKAmLPfM36s2lROniMx0QejY8ry2INvJy6uWlXxdb/gnI+qy98Hi
         1KAA==
X-Gm-Message-State: APuU4Z/AyPjT/yUu+fneGi1k1rWEXv4n7magcpLtdODF0Me+BWkrvMcN
	0U2QXa0H34iVYgl+1uP5eDtKUCWNwZI+4ODZRjdlazB0I0OsFix47EgAUZU6bF7meXefayszI21
	k4VjL
X-Gm-Gg: AZFdTZehjWC+YUjFJ8ixN4PDaPYmHjziK4mF1u/VgDlYZZhIea5yO7XDdEaIXv1snpT
	WuzPjXLEdk/UfNd4l1l4kMUe8BtpDkFSG24jSmB9LHIOWpC4FEpHdhhpvtEX4SGv0ahGcvy/qDd
	8WgMnc9Qbz5P9tVbrJU8fS3w586Y8EabQ3djfv/XfvelnVGEXGkAeOZ80uzJ+SyeMhw6SjYdw9K
	XEGP2exGqld2ETci7d8r8RTiapWpTho1x7Rd8gMIUtTLtnXAXEyygQ4Z0fpBB09qA7VLuJUsjGN
	DHyCvc1d7ybVOqIlelPOQcBvi8kHoDDg5p7CPtLBFDZKbOjP8Rh5xkCXQf8PtI6oOkDFCruLdGu
	6tYbFZdoL7dP8OEBOU19dEIop4GeA3vpKBELsMMrbkz0m45kXsBv6KoatpRquO9XyiCfys0G6Vu
	dnHefK0KeUycz1vKf8Nu9VR8/NeNUEP99gBdo8ehezi6RvBkH+gzKK/i8rjeJcV1e4xdg5V/Nci
	tZKA//Vd9ggxCpuxpZ2EV2Mt0vaGVBOyeQOUGfxv8eaB2UR0ZWcxsb1NYGkOWbzUA49ltTLHL6d
	qA8uegP7Kl57yPi+PCAH6w4wcWuQpVU50I2kFr6c42gkldtl8uE=
X-Received: by 2002:a05:600c:1d0a:b0:4a2:59:f568 with SMTP id 5b1f17b1804b1-4bb8880ef6amr401823215e9.14.1795626157773;
        Wed, 25 Nov 2026 09:02:37 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm728785135e9.13.2026.11.25.09.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:02:37 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@gmail.com>
Subject: [PATCH BlueZ v4 3/4] bap: Don't leak the io of a PA sync that failed
Date: Wed, 25 Nov 2026 18:02:33 +0100
Message-ID: <20261125170234.1648990-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125170234.1648990-1-simon.mikuda@streamunlimited.com>
References: <20261125170234.1648990-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Mikuda <simon.mikuda@gmail.com>

The kernel reports a PA sync that times out twice.
iso_pa_sync_confirm_cb() replaced data->io_id for the second io, so the
watch of the first one stayed, holding the last reference of its io and
keeping the failed sync in the kernel. Where PA syncs are BIS
connections on BIG 0, a broadcast source on BIG 0 then fails to bind
with EADDRINUSE until bluetoothd restarts.

Remove the previous watch, which also closes its io.

Fixes: 2748c60a2c6b ("bap: Wait for BIG Info report event before creating streams")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/bap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 98ef26997..75ca98be7 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1912,6 +1912,14 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	 * encryption flag is also available.
 	 */
 	DBG("PA Sync done");
+
+	/*
+	 * A failed PA sync is reported twice. Dropping the previous watch also
+	 * closes its io, as the watch holds the last reference.
+	 */
+	if (data->io_id)
+		g_source_remove(data->io_id);
+
 	data->io_id = g_io_add_watch(io, G_IO_OUT, big_info_report_cb,
 								user_data);
 }
-- 
2.43.0

