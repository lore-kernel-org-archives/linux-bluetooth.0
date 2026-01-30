Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32713019D7
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801987; cv=none; b=ETqRk0/PfZR4zPpOH7zsKQJhkfKhp8nbryPWpQDOjcb1aerobicc6uqUKe/VxLLt47uQVEEfMBf8T3/NbwTcfbCZA8stDzPUjFwYH6GmLNMnD/nGTzfN3rICO4C9zzEgYEyAIVMmAUbqTjT/mzwt9eBWiPJ6mXU8Q2Qj7qM3OPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801987; c=relaxed/simple;
	bh=1qcg6Fo+zUlw0awma7itvdhqQrXkosVfl4b4dIPdJk4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grm1VxXQqoVYS3wr7RjLzetVTJ/DBxh3thWihWyT1q8auxYP5v3FPZTv/TUT6rFicevOMEFQ8ge+9+bjsAWTgyYCUX7ggza2ZhEmWmLfcux3F48wALVmt7EmkiROn5j/ysgRguYF9Y1XRb/viUnt9sTIkTscEyUJrolwQFjTV9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhlxSVKw; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhlxSVKw"
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-5662c2937fdso1888152e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801985; x=1770406785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1I5Tcnn29kS7X5Bx7cDIRKiPlsqGmWf3rIkh4jrajJo=;
        b=OhlxSVKw/fOP/93D5zCPpCSOW2//HmHI/lz/46kI5khtm7FWY8Zle7Flr2dE7UkYXk
         kh3OobO0rgdYGxJk0Uu7fTPKv/mPmj3CL4nBbyxTbnH1OdH6pqGrKWOttrHJEl+GpDyt
         0Q7vuAdRjn8E96XfuvmWHC6E6Mz9E/LWIY1YxH6qpDXby5oL+coj9sr10Wl2XIJNyPl1
         /7u09zRIs8nLWmxeTf9pLAPQfBYL16KIkX4ahwgZqklQbAu3Vv4Lc4UCRLJhRf1SHRSM
         T1rO+n/82HyKpTfNHq+df8OtC32Cbdp+2d2FOxl/DWOkGwUV1J7q8Run44RmLVT8dRE+
         4MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801985; x=1770406785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1I5Tcnn29kS7X5Bx7cDIRKiPlsqGmWf3rIkh4jrajJo=;
        b=sFp81rN2hmy5+nIK0A4bkJ/sA9Z5PSpXYhqjGyzDXuPd+XgMJmi+HwrjCPG8/7JpZw
         YjVwTt2RXXCVnrbmi5U+KIfBKvDt5NFeUfkcwPPZRLDvNRAWLB+zy6+aykHsCmShkIEb
         DWsNDLOn80HJR4USfyyDxK+EMX/O7f9pHNGll8b8BRDQ5X+zIC9GQUxLvYmXgJBo4LIW
         rZp531KiizcmRzqGeeO9aHTXiuaJXV3qV1Q9MDOKel//9ToyxOFyvwzWLcFzMg0u00PA
         8z/JX1xVKmC3sJ+PWh5GYsXMdu0bbfX6sbtYnWQp4otG4YPYi/MlfS1zQxdRmzcnXxE1
         OAXg==
X-Gm-Message-State: AOJu0YwOs5M7lmjTzxhP2l624wiW6ybyHU05Rwi4X2dwzsDyp0R323wP
	UF9WGjHkfoJBg40NN9uJYeNxbUGKERI+sKYlpb39Sv8fED1eDQ7A6tP+dz/cGvbj
X-Gm-Gg: AZuq6aJp8nDZESnLi6B+6C3kWEqLazd6dzAuVS1zglKB+qsL1nreEKxfLwMz7BQT1w3
	otRRQwmCpd4ztARc4U2RaxkDFNn1EwpnS/+MEHC+8IFV6wT1y2mN8yYjgYCBW2kGUroGCvt+hVA
	PaT4BTp39SyeNmh7caqviWuU6OqdwymvA/L1EIYenHHhLXBZOqwQEXwBIeEbGrhiardgMy3MUXF
	y/i0iMgon1cuHWK1jzGEobWu9KhbD46FyjaBULQ4YT7HQ9/OKqq19jqDDn7ks2aK7SeIREXzsAE
	L57aYdXDgizlXpZbeo+phEWJG/gYyyteBElbe/7Q2HaW1lgkOZdI2uG5OOTTbTE45GrJD84XlkQ
	YHolDB0wj9lAigwPCGbS45D1tGmPzlEs5Dla15Iz9HLawsFfDmGJrUpoYyj+DwnUTkV8o1K+vs4
	KW4awcmxYGVE1EwPzbUZZz/y4Nys8qzIZfNPe83T4UeUGnszQTzbOkoDFX2wo80z4c5GEaox3SP
	ODw8Q==
X-Received: by 2002:a05:6122:134d:b0:563:77a9:e929 with SMTP id 71dfb90a1353d-56691f172damr2384500e0c.8.1769801984807;
        Fri, 30 Jan 2026 11:39:44 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:44 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 14/35] doc/bluetoothctl-telephony: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:56 -0500
Message-ID: <20260130193921.1273263-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
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
 doc/bluetoothctl-telephony.rst | 75 ++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/doc/bluetoothctl-telephony.rst b/doc/bluetoothctl-telephony.rst
index a6870e781a7a..84ea36f778ed 100644
--- a/doc/bluetoothctl-telephony.rst
+++ b/doc/bluetoothctl-telephony.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [telephony.commands]
 
+This submenu manages telephony features using the **org.bluez.Telephony(5)**
+and **org.bluez.Call(5)** interfaces.
+
 Telephony Commands
 ==================
 
@@ -27,34 +30,72 @@ list
 List available audio gateways.
 
 :Usage: **> list**
+:Example Display all available HFP audio gateways:
+	| **> list**
 
 show
 ----
 
 Show audio gateway information.
 
-:Usage: **> show [audiogw]**
+:Usage: **> show [telephony]**
+:Uses: **org.bluez.Telephony(5)** properties
+:[telephony]: Audio gateway device path (optional, shows current if omitted)
+:Example Show information for currently selected audio gateway:
+	| **> show**
+:Example Show information for specific audio gateway device:
+	| **> show /org/bluez/hci0/dev_00_11_22_33_44_55**
+:Example Show information for another audio gateway:
+	| **> show /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF**
 
 select
 ------
 
 Select default audio gateway.
 
-:Usage: **> select <audiogw>**
+:Usage: **> select <telephony>**
+:<telephony>: Audio gateway device path to set as default
+:Example Select specific audio gateway as default:
+	| **> select /org/bluez/hci0/dev_00_11_22_33_44_55**
+:Example Select different audio gateway as default:
+	| **> select /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF**
 
 dial
 ----
 
 Dial number.
 
-:Usage: **> dial <number> [audiogw]**
+:Usage: **> dial <number> [telephony]**
+:Uses: **org.bluez.Telephony(5)** method **Dial**
+:<number>: Phone number to dial
+:[telephony]: Audio gateway device path (optional, uses current if omitted)
+:Example Dial number using currently selected audio gateway:
+	| **> dial 555-1234**
+:Example Dial international number using current audio gateway:
+	| **> dial +1-555-123-4567**
+:Example Dial emergency number using current audio gateway:
+	| **> dial 911**
+:Example Dial number using specific audio gateway:
+	| **> dial 555-1234 /org/bluez/hci0/dev_00_11_22_33_44_55**
+:Example Dial UK number using specific audio gateway:
+	| **> dial +44-20-7946-0958 /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF**
+:Example Dial with caller ID blocking:
+	| **> dial *67-555-1234**
+:Example Dial with caller ID hiding (GSM format):
+	| **> dial #31#555-1234**
 
 hangup-all
 ----------
 
 Hangup all calls.
 
-:Usage: **> hangup-all**
+:Usage: **> hangup-all [telephony]**
+:Uses: **org.bluez.Telephony(5)** method **HangupAll**
+:[telephony]: Audio gateway device path (optional, uses current if omitted)
+:Example Terminate all active and waiting calls on current gateway:
+	| **> hangup-all**
+:Example Terminate all calls on specific audio gateway:
+	| **> hangup-all /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 list-calls
 ----------
@@ -62,6 +103,8 @@ list-calls
 List available calls.
 
 :Usage: **> list-calls**
+:Example Display all active, waiting, and held calls:
+	| **> list-calls**
 
 show-call
 ---------
@@ -69,6 +112,14 @@ show-call
 Show call information.
 
 :Usage: **> show-call <call>**
+:Uses: **org.bluez.Call(5)** properties
+:<call>: Call object path to display information for
+:Example Show information for specific call:
+	| **> show-call /org/bluez/hci0/dev_00_11_22_33_44_55/call1**
+:Example Show information for another call:
+	| **> show-call /org/bluez/hci0/dev_00_11_22_33_44_55/call2**
+:Example Show call information from different device:
+	| **> show-call /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/call1**
 
 answer
 ------
@@ -76,6 +127,14 @@ answer
 Answer call.
 
 :Usage: **> answer <call>**
+:Uses: **org.bluez.Call(5)** method **Answer**
+:<call>: Call object path to answer
+:Example Answer incoming call:
+	| **> answer /org/bluez/hci0/dev_00_11_22_33_44_55/call1**
+:Example Answer waiting call:
+	| **> answer /org/bluez/hci0/dev_00_11_22_33_44_55/call2**
+:Example Answer call from different device:
+	| **> answer /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/call1**
 
 hangup
 ------
@@ -83,6 +142,14 @@ hangup
 Hangup call.
 
 :Usage: **> hangup <call>**
+:Uses: **org.bluez.Call(5)** method **Hangup**
+:<call>: Call object path to terminate
+:Example Terminate specific active call:
+	| **> hangup /org/bluez/hci0/dev_00_11_22_33_44_55/call1**
+:Example Terminate waiting or held call:
+	| **> hangup /org/bluez/hci0/dev_00_11_22_33_44_55/call2**
+:Example Terminate call from different device:
+	| **> hangup /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/call1**
 
 RESOURCES
 =========
-- 
2.52.0

