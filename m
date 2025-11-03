Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA251EA84
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Nov 2025 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203923; cv=none; b=Cvw9NdzONpJ98JwE0CwHW3xhgvULyaBiPDtxzJRDkBpeiWqaID/DglEyMexciPrZliuiaVhFuQwpQDZP8LkSEz7PZNK/mVRIRMP9cwi52mrDxEf7KIEQu+K+FfgsVk4jCivEtFEkRmvzGwWbohQFXMua7agI1yQbzzGJmxG4Pl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203923; c=relaxed/simple;
	bh=Y2vOyKAUsw7BTqHk879G+m/WO8aKQcD7j/W426y8LJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Mv8IbQ9AEdswz/OynYSJWCL2v1Lep7/CyvBKltcxG/gYbPCeTLtXWsV7XrM9eqjY53arE/mpvqr9IjWjPIK+ANBtClnNFAZ8jPR/jDe63BDgYXpy6eJnOsFuduq5G7dErzXpg/mDsa+v52pykQ33u8TTMZJqnIusO10I4xhZttY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaBQCU1I; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaBQCU1I"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54a86cc950dso755302e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Nov 2025 13:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762203919; x=1762808719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6y3SY1q+d08iYnwXjZQe2l93dMMnmoMNLOCQfh7QkBA=;
        b=gaBQCU1Iwi8/9zLW8xGnEodmYeEXmGhu0EeGs2GrOg+wq5dsBtJrX11RndiazM2axI
         Ly06ME57+fDbPFwuTngcoWO9TAgNXi7VuK2hWRSahPVlSEK6T7CG2g9Ci+FuMztD5g9G
         f4v0oMCljsHYOMktmpSLEOH7myxE88QBZoudjnNYmUtYjKtZdWxpAoMOk58Ah6P77CMq
         iy5QB96GB36vOTfhhBYgDe0y/XTrWJZYRaUQNiz+pRaB2EEevGg3+v/czD8frsUHy/JE
         MQoSEOdL81st+k5fqjwtISHSsAFzzrPo8xubccpk7+4io7UvuAo2fE440oULaehWdi8r
         QRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762203919; x=1762808719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6y3SY1q+d08iYnwXjZQe2l93dMMnmoMNLOCQfh7QkBA=;
        b=mayBR0aqQBG9L87eXL7cs1R4vTZgtaCu9iMCbxtPzsMBtxW8l5MPWNYVvo0wjtipM/
         mYd4RC38MQJ0ZB3qCca4xg8ffhVio/348cRvkJHvn1FWFOpsrt1GBcXT0ppQRjc86ogz
         XQUugDuzyaOi7vrEWs4dj2Wp9s52yKufiXLcviYCwJDGq6NfO535EbarichZaechXV+d
         +PSsueuaNg/+qGEpR+GMLuGkxOVvQPxmiv3yPDIpRs5Zakr/NdXuIOSn5jwapPgPfQFx
         A6Xjp2ITYm9pfyvNfYSrQ2qCW3W5hKJs+mUlw7ml6cqFbxr9LzZEcMR6sNf2bcv/dWAK
         sQMQ==
X-Gm-Message-State: AOJu0Yww2FVzNLwQfAihmeOHhba9Q1jKhBwdOO5Vb9dqi1fzKqqv7JAs
	L8nM9YKetP+DpU950Hs04nEGyC2ihOY85ef2p47zQEQWXWJgirvokBdRT9gyADoo
X-Gm-Gg: ASbGncsHQZYM8Enmn0l2zbkkZyWeMBivQT7kxsW3uGlMz0Ei9uZgcR/HVEDvg4/xwc0
	LuqL7eBU+eo5rjD3vfTh+l46rVRCcPJPm82QnQUnN0FcrmcVVMEyTKPw8tw/P7I059J78wi67a0
	Jwjc/mm0MbwdNXTJJ0aBT9LiFhv2yK8alRZiquqF+4d9M/Zsd+ncTs48dfAwETkmwaiATN+V4J8
	M9hrgDo85n436Ns8rPai0v+pLuSFuofK+un2gPxcKNFPav4WZEizNgmJfH5Sd1ENttTnmNgEbzh
	FiT11pv8fgCwK/+4F9l6tKx9rsk0YE7R1yiBfXxa+cRMJkSY9jPpe/XXy29b/8v4Gncy7QeR2og
	Si3F3A/a5NJNubpJfkJH7O3sMk7LiVvqnEU1mhur4Ko9a6CGPNkaydKJnPGweiGSRV+Z4tgK/ZD
	GQT2lDQgUG724laOQEsk0BgcIJ
X-Google-Smtp-Source: AGHT+IFzfe/nHp91bfc28POUdLF/MmnNd70QFFNoFK79S4jw/7gfy/MW9Ty6SxdhIaqj7ar/AhrVmA==
X-Received: by 2002:a05:6122:1804:b0:559:67df:5889 with SMTP id 71dfb90a1353d-55967df654amr1484308e0c.6.1762203919452;
        Mon, 03 Nov 2025 13:05:19 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973bf63dbsm453983e0c.9.2025.11.03.13.05.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 13:05:17 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] monitor: Decode Bluetooth 6.0 version
Date: Mon,  3 Nov 2025 16:05:07 -0500
Message-ID: <20251103210509.1270568-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This decodes 0x0e as Bluetooth 6.0.
---
 monitor/packet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index ceed85318b3b..06c0894d8a18 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2526,6 +2526,9 @@ void packet_print_version(const char *label, uint8_t version,
 	case 0x0d:
 		str = "Bluetooth 5.4";
 		break;
+	case 0x0e:
+		str = "Bluetooth 6.0";
+		break;
 	default:
 		str = "Reserved";
 		break;
-- 
2.51.0

