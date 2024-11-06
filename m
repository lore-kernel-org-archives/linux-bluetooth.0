Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B72010E6
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904972; cv=none; b=Nn2a5YLnb9EgEbo1sBm8zdEx3d5gyQh5p+SBxgtWQxjOGuJb5i87+7bjbtF1R2FM34vvNucV/S3g8LzEHaEZ/x282xiA5H3grLn94+WgBNIpHi2EORzH0AELqketIrg0ErK9jYfYi6kdigFg3YV2ib4bESVXgyJnFkwgBHZCGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904972; c=relaxed/simple;
	bh=F45sEqN0rJWhPPO/kWd3AyX4ZiGzxruk+SkEnqFdZeE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YQrvwHz+OfRxBUG6w1kntc5Xsr1nyBzSVs1bdc5WO0mzQg0x8B14OA5Y5oaS+T4Ax8yiekwxSFzyY0PPMPg0I+kRSqZzNra5tTjTpI4Jb+4an09J69lDA2B3/G40Ea3moHfCDXJmMtCRYv0JZ2967TL3ZmwnoNZR0LCjuG+iuZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz5OdSwU; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz5OdSwU"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5139cd0032cso1736301e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Nov 2024 06:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730904968; x=1731509768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jx3CSQOc7+5s2CAjtSLKaK0eVpDPQu2ZmqZH0T43R/w=;
        b=Mz5OdSwUrVIgLNLOwrUT5cgADCUAM5qxe4nbOSt2gVhpqHv/BZcist+/Swj2LcfZD6
         J62Xvy1kyseBGDJsyBubjnU8lSr/EXD6j24FdWeqNwauT5+aZWWDs2m32O59B3OafmS5
         yxHpP1kVap1QBJEnHSH9TgB1pwA4ovp4qFDl2kiO7OxQd1xfHFlsqeI4VHXCWSQV5fni
         OvMC+wjHVdphLGv4SYhB2yyfIcjzLDJcV3KeXmjntSrVRDr6F8bnf1SIf271Qx609onY
         wHxNkftawqxmJtA/+AKto5FtqGB10u7mntcZ5PgILjVUQkmKNUJHVVL7SHsu6H2fuQdB
         czuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904968; x=1731509768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jx3CSQOc7+5s2CAjtSLKaK0eVpDPQu2ZmqZH0T43R/w=;
        b=Kt4molEUzI/ljfd5rwpmzDn7CMIT6wpqnyNMRzaxJ1pd73c434mUlSjF1L2a5KmdmO
         bgJ4gOKb0XOYCBtOeCNO2uaztyC9xe2Pk676BWEoG0dquhtDdvRUCZEOVPwtzsmFl+Ri
         whg1DKCKvbkJaUGqJ7ZqjJTh3kyUpp/yotKoTQ86DUpaIT+mKc0UO3IPByZJrJd1sXHV
         4JaDBaBUFx92Et5s+c7h9EkoAuReRDJ701c5DIlqnRC9N+InVp0HUPkOIRkyN+yEMGij
         YTUrK6O9Z/trHdL/FMloPHBj8LI11MfU03W4MV/J8Wkgzi4PoEpn/Mvr4b1lExGrngoX
         mhgw==
X-Gm-Message-State: AOJu0YzjUiEjKHIYz7ph0VOUj6nDVhZASRy5lg1Vb2bF7efZZSX72DtT
	+57qHZeWiLno08EzvT+7Z2V95ExHKzoyJJ0wwVOmZNT+TdOUlyD4+lsyIg==
X-Google-Smtp-Source: AGHT+IGg4wQEbmK9WaGTH9cy6c9xU5qC9IBh3i4fILkIG4kNYTgw4aO8+ME/YaetuIHTaVlmW1uYnQ==
X-Received: by 2002:a05:6122:893:b0:50d:2317:5b61 with SMTP id 71dfb90a1353d-5106b15d8edmr23019203e0c.6.1730904968651;
        Wed, 06 Nov 2024 06:56:08 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5106f2cb578sm2642474e0c.14.2024.11.06.06.56.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:56:07 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: HCI: Add IPC(11) bus type
Date: Wed,  6 Nov 2024 09:56:05 -0500
Message-ID: <20241106145605.44408-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Zephyr(1) has been using the same bus defines as Linux so tools likes of
btmon, etc, are able to decode the bus used by the driver to transport
HCI packets.

Link: https://github.com/zephyrproject-rtos/zephyr/pull/80808
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5bb4eaa52e14..6203bd8663b7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -68,6 +68,7 @@
 #define HCI_I2C		8
 #define HCI_SMD		9
 #define HCI_VIRTIO	10
+#define HCI_IPC		11
 
 /* HCI device quirks */
 enum {
-- 
2.47.0

