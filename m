Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA318238C0A
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420754; cv=none; b=P++4ZaH/Rpbk0rgxAxCUHeHTeBaPO6f0aPNt4wx7KXBz/6QdWYPmZ6ClwyJztLK0YOMUQVHZv4lq1Ea9i29sOYZdp2egrBKarJVoNkN/toDr8mVRmtguRjA29OWSWFnVmLogxUQzN4N2fIQK4LkHBSEJR1mT2ImuDdUYad0TpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420754; c=relaxed/simple;
	bh=p8zJXE/TxvmLVJJEMydEmEGRGy1q17AXH9ICU36aeNE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BM6/89p0F7LvxproEDRhniTNWDq4HZe9yC6zfoSrCLGZK6h1DfgwMAH1srwPzO9IPG45eSFvTnLJGfsjla05RgMfFd3XF4nVGl6xTn0FUEVPynM5XmL8XmSdWhnjIGI4Gt7776C40FjxXATebM8jgkofqKQ4HE+T8Ah6Z9zHsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0IL1jdD; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0IL1jdD"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-904d71faab6so890322241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Oct 2025 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759420750; x=1760025550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RC+8kIqRaXCMTLhxqkEOpX/jlNHck0RTjV4aGnXLp2M=;
        b=O0IL1jdDiJuEtl6tCsVZSc25BN+RgACqNp68cg+2Q1JMR7H2nMeexOKPahgeKkkCiO
         /WK4tMySwidgQJo0NDLheeYrU+8gXSzrdn0TSFyrcNMnVJdfiK4x/wz+SCe86RMOdpF4
         RcMukkDSZIHseFx572/fcZMaaYVjG428EW31c3/X3GPNCjihtyQMH0IamqqlPQ47uaIs
         mVtwE51Oq+5SnPGJbq6GLQAq04LX46kuJYulj6Yjn/eJhyo4oVLxkGM3tbnYtD+bHT30
         am58fVin00NSOXgWqQZXw2pgC/q0dRGNwnNBbCllVrH6pcdz4sLpbQVkPDwhyIUDRc4K
         c5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420750; x=1760025550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC+8kIqRaXCMTLhxqkEOpX/jlNHck0RTjV4aGnXLp2M=;
        b=WYfCvMSXyk7Ht2ojbL/BP9bneTSd433q94n1+p7Fw9vWdXuiC06xEusr1Xolv+b6mZ
         luW4ZwcSIaP8uYFjcuKo1rHaHEi+hJ4xGA3DHBl4wgHE1ABTCn4QjNXYwPWxn/iHIoGt
         GRiiAqTuJPDktOl4ChEVIB64ORcbR7l0fKSX7t/j1mdNO7uSDVdhbWst2IDHFD6Wprbu
         Thq4pKFBrNYNz567Owrh+A6fyDgZSt2ShPdj8rW3CD7MNlbnrc4oMjT0lQXalu9MsjNn
         5hzGdT7T1zoSJAL4qASHQbEx/UCLIF6JmgFMlwoDznomkOe/eOCkr4FsopJ87/PVrMJr
         nUpw==
X-Gm-Message-State: AOJu0YzelaeaXOlviPa4XE8dV7xbU0XeT2578SCyipOj5Iss28KJF7qr
	L/EXXIWOEy+PryxHlxErCuvrjTc/3UWCfDe5XlU1i4LqAo6hBK7vJi2E0K9g6yP3
X-Gm-Gg: ASbGncvplDWUsuZDrE4Ty0grpsnd1W+7xD4+qSY2VdVQHdDjKtUjYugLAMBIXu2u705
	7fZNGmZDm0562XaKAXSF0V86YElui/I/Eb12+WH/jbI6fH3TC+FCbRsCGSYNAOdf9rXLZ6Hj6Lu
	E6AreVCWp5z8gNncFmXhw4/V2YzjkEKOHp3otKWfLX3CuWDBvZyW7gF8cO96s85Gu1xlhdFmpbX
	QbTu5fdibnAu9QsQGGBRhooxwQq/GT1tviNtGZJYqAKTXL9DLEco/NVVLxr72A6i/GGrS5+JoYs
	cTpuZfx1pKgWdBq36Ow8D+qERULiGuYW+YW0wk2GPsFiN0vY4OIsqkPArIkpqP+jnvkk28QZQL2
	7JKuvxoPXJRErr7RSlkQXvS11KLPU6E0V3jzi3e4D984GD+ifnc46zOC2HTZmjwjfnesMZpfi3R
	ooyB4P+xJ0KXrMrA==
X-Google-Smtp-Source: AGHT+IG0FKVVomi0n2aBSb3YNkQINekmwHxjwFleRa/HLOUFCe7fwP3YW9js2Puf9c5qDat8TJqXEg==
X-Received: by 2002:a05:6122:1687:b0:552:15a3:e764 with SMTP id 71dfb90a1353d-5522cf8c050mr3439343e0c.0.1759420749892;
        Thu, 02 Oct 2025 08:59:09 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce69923sm578545e0c.11.2025.10.02.08.59.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:59:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/2] client/player: Set QoS.Encryption if QoS.BCode is set
Date: Thu,  2 Oct 2025 11:58:55 -0400
Message-ID: <20251002155855.241787-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002155855.241787-1-luiz.dentz@gmail.com>
References: <20251002155855.241787-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

QoS.Encryption must be set in order for the daemon to interpret the
QoS.BCode as valid.
---
 client/player.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/client/player.c b/client/player.c
index 598ad7f6dfd7..bb193dafeba0 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1870,6 +1870,10 @@ static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 
 	if (cfg->ep->bcode->iov_len != 0) {
 		const char *key = "BCode";
+		uint8_t encryption = 0x01;
+
+		g_dbus_dict_append_entry(iter, "Encryption", DBUS_TYPE_BYTE,
+						&encryption);
 
 		bt_shell_printf("BCode:\n");
 		bt_shell_hexdump(cfg->ep->bcode->iov_base,
-- 
2.51.0

