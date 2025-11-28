Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0F29D260
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345955; cv=none; b=CyXelW1xuVS4a3eAU92CwTRJtS/GasmH3TnzeYLHOMdx/DqA1X3WkPzGM5LRjEhp/chNScWidFHy8I4iW2rFlG6E3AJHUpR554IwOnqRowBVz40XNtOMRwU8ODI4NxO8iNgz/B8iZtgNiV3rvw7AKkTA624DHOg4eIRCXv/J6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345955; c=relaxed/simple;
	bh=BfuWtJpHFnoUxb8s7xJBVcBtioNVHYkElOeeOAD1d8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwKEAgP1N3SKeKg3PGIw893uuel/z+Y9aCo4k1DEOSXrUYdM0dwoIiwVUhvxvDr89Zy/kQ7Llg51IxULG/Cy7s1rSCMxRSVqOp/ytisqzi0aW9cjqW7yDbEkrIcqJXEXznhYUEnFyxMqMBdQZGvs4jMLUCyxPBMltqR5Unq4hQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIp7FjUJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIp7FjUJ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo2435943b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345953; x=1764950753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGAsWoT0ij2AF8u7lzQ99aTp0zEqYgQwfONKoWXhuNs=;
        b=ZIp7FjUJ2K0go7vjjinxJFHzyZlBRz/ZV0MiR/VJUaJxe7yVtl9coSWY1KQfil1Alh
         v7/Xj/TIkg+09AA9lGvxcjPvrWjwrVcNwGf9LXE4XjTxIxjxACblZNge+GvcVYQiCUrM
         1ds2/q8smKNYPGbQRrfel5/RiDDi9KLSMG9BaCO298eDRDr3lYlb0yn5CFYgO71A36J3
         XzcBgPY0sILL5GWIdba78nGV2bia6FH5RF8qHK7efLK4bdUb90lyty7NnVyLyTE8JOLv
         scr6qyIUiO9r+ckVYl9VfOvuyPv8cLypXLBoncy0Q06QMY2dOlXKcAf7m7w23KpLXQIj
         sfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345953; x=1764950753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGAsWoT0ij2AF8u7lzQ99aTp0zEqYgQwfONKoWXhuNs=;
        b=WbahgKsjhhDrHBJyjy8gOc7kVetFc6Gom93KZfXH3Uys/qttdY+LyavxXG14VTL8A6
         jqa6ANkSMJSq71T1Bdv31LYX8yK4R2LJ1xiAwWm0MiHrCDSg2qoYIEMgT415ZChyo7FX
         U42eB6gro0BafeHFYqcymt5beLCfclpIhqYtkSRkwb674ssIo11bIzTQrLdNWbZjiBRX
         wryaC/SsSbudzMDy69niSsco/+As0C5cBv+ws8P1Qnru+EySWKt6GWSlXBy3YGFOJ0tE
         ZnttgY52pzxB285QqSrJwoU3+Hj1paM0RTNam69hF1A/TR5KH8JxcddInOk8k489+l9g
         EAgw==
X-Forwarded-Encrypted: i=1; AJvYcCUPDLT9uVShhNoQJuGp9nlxl4MURuSpWKWKa2qaS84lga5z6LcdCNcQCzrAvEm24lW+uNegZqxsvbcwYk3sJMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc2cx8hD6fVKBwYKsUqANDE3ybY0FBA2DJ/b5GFJfcz+ntlFUd
	QBPHb2MmMtiYoEGeuZIJ+R9GK4y/t9fU4g1UpMZhi6U40zC/UEJUYeUk
X-Gm-Gg: ASbGncvEoq7xWYzj1n3yWpNga4q91GDfFx8apP4vrsU8h51Ee4NQYv7VNc0tFPOZ7eL
	E4p8nTPoWFCGl8syyA7l3fxBDG2Ozabr4BczICF88s4kbumoyByp6283FIglHnwoGaxiDnapNwU
	GGQeBkyCs6xn+8V0lbPr1rdcbnO6I9RpdmVaCYVgwCFyy5Kh5IK17oB5QPGIGDWZJdd+hEnn4D1
	PQdVeJYEiZZyTnHFsya36/s07/zhTCqgEkalTYB2U9Y9L++Jm5KqirS4MCWjs/SpOTYetDO2MzC
	fruQxVH7sDx0PHqay1B53Bm2KImCD5YLU9me+vRVJRiO8ul814cno5UsQyC0KzwDIGLwj4mm1/T
	5kaBFmKwEWq683c73xEsCMhBp3970qNqfZP8OTPALcsNQ4yB0SKL6X41RGscFQFOoabi+iokUJL
	MGMwGDYBy0O7vBgxUvw0G/qSYuCmECvmoFlQtL7Yn3RjAu22BK
X-Google-Smtp-Source: AGHT+IHy5Mo29j/CWbee5Q6OSCJW+TSTmTNfb4OAc8LY3nxwbKHubZG/p57p57Ap+fsLvqvjiDlwdQ==
X-Received: by 2002:a05:6a20:4328:b0:350:fa56:3f45 with SMTP id adf61e73a8af0-36150f033c0mr33804804637.35.1764345952577;
        Fri, 28 Nov 2025 08:05:52 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:05:52 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.15.y 01/14] Documentation: Remove bogus claim about del_timer_sync()
Date: Sat, 29 Nov 2025 01:05:26 +0900
Message-Id: <20251128160539.358938-2-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128160539.358938-1-aha310510@gmail.com>
References: <20251128160539.358938-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit b0b0aa5d858d4d2fe39a5e4486e0550e858108f6 ]

del_timer_sync() does not return the number of times it tried to delete the
timer which rearms itself. It's clearly documented:

 The function returns whether it has deactivated a pending timer or not.

This part of the documentation is from 2003 where del_timer_sync() really
returned the number of deletion attempts for unknown reasons. The code
was rewritten in 2005, but the documentation was not updated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201624.452282769@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 Documentation/kernel-hacking/locking.rst                    | 3 +--
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 6805ae6e86e6..b26e4a3a9b7e 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1006,8 +1006,7 @@ Another common problem is deleting timers which restart themselves (by
 calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
 use del_timer_sync() (``include/linux/timer.h``) to
-handle this case. It returns the number of times the timer had to be
-deleted before we finally stopped it from adding itself back in.
+handle this case.
 
 Locking Speed
 =============
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 51af37f2d621..eddfba806e13 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1027,9 +1027,7 @@ Un altro problema è l'eliminazione dei temporizzatori che si riavviano
 da soli (chiamando add_timer() alla fine della loro esecuzione).
 Dato che questo è un problema abbastanza comune con una propensione
 alle corse critiche, dovreste usare del_timer_sync()
-(``include/linux/timer.h``) per gestire questo caso. Questa ritorna il
-numero di volte che il temporizzatore è stato interrotto prima che
-fosse in grado di fermarlo senza che si riavviasse.
+(``include/linux/timer.h``) per gestire questo caso.
 
 Velocità della sincronizzazione
 ===============================
--
