Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9609B14B97E
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Nov 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730563834; cv=none; b=Cx5bh4HU2RPXXimJwDf76ddOqfejWKH8I0PCTOqZ3YZY8JLzoy8F95AepF8Mvc2U53i5gPjCkozAATKELMXC/fYgvZprtIRGYEqdDyYDnCJHLvE9DN0qbuGv4BRCptSoBLPJ9dhKaGgFmg67rdfjxmgt7Jh6KV+nrCg1R0NVTWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730563834; c=relaxed/simple;
	bh=/IqDreQ09I/GEyj7SK9Hwd9jnVxFYJbe5ogg2Ili3z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZUj5khznQh4aC6SYhlsD1gPerP+gcWSaDY4w3W1mVTUIwSovRJRRT7arCQX0z3+rj9W5W6+0EqpAvVQW8zVjq5pDEeiqYZgjZxpytG6xDUZGGaTWJfIBtOxwuCvG7TA2O0eDF1MjiJZd18eufPkZXn6KHTgyeXwnHnnCyAArhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAZCphs7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAZCphs7"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so24573305e9.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Nov 2024 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730563829; x=1731168629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mPl0l+egfgPUYWdz1t5vfncezhPzpq1MnFgWMxvm8GE=;
        b=BAZCphs7DaAd+XrmF9CcrxnSillO8Cqj2KMPQqaNYgK1l6J6QYCmocIIazNlnSXVDg
         n+3BTnJV0qjmlPIFvVOuxa3UEWvTnxPJmzCr0G4I4DnNxMPPzHIiIZeua80jsQoTvdjE
         z4e0x0ITCQgxA60veTDpFLeZt2TG8elxK11j4HEa7T0Ndt+g633fGlW2cJf4A8b/gkiY
         MsEQkLv0DKtv7GU5aGaMIsBnY6/82fLII0xft2+OyoXwoOWbTwq8pF+Cwd4Fzi0jqqsG
         WFaD5uO6FieiyWoTBTFagwVUMV2nJmaLF8CgVFXvHEnomqzm20qdkC2WPJqvTaXavu8E
         Efjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730563829; x=1731168629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPl0l+egfgPUYWdz1t5vfncezhPzpq1MnFgWMxvm8GE=;
        b=tvupELiGtXP8OxHTJ0R9Aw92RMUFJEcy0LTj9kQRowjUlMgU/lNfuWxxPyjatufi8k
         HrCJPL/qrw9UbZPkv8GAVz8dOz9by8vI8WXLKna2j03e7nBI4HXa9I9AbotQPa3wdGCI
         e0nYE+RwQSQB644ezc2K/hAwcI5k4uvefNghk365trzxsf8PkEF6Nyx+7o4D0jjcXJtV
         zIrcEanvVFI2vyWV23SF+LHo87AQ8sB3hxf+ZYxjuQpaFEwyjdmKfHzVu1efOkDzCxIz
         lmJkl4jSZmMj+yRfX7+o5rgkDQYXeFVm9Mv+YKAe2FLPeiKLQZHDMId15lVY1EXaWWw8
         /YLw==
X-Gm-Message-State: AOJu0YwaGQzoWdABStXO9EC8H6WLMEmCRDUmD4qcaYLRf8Gbd/PljNFk
	Pih4G1o5IvIP9bsMuXc3J4WcflbSK1kRJAxIFEHdvJMQlN4NMwIhRsboPw==
X-Google-Smtp-Source: AGHT+IFqyhmCb1MlYzc60Kr5OakqaWXzxRZmT/khtZsV3RGjdgxqJvuvVXAMVLHnk4x1lAjSjg2bBQ==
X-Received: by 2002:a05:6000:1569:b0:37d:3985:8871 with SMTP id ffacd0b85a97d-381c7aa4867mr6436452f8f.39.1730563829290;
        Sat, 02 Nov 2024 09:10:29 -0700 (PDT)
Received: from localhost.localdomain ([81.15.100.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e89csm8490893f8f.74.2024.11.02.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 09:10:27 -0700 (PDT)
From: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Gu=C3=B0ni=20M=C3=A1r=20Gilbert?= <gudni.m.g@gmail.com>
Subject: [PATCH BlueZ] gdbus: define MAX_INPUT for musl
Date: Sat,  2 Nov 2024 16:10:18 +0000
Message-ID: <20241102161018.2518100-1-gudni.m.g@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the same solution as was done in src/shared/util.c
---
 gdbus/object.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 84f116bf1..7b0476f1a 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -20,6 +20,12 @@
 #include <dbus/dbus.h>
 
 #include "gdbus.h"
+
+/* define MAX_INPUT for musl */
+#ifndef MAX_INPUT
+#define MAX_INPUT _POSIX_MAX_INPUT
+#endif
+
 #include "src/shared/util.h"
 
 #define info(fmt...)
-- 
2.43.0

