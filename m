Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13751AC43E
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429853; cv=none; b=Ee1xOlPTSLAA/VurbFbwTUweclJR7oMVvttfQiTsrKMkmIqZrZ1aHkxsvK53Q4mfQGbMdEsxyGZ/ulvfifDU2+IW8PgRzZdPMB8dmRqa3SSA3Q4ewIpVAA4VV0ky1jMajsOr3rXU2M2+iVT0RuyE2a1W5i2KN/3tZCbfMvumOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429853; c=relaxed/simple;
	bh=ocoxxso9K1uUh8fyrN+4h8iLTidDhYwo6krqFTHzbgQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BbLi5yzeOXzXh4w70L61sUeKhiT7ZXh+MawfZEm8SrqFgLbVzOzED7+mKy88zJepkL/9plwgxHyDLuS3XGLdMI7hQjz7PPo1qTfkm+5i3wKcIyWrq9RTzrGcPjKJLnKjGb5LZOQd1q+7dFE4HoC9KAaTx/Dmc4hzCo9gU0wjoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KB0YAjUG; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB0YAjUG"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5c691c6788eso2986561eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722429851; x=1723034651; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VbOltmIy3N9GbDsshWu6jjpHoe7WYZIEpZ7g/3awDYk=;
        b=KB0YAjUG1ljqQHizq8XDgffU2IJ6yvDhwP1ldfiQuyy+ZT9jBh/4vouaX8db2323Wy
         foeS1O7KH2MeobriS/cSjnmhWvP/O86SKWmyaxUbaRks6ndRIEzqxQNw+q2SdJbhuQuo
         96EtyVNoNtEthGW34nm9eSbcE21lP/Ua5pNQ2dBc/0zH24+AEVfKjWyFP+e3fwvGglZf
         zFb2/qRV7phCvS37o8CgPoOEk/aSwqBcxmQAWBlxKIe3EwU0xkuK0CYhgswtcjC5ffI9
         AihsJYRQQsniEU2x+BGO1JTqTMl1Fvz9fGTEP3COFQSgcCjfW3lqFuhCMO2msh1ceLAy
         ywFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429851; x=1723034651;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbOltmIy3N9GbDsshWu6jjpHoe7WYZIEpZ7g/3awDYk=;
        b=e7otHFHg1I/usw7ObHfW6dJyA0luN8OY5dxmtUR6XvKgtC9JXDnYkKzjzKKJE6Kwa5
         yigfp6RUvtaTREF55Z6YH9mERC7gymXuDWdKYRu//WXMDW7TGy3waC40PWzTL6ZvG6CP
         GeV/BQwF/HX5UZMeR1qaOGfooALz6TKAdSHfZDzsamvciCOcWd8vfUHyw8T3qodL0/A9
         EsKQyZzoSB3OW6x5M/WD2rtgDJbSWYhVzdzsmPPweOUzU6QDuU22bgUz5AsutfumlyZP
         nFzRwavodt/FZmz8LWABvckxm4bwkYVYN/9nT+BUVBqMkPWT6XVd0Touky3ZkI6Pww4G
         21Hw==
X-Gm-Message-State: AOJu0YxVMjdXT3hMBrZsXZkXbT554X+8BLYy/g8tIPys95q5aoCJwFAQ
	ei1z7DflBqboSALiGFbOz45F6m+nvZOZGaVyx6f+CbsSjaSAMTYYnR9Kjw==
X-Google-Smtp-Source: AGHT+IGlVEN64MIO4O7QUAQTVQ1tC1RM7Ps131kOZFgBy2SoGE4XhlHr20pknRW9IHBbP7AKjvdQTg==
X-Received: by 2002:a05:6358:b107:b0:1aa:d6fe:f3fc with SMTP id e5c5f4694b2df-1adc06d84d2mr2323707355d.19.1722429850686;
        Wed, 31 Jul 2024 05:44:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.126.47])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8db6a0sm73115466d6.10.2024.07.31.05.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:44:10 -0700 (PDT)
Message-ID: <66aa319a.050a0220.bec44.70f7@mx.google.com>
Date: Wed, 31 Jul 2024 05:44:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0072335087479939134=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: btusb: Add RTL8852BE device 0489:e123 to device tables
In-Reply-To: <20240731121314.3738700-1-hildawu@realtek.com>
References: <20240731121314.3738700-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0072335087479939134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875454

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.34 seconds
BuildKernel                   PASS      29.89 seconds
CheckAllWarning               PASS      32.30 seconds
CheckSparse                   PASS      38.12 seconds
CheckSmatch                   PASS      102.54 seconds
BuildKernel32                 PASS      29.10 seconds
TestRunnerSetup               PASS      529.58 seconds
TestRunner_l2cap-tester       PASS      24.29 seconds
TestRunner_iso-tester         PASS      37.81 seconds
TestRunner_bnep-tester        PASS      5.04 seconds
TestRunner_mgmt-tester        PASS      113.61 seconds
TestRunner_rfcomm-tester      PASS      7.73 seconds
TestRunner_sco-tester         PASS      15.29 seconds
TestRunner_ioctl-tester       PASS      8.19 seconds
TestRunner_mesh-tester        PASS      6.30 seconds
TestRunner_smp-tester         PASS      7.23 seconds
TestRunner_userchan-tester    PASS      5.38 seconds
IncrementalBuild              PASS      28.34 seconds



---
Regards,
Linux Bluetooth


--===============0072335087479939134==--
