Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2C3D982
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Sep 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725742314; cv=none; b=XDJjSpnwZ9WnY1b6V91q3kSzFWs/FYXBEPvzGlwq3zBWs+9Uslbq8XtpTHwB74B6CajV9NqHicXNclytm0eUGB0d+TdKottbQUoiikvKpIsP6XVhtcgiB79PiINbEbJAIiDOPLfVO66fN5vcka48ZXa85/VLs0cY26S9wqE7ZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725742314; c=relaxed/simple;
	bh=aDNySAO6yG4fFDFYPMfyLw0Q78w1IYmd1cPjFVafACQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q06wWLFdHjLMbRZ3XB6WaAKJrIEOxuF2kQRB8T833viDNvfOisKm2/EXaQFjnb6TZPeM6Lvo1EkiCrh63N68gOyd8wmNYOMn4B0fs1NPCMuGcnJBsohuafyq58Fhd50k/hUpTrRH62+iL5e5dNngFOQnF/0AdLZtpnIsS+GJY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VigA6PUF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VigA6PUF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-206aee4073cso31575845ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Sep 2024 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725742311; x=1726347111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7nT5xjXg7qsIesQ0p79ocbL3I+Q+QHFC8bs8vDnDgo=;
        b=VigA6PUF6lRlDvZbBuZqu5Qwo3xdHw6DoYOaPNL5ZB4bM/CdD1yu7pOOWQ2y6FJLNk
         qbUH3NEpd1DC4pnuTg/B2Lr3JSbJqRm3ltVs6g9MnMD3scQjjCcf3QU6MtPfnkrCAaOC
         ZrLRPxFKyz4vDfvqi7diM0mWAxvOpodUAiDTMQxrWXc98TLvItPeNCMthhh7OlKWxA7f
         Wl0fTa83KqmwGirIXZ/48iVF5DFjl1U/nX8pqYwWmlihGmKfA1RTTdg34ILwvjptR6Lc
         8rHVSEfg+7/9mMhu+S9WwpBwAPsrOBiP9moMuZa4PyzaYEQGxItiyyJNCvzWFQ35fPIB
         uvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725742311; x=1726347111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7nT5xjXg7qsIesQ0p79ocbL3I+Q+QHFC8bs8vDnDgo=;
        b=JkIeLInJr0lpCU1OzXJ2j0Y9rQ4afmCH3yHjkNG0R5ZVoz1o2WoyJbEJto+FUuwbtL
         o2ncEPSe5rXBPT8ENUBmHPnupfG4xENqaTXYJGXiz+FHQq8wKZnjCSunEvpyalDQbEw+
         xXdXil5HWukpRm8CUreQg1R2OXTVcaBlw9VxWFLjlEvZSAn2ZiERKYjAXALbfmOmraID
         Y6PSPzHK7mfrl4B6hP0wVeYHo+MmkNzH4duj1yuShorOdpOkDNoXOotLh/5RSuQnjHa1
         BzREdWqteEiz5YZtOCeqWUdWtsn+ctEaJ8RpxDhwIPjXEes+f3M0QVLBZjog02YmrCdJ
         Ir0w==
X-Gm-Message-State: AOJu0YxSNjQVBcOC3SAUe/zFBFHg3iCdXKPqwW32H1NEgPJcZaMKxUh/
	erJXJQmURVBxr8Vl5cm8ZGPalKw4aom8xx0hrl5JTPgg0PkVNWaIWX+JOQ==
X-Google-Smtp-Source: AGHT+IEx5lnKo9M62WlV60Duxs7F5/9t+vr/qz1RBtcA35aA3wp6vwUqVShJqpAzS6ts/UM52fI+2Q==
X-Received: by 2002:a17:903:2303:b0:206:c12d:abad with SMTP id d9443c01a7336-206f05523e9mr113172895ad.34.1725742311301;
        Sat, 07 Sep 2024 13:51:51 -0700 (PDT)
Received: from vibhavp-an515-58.lan ([122.161.69.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eea95esm12046995ad.161.2024.09.07.13.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 13:51:50 -0700 (PDT)
From: Your Name <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ 2/2]  org.bluez.Device: Add documentation for ConnectionType.
Date: Sun,  8 Sep 2024 02:21:46 +0530
Message-ID: <20240907205146.8977-1-vibhavp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vibhav Pant <vibhavp@gmail.com>

---
 doc/org.bluez.Device.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index f94fc2129..ca3c4664a 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -161,6 +161,16 @@ string AddressType [readonly]
 
 		Random address
 
+string ConnectionType [readonly]
+````````````````````````````````
+	The Bluetooth device connection type.
+
+	Possible values:
+
+	:"bredr":
+	:"le":
+	:"dual":
+
 string Name [readonly, optional]
 ````````````````````````````````
 
-- 
2.46.0

