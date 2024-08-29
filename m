Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6728685
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962689; cv=none; b=jrFNGN38mdOI+oL4R7uXmw/FktLrHIy4ZJkEYbtytWfKi9hNH+dD9mb9ZeCliMONQyd3Zj2fBMgrFEP63c5o+9UYHH1j8YaR1hNwKDHluyaSM3/uTOgSnkwau5y3kw2NjV5Yc3jdiWL+RKNbqQgWEaGVPSeiY+RU5I1IGtVvwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962689; c=relaxed/simple;
	bh=ZjlsCN79x406alqrhys11WXnG5KtXZ9f17j3EBCzXs0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e+l7lENpOwXoVbMgVRh9jxqCwDJVIAyLFITJs9zkDMW0Ze8BUAWDcVkKLjbjgF6u9kesKO36D9jzPY+YDnZ5wsiSbKryS0sMsfey8oLBgClPrFqDYAMtjBApRgk+ySo8NbUB0+M4kxXmzKgze+9++QWXo8vDYeyjMA2dlziRCTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX+OdwAN; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX+OdwAN"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-498cca5d48aso356261137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 13:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724962686; x=1725567486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5WfVQ5E3p9UvMDX3ygOcbyHH8QBhSj5xgqOgxC4dFQ=;
        b=HX+OdwANIvRWrZJ5D46coO9/ocQHfAIx85XWP5n71xrthIXBYa/DhLQ9HO6MyaaUkk
         SkAOMYSKaMCIkBaAC60tVYVIGYYB2nu5+t1ZKM/PowItt2B1Gr/t8HZxemE1BJFXqF8X
         0WJJKDvUGY93BNYdT22FR158HrWuav+amptJaGvD1HNjdGJm6ZV7CigjzLSCJUPCBDAl
         gU+eJ+AgMgTXPGlKTf/jAhy+Di0r+2HTJzofkmtUem9njdZQkNP2CLrVskF0o4rtulDv
         6yNurnt2py2g8DOacyscCDD3oeAtsJB8tHk+kFnjQ+7I4t2qJVwtySelWbORE63FHvpG
         PUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962686; x=1725567486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5WfVQ5E3p9UvMDX3ygOcbyHH8QBhSj5xgqOgxC4dFQ=;
        b=XiSkhqIiI/N68TPsCXGTpmIB2ad49Cex5cocTRgUlT6h8QlCDeJuOUmIjIOpA1q2xx
         gWUTH41G/Ax/2pFpszhsUNeqyaOg4xxj2/tDm9hY/OPJs6U93LAaFpLycFoHcH4vym5X
         QOgldi12W5Ztwf4v9wScR3ThmMEWkWWCDQU7xnOLKo7yw86Wx+EsA2Ljkztv+SmN/mak
         GiE2T4QifVjBC20j31ysdb77fzn45aBRP9TqPn9wkuwwkfl2DuuFLP/WN7RYa4lN/4XO
         kAyZRZVoAWaUGodr1m5E09pLQX1R/aRYtyGCJxb5jjiU+P0ptrlt2uYEhiFY8qFVxE38
         wYgg==
X-Gm-Message-State: AOJu0YxnWZP2aEhaWuBTjWMinOgdNAk1JUqFNuJTEGA8GAYmirjGHQJt
	GAgEfTZxlFb5KZZGtLHSZ+w7M3t47KCfvQmo+F3kNN033OQAAJ5+pA150A==
X-Google-Smtp-Source: AGHT+IEplHD6Hqr4jMZ+1jsvQp996Jls9vu4XvbWgef1K4oYT6LngbqBOM/xxEBDjnEW7Y6U/s/iDw==
X-Received: by 2002:a05:6102:c0b:b0:495:c4e8:fc3f with SMTP id ada2fe7eead31-49a5af48a80mr4871957137.23.1724962686299;
        Thu, 29 Aug 2024 13:18:06 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-846a9d127besm231386241.6.2024.08.29.13.18.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:18:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] device: Fix Pair method not setting auto_connect
Date: Thu, 29 Aug 2024 16:18:03 -0400
Message-ID: <20240829201803.1103129-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Due to commit 507ba12483c3 ("profile: Remove probe_on_discover")
disable_auto_connect may be set when a service is probed but the device
is still temporary which is normally the result of service being
discovered over advertisement rather than connection.

To fix this the Device.Pair method needs to check if the
disable_auto_connect flag has been set and then reset it set auto_connect
which is similar to how Device.Connect works.
---
 src/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/device.c b/src/device.c
index 1a5e8a7caa27..0f18c8c7f54e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3114,6 +3114,11 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	 * this in the ATT connect callback)
 	 */
 	if (bdaddr_type != BDADDR_BREDR) {
+		if (device->disable_auto_connect) {
+			device->disable_auto_connect = FALSE;
+			device_set_auto_connect(device, TRUE);
+		}
+
 		if (!state->connected && btd_le_connect_before_pairing())
 			err = device_connect_le(device);
 		else
-- 
2.46.0

