Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173032DFA20
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753706; cv=none; b=A2Og9cAJJM+zQN92pwL/+xyW+FlulHZSFK0svAb/yTIpgaiy4u1aanva2H7QRB4XM0GMEoBA3ddhjq7vVWJ16udOLpbFLKymhiCm0VRIGnJrWmUFgENWzFkJmZvFLbe93PXHDPrh4DtYSVyJ72vwcA93I02WgMUMYm3RS7y0JKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753706; c=relaxed/simple;
	bh=L3JCkH3UOERCddVJK7QZMFBci/1m6FwhSUZ3on3hKJg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeLp0eB/fBt0fn3F7GjzFE0ajH1bdk9A0RGEE2oLb7nQm4TPXqKxyjeVT2fHKkmuHCRR9rMTeaJV1viDmzwR6++uU/ehaRVuABk3OKOqSDM09AM5edzeHxmuLmukPphQyqwJEEaN6roIhAkzEV69Cg2cAU3euBdyV5xWqLkuOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUzOSM8B; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUzOSM8B"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-528ce9731dbso884407e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744753703; x=1745358503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuX4QN1XO5qkD+Mq8ZB4etY5v24jEcjvNl1G0WRpx40=;
        b=WUzOSM8B7UQvI4XEiiRwTu5yQeX8EYkOjiU2WWQGU+x7v0Ma7CbbLWzkWh7S/beTWD
         0GAnds3+9ogqrhao6dc7cn8re0Ih5cGrumrRZTRIXY731Q4rt+uivPM7vGs0AvwZgYX3
         z7ImDEomz/xev/7Y0C6z4eBeLH6yHUVjToRszdefNKPbwjZEaoNWwq6Z3Shos6BGMd0f
         31H+3TLJtvMcB/UygUPN4hNe6nilJDAegbBVCXMG37vnSo4kgu7cHVVoeoM4GPGbHV5T
         3MAiDKN+otesraVOU5x0FjyHFgU0QLWZEJznaUKSc0k7auHFcLSxiMWf+ix832ob7aA3
         MBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744753703; x=1745358503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuX4QN1XO5qkD+Mq8ZB4etY5v24jEcjvNl1G0WRpx40=;
        b=la/N0Xv7Hd5tLeDFzVh+66NPw7+AVYSL6xscDRYtA7SfO6yOO5ylITQhuOJZTZjm5W
         nFDem5utnrFTkgmUQ+iq4vn/TvxV+L5q105VcfFDyAgwgKRDgy0EHnJaM92M0PdKp/jg
         +9r88YcbhWoJ9FIk8jk+HI/FArUVn+XiGo6GkPa+Xt9HwL3k08GcBmlIE+w8tQkQoByq
         lTBs9o+MhH/Ky7B9gVNm83sHsUQNv3sfPl/8BDSf19vWiEW0gIe8+WRBxx0Fn5i2vdiy
         Wacn8tDeL1PtEH+42+ewdBR+6Y1+heiR6O0nII0neBfSpCVEv6QKrLQ57WmqkqBJhuXp
         bCuQ==
X-Gm-Message-State: AOJu0Yzn2ZmdUHGSYa1jAC0aOt7gjZsVmkFr2PlOQl2oVPAo8wxd5H+7
	4qOJaLyh/8dVa6f+iDIk1Eou8T0FuOzWeOalOmrYOSfu1DMSvch3FuR85yEzoNM=
X-Gm-Gg: ASbGncv3ZoXWNWSvEphq2GZOjqCOOjAMjqxDxyi4ERgNV88Cqg7Q4DTV9FZWRGYnDVy
	K3ldBeyIotM9H5wSVUm6cIrtBXek4+PnqcgrRs5sTOFSaYaZ23xVLYUAjo/VOiON2Xtnlp+HfZj
	EYqju3afrt87oyIR+9ayf1OAzz7w+klbr0QOFkWMmTfNp9o8qJQGS6K/aFwiHy1VM0oExJ6Rxmn
	QDZhaW8Yg/zeanLOX2pD0WQnfid1vwrkQ+K3gbMFi3ZqKwyNcRSTEdWyPSZJ218KM5FkJ1p5PrL
	9cGafdFD7/fHo96pl6byS0xSznMDCGVluWLuiKdvjItUHlhTJLwfEEVhdmDSd2AhdGKxzWZrbft
	eBIXrFNckhA==
X-Google-Smtp-Source: AGHT+IHTgK70cNa1O/BlXSFEEZw8Sv2cI0O2E5xGDBVr4kVrNU7IUIGsx2DvvERlBNOy9FJ0bgwX9g==
X-Received: by 2002:a05:6122:a1b:b0:516:230b:eec with SMTP id 71dfb90a1353d-5290919c84bmr839980e0c.5.1744753703258;
        Tue, 15 Apr 2025 14:48:23 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d740sm2844459e0c.33.2025.04.15.14.48.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 14:48:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/7] iso-tester: Test getpeername return SID
Date: Tue, 15 Apr 2025 17:48:08 -0400
Message-ID: <20250415214811.1677842-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415214811.1677842-1-luiz.dentz@gmail.com>
References: <20250415214811.1677842-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If test is not setting a valid SID (0xff) use getpeername to validate
the SID gets updated.
---
 tools/iso-tester.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index b362647461c3..63f6951e3d0a 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -2575,6 +2575,40 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
+	if (isodata->sid == 0xff) {
+		struct {
+			struct sockaddr_iso iso;
+			struct sockaddr_iso_bc bc;
+		} addr;
+		socklen_t olen;
+
+		olen = sizeof(addr);
+
+		memset(&addr, 0, olen);
+		if (getpeername(sk, (void *)&addr, &olen) < 0) {
+			tester_warn("getpeername: %s (%d)",
+					strerror(errno), errno);
+			data->step = 0;
+			tester_test_failed();
+			return FALSE;
+		}
+
+		if (olen != sizeof(addr)) {
+			tester_warn("getpeername: olen %d != %zu sizeof(addr)",
+					olen, sizeof(addr));
+			data->step = 0;
+			tester_test_failed();
+			return FALSE;
+		}
+
+		if (addr.bc.bc_sid > 0x0f) {
+			tester_warn("Invalid SID: %d", addr.bc.bc_sid);
+			data->step = 0;
+			tester_test_failed();
+			return FALSE;
+		}
+	}
+
 	len = sizeof(sk_err);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
-- 
2.49.0

