Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFEF18EA0
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcIP/tmQ"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-781e947b1aeso18842385a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 03:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704281382; x=1704886182; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jdx0K9zhkd6G6N+7aygh8PVbzVzpwHXo2T/NY2uUWIc=;
        b=jcIP/tmQ93UgHSEGHFOV38dyYAlgM6mbcniVS/jXwJd7qrrh6T0j8j0HH1L4DfKwnr
         lf4hC1FmXzhLRNJq3GcW4EL/Z+CfmK2Ox/c6aJAiUnCt4bmily16BTu8uT0rHeNSZH6J
         DonBKjx78/TWjqDyXfDbkSbql8bPudkg27cuEUsGK9DegX0jF4M3JiQtgjuBTNhUwkEb
         KqS9lI5MITWzXAOwfeMYHlqkxFATMAolTxj2LaMKfJB3Bo2ruU7nFnoZPwLYFFnZCn9x
         jZzYO1YNPG9KvMJOPqZVRdET3uK7utSPFdTZrLONXgHHLUr2z6c+ZKGHtUOpwUBTT5ZC
         1BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704281382; x=1704886182;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdx0K9zhkd6G6N+7aygh8PVbzVzpwHXo2T/NY2uUWIc=;
        b=Sjt+DgM5goKqRK3lxMGKh1skKTPjwvJwd/j7JV+m+FWG9Y78Iy8AJAPisnysB6kogL
         96P3UJu1POlbPIDip5CLVouvREd+kjdMlby86doeAYzEI0JJVvReqKaZuBu6gHT7mOkt
         2qmmxWZLcQxemyKrNVx9s+JM016hVovKB0nT56cevB5rDcNHrahn9V4y9/dxsbuN0+6k
         FiBkeLyjsCefuBWGfJyXGsT6jo4+LJkGPdZWGSsh9HCVHxVeiEjaWhowWwKFtkGi58cS
         /hrYl9RmNipSjFzmCh7YFOC/EVEt1IuTgJHnQwCdbUeN2UKED0ZkWCTdgawpvNaP5PkZ
         a6gQ==
X-Gm-Message-State: AOJu0YwLdy47ftyA/kuBwDtBeJ9UR49GTm05RbwT7ZP01Y/defvMRZ3Y
	5uEtyjwgjogv3Wh2w/k5ZG9AilXNjx0=
X-Google-Smtp-Source: AGHT+IEf02g5kMkrV8tYyYug96BpdXTI9W17C313HBo/3zwhmhCHmvtjkQpOnOfTKPvWYcKwGFgE5A==
X-Received: by 2002:a05:620a:6221:b0:781:5532:efc1 with SMTP id ou33-20020a05620a622100b007815532efc1mr9487206qkn.106.1704281381716;
        Wed, 03 Jan 2024 03:29:41 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.47])
        by smtp.gmail.com with ESMTPSA id f21-20020ae9ea15000000b00781706e2f7asm4880556qkg.67.2024.01.03.03.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 03:29:41 -0800 (PST)
Message-ID: <65954525.e90a0220.47e58.cfec@mx.google.com>
Date: Wed, 03 Jan 2024 03:29:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5841978930414361080=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: [BlueZ] adapter: Fix airpod device pair fail
In-Reply-To: <20240103101328.1812899-1-clancy_shang@163.com>
References: <20240103101328.1812899-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5841978930414361080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814046

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      23.76 seconds
BluezMake                     PASS      687.48 seconds
MakeCheck                     PASS      12.14 seconds
MakeDistcheck                 PASS      158.97 seconds
CheckValgrind                 PASS      221.26 seconds
CheckSmatch                   PASS      325.52 seconds
bluezmakeextell               PASS      105.98 seconds
IncrementalBuild              PASS      643.72 seconds
ScanBuild                     PASS      933.53 seconds



---
Regards,
Linux Bluetooth


--===============5841978930414361080==--
