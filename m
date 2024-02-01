Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839762169
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801906; cv=none; b=Ay1l8bnh37pvR42RhSzoAmpXUkVBP62+dwmP6NSucvzZnsQGCm/gp4HbQ5uIgdzBl00lD9m4lD6veHuZWbuc+81a5JqoefZt+qaUn9tK5OgXd/d0DxHdMsHqKYZyGZAHrEmqVbce4UfSNxQsaQ0KJTeUFUqt78Eph8IVIpaVvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801906; c=relaxed/simple;
	bh=dOOpHAPXm8BsA8Z11Lydd2TjPtVhfXvcQFXbe/GdLVY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H4AgCL6O8KvQnKXzysxV029OloHqbEWVR85Zg8mC/B1FsU2RhrABMcAsXSto6cOKVOtYRSmnrJkGl6x8GQMXbs7iyM7JVTUFFDr7fq2APd3K3omSHQhVW1U3Oef04nfWLvWK3yYif7FpwQUGH3PNP+9YWQQhzz9z7IQfb7jWKF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llppyz5i; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llppyz5i"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so541649241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 07:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706801902; x=1707406702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=85jg8ARE52zUhjrDENCBAFvfpYN6H2nEwrS36GRf8bc=;
        b=llppyz5iPR4kZ/MK82wzZmZB5z12sl9H03kT1n17uaYFatSuccHFeRuMjmrmkSL+zZ
         4ycGQOD0fV8BpOLhbhsWZcPFSQYM36K7ohNhhXgZAIqxRPDh7Z4PIXyrIHdyMX2yJ0ME
         K6e84eC2Qk386beoWqxHjBs91n/iwqnq9TyngvqBL3kFw9QXeo5sjsTOt0yrcGr7SdEU
         bQYg7uhMhl5c5vRYPI8u63GyrkOvUePleW7pQBr8aNQS0qQMql/XXvp8q+pge7d+A92D
         GLRUkE3boalOYHyyiOZaKESTtH5FShzMu/9wViTESYR8GrD6/bKERESIw+mUc7qts7o8
         o/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706801902; x=1707406702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85jg8ARE52zUhjrDENCBAFvfpYN6H2nEwrS36GRf8bc=;
        b=m7RIl/6b3K+aSPUWAZImfryqkok+hme8yxtb2wZ9iTXoyd2dJKDtEg9iDHsNTNdI1s
         s63rZ6CrNFz/2e6G/9PKk5vLwFoVcGb8HAIQyBXnl8Nx06dzLUwQ6+U1O8dHix32Oe8y
         jplx/w07x9L715llIvvGws1NemDpluvd4WAqFND6zM4/BP1LTp6eKilsZe0a38AWom64
         m/1HtDqc2gt0YgdFJxeCVifd9geo8vY73gO3s1ZX/zqNSoEKx05+HBzPJutIWDfZEHrW
         3oB2xiONtOOztheRHF9S/IMvexuZ2XBt2zoXxZuodb1HV21rHdj0KV5D3+tMmrQDQuQz
         38Ew==
X-Gm-Message-State: AOJu0Yx2RbSRqAsodCamAruFQJETuWiG7qR8wZABr7PGWZU/0Zpbxn+2
	jqB8vEz8GI1CwZlmz4Z4EhLgxngUBZ6+g8gnYFdHLBDZ9pIeYNPezeZn8evC
X-Google-Smtp-Source: AGHT+IH2qXTXn/9TrXIOLqIA6KtZr55XCScXfFdsNpey7M4eWom+2BcuOQuviSTTcApLYBvQiEC2aA==
X-Received: by 2002:a05:6122:99f:b0:4b7:9dc:9ab with SMTP id g31-20020a056122099f00b004b709dc09abmr2797208vkd.16.1706801902118;
        Thu, 01 Feb 2024 07:38:22 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id ca5-20020a056122400500b004bd503f054asm1624586vkb.42.2024.02.01.07.38.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:38:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/5] client/mgmt: Add missing settings strings
Date: Thu,  1 Feb 2024 10:38:16 -0500
Message-ID: <20240201153820.1016507-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds "iso-broadcaster" and "sync-receiver" which were missing.
---
 client/mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/mgmt.c b/client/mgmt.c
index 62167727c1c0..44bf4d2019ea 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -359,6 +359,8 @@ static const char *settings_str[] = {
 				"wide-band-speech",
 				"cis-central",
 				"cis-peripheral",
+				"iso-broadcaster",
+				"sync-receiver"
 };
 
 static const char *settings2str(uint32_t settings)
-- 
2.43.0

