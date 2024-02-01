Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD138526D
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814621; cv=none; b=Q8Uv8zGiCucztYw2A2yk6rYlUBjJf0TwMzLxTbP7rgPU2cTtkrk7CRq0+a8XFOidY+EjxQjUbG2ZFrAWVwqgk/wvtOuNRwKu1Y9NcRCnWI/4BeDupWrPpvc0ggoQLONx7aytLUQAnGcwUTLuEquZeoUKTIbwWVpqq/RVUaZ4NNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814621; c=relaxed/simple;
	bh=dOOpHAPXm8BsA8Z11Lydd2TjPtVhfXvcQFXbe/GdLVY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=laKwcEsvzEeehVxfC1n/p9zojqQ3VlRWOpUhxEkBLjKu7hNcn/gpVuSUiDRZftUsRntf4LthY9d2SJWkMTHQcb3g0yXLJx9IGu77b2Eo5F/DROtQnzucHYHYPh7Jd0iotLqP0Px+VsbeAR0ihFyAIcGPKKu+X5QSXBt/6iUsCD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4XkQsTr; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4XkQsTr"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e132fef7baso725403a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 11:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706814618; x=1707419418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=85jg8ARE52zUhjrDENCBAFvfpYN6H2nEwrS36GRf8bc=;
        b=P4XkQsTrHzmY+IAIe2yuWovUgs3JOroSeTV06zy4zuwc1+9vdxqYgUtKTOZNLczjOf
         p59MatSd89SmfPhRqHAwlagj2euVrW3Nnys4RIcSVp3+FsztS6OChGWg2388AEbgoSyJ
         WBR4q29WtPiWWtx7NM7oHz4AE2YuzYae602h8WEPDgWyC32AMXopOfQveVGizGFyxbOt
         zfNytg2bSPz+QA6qhwWdCggE7WuPoaLOUXT+lYFYYSOJRRBOvbt4WWvhK1W5kj4i+Vnv
         faoBzzQKJgYaaQD5SAU3jRG6AQXIDqLCwqn1349/SYlJptIH5kuGk0ixPC4PACDImcuR
         Igvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814618; x=1707419418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85jg8ARE52zUhjrDENCBAFvfpYN6H2nEwrS36GRf8bc=;
        b=welecCwDxubeeLkMwUg/oKGCt5FpIEDzPMldY/KvlTip2xyRXjV/P2Dl4Lp7rBOnpn
         JIiuyAza8YIwnd2HOKr/w1qSS8FWKkT2j6KTmtliHFV6anNEfjHb737XMpKQcUClWOSa
         D+wbv+UjWpMyqZ6ROqoE8x2EM5HnIYnge+YOyWRScESaWGdXDD9Tn5D+YlIoMannnMwi
         iYlI5Pej4aXMuC2y+gUZ0YU0xibVjXMb2DQ6ZtYVrY4bikGXvWcIdWoVxndy8YkgJT0Z
         7yiW0og8D2Kk2VAP0duYDhEjoKwZcEfHe8I+VEb3BA+ZVXS/jIFR6+Ek8fSPRhQuyhp5
         8h/A==
X-Gm-Message-State: AOJu0YzYACstF5oEQJoDBUxg6h8bfmip7+DUsqct/3Ql/bfPXyZbsRzH
	+DrVY9pLGlCTZ59yPAB4gN775ezf/4a9dTKLZPdxFTYC2Ou2XqWfFN+4f+Py
X-Google-Smtp-Source: AGHT+IGb07gs/s+TEFLVHcXPVLE/2U+KAti0gCRjrzKI9ONi/EobkShJW8wnQ02wFALtsWpC9AWcBg==
X-Received: by 2002:a05:6830:348d:b0:6dd:e799:1d27 with SMTP id c13-20020a056830348d00b006dde7991d27mr6137038otu.26.1706814618304;
        Thu, 01 Feb 2024 11:10:18 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id db16-20020a056130239000b007d2e2f14bd4sm35912uab.29.2024.02.01.11.10.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:10:17 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/8] client/mgmt: Add missing settings strings
Date: Thu,  1 Feb 2024 14:10:09 -0500
Message-ID: <20240201191016.1122194-1-luiz.dentz@gmail.com>
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

