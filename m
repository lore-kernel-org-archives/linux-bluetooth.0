Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACED282E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT+oi62i"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd562d17dcso426190b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 10:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704997829; x=1705602629; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=88Ttj1Tkkbhuu5BzP3d/3TH3k+UeWRCivqgt8IWxoZs=;
        b=fT+oi62ipP3gt9/xd6+tKow2Jf5DueA2wkyC4w33GNP4E477nIAgu8zlYHCYqOi5dW
         zyfDtJAvv+qpL/gZFoN0RRUTbYsmtdtvsmM78PRgxYFGOdRwK3ouGjBADchvapjKQ2MB
         DxlLVGLNQdCOaXQa/b2VKfBZJymyLZqp4DRjHpFaJXkPQ5e80tNJc6Hbqdsfd6sJdzEh
         DcB/tj+zJ4dsfUyRfkcVr9Ov5x62Y/hfTiLmblVEMkjSMF68jSs0bcRD9PRwfuL2yOm/
         4cpytrnnJyIF2X/o5rXXLjgMVwmS3XwmCr18eHujQDiVktqLyEtfDn9H4jwYZgbU8TEX
         jE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704997829; x=1705602629;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88Ttj1Tkkbhuu5BzP3d/3TH3k+UeWRCivqgt8IWxoZs=;
        b=KybMzuPcXkgyqo1OT5Wj+hFj9gIvoZyXhE4YTdw5UPMsJbIdQ0TWxpfleqNz66nXxZ
         BS9prON6xpmVMYrPjM+l6lYj8o1DZBMlcEeZ+G8PNbQ8Emm5aS5v+smy5POSYnZRdPkD
         qHMYGYETuDHWLBuCpzdKNCXcefvVHuT4EhiM/mu/mo7RaguaAwV0I6U56BzzQoKZbUr1
         6KzV3JYaPpZDc0ugMdCzTl9bz5mVWiSRfQzcAIVCAQhnfOe3A4Pi2h0L5K9a5yk9FAib
         fPcvXF7gx/a7FefCeAy42LQlLFL6vabVzIjH9br6W5fxijGIWgzO8DfSXD4fjdKCUbq6
         6x3Q==
X-Gm-Message-State: AOJu0Yz+xUpedGpMkR7hPsyfx7f3XQYpqtVgdBsX03P9CdGKVmCs0pad
	3ZYy6FhBrGQytVEXMmOE4pvXeB+wMVs=
X-Google-Smtp-Source: AGHT+IGGkJar75vSEO1LJcZPDyXYENE2oiNj+IiLlhQTvCNxXeV2hdT6LM47gfbOSOpbnZDR+29J2Q==
X-Received: by 2002:a05:6808:1494:b0:3bc:398d:9e2c with SMTP id e20-20020a056808149400b003bc398d9e2cmr110563oiw.66.1704997829115;
        Thu, 11 Jan 2024 10:30:29 -0800 (PST)
Received: from [172.17.0.2] ([20.102.46.147])
        by smtp.gmail.com with ESMTPSA id e1-20020ad44421000000b00680b31f81a3sm473399qvt.39.2024.01.11.10.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 10:30:28 -0800 (PST)
Message-ID: <65a033c4.d40a0220.e989d.2c10@mx.google.com>
Date: Thu, 11 Jan 2024 10:30:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7175187589817592243=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [BlueZ,v1] avdtp: Fix potential incorrect transaction label
In-Reply-To: <20240111171635.144825-1-xiaokeqinhealth@126.com>
References: <20240111171635.144825-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7175187589817592243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=816255

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.49 seconds
BluezMake                     PASS      732.00 seconds
MakeCheck                     PASS      11.79 seconds
MakeDistcheck                 PASS      163.58 seconds
CheckValgrind                 PASS      225.66 seconds
CheckSmatch                   PASS      326.05 seconds
bluezmakeextell               PASS      107.87 seconds
IncrementalBuild              PASS      698.58 seconds
ScanBuild                     PASS      923.35 seconds



---
Regards,
Linux Bluetooth


--===============7175187589817592243==--
