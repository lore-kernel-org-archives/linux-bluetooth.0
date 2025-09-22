Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC11FDA89
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573081; cv=none; b=aWRx41rTRKF5SlZ07As22WQcUOG2H115l2rdzXsnWZD94tGIecBtEzumtSjjrU8G5k5DNXrV07gtpMtEGbY2cO+9hMIAcgKK39+oSi2MOkfqVMahBiIkYysd3Iud+aicd7UDQHCHF+G609FS102IwuSUL9VZQFJZYrf8sC7NwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573081; c=relaxed/simple;
	bh=taI6BcQHiU0ePcdKZPNeLjUOxfrTHgb8aKeXGUoebuE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R67KEY2GHJJJy2onrOKuYhGOPUd0bFU12GZifILbsZzDIEvqcHyXlNcMNpS2fHsOr9oRNBciC70nnKXpXIKPW1DA9a8WmNZZKs5n5ECR36cP03KvpFbxtV5MrTp4fC9F0y+nc8m1YQQa9GS4mfDM8xhW59CSc0ywi5+c3tWSQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDKSVk8O; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDKSVk8O"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54a7bf06edfso3228535e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 13:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758573078; x=1759177878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iCMad0NwvkkM4Nk21szhUDhD4YRk5VCUxdfOXMhOXb0=;
        b=MDKSVk8O7TT5serSizMYMAtkfETp5BonXTtmJseBvx1uDbAqXcvt88VKDYjwScXzH5
         DOe3lgtWCe8mPFVjfYADSBjDHjhEpgeUC1JyEioJydKlzlEc4wv+Ars1gLmyQIqxUAWf
         hjMeOb5WsNU5OFQJqEaGuPeMEw+/v8fEG7jyR5X5mX58SbFU2yfIElGHdugdtVlGhTrn
         onOUI3kIuXZ0i48b22yU+3sQS0XQsvEfATuWDIAOfEt0+2UuQRBZfRw61NtvxYW6/hbH
         9YILC/97gWHvGJ91vsDo9nGG8/iBL13wzTkDAZeVg0xr80tiX7EmqUW6wa1/puKUnNOK
         +HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573078; x=1759177878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCMad0NwvkkM4Nk21szhUDhD4YRk5VCUxdfOXMhOXb0=;
        b=LYlOEthmdBf36GWBo3hYKJuDSuzAIpg2D9UTKbqtcno9YCc7IDQOvIjoGnbPcX6pn8
         JwYd6bvvlP3mkuQe3TjuoXjzxGND+emCiKSTU9Xo4RklmyS5Crrnrxbm3tZ0KbU/46ts
         QuCfi9m91NvGh5bA60vvOq+0GYiZaZWM9B1UPbiQ7wvXEnYdzoN5wZMp0lpZXBYkhlZC
         u3S2NbssO9L4eS8Os8GRtXcUVtN6kMSIpWFctYbLY9TfTburv52QX3n5Z/4mQhg+32sZ
         HY97KY5AZ6wV0PyFjRT+FeYROkAXQpJAaR1VryvzkDwhNEoAq3KNtSwSdGvUsVdOVZr5
         Y5rA==
X-Gm-Message-State: AOJu0YyMwkJbSge89WGfZnG9fjwyFBDUVJz0LU8pMOpKaruMsaPBm8O6
	kZm4lAQq7dDAau+9w/3gAaf6paqONsI3UJaTDuAOqm0LQI6yo0nipx9WBKVcYpFOY5Q=
X-Gm-Gg: ASbGncvygdeE5yMdDt9NpD/xnU/iP7ekggA8WkkcdfsOEnDDKfaFS67VGVg8DmWcL4Y
	KmVE1HHWbeHuXIYZNfkHzXy2NU1YXAxpxRVuPJl3dmCsXstq2MsZKzQ8WVd5rBPoiLXml4JvYwr
	mCj1t/jlzCpcSll7Bz+UBHk3PGzCNV8nAobqP0cc1SVGPwFLemHdcdXcEcEv+wx03WKUimWctQ+
	O8eb+T/JHm/ftWL/rKPWn5wW0qkPYLA1gsIWIUYrtaZkk/qnRvcJAvIGtNCWZiSy8e9JaweDzUT
	Ha3AJD28EoSc+sl6map6J7gj6FxxKjtgnRENa8oaiJNq2ia5p/C8kS+eUBJBW0uUHGV4DcgLU7p
	3IPddC1Du0XI9dUnOD7GucvlJPRgF1uLgbllVQWgidKbAfF9d4kBXxl7hWowXZoxa3Q==
X-Google-Smtp-Source: AGHT+IEMDJmYloj0Ej+JfTyo5MQK9Um08ceYO3cu3vbZLxPxl5U77ywh+1fiMcJK4rum4bMJt7l1Xg==
X-Received: by 2002:a05:6122:54d:b0:54a:8690:719b with SMTP id 71dfb90a1353d-54bcaf72758mr156229e0c.11.1758573078129;
        Mon, 22 Sep 2025 13:31:18 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a90ab79b5sm1819717e0c.13.2025.09.22.13.31.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 13:31:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: ISO: Fix possible UAF on iso_conn_free
Date: Mon, 22 Sep 2025 16:31:06 -0400
Message-ID: <20250922203107.3112454-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempt to fix similar issue to sco_conn_free where if the
conn->sk is not set to NULL may lead to UAF on iso_conn_free.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5c68c0ea7d97..d24c7a1ace92 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -761,6 +761,13 @@ static void iso_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
+	/* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
+	if (iso_pi(sk)->conn) {
+		iso_conn_lock(iso_pi(sk)->conn);
+		iso_pi(sk)->conn->sk = NULL;
+		iso_conn_unlock(iso_pi(sk)->conn);
+	}
+
 	/* Kill poor orphan */
 	bt_sock_unlink(&iso_sk_list, sk);
 	sock_set_flag(sk, SOCK_DEAD);
-- 
2.51.0

