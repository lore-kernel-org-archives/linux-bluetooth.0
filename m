Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA11FCCF1
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572927; cv=none; b=i6yhTP2AJ1RbQKeL1L0GRLkjHUGD3KKwclmgtAatiwa+a74P4Re0AuujhX/WN0j20dCWD0HmNmZXJQ7UozoUly3XQFxqt7os/3wrOPcOAtlgpo9OkRQOrUA0ZpdFhbIddss3DEI+nBE+JOEBjAUvEfMX6C0y8XUdf75B0IVlU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572927; c=relaxed/simple;
	bh=TamKxxE+Ufbgvd/HUh/F1UD90tgq7zT3uXn+MvCQNkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZthDnGxHoxn0AvBsDlajlmsx0TiaayM5w3UfWgHNMvMsMv0HsmWiYF6xEV/pxNs2lxMMJGcHSTKprn0XdMElBXJVnhLNEgPZInUmCeLVXbxKit9fNUWPkVkwqL4IJ9aSZfhxZbt5DZn1Mu3f48z1KhRmtUzH1ZMPjQ3uYFcw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub53c8Y9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub53c8Y9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43962f7b0e4so15567435e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 14:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572923; x=1740177723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XunXjeXN65TG4u6bCk6eREzYkbeDYQAacnwiEbp5adI=;
        b=Ub53c8Y9KV1lIJn0GmZfsm0HMWWBAvcLs4CgsspCcP6YsyjGTpBEWLot1pS09duvVD
         OB5zOO6PUS2ohlGQZK/Nv3+mwKyMU4fTQrcgr3N3qSMyB835KzY18VTgOs0TwGlVxJpn
         LAujzTykZi9pTtkWX3U6m6i2I/DwFFAc6jUQ8uHc9NcK/EfBsHYzQalgERmZOyXoFyzh
         ZBYDULtpOhlvP8qJeZoj2q+1PSnFbGqaqXmI90vKDoEzNehIMl7bWtmE10Hl5tgMj22j
         dHwe2DOua1YmwyN5f6g1vaBHs4QfplTBbKPV8gXncJC+aUI4T+r0zwJEG5Hko8Vuol1/
         1bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572923; x=1740177723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XunXjeXN65TG4u6bCk6eREzYkbeDYQAacnwiEbp5adI=;
        b=ql2xhLJpxsl+AoCkIIZot3V1NBarU9RadUgGBbD1LjeDv3kte/5jo2LL192ZBj3SDW
         iyQwZA516/e9XQI9q8BxlbF+4sfMekNdWKMaz5gbqPcK6eBSpdFYaLPNS/904Lfvdduy
         Vk2gxKlLwbIOKarCAPgzw3UQOowLy9XaqMjmCpGg8phqJTB85Q7ZU8HOc6DSbpnJThT+
         OdefyXjzxdrQW3YQF+pBxpXeMqb6u6t6O1kCv6BtbfQI25Y+cSzNcfptg23q9vKPbyCf
         w3aLhZuNBKGlmylxqFcXv0KT2p8+2uoE0Q+hq9TQB8mHLio9L+ey7HdHXZFs7Sh6Pkpx
         xLAg==
X-Gm-Message-State: AOJu0Yx+utoNjS2Vn8rSy/1fMfqKedKU0um7tDOf5VH+g7eYDxnVSX1O
	8y33N7qjYgZ9lFoVKTgXAjjMZk2kW6vfz4wtppQSyj1D2R7VM6oCX/lIIxHB
X-Gm-Gg: ASbGncuunNOLBtY1DV35rx/4pCiU8F+VXNrPsU0ztfQOAGYPiER5qr1LAeDj57hzBia
	lB5qZqyZoF9O9blarBcKrR1zUJOYUFga0NPZJjg2vDlPVMJUhOsy8ldkbT09czu9aVSgDdrGS6K
	sGqu7a5EUzuJolK2r/aATHfJNN1aNvp7vTeQlTLz3aA/rFwgvQmsgWslDf+xHduKpcKXBGy2NXv
	vdD1k/gsoSeEXYcOpNXqVAV2pklU6U3L4YASnktxyeriakv6YzFqEffCbk8Qo2Q5qaHeSZSAO9q
	dZT7H2eB3xnwkgnw8AlPr0n1
X-Google-Smtp-Source: AGHT+IE93gIqN0l54bUAzrHZs4Op/ol681GEhNHZFe4dU+ocg9Yv2oD0W0gWdXUmepC6VGa9mS5ASQ==
X-Received: by 2002:a05:6000:402a:b0:38d:e48b:1766 with SMTP id ffacd0b85a97d-38f33f118c8mr785906f8f.6.1739572922574;
        Fri, 14 Feb 2025 14:42:02 -0800 (PST)
Received: from vibhavp-an515-58.lan ([122.161.77.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961645422sm34358555e9.2.2025.02.14.14.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:42:02 -0800 (PST)
From: Vibhav Pant <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ 1/1] adapter: Fix unnecessarily enabling the connectable property.
Date: Sat, 15 Feb 2025 04:11:49 +0530
Message-ID: <20250214224149.135458-2-vibhavp@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214224149.135458-1-vibhavp@gmail.com>
References: <20250214224149.135458-1-vibhavp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While enabling the discoverable property for an adapter, only enable
the connectable property only if it is currently disabled.
---
 src/adapter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index da602a7b8..01ef0db5a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3142,10 +3142,11 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 		break;
 	case MGMT_SETTING_DISCOVERABLE:
 		if (btd_has_kernel_features(KERNEL_CONN_CONTROL)) {
-			if (mode) {
+			if (mode && !(adapter->current_settings &
+				      MGMT_SETTING_CONNECTABLE)) {
 				set_mode(adapter, MGMT_OP_SET_CONNECTABLE,
 									mode);
-			} else {
+			} else if (!mode) {
 				opcode = MGMT_OP_SET_CONNECTABLE;
 				param = &mode;
 				len = sizeof(mode);
-- 
2.48.1

