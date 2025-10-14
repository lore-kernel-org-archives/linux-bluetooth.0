Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF53064A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473564; cv=none; b=RKyfsKi7RIt3OWTcqSj6Mvt7/Nk/qlaHUQh3B8IlJcLB77J6hnILbbTntGQQWloTKd+OTd9HJe97OhSkxArWOes8bc3AF7elhcUfE9uQKksMwYJQPToBKCzJ6Qk/XGOd8ymr7z/TF3bmFXvJcm/HSqDGAJCV/e7HR/50PjZAumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473564; c=relaxed/simple;
	bh=0p40FodgN5hvu+EqwmFMKWS1MmFj+iDh/rcNIyX9I84=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qigLJ5NlMxTv9QkiXyIRcF+IzKi4ay4h9x/xGoFdT6IbxP4/bEk1IkRv1dL5m58bmJkixSSBNs9x9vQC8nwN/52pRuY3Amit7ldl5P9cL2wiCOw68Gkh3pU7fbwDm50lXkOfF96EopzoQmAw7aIirPhAWajr7PA9q0f7IGJUGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHNVpmDH; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHNVpmDH"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-930ae1c6d05so1516518241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760473561; x=1761078361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWC9jcyTt97LNmBjGWt0kCaODQ+nW7diRe342RU8TgQ=;
        b=LHNVpmDHa9rcl45oghe3Dp0TWhfSid+zkw9DY9LgjZTbitUs0xdfRFuRgi/U128lFp
         8Xn8Bwm3cBfPDXS05A+GdIHWFxYBdcuBpxCZjkmUdxg4XjOFmWXwiNS8oMTkLTINvpQq
         jsTnJHnvRPM0TrpdIumu80zGKdlth4mr9lbEoTENuIvCCKtVmKL3Yvor5NnRgasYGV8k
         CEQVO3u+fNWP2wu1pdVvuQtSz/w/sXIXSYnSqc2A9OcG+SFxQQMQwCSHfnde/b4rijU9
         QfA0SKCO6jF98AVWqdWWQ8QYUA6R4gSkcR6OloM2xPo1eJLEoBN91kSICpNbCzujtuap
         euaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760473561; x=1761078361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWC9jcyTt97LNmBjGWt0kCaODQ+nW7diRe342RU8TgQ=;
        b=j6wlwdCAIqt9fWFPsOLKKFtCy06avUvSaDdF43xaaDSiZNB0B7lswYdurfdSlGebCn
         UYSqF9taJeqNuhNbovglO3ItkErzYRle4QAYYZVIGr9Zzbhlw4zRTrspDMARuwR6UUtJ
         TzGe6Xi2GxnbQ1hdPTfs/cqPxHT/ajns42omQlrvII4QaHcYYTUh1SbYDbwKHbWkcGnX
         I5IIcEKZPqUwLWxzORdWuYI6/riTUDgsntTVzTT0XTKSgxbDk0ab3Jax8ajngqqujr8S
         74LqlwN1oY6eJy4aeK0vfE3YcSZsoE3FCyiiyGLdiZMS81nZt6fs+IT+j9QD6uPID1qA
         FFMQ==
X-Gm-Message-State: AOJu0Ywp43EilNXqn/ppY7iuxUceuirsBEygrNvhjOy9f/tc1l3VugPu
	CLyvIusqg+vnoIPdnO+vh7KBl+CbNf8+yBfA/OxY/hK6tbEN8//DPl82kncasHnQ
X-Gm-Gg: ASbGncvxmmBSfi023C1kXi9tVxm7jzwpXbA7aS2IALOWBiKB+056ZMd+PdkTV20LQKZ
	TvqoPVg/DeQ6I36ZndbZssEMoqVSyRIB03GY8GGyNnXlz5jNPcfD2lR+DzwC3oa2f/nN5pA19rH
	xZ/v5f0zCB/mDYXubWaJf1xgy3EgQ2+nGlbq3cdBQT5skYBvOKDMDy4jTc7KZpTQ2fxNf1wtYUs
	Cf/rGVtAwdA3FDU0lEME3X1sptCsm2ViuSePCvmf9zv/X7lgZ6I0VqYOirmIzRb3Q8z6wN0ynB7
	KWvjliMD/JsK9OXmYw0gDKVJSeA2vVpuCpEKoJuelfmmWAfhsGd+3LocrDBaDFr0nhlS09sQPaE
	6Fz6SQ5uUVBvjz4r44EiLS4DjgmiP03zJAzSCDb0n+YJR
X-Google-Smtp-Source: AGHT+IEmasJHd2YkhVnPl8u9PdCJx56jnlcFgcJv6XdtNjldUHgi/zBvvZTFfKl2V2EZ15yl+4n/KA==
X-Received: by 2002:a05:6102:5121:b0:5d6:36fe:2c8c with SMTP id ada2fe7eead31-5d636fe2cabmr994761137.13.1760473561264;
        Tue, 14 Oct 2025 13:26:01 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc7126c7sm4807355137.5.2025.10.14.13.26.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:26:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] transport: Attempt to reuse object paths whenever possible
Date: Tue, 14 Oct 2025 16:25:51 -0400
Message-ID: <20251014202551.423660-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to reuse object paths whenever possible to make
scripting a little more predictable by not having the fd number
being increased regardless of the actual number of transports.
---
 profiles/audio/transport.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index bc550b743981..83e3c9791a66 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2582,7 +2582,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	struct media_endpoint *endpoint = data;
 	struct media_transport *transport;
 	const struct media_transport_ops *ops;
-	static int fd = 0;
+	int fd;
 
 	transport = g_new0(struct media_transport, 1);
 	if (device)
@@ -2595,15 +2595,34 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	transport->size = size;
 	transport->remote_endpoint = g_strdup(remote_endpoint);
 
-	if (device)
-		transport->path = g_strdup_printf("%s/fd%d",
+	for (fd = g_slist_length(transports); fd < UINT8_MAX; fd++) {
+		char *path;
+
+		if (device)
+			path = g_strdup_printf("%s/fd%d",
 					remote_endpoint ? remote_endpoint :
-					device_get_path(device), fd++);
-	else
-		transport->path = g_strdup_printf("%s/fd%d",
+					device_get_path(device),
+					fd);
+		else
+			path = g_strdup_printf("%s/fd%d",
 					remote_endpoint ? remote_endpoint :
 					adapter_get_path(transport->adapter),
-					fd++);
+					fd);
+
+		/* Check if transport already exists */
+		if (!find_transport_by_path(path)) {
+			transport->path = path;
+			break;
+		}
+
+		g_free(path);
+	}
+
+	if (!transport->path) {
+		error("Unable to allocate transport path");
+		goto fail;
+	}
+
 	transport->fd = -1;
 
 	ops = media_transport_find_ops(media_endpoint_get_uuid(endpoint));
-- 
2.51.0

