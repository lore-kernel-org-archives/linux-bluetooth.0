Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A022D9E3
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824042; cv=none; b=HIyzprVMeWeXLRjwjpggQtKHeq5fawerEAnfk9xJwBkN9n4NkEWNDVot8tQY52Pg14a6akyicyYw1Wxg6jzRRiEH8kcfnXf3PfDNH2W5hYXk6jyyd+dWcl8bOSOWaW+y87WWjtjCgKwvm77RCucmrN16a+nw1MgaypT18MFtf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824042; c=relaxed/simple;
	bh=02S5GCPMbSn+qM9QQLIzeCgm8S1NSA0as6shqasZp/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUQSXTB0gqAWRiOrID+SHE9TSgv/VcDkEluBe0HglzhhX96Tc7pRnZQJI78vnCCmOAA69IJ5Hx5vuCeCaTEV/81hmNy5avXZEnMtRUt9M46ichlGgMAjL4scFbpkCN01T8GARh+CnT5wuwqH63n+61wpns41ByOKtpWnjPQLe0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=bi89Kukl; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="bi89Kukl"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso26202166d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 May 2025 13:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1746824039; x=1747428839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ztjNrSBaY3P5WyFQyux5qSIUKkFCQR/l4SZOwbof7J8=;
        b=bi89KuklxJQUqHLxvF6AxpbGyjRwr+UHQ54Vx0BxlrfBDNNzlco3P+9/f3Qb46XGxx
         WcIvjgMo92XdZ5Rcz73MEFUgDyjU0MEDkGiptp2pBo9ihpFLiKlXxpA8vHpCRFXSF9wq
         s+CRr67BqwfICjqXU7B9dhmodJKgDwGDo1XiTdbV5lTQcjruwE/mM3BJcTHtKQVxHCbH
         CLuqgC5VM19/IFxhVLopnys9fZrMojPSbJB2/ue/f0bODsjKaOuoj6esI+ja9UbGBb1U
         Obi7jxHIdHtciaWFvvcjv88GpLFFPkyzMKQMmnUrrNjjXvrT8E5kL5YaWNngy902bVTE
         Ktnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746824039; x=1747428839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztjNrSBaY3P5WyFQyux5qSIUKkFCQR/l4SZOwbof7J8=;
        b=azcKela5HLBvhC6lPYMNiw3FNljmj8ItY04d1fyfTq/NGBDpWhQM7fHxJaDQ/JCWAR
         Kmmxi3gRNMC5B0ouhChCrf3y7T98EBIt+m59IWM4F1hHect11ia7r2bbaKpiyyn6ZgXu
         2uhEKjgmhEwwebwb1p72ltUMrjy1DdGJGzewy2gCe72uHcWI2I6wrIRQA9C7mVa3iDUY
         Pbx6WyqBtVh6HIkhJG0uqZEGCWO3UpiI1QJHHIcWox7IalGgSLfsxl9NCsUCY3DNAaTw
         7CcqfMt+lfobTzKOoYY+MdkaBg2WGhcSLduDRJVQ8g+c2FcZoOxyg9Ug7ek3ApLEDVMA
         VLmQ==
X-Gm-Message-State: AOJu0Yx1o4ma5GBizGLnQ+Y+hEaSwwzbnuFrI4kh/IMBRie9MFwTHgpD
	Y7+m4LPxHtLESVBKgm7wTqow/umGg4xgfcgri+W/0RMIyE1NmZNWfYHYdjxhGF8wRZJoulPlOx1
	t
X-Gm-Gg: ASbGncvX7inpIv9snEGVvLgSJNTa5OncYQaghSWw0VmlCXMxbhou8C+NvfcEmb+LBgC
	zbmB6u/60ZU/D/WYPaYBhjmodyZEuoFd7pLsv359RP7pAQGd2eDhyxuTBZ4hENEC1gs/Uox8gOz
	tO95qODfcyjUKAjhwt2NhVzM/vuWFRrl4gijnbGI/QotuuhQCTVQZfXufDPDgoUbNlqcGtyVVn6
	mOhWg/xEz4VEvhSgasjXdFcPUqDIkeKkyWVpeWEbmt/WQxt4tPtaRQ/ou+zKCTkuyQQVQbloIYn
	THjYVpvDLZlQagsaaSixzkTXo5/iT/s/2j06bjR7O0tRJYt0nRTSmfkTe2jVsZLcQKCDxQ==
X-Google-Smtp-Source: AGHT+IHVqKlV8RDaQHJ6q6bE0VZspdWvg+VGl/1KK35/eCEeWbIVFA7vBd1iCLYABG063270TJ6iAQ==
X-Received: by 2002:ad4:4eaf:0:b0:6f5:421b:623c with SMTP id 6a1803df08f44-6f6e47e868cmr69531506d6.25.1746824039122;
        Fri, 09 May 2025 13:53:59 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net ([74.15.46.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a472easm18439646d6.86.2025.05.09.13.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 13:53:58 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	sanchayan@asymptotic.io
Subject: [PATCH BlueZ] shared/asha: Fix bad parens in a comparison
Date: Fri,  9 May 2025 16:53:41 -0400
Message-ID: <20250509205341.557936-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last parameter to the memcmp was incorrectly the result of the
comparison rather than the sizeof()'s value.
---
 src/shared/asha.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index 3e1673488..69906fcc5 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -348,7 +348,7 @@ static void check_probe_done(struct bt_asha *asha)
 
 	/* Once we have ROPs & PSM, we should be good to go */
 	if (asha->psm == 0 || memcmp(asha->hisyncid, zeroes,
-					sizeof(zeroes) == 0))
+					sizeof(zeroes)) == 0)
 		return;
 
 	if (asha->attach_cb) {
-- 
2.49.0

