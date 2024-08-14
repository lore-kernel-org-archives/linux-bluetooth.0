Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD611BD4FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661842; cv=none; b=bQ4Y+jBtsQHgzIZ/6owDGdyBaOnIST0bXsAdXTYdDb+ZnTLwdHcEZwQFLiBMvbaz24N6E6tws80bWAqtYqIpdigmo/t5rCetfzbGcic7tLXp8n0iBWsWPcWpfLGEqLCCsppxZw7srmTo4Vf7/owtSQazpBpV6Xs4+XrjkVWQLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661842; c=relaxed/simple;
	bh=Oa22wE+1XQT8CkBwoxvgIDRzi1JRgLavjn2h3O9bGV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuurzmKY2SHPq/RmXWNKeNIHFz2PTL8L6AiaCgE0m7km5l9N16PWAPl5c5nDqPs1HOiS//DfaC1hahPCT7Rn5cLzcs4j4hGuxhmPBOPEnvGPuvC87L3FTG23bKur9wv7AOxskB22XQz/3mNX0VomWjTtl8JOOZEA9JpJkRW0vTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1jqJtJb; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1jqJtJb"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0ea24477f0so279890276.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723661839; x=1724266639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/+2ykAsZXMD/eMp2tl+lU5moR3JfSXuySPNNKdybvk=;
        b=K1jqJtJbnXhr9JoCb1kczuETtU7tVzYg8gR/oTp6tcdiwFpuFtRiaHRdHbANWlIz8v
         +jehorE0xDIc00PXRfSfGE32PkzkCvrnrfJWOg8uf0IRG3rILgYonHNQwhlFetmRfSUu
         74JuaJb7+Ema28+PQdnhkoqjRLFaWNrTItiIeFnH7byDsk0j4bGkUtQiPPAJSksBuxzW
         7MNTkpqqIQsgowGXC/lz9j7ga4E/EpqFMProFB8nnBKAbpsZ3YwKUpYH1/m9DAcfl8hn
         O43HxcJVXz8DafDawjERQMLo1ACQv1zuJSaxjl/NEKflUywEpDYUMcma898Qi7Gf7bWl
         8PBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723661839; x=1724266639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/+2ykAsZXMD/eMp2tl+lU5moR3JfSXuySPNNKdybvk=;
        b=cZeM4OHfD0/xRFjgkZSEAgcfJpm4EXW+u4kU8qMsku1HcOD96u+6477/kNTBHcxqxv
         c0c3O79nPxpGvMeAJUBoJ5LBwXl6nchu+VstdHwiR39udSjad4Na7L7NH0qSfK1PeUhg
         uHa2QY++t3jhrTIEeOlGdBM94uj+krWV8fiAAW0g0io75AJiRI4Pvo1ZWtOAISMbiTi8
         OG8LfgdoZp+ZzIyE4Z65sTyPu8pMp5bushBkbrJ2TS7JcKkKpu/GNGoQmUCwUiEIA/k+
         QSbCXCQQYmoXmsi6Y2LJR/iirchO4pPio3AFj7wfu+1DlUdW9O9DsWL0x+lf4W0F0D9Y
         Ucvg==
X-Gm-Message-State: AOJu0Yy+9rkdo8fGHO7OH/TOulpNsjtTeiRlOgaA4udn4XwHZ3cMQCoy
	VF4Xg745GUlyte4WU/0Xb8Qd8OSTmCQZGY7m3Cd5vA/f2NMloewo89kRj8q/
X-Google-Smtp-Source: AGHT+IGvLN3VLJyd0D3VXFNo0LVxkDoDOZxUmhRlTz4Fwv1hZ0t7m4WHuN4eLOE2OFrSla6GSiJLYg==
X-Received: by 2002:a05:6902:919:b0:e08:6373:dfb3 with SMTP id 3f1490d57ef6-e1155a48191mr4889462276.1.1723661838777;
        Wed, 14 Aug 2024 11:57:18 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e116203d02fsm274037276.48.2024.08.14.11.57.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 11:57:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] adapter: Create devices if they are connectable
Date: Wed, 14 Aug 2024 14:57:14 -0400
Message-ID: <20240814185714.844117-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814185714.844117-1-luiz.dentz@gmail.com>
References: <20240814185714.844117-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Rather than just depend on discoverable also check if the device is
considered connectable since upper layers shall now be able to use
AdvertisingFlags to detect when a device shall be considered visible
or not and bluetoothctl has been using it since commit 815f779aa8e4
("client: Use AdvertisingFlags when available").
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 85ddfc16568f..245de4456868 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7293,7 +7293,7 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 				MGMT_SETTING_ISO_SYNC_RECEIVER))
 			monitoring = true;
 
-		if (!discoverable && !monitoring && !eir_data.rsi) {
+		if (!discoverable && !monitoring && not_connectable) {
 			eir_data_free(&eir_data);
 			return;
 		}
-- 
2.46.0

