Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7C1E515
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777929; cv=none; b=ubsGxM3Qa06ComE3OCYxqMVTXeMLN3pQZ/toCryYPGZD7XmC+2qhEfvREGwqbt08M3LKlHUecDbgiPEhRkaWlDoTQkk64cAH2CrbGvNQzNHtPyh3paFvRszXpnl3CIIsxM3tpcl6kxH831EnHsc2rEHY2PXYGtfjcdpIK6U1Jo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777929; c=relaxed/simple;
	bh=cMIpJkcuHQgzUplNI6YbsvBvRqtGncpvmBUJN96tzqA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gLoEQ/wIEX+HRQx4JjFu99hnesl6KHYmFZPyxPDUAuKALi8fgSUIpA1gKVI7OVBVsQQ6vQw2gWY7XR5bD1ipzGVRjPCz3q3Hp/QxbrrOvDDi6n+fCbaRBmF+nmF237AE6VUR66GpPsHjJZbIWSZDUHjbG+Rd1Sll1E0SRF4PdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgsJz1EQ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgsJz1EQ"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3983f8ff40so3556408276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 12:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733777926; x=1734382726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sACaKpFbKdhKAPdz01P4ndraFFeTetjnMleNTB+IPhk=;
        b=DgsJz1EQfsGII7YVh4xmz4x8caHRwoSwjheBqN5Js6pgxsn6/Rq+Jb8+S+7yZqeAGl
         Ee5ezcua4oW5SLpwJ/RB/wgQX5I0pDgPwo52WOobNXw1K/M5J2qtB1NyRbs01u3o6Rga
         xjAaq9T59pbyvawPPI3+wdxsGcUJHZdFevipITyj3rH7BV6PKipyLPeH8eIWZJYQCtqy
         uIiLrSpm9y4iz+6YUK4gOXv5kQVcXA38TkYN1qXH+adI0cLXzboCWujXRA0wa7IavITk
         WM4gE3Jj7T+OzTgApaVDkT0m8vS6REsSr/Nhus6sMDPPrLj6tPgiUno3Qw2tUoPkNLfJ
         qAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733777926; x=1734382726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sACaKpFbKdhKAPdz01P4ndraFFeTetjnMleNTB+IPhk=;
        b=aa2LGz744aBT3+lIO3BMn3cGUFfFqeEA4w0J1lGaPpOgbezuVAk5mAtFj/qQg3+1rr
         pXr1u9nW99tOP+prxKre9LeHukC0lQvERGkg/ypz5T2iRj1Sjc36A6BWsGusvAGW86mN
         DetWbnVXRijhLErAswpGC0p+v6myUrzibnQP8D8Nr9JkYYPkaUl0Ff6dCRDedg1v9T0O
         c8Kd+QEwGawuJAYLGKH7uOXNP9muLePKsPg5J+nSy9HKorQ302ClScUCbXY0FmXNFhtj
         yKJyOVdFDLnR9wExd8hv4nq56osKMBoZ5tTzEH2B7rx/Y1XfMgbEFLO12n3NDTONrI3I
         Z2dw==
X-Gm-Message-State: AOJu0Yx5O3oSh4y0awjJvw5RyeaSRlfC/gKiYUxR5Mx1ulcBA9Hz+SCO
	hLSQcWJwsomRXDHHlVy1BS6Cq7QHdcdDqQuZadkWZ2lSsyV3NOPBUZ/2Ng==
X-Gm-Gg: ASbGncuBjhd9KisRSG/OyMD5ig5l3tKGgK6xOL8zbi2Ed8EpC2YFsXcmR2Ryf2c2L61
	mISFc+oSJOE5k/gHvFvxGRqhuo611/c1nWx9EXnshRcZAaxL4VobaRsMooEWZokZOU2jUG7ip9g
	8xu2Z+2Yn8gRC0/3kGq0y4Z5qwAvti1YPKGHEj8Su+aHL553ER96pGGA+gEHfrf0+D8IHRWs6yQ
	uxJ0MCvb77yWEvrzaj+mKkRYwgQW3V44hFm+SweEnXsOt6CKQyurTgtVV4n2UjlchUPHilQW8CD
	Jle10RCEs+XAmURSRVcPtA==
X-Google-Smtp-Source: AGHT+IHxElwS3xd4oWa1rf6e5BQ8s9ESf1bHYqJyT8P9G7IpowAz8pQlyF23zXiR4Y0bu7wydG8jUA==
X-Received: by 2002:a05:6902:2d81:b0:e38:8263:7990 with SMTP id 3f1490d57ef6-e3a59d09878mr1579166276.48.1733777925806;
        Mon, 09 Dec 2024 12:58:45 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e39f6a42f31sm2556098276.4.2024.12.09.12.58.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 12:58:44 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] shared/gatt-db: Fix possible crash on gatt_db_clone
Date: Mon,  9 Dec 2024 15:58:41 -0500
Message-ID: <20241209205843.1394081-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following crash can happen if the original gatt_db has incomplete
service definitions since the attribute might still be discovering:

 Invalid read of size 4
    at 0x1E5A39: bt_uuid_len (uuid.h:289)
    by 0x1E5A39: service_clone (gatt-db.c:284)
    by 0x1D5EBB: queue_foreach (queue.c:207)
    by 0x1E61CD: gatt_db_clone (gatt-db.c:329)
    by 0x1C18F0: btd_device_set_gatt_db (device.c:7110)
    by 0x1C9F96: foreach_rsi (set.c:295)
    by 0x1D5EBB: queue_foreach (queue.c:207)
    by 0x48EA91F: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.8000.3)
    by 0x1CA2C8: btd_set_add_device (set.c:357)
    by 0x1BB9AB: btd_device_add_set (device.c:2049)
    by 0x17FF76: csip_ready (csip.c:243)
    by 0x1FD5CC: csip_notify_ready (csip.c:546)
    by 0x1FD5CC: csip_idle (csip.c:630)
    by 0x1DE20C: idle_notify (gatt-client.c:171)
  Address 0xc is not stack'd, malloc'd or (recently) free'd
---
 src/shared/gatt-db.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b35763410d17..72254c7e41ba 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -278,6 +278,9 @@ static void service_clone(void *data, void *user_data)
 	for (i = 0; i < service->num_handles; i++) {
 		struct gatt_db_attribute *attr = service->attributes[i];
 
+		if (!attr)
+			continue;
+
 		/* Only clone values for characteristics declaration since that
 		 * is considered when calculating the db hash.
 		 */
-- 
2.47.1

