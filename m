Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55522D4F9
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591568; cv=none; b=CbXcikioN1lP0pGBJzIq+Iu1WOCvqOhfZ9+G9bkxiJYQ9iArJpFt+Vc3iw3ktvHR+SaRK3rDynm7kfShGDRf8g8laCZVIVcsvIiFSw+qCkDoSoqHUL0Xk1Ypmx6v6DBRX+eSD1iNw0EjYQt+lFC3gn3NudM2eAWU9g79H7cDx8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591568; c=relaxed/simple;
	bh=YnvrGlk09tfm0i/m266s30sVQftqw/YJCHYafg41Q/k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=clNScIdMLuHtuh8p61C36+RPd7g5xq+RfAErIJOWsJ5yTzWrkJL6tvo/iCh7bwB9JrQMBErFeMUmeRyNdTtExgmVFjC64qYjLjadrhb7KwU+YBV8Heaq8f4xx1KSgPnD3eiF0Hm9z168zYWmd+ZOeTMJC21nABrZsO/wSlXAsHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsD1UjuE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsD1UjuE"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223fb0f619dso53211885ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742591566; x=1743196366; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PwMPrfKQiSHZf9nKzisknLZJ2gqWHEt5naczaFyLA/o=;
        b=HsD1UjuEtDuU2GbdJeLdCbr/8U2M6NmvZ8r/Z3Z/mNBu8F7ml3bB7ypmNqSr2cEms3
         US0gGln8sCpdIW51qhPxXKFBqkJZY8lR0LxDXUd1J9WaY8RkUTRd8SITvyuY8Ryj+qnG
         7LiTZngfv0fIp5CMejegIdb+xWamSGo/fyxs9C+/jejk3+tdUp7V9n9o3ot2CCc9ZrYY
         3ZRDB5suEZN4CAER7fvUgs2Y8X5yrcBxQD2RxNzMkoo0yCDBGe2TsYY3EaY+SyttdpTO
         fDjeGjzr9N0R63iWZ+6VQCFM8iz4BK6IxC0ECgt2Xb5y2+vJjIlJ3PrJdqCswE7Aqtrp
         zg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591566; x=1743196366;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwMPrfKQiSHZf9nKzisknLZJ2gqWHEt5naczaFyLA/o=;
        b=sC7qCMSyIZQmXCqU8zOkRgmNW06C8DPuKOdnyc2SlYjOlqWPRANoLBNESGzjkJHM7z
         bkSRDVsTZIzmSGrqvSRtxA+z9f1WNZlOPN2eS3KwriQlfe+j8eXMkXYdtd/EY10gOvUx
         UQOYmMUQuhglh91KBKMNQY0WI4/SwPpI9htdD1tME1U7xSLIuWq8BW0mLK2r4QO1zQY9
         PTTqgrLLBPlEpWAO7orzCs32fPy8uwlK4msTXQ7zLSt90aDP4c8emLde+nlLFmk84REJ
         GLEUkNfbhVStotoVj5WWk3VD8jyqb8ma85ZNhDcgLsvDZ0K1p5FEiFpOtBA2pCoXCtvJ
         JdBg==
X-Gm-Message-State: AOJu0YzP9vPI22oekvdT413LCg5blR6lL6/cyRTurvjKwGCmOo8CiAV4
	GbgcifNHMLZyewShtZdnjT1crqOylMMM+AvVlWAbziHwdaBO8XIFtiweYw==
X-Gm-Gg: ASbGncufz3wVK39icxVyDMrV2kcpk2UAYftJscs5RM+tiw/yL0vpgBDHkADyLDhmQay
	vprKikt9sASLcd3Miz1ZS0ha6RiHtf8CzgWPCyHEyVmSkgsoRc/0mAjVOARYKlW2JV4s6ELuSCL
	4VgY7rCFDoj//lYwbMtjNOPGuvthqleP7dF5z5jUBu+byRnJR3sYCir1FjmlL+bxIm6GVDJawL6
	AZcpjuGDf+eZKCmVzGiZOMaJOCgFBBRhV6gvB/v4t3XeYflqcHeWQd6T8p2bB+7r9FyP1q7HuYf
	QDQbuSnSXgI/XJknbT7wuYpGV5SWlV5oA9HTCio8E+zSStWNbSU=
X-Google-Smtp-Source: AGHT+IHYhTAZF7MTbpjTEFBvBigh/KW2kYNsOajfhrqCuPPyiztjDrN1NdRH8MdhX1rSTInEsE0qxg==
X-Received: by 2002:a17:902:d488:b0:21a:8300:b9ce with SMTP id d9443c01a7336-22780e2a48bmr64545145ad.49.1742591565803;
        Fri, 21 Mar 2025 14:12:45 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.47.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45e67sm22409295ad.91.2025.03.21.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:12:45 -0700 (PDT)
Message-ID: <67ddd64d.170a0220.1fc66.9334@mx.google.com>
Date: Fri, 21 Mar 2025 14:12:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8867277845422240604=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] mgmt-api: Add missing Device Flag
In-Reply-To: <20250321194545.1728631-1-luiz.dentz@gmail.com>
References: <20250321194545.1728631-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8867277845422240604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=946404

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      21.25 seconds
BluezMake                     PASS      1542.58 seconds
MakeCheck                     PASS      13.57 seconds
MakeDistcheck                 PASS      161.48 seconds
CheckValgrind                 PASS      213.63 seconds
CheckSmatch                   PASS      284.50 seconds
bluezmakeextell               PASS      98.57 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      871.05 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8867277845422240604==--
