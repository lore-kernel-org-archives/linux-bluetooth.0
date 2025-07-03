Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3602F533B
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569405; cv=none; b=U5+IbW7tdj0d8EUgqiqyn2C6kEJgv2MXZw6Gf1Ctp9FKvWPltZCR+s5TCn6YHleFZMBUSRxWfWL6xSkcrqXvsB3NuI9fXhKhLXw+q7VzrNusv9Et5O5WmqbCyiN1NmdP1gGetuvaL95OFF2trCRSLHbQOr6nOgZSyCj5JctOvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569405; c=relaxed/simple;
	bh=OrtaYELYB1b6Xgbm/abA8z/xCbqPoFrG2gwS+HBxSjs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VXVbDQzN9FrA5Jl3sqke69E870NIazNKJNWk03RPlkiisBqyHR8+49FLSA4x1NgFtf8KFx2nGKLy/GzxWB2NzxkivJwy6dqfku4MnLS656QBI9kv0GVQWbeAEH6UuhuyFG0fzHLaJoZevfxzNuA8QGo96MUUGYl5bB6HSBMyF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxJPSqi2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxJPSqi2"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d425fc4e5fso20834785a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751569403; x=1752174203; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IZruvFWA1tELco7cKvVPmN0vlDW0f0gci6KUr+G37PI=;
        b=AxJPSqi2oM6szX6JKWY7jVa1doE9SNxpa9KuF5R/jvuPUEyhpatyWHts14dgK6X/48
         XnFfHEXP6wT7B+0if7GSxCeANRczH9mxFd8YroTBU6mj1qy5XqugOpeajjRlCj4J6CJr
         Kqx6mO2xdwOH3ETzNGTxS1uh3K4RwmS6o9gQQAO6GYxndIWl2loPEAatA3rnvhLclgS1
         3Oql6hRu8UGyxaQOem5v3LGqFXmV0g3POv7YqC5p2Sq3MyXyEyVoGlKYwslX955ctrVo
         Q2QbrEgfHwswahm6hNUfJdhys1RMXLivab9m4a72KnuMFzYzv5Oq8fhlFCyEx6X2uw6f
         URzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751569403; x=1752174203;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZruvFWA1tELco7cKvVPmN0vlDW0f0gci6KUr+G37PI=;
        b=odeHdkIq4NIKEKH/xZ/+zoYSATWpD6psFm7no2cwFvKOclUFVB6NdOdWG/AeNnVK0v
         WgcKEOzrcWGXSCpaXwFpElXsfaBMuZleSq0ZAHcMOQIs51CyKbzATO/5w4yjE9caSKkZ
         213QK9SR7GCe3qVHLaAZugxWolP5lWkGHQbHCvPy8xLcvD7/gSSkEoS0pJzvkPD1R9IJ
         hk4LitM0gsnupm5mzsDTA2kUv70R2qPnjk3U4Pa5+eiSG6M2D+myfo2IZoyw4H7w/ASC
         LCEEeks+AcxFQ29EJ04XFI9DiHxjzaFSmwGOoiWjSZcaUTDV1k/94uZpg+R7LEMEbAWC
         KF9w==
X-Gm-Message-State: AOJu0Yy7mixzm2ZoCU2j8q2+7ZWYyMGXgA2iCJ6ROFQ5ZrX4/SoSVvWY
	dxggVVa53Sim8iYJc4pECq7ZcxSnY308KCGta23oG6NR4rEWgy6oJP5fNT0N2z9M
X-Gm-Gg: ASbGncvoGJu2pwqGCPL8lQd6+6iM9jkPVFagXV1/o78IjIODVUHt4Rbb3UW8veKxgdt
	rSWB9coX1MOXaGxAawrOr+5VOaYtDXA5U7FxBPqsBxUnLxva1fpP4qCv/wHiG2l7tVySsGIuAlZ
	HZpbZp95IWiHeQjE8YmTvyfGYwplDzNt2qvT7wuvvML/wV7w+yZpJzx0NP/frpydd4D1h+RPSmZ
	bXJ5ZAyOpnMcskmH4NcTsjWeioyCPa9PJqhhNfpUix3IaVE7bfW53b9uJGrMmzN75ZIboIM2G41
	9ZA7uJXTFacyycLfYWSZNCalWuNp8BY4VO0ZpDpMUEhnQDNqvHj0Y4rfO3GGIN3GJ8jb
X-Google-Smtp-Source: AGHT+IFUI172wLyWlt6r3GJmF8V3Ch6hyOXT7fY95MUJqqH1ul5fUGucstfEj69nEw6RO4N1LxXFQg==
X-Received: by 2002:a05:620a:4494:b0:7d0:9782:9b05 with SMTP id af79cd13be357-7d5dccbfa06mr7009785a.25.1751569402582;
        Thu, 03 Jul 2025 12:03:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.212.58])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbec3696sm33204585a.116.2025.07.03.12.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 12:03:22 -0700 (PDT)
Message-ID: <6866d3fa.050a0220.103449.24b6@mx.google.com>
Date: Thu, 03 Jul 2025 12:03:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0808790485687427850=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/shell: Fix not calling pre_run for main menu
In-Reply-To: <20250703173228.1815400-1-luiz.dentz@gmail.com>
References: <20250703173228.1815400-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0808790485687427850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978742

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.30 seconds
BluezMake                     PASS      2704.02 seconds
MakeCheck                     PASS      20.18 seconds
MakeDistcheck                 PASS      197.80 seconds
CheckValgrind                 PASS      274.51 seconds
CheckSmatch                   WARNING   302.89 seconds
bluezmakeextell               PASS      128.26 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      906.82 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0808790485687427850==--
