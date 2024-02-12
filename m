Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1264E1C5
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777117; cv=none; b=e4zJC5cXARj3qrVkhrAluqKASliO4sjKtjB97CdvCaizLG9/Kk6HpY5gOklIdm/hwWp4rGwyL7Acku0WZUFpFZlGn3l6RsLAJYSWHsB1O37K+IzgQTpSU7L6JwFxmQM+YhQ0rTgAjKYdl+GUiACbt8JhRlzHYDQqAtBG2QZWqxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777117; c=relaxed/simple;
	bh=RvyDHGhYb9qRK0GozMLCph6YUdvW3Eq/zyPgZ+7nXgk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPjyivZxILLCneUqJqXcJ3mJ576Sc2bVGPNCjnngOjjFcyzKG3ecMd96PQCBPcgJ8UoWssJcB+ubJqCyy+g+ohPPAiLtQcl49CAjg5A5AMMrG51EAB/d5LwP91rygQ5HqiglH1ZmrUmMsiY6aS7p0zsT1kvwoAlv6WuZQh/5fV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2d5AxaU; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2d5AxaU"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4c022adaa88so556369e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 14:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707777113; x=1708381913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Csi8k2wIa0lbwvBcpJhV1MNaSFF2B9iPCf3jqUMKa8=;
        b=P2d5AxaUTun+8RD760aP9OKiJButKGyytVj4MEo6U9RwO8JaKY+vRZ1240fTPJrvM7
         AOQRYk739XrqO+p2FuwRDByK8wHa+cBLNEwb0d3o4QnzjTOKdfwqmOd/0jlaSdeTVbQg
         +UIxw39f2QI+XfTXwErM+l6fxDodUITyPgTyqs5wSJSPOQxZE4cnA5NE7QbxsIZJsDOR
         +mKNgifJDRlwyZuFJ9p/cyVXDVOMNf92u7T6/vxdEvuVoKEW0KoC/31tNAp+PKrU7yfJ
         Ex3jtN22otm+JZDXY7okHMRYiSgKz9cci6aOK4CaoIxU4vDpl7CRttbZzC00UJkSlXZS
         lg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777113; x=1708381913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Csi8k2wIa0lbwvBcpJhV1MNaSFF2B9iPCf3jqUMKa8=;
        b=GvXu/DX8iDD/FFP95M39mXH8phN6AHm7FoxNLPeX6iSXB74M9fKPVUuCiMlZdASkuS
         yr1hzgHSqtt1yWbpYxrqHk/ocWh4W1NpkPIqGHps/DY/Qd1a47w/XwHrHTgKWtvNfSla
         UmjDNqTlji1A/WgH0Uor/1iAy0D5qIMQnoUyvAYPgxT8G56obzwiOEWX05m/8OPQOadr
         SM9BwHfRLSRgbDg9yyeSVHuGiYIZHId3MmcrsJXMYXL2Ssi2FUPfgCNAqhY5/dOhEJvX
         Za4ZuwmzHIbHAGcU8aUZM2qjLJGy8OeLFS5DSC4VAJjGAN+8ObhwVOTLNWP6qR93tl/z
         BMfg==
X-Gm-Message-State: AOJu0YyaMxeSiOa3WkLsdFtaM2Xcw/Dv9KK+WL1mdwMA+GEFylw2lxtp
	sGBBO7WNrEItA9s0SYXT5PeZSJZ0yjMvcG/bhjqiPVZWlTGU3uOhiaQyIRJS
X-Google-Smtp-Source: AGHT+IH2V0qVuHLon28jvuIIXYA+ZaEhb8ZShwP7zquYPFd9lxWHDhTiBng7RbUVl9itXkgtZ4mNaQ==
X-Received: by 2002:a1f:4d43:0:b0:4b6:d63c:ca8f with SMTP id a64-20020a1f4d43000000b004b6d63cca8fmr3027769vkb.16.1707777113205;
        Mon, 12 Feb 2024 14:31:53 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id z13-20020ac5c18d000000b004c0460eeea3sm840483vkb.43.2024.02.12.14.31.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:31:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/3] input/device: Don't destroy UHID device on disconnect
Date: Mon, 12 Feb 2024 17:31:46 -0500
Message-ID: <20240212223146.4142264-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212223146.4142264-1-luiz.dentz@gmail.com>
References: <20240212223146.4142264-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes classic HID behave like HoG which keeps the UHID device
around while disconnected so it doesn't have to be recreated on every
reconnection.
---
 profiles/input/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index ff7e3482d0eb..08bdb30f1f3e 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -985,6 +985,10 @@ static int uhid_disconnect(struct input_device *idev)
 	if (!idev->uhid_created)
 		return 0;
 
+	/* Only destroy the node if virtual cable unplug flag has been set */
+	if (idev->virtual_cable_unplug)
+		return 0;
+
 	bt_uhid_unregister_all(idev->uhid);
 
 	memset(&ev, 0, sizeof(ev));
-- 
2.43.0

