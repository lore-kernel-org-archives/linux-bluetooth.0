Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3AB4A3F1A
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506947; cv=none; b=Tgi3gfWIAwEXnzNCZzWS3+FQmPuLuJ9KoEfJw9uqJzjZEjiH+VwGrjssA7nUVtnmJ7YY2aGk7MhRFpOoqmkBrZordc/dnkES8JbidTsA3fMa5OHtWn6Rnxf0GTqKO/XsouMv5H90FBx64PVaWW7WVBhtoFTFcbP4OBDSh4cNnvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506947; c=relaxed/simple;
	bh=J6/l4RF/zlHexHNkK1xwHvf5YAYdGfN44vO46DpJTTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYztzGnjJP2DRRWcO+VwWGBra2rK9gShLO+JZ0BD7B2cGmZ70OobIW4MFuURhyxFcgLfTXz1PpeW8J3Rh6fAmQhxl9aAvhuh6TSt2vaV0xNfB43hEbrdfJmcgh3BXZac9sCQfqxwYPQgKg32/DKuBIqdffWPU4p2/HzQ47+U2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLvFPr/Q; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLvFPr/Q"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-79229116537so84376137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506945; x=1790111745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D9xg5oWDeHx3SWUQsZ3Pbq27tn0d+aRzZqxxyDWVVkc=;
        b=KLvFPr/QbG1QCEBn/DOSq6Y/b20jcaivWKL2UY0En9/LkVexJmD28xlDVKP5z15tqd
         LAMD/391OcgfGSix6kjlH4Y1fmeMcblEYlRVHmFXhcpUOlfbvIgsrJfem5x1erC6n6Jt
         uTxcngt+oYIrMuRDaR1M4fDa2q6Cp7TnUufzrRf7yzrdY698yeqQM806X8zqd9AQlrE5
         Jog9sNvfChQRDFWtDYWLtEB7xquqB8wzAK0GYsSW22laJq1eZjTV5unwGYyVjW2hiMFx
         31Sq46/3AC9FbmfyLxukYLanhyN1wVrl+O/B9BIthqGAv+zPISmLOTQlPMGlGrzL5gMd
         GUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506945; x=1790111745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=D9xg5oWDeHx3SWUQsZ3Pbq27tn0d+aRzZqxxyDWVVkc=;
        b=d7coVCHdsHyWw4qh01Nu9qDSfQMlyuk6574yl3UQgtsliytFlAFKcJvPspeGZBniHi
         jUaAtLjWG0gP1faXncqwpwxsrJIuIoj8xsINOpajBIatuhOrHqKsozPuSVNFC8lLi0oR
         Q1SD3vWJLbYFgJAIyh7XbywBUsZ/MUoTOA0JtgcHXUV5L52ieb964TcgZ9pX0ZXiC+ot
         ZwqtdJc9eTTbAXxLcehwzeycx2BKEYpNKXl8rMp5yHUvrlErEZzqzd7K1g9T9z6NozAR
         cDL9LFoSGqa3V0iyKQnhTZ08GIgGjGjOrQXOnqmnVUCeUskLgMrkZsYcwl+HIk37DIq2
         y5wQ==
X-Gm-Message-State: AFuF++nIRhxopDIZQllmoWej/yDxxrLbQx8S9hFT+lXNzTazbRe7R1Pq
	9IFWLcXhQY+R0qtpDN1JFhVcJOAdSYNFGBWVYrhR6SUzYvY+VNJLFmyIIG7eqCMn
X-Gm-Gg: AYBFou067JtdmsGzhacHBlbhDkX+xFqN+halJNkxDE3L8QfJFyB8B3R2CMWhERbcIt+
	iiudeXHdi4IZtsW9OooHzESgr7z1E44Z+9sLfxO/SLBj9PnIJeNr8J6pQNTrPaq+oQQPGZfjZ8g
	3SAZJ2ktYj54BjznRDlHtlQ1UjiMuGqJsAhfS1TDdyPFgceHw+yl+Xz6WKmgev8SviYstS+515+
	gAg4t/mxqHFiMufCfbu4tCDYqHRBWpY9j+DUAUYsDuHjmNRyUJgL75shlH8301EnKmcFXHjvUvo
	KJ94IlkBMFdSsYepq1i4JuRq062DRHr2GTn0qTfNIQ3hT/joDznKsvS0z8PfMRntx+jI/7ARhK5
	47OzldhcJc3VwrpIzB5Zil0t/K/0UMUBQVxctTDX7VqFKyGzuPNqFPpqtToDqe1X3qSVLHbXXNE
	odOPBEDtHQIhK5lnsRKmGpmfMnP1e0tfBNEzwfOfK18554wbvftGTTpRDMsmfEFg/1uswsmF5uN
	v3tuRuIxya8cF3PsObDU2Fdhccx2tPxg0VNBHEuMf3ktHG4vTCQybUHdJSLpt/C6g==
X-Received: by 2002:a05:6102:5f0b:b0:79e:221f:708 with SMTP id ada2fe7eead31-7a0254bab9dmr477453137.5.1789506945174;
        Tue, 15 Sep 2026 14:15:45 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 07/11] emulator: allow the maximum number of CIS of a CIG
Date: Tue, 15 Sep 2026 17:15:24 -0400
Message-ID: <20260915211528.1223784-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The Num_CIS of LE Set CIG Parameters ranges from 0x00 to 0x1f, but only
three CIS were accepted, so setting up a CIG with more of them failed
with Memory Capacity Exceeded.

A CIG has one CIS per direction of every member of a coordinated set,
so four of them are needed for a stereo stream to a set of two.

Take the maximum the command allows, which the handles of a CIG have
room for: they start at CIS_HANDLE and the ones of a BIG only start at
BIS_HANDLE, 256 handles later.

Assisted-by: opencode:claude-opus-5
---
 emulator/btdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e29e050fad59..26a8aff62d85 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -40,7 +40,10 @@
 
 #define AL_SIZE			16
 #define RL_SIZE			16
-#define CIS_SIZE		3
+/* Maximum number of CIS of a CIG, as the Num_CIS of LE Set CIG
+ * Parameters ranges from 0x00 to 0x1f
+ */
+#define CIS_SIZE		31
 #define BIS_SIZE		3
 #define CIG_SIZE		3
 
-- 
2.55.0

