Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D033E349
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884593; cv=none; b=FBCxnN8vifm5fMLiJy+fyupBWprfYaVWI409KtsiYshJI4JQE7HPwOLHm/A3KRzqxY3r0EGugR+MHLIwReUrhUyYjCzQmjFpMY7m2W1iVEWHu9xYYBxreI57OA0TNwZww3rT0t+CcDxj6YXeQSKz6bTpTgyAoMxE3VdVfwXMHig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884593; c=relaxed/simple;
	bh=BnDq4g200uKHver70CR9bpnm3LCAc0yERDhFp03pmzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJGnVbwxo3ugcD5bOsMZWydw6zHHuL9O5OvfsdZoBqrxrjB/xX/J01fkbtLlT9clXyO2raspbe5m8zzHCL0yFaW4OfLyQgt/ZHxg2xuUL2IuBFi3H2JgVPHRh/7vOC0kpLQhWMa2yyDUzbfxVfzPnu1HiU3GiH2mK7L3r3YRyKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfI16Qa2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfI16Qa2"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6492e7925d2so5324365a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 03:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765884590; x=1766489390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ywNV0Nz+m7Q6JBbWsC/013woclRG1S7r+GkSPRlEZE=;
        b=DfI16Qa287BWRckjbPvi3d/6L29sHWGGs6PUbFmQqDmvWsQGisr0fksDNtaWUu1kXY
         nZ/oWFjHZculAQ7TLvoTigMc170Mwdzf2QLrSk2fbCGKvdQLlS+YpWRuTUlmEO3qj+UV
         VCn7sSMHIodm/cpA+mdARDC1vOrIwHfZ1abOKvCHw1l7LktnhjAOd/MC/OA+GzfMcypQ
         0XX6mLXqEGoEeeE2vXW/XXY/OuqBfEoy3Kmxdk6bo4IdwByNU/AZKcbXXYgebWyMe2Fd
         AbOQVvsznaUOs+lavsEMln5IkvC036Vhq1Ob2QnGrDyu5rTso2QQEMgDNILWa38gkSGc
         rKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765884590; x=1766489390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ywNV0Nz+m7Q6JBbWsC/013woclRG1S7r+GkSPRlEZE=;
        b=xK8ChqXWKgmCJql6gqb3CuzSo16OL0R3Dc/AbeXv5XllOM6rBu5MEVQwjcXqQ1Y6PQ
         pok1iLdfTDuN6acqU45fiHKeEkQTwym/ZYtkDtQeJVvM7Gy/z3cYUqcuFn3pkBs3w6d2
         TZWKhFZL6MXkGsBj4CvI/ebn27duJzI/nNNEtq7BTwCpuPZclBvmSjJiCJkp2p+aJ7CK
         kpe9ACZ1oau7xTb+NTZ2x56ekPE5HLyqE1rGtyi7zv5Yv/GxjQ9Lg36y/lYTanTklXEX
         81yJ+/ORd1cbrEkM1ElccfXMIhXGxMozghKFxYfFd7NvKqfeVVp+JfHk+h5X9NQFeEzx
         Wmpg==
X-Gm-Message-State: AOJu0Yz8ToAoPHWsUTWfcCc7WLpceGLN2HsEtZ5tjVXOuckK3Z7iMudS
	784zDshPlUHjLz9mUlZhp9uEtDiQZXE+djPMuZgjHBbBZNUzbCPsyPNf55LjZWnU
X-Gm-Gg: AY/fxX7LYY8/kfogYHoCY2Jbx+RkzOhexTsGc1yhLs22DSyXdOiJa69ZVs2y5VLf+5R
	EYnde+oJI2qGupP3VzpaFwLWrgbVVblF7yj3vr3J62mmBc3tANmxhMMP6R3aDQ5HurZ8d/WFPmK
	QgBeqi/LiN1nloyZOMkWk51ZIXIwHJQnE0QJ4nbkMtbsZi4l7Oc/nYHBxDU6BQa48L8niG4BgqS
	UgUjXV8nE1zH12ovYOvSu88PQSkQdFQQb81W1T6QP9FCPwWG4FBPDOVuEnII/mB833QccofLpS9
	RatUjtzIL22QlvJPAxpYwguoi0jux+8cF8NPMkoiOFN7ZtzHlrToDf16bdb/ccZnImJYJYkhOJE
	XXd9/ziLYPYGJD8auzCAO8jN83ZxXTLMp2VB5YAf+sZOaxnOT7Hjr6FIxp6OoGj3qhft5kf31XE
	xWFvCNchANMiBYjk/fhLY6P0tD1x68nu7Xk230bRVi8U83whMUvEK+OvnXfLargacg4PahSF0S5
	glCQRtFGQ==
X-Google-Smtp-Source: AGHT+IHL0rnOLov0ZFsYiVUHsPM0CS6lOStj4q4Es7w2Mb0xGF0S1yO2KsH9p6vXX28fO1zgDW2lCg==
X-Received: by 2002:a05:6402:1472:b0:645:dc76:c169 with SMTP id 4fb4d7f45d1cf-6499b1b86e2mr12447278a12.21.1765884589525;
        Tue, 16 Dec 2025 03:29:49 -0800 (PST)
Received: from localhost.localdomain (46.205.203.157.nat.ftth.dynamic.t-mobile.pl. [46.205.203.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64982040b8bsm15907420a12.2.2025.12.16.03.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:29:49 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH] doc: Unify properties section name and type names
Date: Tue, 16 Dec 2025 12:29:41 +0100
Message-ID: <20251216112941.701823-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/org.bluez.Media.rst         |  4 ++--
 doc/org.bluez.MediaEndpoint.rst | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/org.bluez.Media.rst b/doc/org.bluez.Media.rst
index dc265d783..a68c38c9a 100644
--- a/doc/org.bluez.Media.rst
+++ b/doc/org.bluez.Media.rst
@@ -29,7 +29,7 @@ as it likes.
 
 Note: If the sender disconnects the end points are automatically unregistered.
 
-possible properties:
+Possible properties:
 
 :string UUID:
 
@@ -43,7 +43,7 @@ possible properties:
 	values should match the profile specification which is
 	indicated by the UUID.
 
-:uint32_t Vendor [Optional]:
+:uint32 Vendor [Optional]:
 
 	Vendor-specific Company ID, Codec ID tuple that the endpoint implements.
 
diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index 8202b2fdf..416a64fce 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -115,7 +115,7 @@ Select BAP unicast configuration from the supported capabilities:
 
 :uint32 Locations:
 
-:uint32_t ChannelAllocation:
+:uint32 ChannelAllocation:
 
 :dict QoS:
 
@@ -127,7 +127,7 @@ Select BAP unicast configuration from the supported capabilities:
 	:uint32 PreferredMinimumDelay:
 	:uint32 PreferredMaximumDelay:
 
-See `MediaEndpoint Properties`_ for their possible values.
+See `Properties`_ for their possible values.
 
 Returns a configuration which can be used to setup a transport:
 
@@ -180,8 +180,8 @@ This method gets called when **bluetoothd(8)** unregisters the endpoint.
 An endpoint can use it to do cleanup tasks. There is no need to unregister the
 endpoint, because when this method gets called it has already been unregistered.
 
-MediaEndpoint Properties
-------------------------
+Properties
+----------
 
 string UUID [readonly, optional]
 ````````````````````````````````
@@ -196,7 +196,7 @@ Assigned number of codec that the endpoint implements.
 The values should match the profile specification which is indicated by the
 UUID.
 
-uint32_t Vendor [readonly, Optional]
+uint32 Vendor [readonly, optional]
 ````````````````````````````````````
 
 Vendor-specific Company ID, Codec ID tuple that the endpoint implements.
@@ -208,7 +208,7 @@ array{byte} Capabilities [readonly, optional]
 
 Capabilities blob, it is used as it is so the size and byte order must match.
 
-array{byte} Metadata [readonly, Optional]
+array{byte} Metadata [readonly, optional]
 `````````````````````````````````````````
 
 Metadata blob, it is used as it is so the size and byte order must match.
-- 
2.51.0

