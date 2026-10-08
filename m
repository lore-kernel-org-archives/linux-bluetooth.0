Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADE3B05B2
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480989; cv=none; b=uo3JMvkVBsSiwtrHKHRg/iT7tjCesRURjPbGjdM9MU8jloCgMYxIWh9otri/eUaG1ojULSpIfmwyYTROgVwC3NFc33OtTfHt+HyqIJDyJo/eKOZW21ozhM37mxs9SIBDM9Bh2GH39clz73OlCge9npFh9mzWFu3inm4/LKqbXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480989; c=relaxed/simple;
	bh=oTazQo6njsVVkFrAnphbMYRtCfSEuu2sR7vM3Hmzyss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5DHAQY16BEGsSiYJRvfJofcRyBZluWDCBdVJ7/Ys2pC4g5cdPHayi2PWS64xSlqinRjDStKAFfX2sjqqnHltIWjN+ZkY1MxjWuVW+eUlrO22uBdL5uo1I00yMe48rm9Ie+gpiProRrg0JALkDeng6f/HRLc+sbK3jQ6rr/uWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=DFe+7PEY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="DFe+7PEY"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e5f819884so371679185a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791480988; x=1792085788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08otWKCGADwAkFvqlbnOe0pVZ4Pj8UB4gMnmxoIibMY=;
        b=DFe+7PEYx0biroRekaYPrggsNCM7GzxIYU2DV1PgI3Ci2Jj5F+Z/tIrazHzAs8jY6U
         JBGwNLR7BxhZVFVVTRj8UUr2nlOEv1PWKZSUNbUFH2BURrCFz9reysdZr5RFznEziC6K
         7LfS4VZZPrcaHWWvV/l0Jw2ocgo8mSos6pPHFnFehZJ3fZ7bgJaykRRayTDK+xXfYYaS
         lOACdhV9eeABDzL+sCvPdyxKwTX0DAKIUrSmgneoT+d1hQF+W8aCUMYvyQ23d8qOK3gp
         xBHX4Ftp7/ptJDYOsnNVZC7cTdW+06poJMEwRWHCEzWH3Mlc8XawYuEMcG+XvXp2ZOGR
         UY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791480988; x=1792085788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=08otWKCGADwAkFvqlbnOe0pVZ4Pj8UB4gMnmxoIibMY=;
        b=wco2J83p9noOFmcCTA1Vg50NyZzAgQyC7r56yrM6xbWuJtDpMdW0HqwQn4QVmFMWpO
         rhJ68WBxumtJIPNA0ieDO2yuB6aTw9+kgViqAIcg1uxPVL0MJ0UTDY/DZIijNX/b9cVY
         DFac1zM/1B0wqftv0B5FRf1h8MedxdKQIIIroHJ3lrsfAgQRGaJI9ZtceZBOQg0Q1y5Y
         9xFuogHJv9Wofjt6QXNtPfI/3+QPy7GVssctotcEE1pwIRpbs40M/dlh5jqGrAW1Wi/W
         TbogZr09O7sEywcPTbFFBMQk6P+h6YxImZ7kcF2L+4UYkpBr7F5ZBvVZW0jyQrJyoYaY
         fMNw==
X-Gm-Message-State: AFuF++m5FacQrG+vA81s9Ga9I1TDSmT1sd7a+ALlS4booq79I8aIjeXr
	HyoYvLZrEOEK2FnEbv7B2rJCZ1NWOJcv4+OlwHDVXayXQrGqwn90xFU8A2uvh5wPc4wYGA64wXw
	uCyD5
X-Gm-Gg: AYBFou2WjkowqeMHxjtti8KNbVZEmWubT6pSsb4mvim6AmVkDQJ0D27AX/ygRVSA/Hu
	ZNnYLwv9VjQdjb6R2P6fRUS1OKy+MALlJvmc39NA+LEpy7tfpjr+PyBnug1DJ9dbPtFO7esJrw9
	qmMhNAE+enFbACLpEgUSoNebJmUgXWrbymYGkJv5hpxNSRpKGyWBds+hCmhaM1QU9kCe6O8kkeB
	vZ9mMswoM/KSeXJ3yTK/atslKDauHRVOcE4zf/rdrgmMw+0uVBe0GLbk1GSkA4n5n8or1sZkcoR
	Whq7agPrNfgK2JwWyz8S7vOIK+WO3YwEabFw4tefxhrTFmofLMrXPtDP5CbPOJmHpG0HzgH+dYw
	0w6xJssFYj9NVvtKv0A21PmByFiYUefQwCZib1r8aZ0qGKuxmA3XB3Ci0AiO4U3S3J2y4Rij5yv
	XoFKAVlCmD4129nJY15PJ8aY+ldR7fdkUJ0Ci3cxFDXvCId1lmqtHxtsDazyl8UlNMchUgK0aYv
	+UXqGa/7BaSks1R+XWYnkeOOjvRZboMKyc45fsDjt4OdU6cjknLklCF03u2xZqqlA7Yrsrrqxm2
	bqW5N5O/PXNypQyJyZ/CPF2LIrSqqaYFxpW7kkOE
X-Received: by 2002:a05:7300:3091:b0:351:bb8f:540c with SMTP id 5a478bee46e88-351bb8f5614mr4034715eec.35.1791480611333;
        Thu, 08 Oct 2026 10:30:11 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3535f385672sm41804eec.0.2026.10.08.10.30.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 10:30:10 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 3/3] client: Print LE.Role in info
Date: Thu,  8 Oct 2026 10:30:00 -0700
Message-ID: <20261008173000.3615-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008173000.3615-1-kevin@simpleble.org>
References: <20261008173000.3615-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prints the Role property of the LE bearer with the likes of info
command:

bluetoothctl> info <addr>
...
        LE.Connected: yes
        LE.Connectable: yes
        LE.Role: central

Assisted-by: Claude:claude-opus-5.5
---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index f5fdd7d12..d2d25b9f4 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2097,6 +2097,7 @@ static void cmd_info(int argc, char *argv[])
 		print_property_with_label(bearer, "Connected", "LE.Connected");
 		print_property_with_label(bearer, "Connectable",
 							"LE.Connectable");
+		print_property_with_label(bearer, "Role", "LE.Role");
 	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-- 
2.54.0 (Apple Git-157)

