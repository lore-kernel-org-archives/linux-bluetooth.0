Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC565368953
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136223; cv=none; b=OViYlED49HML1YQzs4MJuY2ZaX1lBqdUJtzrsKYGjX06A6iugfHrQofuaUiquKgMgvdvEdOjPVZiYAICXllEOxugc2umG5NA8Q+W9lgaYUEsbFyxNjMN7b/qviXJI8FYJrzzqML03tYSLBX/xnQlSZL1X0lbBIu/I63LsNG0KIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136223; c=relaxed/simple;
	bh=Hsz5yj1r4YoE9smlNCPUmOyYitCRN5/rU/TiwLfka60=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XZx/SP8/4+SP4DCzOCOzc7m9f1URN09XT80V9HNB3FUs3gkoH858JO+ArWXW8cfTXsodfHhLTbS3q5rmGwfPdgwaLVCuVfAXw1YXNG338SQQrmbGydTQU7sIla9AyCo0Wc+SIAxc+tkNKUg+OPIApWdFeOjCt7Moh37SV9C3Mvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBhAKyyA; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBhAKyyA"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94acf9ce1b7so992554241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 12:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772136221; x=1772741021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1kRpKGa4bFdJRdEhgagIcjv8LE1TGhH6+O+hVNoG40=;
        b=WBhAKyyAnuQmO7oq0PhsjI9xPASbFgD6cIqmBg3qaOfePPkLVfjJyE9fWRIB5U3t1l
         TeH54rV31P8IxylHAFO+IqCcG+3O8haWRB7TrrduuveIDy8lyCQ++mQd1rSBVc2Nn5aU
         HPXd+Y+OzdFSzTghhJXkX8Xwy6r0U+GEIzrWN2uvNGDmYTnrdkrKuFuCzPc+Cp56Z+hp
         ynDd/MJh6EeMsjJwPfbtnJIskcoItUjAwnuIutjtmw2lJvf9WtjkToxG7fIsY4WNTO7r
         SB/gxZcKPWm5EjCoeMSVAQanR16gsAabo4dMEDVxgMlU3LohqjC4MeRyHnvi/NkyhSBe
         RdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772136221; x=1772741021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1kRpKGa4bFdJRdEhgagIcjv8LE1TGhH6+O+hVNoG40=;
        b=QuXu6oa4DE6emNDL1xXnwF6oQSxTdp5nkOBzmthcIXqaqh8C/zPzp+/WMeCeAGb+az
         B8fn7wg9LfUXXb/Jd4ZSANQSMfw7J65DtW11ogBdLISvsPtUSREqIasuRFyYmGr6xhn6
         CyvtWM+qafrFKjCaQ89s3GCmkqhCGQn/W+8J7kmuQg7ZwHdGb0nU5ThwDRMTar291Gtp
         LaZ2mWELQ/ffSW4+gdiBMflSjSclsInsR0XGDebt8v08JcrJp7aYmJJnXdnL94QJ3GyO
         mIAsUDhwrwjEIsyYEqPcBPDlJBZQTdnE7y64vXeQU1zOA78Yc3XlXHqQdi/CR3JWhmwo
         2PGw==
X-Gm-Message-State: AOJu0Yz1zTsy220RbI28cNWvf/KY+g2VNAtZU6aJAXN/HPN26yiy8UHj
	7yy9Tl9kcyCBkZ4dIcM0CYaLJnu2itacCpTUcNmfFBRV8u/pggilBO1EBfQnNaLSflA=
X-Gm-Gg: ATEYQzwtxIC8kcIINaAkw00ALfJhnJFlUDrseurkStzzNH9WjOZMXbV8NC8epDL0BDY
	2pcloOzxQYIO/TlbIuum9ZhgyWGJY/eOeScHTyhKicpLTAaNDEhRjlUBXrbvaU1A17fWELbmsww
	OlkTnKfERq07e29KTaTHTmcpggV2LIhisSbMf+e2T5V5fTQmcdnGawz0HhzqnpSfhvrB8Fxr8bh
	vWvGIdw/NORrcZFsp+Jb6mIJh4Nxn7CG7nVlli57FNZ35gOpAw/nxyHAVCo2uk0nIchwuOeWv0J
	hzh9Sarh53sa9VCHTEuCK0B29yOt5v1EO5pPGt+Q/rdJxHM0pxxxT9GV1kIXgnfzVX5gVA+dl8I
	v2Y/dKNinZRCceLeXYiVKl5nPlJ0B5l0vFUD4cIYhoDodiSJvMkj6a8+eTqo2Sl9j9pwI6GVA99
	nDQGDCTB8eU6px1+XLQYWRXgsJ42sC50SMmM9ZzTuCR1jnoZpbx58Vv6z6wJ5ri3rjZ6D8QSEUl
	UHkvXb+dhfae7F6I/e5uD+Z3rJ5
X-Received: by 2002:a05:6102:3587:b0:5fe:2c9:667d with SMTP id ada2fe7eead31-5ff322d761cmr383696137.2.1772136221394;
        Thu, 26 Feb 2026 12:03:41 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1ea1596asm3260963137.9.2026.02.26.12.03.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 12:03:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] hciemu: Fix silently dropping packet if writev return -EAGAIN
Date: Thu, 26 Feb 2026 15:03:29 -0500
Message-ID: <20260226200330.313530-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code has been silently dropping packets due to lack of buffer
since hciemu design is single threaded it cannot do partial writes
or flushes to force the buffer to be consumed and give space to the
next chunk, so in order to fix this the code will now attempt to
detect if a socket runs out of space and automatically bump the
buffer with use of SO_SNDBUF.
---
 emulator/hciemu.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 8c73a07eede0..01a8e80b727e 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -118,8 +118,35 @@ static void writev_callback(const struct iovec *iov, int iovlen,
 	fd = g_io_channel_unix_get_fd(channel);
 
 	written = writev(fd, iov, iovlen);
-	if (written < 0)
-		return;
+	if (written < 0) {
+		ssize_t ret;
+		int size, data_len;
+		socklen_t len = sizeof(size);
+		int i;
+
+		if (errno != EAGAIN)
+			return;
+
+		data_len = 0;
+
+		for (i = 0; i < iovlen; i++)
+			data_len += iov[i].iov_len;
+
+		/* Automatically bump the send buffer size if the data to be
+		 * sent is larger than the current buffer size. This is needed
+		 * for btdev which doesn't flush the socket buffer until all
+		 * data has been sent.
+		 */
+		ret = getsockopt(fd, SOL_SOCKET, SO_SNDBUF, &size, &len);
+		if (!ret) {
+			size += data_len;
+			setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &size, len);
+		}
+
+		written = writev(fd, iov, iovlen);
+		if (written < 0)
+			return;
+	}
 }
 
 static gboolean receive_bthost(GIOChannel *channel, GIOCondition condition,
-- 
2.52.0

