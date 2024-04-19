Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124712BE93
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713558226; cv=none; b=rgrgjDCvk0ihPrUBmTacOQ0J1e/nEOCPdZkXc8cp5Gq0BimUwbau50nyXdjt8uRs/zA8AFxeVK4NMeSrkknSnpE8OQGBskznXDGoghzRN0LCJedhCNaQRkWRGp0BSFfz1VJO68EJ8PppYrhUbpzg4eVVFFB//IBNgdo1bC/XJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713558226; c=relaxed/simple;
	bh=mzWCx/AqdSzGS5oV0fY4XebMhHKEgNlAWPQ80m3ivCo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K/emjoqVRnMpg7ZRkZqL5SmonBdRpVf5A9yzFRH+Hwz+3g9tdXU2U8M9cmW3ms7Djg9LACxN886K0GhTKNgugeyfiEPwY4C63dK/GvATwTqdvFj8o6YS8TnWE7jYx3YPu8Oh9szkvaJUGzfYDRj1agAWkCYdPuo+h07c2iado3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xl/H6emU; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl/H6emU"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4dac112e142so717294e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713558223; x=1714163023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns/QWSfCcQ2qeMzOP7FTDn5CaYPpr3H9iBes5TfM/7M=;
        b=Xl/H6emU2+sESxvPc4KLqUpsRIUZ/tVfdi23Cgwto5RjQMU9YrX/Gls0CRaGMBiVv2
         XHgwnYq6WSq21o8xNxM8xc4JAGvxCR5eSWMjDwV0ac3aSYnEXl/Yp+5yz2gWrxGisWVy
         TOF924+QWhrw1Z53RbiuX5iDNhI8/kCLfHj0nr1mHi6FYkLp2iO7XyxqTer1HMwwOC1/
         OS+dmY9KTN+9W4Q6fVoZA2dBmYw1aECP5QgEzskZRFJZz0RJdJ3vBV5T47MGqSo/PK9n
         AVLxydOXtzHHZm9p25A6SBoG8CkSUJv1lgJ6rlU2nV9dsdHPkJDkzPrCkM3Mkz0M10PB
         SXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713558223; x=1714163023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns/QWSfCcQ2qeMzOP7FTDn5CaYPpr3H9iBes5TfM/7M=;
        b=YvlW8PzXhBGnu8k4ItDLEEj+N2kiJqAOHeq5eMtk7AR2P0uzSdtwjVPUXjjAb4m5sP
         xXso+2ll/ynWk14oUk4jSXnIWbNL+ro+4fhiorB8P1CtkwIe7c2/qWJXKm90DAPY74u0
         JTCoZMOR3mDe6lLxYiaSXzplK2ne9wDByCqm8fbpiUihMqvA5nsg52OLHQb9Fl+f9D1g
         ioXvT3SL+nYP8XRKLfg4jGH8J+jJsKeUg4Fqx1mmkeZxANGQrMasMfULMshTRGSVDHUk
         wYuJEg9lx06kOmBoYJABHNmhT1/yPbx9yZyrtzvLQcoI5RDsx+kUA4WGbhzLk/C2XMJP
         o2mg==
X-Gm-Message-State: AOJu0YyLC5h3zHuaM2d+xhz8ByOtVL9AbFDIzwbOm2EPFSJ5md/0R8/2
	WT7yCtKfGiOnGbLWenfYsBad5LH0IcWw2FGTMFJ1mvYDQ7cmggqMSPsYDw==
X-Google-Smtp-Source: AGHT+IGFZVlKAppP3X65wIj+P0AmTEuiCC8UjIOKdh9Tq5FUWvYHoJEmzU229qgz6ZnJlubQwDrcRA==
X-Received: by 2002:a05:6122:222a:b0:4c8:8d45:5325 with SMTP id bb42-20020a056122222a00b004c88d455325mr3621963vkb.7.1713558222914;
        Fri, 19 Apr 2024 13:23:42 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id r2-20020ab03302000000b007ec900d958fsm195833uao.7.2024.04.19.13.23.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 13:23:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] client/player: Fix calculation of number of packet
Date: Fri, 19 Apr 2024 16:23:40 -0400
Message-ID: <20240419202341.1635591-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The calculation shall attempt to round to number of packets to the
closest integer otherwise it can result in 0 packets to be sent at each
latency.
---
 client/player.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 1f56bfd270f6..65f771039258 100644
--- a/client/player.c
+++ b/client/player.c
@@ -63,6 +63,7 @@
 #define NSEC_USEC(_t) (_t / 1000L)
 #define SEC_USEC(_t)  (_t  * 1000000L)
 #define TS_USEC(_ts)  (SEC_USEC((_ts)->tv_sec) + NSEC_USEC((_ts)->tv_nsec))
+#define ROUND_CLOSEST(_x, _y) (((_x) + (_y / 2)) / (_y))
 
 #define EP_SRC_LOCATIONS 0x00000003
 #define EP_SNK_LOCATIONS 0x00000003
@@ -5031,8 +5032,9 @@ static bool transport_timer_read(struct io *io, void *user_data)
 		return false;
 	}
 
-	/* num of packets = latency (ms) / interval (us) */
-	num = (qos.ucast.out.latency * 1000 / qos.ucast.out.interval);
+	/* num of packets = ROUND_CLOSEST(latency (ms) / interval (us)) */
+	num = ROUND_CLOSEST(qos.ucast.out.latency * 1000,
+				qos.ucast.out.interval);
 
 	ret = transport_send_seq(transport, transport->fd, num);
 	if (ret < 0) {
-- 
2.44.0

