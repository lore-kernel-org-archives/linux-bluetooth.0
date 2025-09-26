Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B748A25A2C9
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903619; cv=none; b=onFcfMT7hbDisvld8VnsgzVfgYiuqxbtaMBYEkk2aD0Y5aMmJOmGCY3soXxABU9mUg1DqDpxWH7mDVtmWrcA+EzjK/ASUonAiKas9qyMEYdbbkPyg+rgYrSfghv7uhdTzkqvm9aq1THXmZCguNRSWU3i6CWR0PcUd+R2Rhkm+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903619; c=relaxed/simple;
	bh=nqPMRsZXC38i50jm9s8ZAazKQfUhl8xqbSJ4KzTQO+c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CIUfXht8az4WwLvxaTNd3AkqFKY9eR+SlYJ+7AH5LA23+XFMpQtEOuJUUZ97I/eJchnw6m/s3NGDK/02BLn+XKTvrX2JeXE3KAr0OyZdb1vKqlR2p1r5VJ2QM5zUDTxuQvfBzNVLHhs2muueO4RoIjiOszVVmlm2wOsYDOchd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJRA3VM6; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJRA3VM6"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-54aa5f70513so668587e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758903614; x=1759508414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnAvfQ+p5Zp2+D1h9RaUWJt29oENn6o5rYxFdVvPk5g=;
        b=OJRA3VM6TCltHqjen1jApE24k1+3bvpMupoVWS4967OfVz7FTN9UVUJCjzHcCCHZUQ
         JIClBAOLYCGWkqmAsT8Ob+FOWb6KSgZsVw4b5WDdMKIy66J7NrIMn6JMl/xP2WrJlJfU
         QwX3DKkkbaUQq54BMWP5ZSYFiP5LwEye2xzRf3+NrpR32w/iXEZT4/i2JoBFhYmxpuLQ
         PRb65YLAzj4QsudEWsgfM85Hc7/DqwKgTx2zIJkcVrqKHsgIYTPV4FtIn8rIQoN228T2
         jlMv7RSwSu3by0SOSyZgm41g0aMis1n6VaSk0MdB4EAyEk9krGadHIHTEuaimvtEp6kR
         IOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903614; x=1759508414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnAvfQ+p5Zp2+D1h9RaUWJt29oENn6o5rYxFdVvPk5g=;
        b=CZpJ8GAKxjP8RDFd8R0MSzNYNC//t3zCMFyrNSO3ihACrLgbKd6PzG9tbe0YdddS2s
         5VcR8jMbqhEtOs3bOCBvfdMLwK/EuJw3V5kQUyFye+qneztlhmaPF/UDdHi8Hgh3C8N+
         fR/hWk4hgQeEGTSevhpbxUQYEHWXj+/7mXuEnqtGuKQhy+rt/5S7+9+xFP6tr5iGohsa
         41FYKDkfjcbiF3Hg1eUhHdmlWBYQWYV3dWi2HAniwZufysOEb9l9Xxbh+ByhIjJXWX1Q
         kdRZ2QPFa6AW6yqJ3Z8T/wQhFv2suh5dy9qNuibPQPT4Zfzs1TpqOTK4ud9W11SFkEH5
         6uzg==
X-Gm-Message-State: AOJu0YxdKmSGHe1GnbQtcbxiMg2ZA4m1bbowxVSTUNA+BXFmnnaeVKys
	xpqNCNUc7WjI0wJieX5GHWZMSvIDgq2s0mVYfNbBFF+CFYqwAj1g3OSjFZgIvg==
X-Gm-Gg: ASbGncu/3mO9y6BvV1huTElf4QtydoOM0DOXBzR8oSZANq09kA5vb3dKt6lM1mJGRit
	ArKnoAUzdT5bouoQOUBpOyNJdNeDvmKyxCpErh3MQjbMJ1R4+KAsMSQN1vY585ByPhgdCNZEyow
	mE3HsPbwozgymp6JkPtXIDfE9MB+nFQ+I94Jerp8t2RX0XI7+IOCkeNZJYkKf+Bvrzh9ABC8D1y
	N13rlXVTTz3zO+Ih8tA8UJ7vKB//A5T8t44YaV+6sZrLvMfyJnDm2Gk/1tCmImYaoqWa9kqvMPN
	GUNC3HvEbKigENbOQ5jJCaF17iqM2xN1K8cYxg8hWZAQUOjLH7BQt87AlnQN1WeXnOi1/Trb+kT
	WBg5okVyalc9XalQEBC3tvrbKrZ12XGo0BFcpN0hUnMNMNAR4R3+I2YvAjAYp4SvaMBiZmS0dV2
	f9
X-Google-Smtp-Source: AGHT+IENNXpDYiTlmn89SaVJqN5/LpJhckKHQGtZrhg46Nhf3fIqm1ugMrVU3Eet+de/IjieRo7lFg==
X-Received: by 2002:a05:6102:292c:b0:523:d987:2170 with SMTP id ada2fe7eead31-5accd4f6950mr3169825137.21.1758903613789;
        Fri, 26 Sep 2025 09:20:13 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916dadfe156sm963086241.19.2025.09.26.09.20.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:20:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] btdev: Fix handling of BT_HCI_CMD_LE_SET_RESOLV_ENABLE
Date: Fri, 26 Sep 2025 12:20:01 -0400
Message-ID: <20250926162003.754423-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Checking for le_adv_enable alone is not valid considering the comments
itself states that peridic advertising shall be allowed.
---
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 99e3e5cfa754..67c932d53d59 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -4273,7 +4273,7 @@ static int cmd_set_rl_enable(struct btdev *dev, const void *data, uint8_t len)
 	 * • an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection,
 	 * or HCI_LE_Periodic_Advertising_Create_Sync command is outstanding.
 	 */
-	if (dev->le_adv_enable || dev->le_scan_enable)
+	if ((dev->le_adv_enable && !dev->le_pa_enable) || dev->le_scan_enable)
 		return -EPERM;
 
 	/* Valid range for address resolution enable is 0x00 to 0x01 */
-- 
2.51.0

