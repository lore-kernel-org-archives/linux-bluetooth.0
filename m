Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D83542C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810569; cv=none; b=ZFJdpqxiycEgBifzg4v2RPnCG4Eeglj0khVlk/pMq00Dnk06vIh4xxtNZ4+NxmuS1luxaJtMKIvxIUoMN8n860qQqssw6hthmOtf8/eqVeOBxKsnTUJCCAd4hgNqp1AlsMX22zszP9SahdNvWOYVlCv0dwL06Gy8O0kpkR+t4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810569; c=relaxed/simple;
	bh=LYISWL86KL7Uk58GnxnrXddW+FoKabNbRJo1hjFBJbA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtTGzoM0UQPdtCZ9AL6dQFK9cUb7lolrRRFL/mMyeRVsbPofkLyRDXDPu3aWx4fE2WMbPozg7CB+8yKzDnpe62IOdFEmqy3zjJacamVKdsOUY385fPiL6mdL7tZ/wV+BPxy8dsdhea8AP/Ck9B/a1aYUIk+6KJr0p1sLwkpqhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkxzAedh; arc=none smtp.client-ip=209.85.217.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkxzAedh"
Received: by mail-vs1-f66.google.com with SMTP id ada2fe7eead31-5eeaae0289bso1658941137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810566; x=1770415366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQMn5YZxiOBfyGwvRG6Hb50a2WarYYSuu9UHaiS+tEc=;
        b=VkxzAedhm9Jp6SsG8myoxBI+tOiKJYlBao19wcWiXwi5RnILBCPOiKlWvweVPcLOX5
         RNTY/lOGFTDjnXbB6oCGj2N6SudDKNo3jCXoDQQUj4QBjLf13cp7mGl0IxSH58ZnqfO0
         SOyCMPtAqeewMZdU/5jiJMgHA+qJI7Vf6b2TWE39Ch++LRLumG5KoubRSHvFWN2MkaTr
         RtIXh37HNusYgs9xaKsHFJZYDcedDmMTcAls2OZ7G1no0VvK8R2ThC23010UwEHNjGzy
         5clxKg0v06yy5II4xbGHLnjdn2Fbl5dp3wijatyfPIYNic6gkuip0/3gjiW5JsYUh68x
         rOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810566; x=1770415366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jQMn5YZxiOBfyGwvRG6Hb50a2WarYYSuu9UHaiS+tEc=;
        b=CWLN6dlFelaVqfrgzvVq/3o87nDls2qtmIOrVr5Tw5PVA1yya/zfK7DRoYnQeXfYFt
         aPdnG0ZACiqs52Lz09w7SiAD8ulPO9sleY8jTvFL+dnF/fkmWx9hPyclgn/ysZXZbWfQ
         ozb2lc9C4zc70gpJ/KcLeOaa1AimALfKgcT7/vhD1faMJWUkGkDzwP1BNIm8QVBTDs22
         lyYF9jXVQDJxBut9tLIeVgyPzQY0E+8Bew7xG2eMjbltT/ZJ5+kVK06Ag97/z5fEHZqh
         Y9xcThfgqc2AYir9pyFR3mwX6q7KFGp/hLT+g81VB06xgPbcB57d6koPdfwIhdHKrCaB
         5Www==
X-Gm-Message-State: AOJu0Yyy/5BszKxpe5taSTNXfpCvteG4Qc5YYBF9Zzp29LyRL/7upAZb
	jG1W8pPzn1z4Mg+HKqQTdZ4NeaO8x3wlgPaW6G0y0T/qr2kLs9duzpMaf00/bDUk
X-Gm-Gg: AZuq6aJvBO20gr2HNDddoc+BzvGSMObBdxvxPPzdwigSGNlNRVnkYY9W6VXIRSo+znC
	3nIfGo1S0tH9SSKjYowo9r1Shu2ZAi39V4bczE22L3UlSHCsZ7M9iG5Pj7WwiSVrjjYQo6NsNsI
	Tg2gaLW5+87CjbLBFGftz9+6yffGyxgAKCy4eNMPSVh+88tKlc5bw7ethFyBmdSOuWdjSBgE3OU
	UpNe/ptC4apGojK6uVp0Qn3bqaN3jNMw7Cf7srAFWGx5ZOm5ar+O+pqFYaQ8pS5XwnxXknvRjGY
	87fTZL5kZIpFd6uiSZqcttniOyc6bQykSFuILejZQ4E3S3gJiAY82OcfX9/0F8SR6k3wIrKAIi/
	YKACQTyIQdTWfoV3kZ35PiYRnHyZXowY/ifds+rqgTvAz7iRGUNX9Sj5oniTCDWw8T/qnHVWxGW
	67r/ilN4ktWUvIKkRSxnGxj6KpA/Mj6jGOhUwjGk1pYm6AfSQell2quLt3sZCKQrOfwGhdiWvmT
	tggDg==
X-Received: by 2002:a05:6102:3f4c:b0:5ed:d33:a65d with SMTP id ada2fe7eead31-5f8e2681c71mr1800878137.34.1769810566430;
        Fri, 30 Jan 2026 14:02:46 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 05/37] doc/bluetoothctl-assistant: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 17:01:56 -0500
Message-ID: <20260130220229.1346261-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 doc/bluetoothctl-assistant.rst | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/doc/bluetoothctl-assistant.rst b/doc/bluetoothctl-assistant.rst
index 33fbcbc764cf..ff22e2a82291 100644
--- a/doc/bluetoothctl-assistant.rst
+++ b/doc/bluetoothctl-assistant.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [assistant.commands]
 
+This submenu manages BAP Broadcast Assistants using the
+**org.bluez.MediaAssistant(5)** interface.
+
 Assistant Commands
 ==================
 
@@ -27,6 +30,8 @@ list
 List available assistants.
 
 :Usage: **> list**
+:Example Display all available BAP Broadcast Assistants:
+	| **> list**
 
 show
 ----
@@ -34,6 +39,12 @@ show
 Show assistant information.
 
 :Usage: **> show [assistant]**
+:Uses: **org.bluez.MediaAssistant(5)** properties
+:[assistant]: BAP Broadcast Assistant path (optional, shows current if omitted)
+:Example Show information for currently selected assistant:
+	| **> show**
+:Example Show specific BAP Broadcast Assistant information:
+	| **> show /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
 
 push
 ----
@@ -66,9 +77,16 @@ Code, a zero filled array will be sent to the peer. Otherwise,
 the string entered by the user will be sent as an array of bytes.
 
 :Usage: **> push <assistant>**
-:Example: | **> push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
-          | **[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00**
-          | **[Assistant] Enter Broadcast Code (auto/value): Borne House**
+:Uses: **org.bluez.MediaAssistant(5)** method **Push**
+:<assistant>: BAP Broadcast Assistant path to send stream information to
+:Example Push stream info with automatic metadata and broadcast code:
+	| **> push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
+	| **[Assistant] Enter Metadata (auto/value): auto**
+	| **[Assistant] Enter Broadcast Code (auto/value): auto**
+:Example Push stream info with custom metadata and broadcast code:
+	| **> push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
+	| **[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00**
+	| **[Assistant] Enter Broadcast Code (auto/value): Borne House**
 
 RESOURCES
 =========
-- 
2.52.0

