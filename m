Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD622126C
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550099; cv=none; b=Vb9nQBxHnhTEM7U8+TawBUJCYrXp75Yh10sux8q/cyzKuk+hg1lcw4W1vR7c7MeZF3k66S7HNXFoYv1iD+CKlIS2m9zJDJ0q9faBaKHl7p6aJ7YG1yV2X+eMjjj8PlvzzCW4aACT4Dp+5NH6pm8qGmft8DLwgsuvKcj7EWQ9+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550099; c=relaxed/simple;
	bh=15FrH2Q0ILNwLPbpKIVgrMOQ8Ld0eWxtKpvtEMZgcdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qrgw1/GPcVAqqZ06cprb9wfJTPXZ1Dn9Q2adJndQ+T785JX8FjI3IfTXyr6mp3eBR/gLbxXK/f7NMDADIxIRBzEtgifHuoXU2qFCHp9sfYQruqJVauRw9Ebj103MRqABXr13+5QOZZ4jyasXT8dGzk49ulirT+CbsM1Wd+PnLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKjNSuTy; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKjNSuTy"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-53b1717c562so3121459e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755550096; x=1756154896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/wt08ZkqsLQM7Be6+p6QIFldAWcTRADuzpHzUQFcOk=;
        b=nKjNSuTybyKkOVT/tTai2xk1UGPSzI28QHYuCdBP0UQJv/alUVXJt7rC/oaLc1swkD
         EQun3lCVqnNzUSF9O+H/Rm/MysTCwOxsGCE396Ww8kKh5p9NGy712gw4kQ+q3O3PHLDN
         l2SBxdVC57w0GgatuOiQCg0I2wQthKyFFED1De3MgEljsTFU/FD/Wawr4h3fwb0lUVJb
         Vj8GtjkSPuLIyGjfTwDJ0fbvreOMHY7uzd5YzN8UaKg3lk98DA3omzStlP4sCwOGGQlk
         YOVYhN0IHl3HJxHUC7eV9DwHZrMoYDl0IJRhckHqg05bJXGJ24u10HwvQoS//hCrnNv/
         hYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755550096; x=1756154896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/wt08ZkqsLQM7Be6+p6QIFldAWcTRADuzpHzUQFcOk=;
        b=QlOx1NwJ7D2neOPOeb0GskNweiARrYOppNrTdLPdOaX9O5JEdzIOxhUf8/R9u7+0tx
         e4VIxYRn+UyZtkr5/1DokgfH4xbQun5cMbWqVbM92LfAfWFmhvmHSLlbU56Wcl1s1vXL
         /IKnydJmBc9sb62vePCkIDas8esPK0geAsTkQr81bnol2AIUpN82x5bSnEDpmOyN124u
         gkjJ/57JrgJQqEw2QP5qqH9K4NJQO2Uuhly/ii+KDEu1/ITYyaf3E8AMmU0dweUY+0yE
         rVIVF49KBKq9KplqHXZc9DymYdwu1NZXnswXpZ93O0jfjCiLNJsQuMIIq/IHzIeuUcsr
         vncQ==
X-Gm-Message-State: AOJu0YzFrFcOqdOTDcNhkz4g4cBVoTJhj8dUgSSpckye3UM6StAUc6xU
	1VNzucGqStgtvGugVDMTFfAemaXO2KDn5M1sHXmG0Owk1M8Xp4AHp8Ly84eIlHgg
X-Gm-Gg: ASbGncv+x4oR40zvKHm+eNc70gULgGBT9Ee72Q5+AM35sDD+ZPEBj28JzJftjMJPEwv
	MwSEXZbAaXjExvhc1Md6o9zIF5vlK+yIt5Bg7cSvI5/yb0u0VtqlvMNDTZ6xgKEUB4AfSPljDZZ
	HHZ1OpM0QS1CrH5OibUCOj7BFM+ZlzmB6uwYV6JtA+KXpfoDnUvMkvgtUFD+5ZkR8n+51pzfXuf
	HUXZPM1etOJq3F3tsryl8Kbg/sZWYzkX5ofizZJl5TcXDh3KSaNO8cDBJuofXDwC4D9n/eXNLxh
	IkH6pQHmhWynNjGsafgV4pCMM5TCns7ePvHGtMu19R511yBkCOk7lfizfrPxvsm9d9EwvmSdLzG
	0y5ci4NNMQK2CXQcbJAlXWr2xoTKamVdJmqBASpb7gEhH2fmu9Qjwsj1hX3As9/84KZT1K60FGg
	Y=
X-Google-Smtp-Source: AGHT+IGCF+89XDU76BasaFYeu4J1fwoCeFLMpHjHtz18mGEH0wstwhjXTWHxJNZnWHOyvHQZPM6V3A==
X-Received: by 2002:a05:6122:886:b0:53b:1afa:19e1 with SMTP id 71dfb90a1353d-53b5d15ed05mr94598e0c.5.1755550096013;
        Mon, 18 Aug 2025 13:48:16 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd553casm2101079e0c.2.2025.08.18.13.48.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:48:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 8/8] Bluetooth: Add function and line information to bt_dbg
Date: Mon, 18 Aug 2025 16:47:53 -0400
Message-ID: <20250818204753.1203949-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818204753.1203949-1-luiz.dentz@gmail.com>
References: <20250818204753.1203949-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When enabling debug via CONFIG_BT_FEATURE_DEBUG include function and
line information by default otherwise it is hard to make any sense of
which function the logs comes from.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e5751f3070b8..d46ed9011ee5 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -272,7 +272,8 @@ void bt_err_ratelimited(const char *fmt, ...);
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
 
 #if IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)
-#define BT_DBG(fmt, ...)	bt_dbg(fmt "\n", ##__VA_ARGS__)
+#define BT_DBG(fmt, ...) \
+	bt_dbg("%s:%d: " fmt "\n", __func__, __LINE__, ##__VA_ARGS__)
 #else
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 #endif
-- 
2.50.1

