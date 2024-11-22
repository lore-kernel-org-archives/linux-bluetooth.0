Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98E9BA20;
	Fri, 22 Nov 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283991; cv=none; b=ctHuAlqE8tmY8v+8G0sUAp5vh1muhTAifbq7G0MbCGBsq2hkxrmUwwT34ub1LFlCueqC/ISO8mOSMiG0Pnnnf8pVzrsHAg9oJHFcNdIbrocockeRmp/udqVrwQwTFNy+bIxxIDwgkuAYeG3SHpm0lYqG1CqKzzijmgp+du0l26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283991; c=relaxed/simple;
	bh=TwaPM4jIKoOVtLWxJIV9PGeLmcYKX3ahSJ6uIW+w0FE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jl3i5hgOpGfypGIEUIjAvTUVAoiV+1is/uggQCS4Oyo8rY14EbeYHQ2rwrzFTbuNxQoY05sl4K9dkvxJLCqVYbA6pgD9S941XtdzioI0tcmi7+3yjhf9wee2YKlDiQi86Nf/5wW8OYgJXmyNovLBA/6Uhqtr8RuUw5QTP+v8UOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZlurkJz; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZlurkJz"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2965e65ce89so1413721fac.3;
        Fri, 22 Nov 2024 05:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732283989; x=1732888789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOzcwXcalhod32cmc84xJL2cjjIFVhql6XvOAWQZepY=;
        b=OZlurkJzh2cdeNhiBD0IyIdbApq8STAiwUhCOasC1Y4J3D5CVyRxRKOadIs6FwP4bo
         efoCzCdlIPHSvsbFNt8/z9JA18J2HPW/jZvG6LiPIdnIvm9QFE5EfKjEj5hrRkxJeKMi
         DVcKf0rt4Qy+J5O3xjO0g2zyXA87I6JzP4tJ1XIkQmE9RLgH0DjLqBJt5OwZIAtoKjiS
         73c3C/tZTZVV7DWKdRxGVA5WstUj5htIDljOj4jjK0W9p8aRI8rIvn5TSkrPKXCbnl8i
         bu6WHqHPwiZOOj+idrhcjPA1iD2ImzRwmeYAV3qFRZnR1qanZg73EMPKROHqnpVn26eK
         X/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732283989; x=1732888789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOzcwXcalhod32cmc84xJL2cjjIFVhql6XvOAWQZepY=;
        b=r5h8BEMvORoVoADCB7sE8PTqlWKVkn3bw7QA2ubMg396ctDh0cZfMc8tOgR4QF+3ci
         WX0mk474tCwRvwDsXsKj7G9a2vT7NllQ+oh+HEGHI1S0dEZk82DUhHXLOsoKnO8xTUiO
         NZehj1MRCXzPrffI/A/LSRYoEmqtx3/6G5eKsQHJib+wDEeXjKscrO0miEDsfs5EcOJr
         W7viYEH0LolQWugGO0JgkulXRW+7+9shN7V22erzcJjey8fwFCdajVqhcaY5BrYN73s1
         9v5a4iDjqgoevQxouxa/DQ4mCxHjh8EMgDahOsc9j8XhZp7zFh5oNUusgU7ujpZepvlh
         jXkg==
X-Forwarded-Encrypted: i=1; AJvYcCVhmxhU/uDZpKahPtw2Itn8fUJ1tLjk6m6sV+kFXYmyP8LpqUjkEMhQZO2LaEVMKmRaUFSj+0wrMI9mYweOWg0=@vger.kernel.org, AJvYcCXc7Vyd4LVyKd4nfkOcrw3dCxeJTU9DP0RQ1Oe5R3dIc0/+78XSkAPwXRn4MbsrRKkAr5Md6HNW1Wt9L619@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+i7WcMXKpmc8GsnLqx+VmW2wkgK0WUCAUupFVmIb/MDGQwyU
	M2YBMc6oA+kpTnmnomXZucKquNPbxFi4+RzazIJIVaOJc12CcsJU
X-Gm-Gg: ASbGncsyQdzIuBpk21uL7ctr7GHq4IB8sTOOrf8J9qQOCKfB+o24BPPafL5A3v30O4n
	4zcF+3sxX46thYJR45r5FuV/x5vyQtBlvJZEN9U1q7SUmp7Gf76RD0PinuYR6F3NglupiquT6C2
	qp65rVxKSXdOhiG2wy5uiXy2xDSerL/ul44rao84Z8TdWEQi2nUOML3DQdsURbrbtjK3Q6l+KKR
	XJcZINSUa/SayjvGvBmM/7KyPhuFWFY5NUeWaD7m43kvmKwWWHft8eHZE3aRNIm
X-Google-Smtp-Source: AGHT+IFQFSVRu+wDPQgYpx1TU6z+L0eIhB/2YhP/jdm1pO7Zw09B6MplcxZqC+X81NdVr4OpEWq2YQ==
X-Received: by 2002:a05:6871:4398:b0:296:e288:6567 with SMTP id 586e51a60fabf-29720ad6360mr3053873fac.1.1732283988772;
        Fri, 22 Nov 2024 05:59:48 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:885d:a03e:b4c3:3076])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3f8c2fsm1645303a12.75.2024.11.22.05.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:59:48 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] Bluetooth: btnxpuart: Switch to SYSTEM_SLEEP_PM_OPS
Date: Fri, 22 Nov 2024 10:59:39 -0300
Message-Id: <20241122135939.337327-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Replace SET_SYSTEM_SLEEP_PM_OPS() with its modern SYSTEM_SLEEP_PM_OPS()
alternative.

The combined usage of pm_sleep_ptr() and SYSTEM_SLEEP_PM_OPS() allows
the compiler to evaluate if the suspend/resume() functions
are used at build time or are simply dead code.

This allows removing the CONFIG_PM_SLEEP ifdefery from the
suspend/resume() functions.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/bluetooth/btnxpuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 569f5b7d6e46..06c1093c70ab 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1588,7 +1588,6 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	hci_free_dev(hdev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int nxp_serdev_suspend(struct device *dev)
 {
 	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
@@ -1606,7 +1605,6 @@ static int nxp_serdev_resume(struct device *dev)
 	ps_control(psdata->hdev, PS_STATE_AWAKE);
 	return 0;
 }
-#endif
 
 static struct btnxpuart_data w8987_data __maybe_unused = {
 	.helper_fw_name = NULL,
@@ -1628,7 +1626,7 @@ static const struct of_device_id nxpuart_of_match_table[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, nxpuart_of_match_table);
 
 static const struct dev_pm_ops nxp_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(nxp_serdev_suspend, nxp_serdev_resume)
+	SYSTEM_SLEEP_PM_OPS(nxp_serdev_suspend, nxp_serdev_resume)
 };
 
 static struct serdev_device_driver nxp_serdev_driver = {
@@ -1637,7 +1635,7 @@ static struct serdev_device_driver nxp_serdev_driver = {
 	.driver = {
 		.name = "btnxpuart",
 		.of_match_table = of_match_ptr(nxpuart_of_match_table),
-		.pm = &nxp_pm_ops,
+		.pm = pm_sleep_ptr(&nxp_pm_ops),
 	},
 };
 
-- 
2.34.1

