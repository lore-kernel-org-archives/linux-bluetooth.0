Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76FBE7F
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930184; cv=none; b=LhjBuwikxcKaqVjM59T2WMxbgGTxTBs8Y57bW6NxN8JLTGoG/YOCRorw+LGul/xZ3QcCyE4e0gqa1bkVOcjZcS2TOuJcqenkb4xJ1lFbCvcT3Kyx4bLYfjm/1Hoo6B9xBJfq0KRmlI/eeHBYk2xOfxx54iFUfPQ03ohviILYxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930184; c=relaxed/simple;
	bh=yUTz+6rJaQ7zK/bD4BiSQiQsuCLOec8aisXyHwErbdQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aNHbn8Dl2VVEVRjIXCe4q6p3zY78Fm+UmIBP3bCyP22VQTr0lZKfDNmVZ4aDFsFBOWjpsXKmHX1+8AqJoh30oluRTGw2MfmbBZZ3lqoloWRJ5dU07z9UgsC+RcDzCj8Ra5itzrGa5NpJUi1yJbox0f1MCSPJC20KG9Yu1Wowz4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD8Jr0Y3; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD8Jr0Y3"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79c05313ec8so227698985a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719930182; x=1720534982; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1f3pDY3+4ZPpsN3o7rVAG22QXNzif58nrIaXK5wKHGE=;
        b=kD8Jr0Y3oybD28ymwfc4qxUoawOh2M9J+NunEidNchaJ6T6K+dIE+LCxXFDWp6rXIp
         dSr8uVygfI7ihomHLj1IwX7Ehy/2aZUklpqfWEc2+tWZAN7Y10AcWNH/58k1uGTDzz/D
         ENScQoIDdi+pZcbheztimX474AzLgvmYdlsU+NPhP8TtajKWU7Di2kDUCOP273gj9bCt
         LwNm/uE+NZR2rp2qbxWzFPc5iiVDekJ07BOgWZ2g9TvCJPeSNltBip2/BrKGhRnsi6En
         XWjK+5EG5ZZNnIVwUBhYG77o+x/HyWAX6OWnQnQUklUKKcdl88E97ZaXkNOtzCVzgMPJ
         fmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719930182; x=1720534982;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1f3pDY3+4ZPpsN3o7rVAG22QXNzif58nrIaXK5wKHGE=;
        b=xGG7neOpPti+zdN/qNygdwghkQp9mrbmjmx4xi7g4hQ0XCwmY91inmaawE8SmirwGa
         NptHAlwfZEP2Xz8W/Q0g+PTsdrI7lVta4X0AqZwdv8PAADO7hiS9nSD90fOmTGd9q28g
         V8jnPhc8aj54/krjp5DEtD84NMz406QLbuvdS//pFmM+L0DZaoLNxFmrW04GpcbyRwRX
         sqQff/Z6XR4vSFrG/SxF6XpOEJ/EbnNoSvSZSHWrrlxHa9IHs6u7o/7l4oxMzy1DL7ZF
         stqIu6N1jmd1TZ1NNJ29kW7i5HAQ4mZ1lo7w1I3VpEBqpM1+ToIQCjMI+VVFSEfRs91+
         +Tnw==
X-Gm-Message-State: AOJu0Yw8mNSm87mJGO9MqTWDQ50Zu8opi5/U9OIyZrt5JE2/zhxqRj5R
	2YuEvhDcnC2+VH3quNiMFQVpK+HLYK1j75qvRGrjod3X3Z1znz35+OUZVQ==
X-Google-Smtp-Source: AGHT+IHSK8ehi3Gyh794e7ZL75mQIXanQsdsFRkoHnTHOXmO5Fq1NaCDdc/5Lo0tFk8p4VcQE1q4rw==
X-Received: by 2002:a05:620a:11b6:b0:79d:7179:f908 with SMTP id af79cd13be357-79d7baa6fd3mr1014328485a.73.1719930181945;
        Tue, 02 Jul 2024 07:23:01 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.79.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d6925f583sm463230485a.3.2024.07.02.07.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:23:01 -0700 (PDT)
Message-ID: <66840d45.050a0220.1a96d.1c29@mx.google.com>
Date: Tue, 02 Jul 2024 07:23:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1102472909641013110=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] client/player: add return value check of io_get_fd() to transport_timer_read()
In-Reply-To: <20240702122717.77746-1-r.smirnov@omp.ru>
References: <20240702122717.77746-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1102472909641013110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867534

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       FAIL      0.57 seconds
BuildEll                      PASS      25.82 seconds
BluezMake                     PASS      1808.41 seconds
MakeCheck                     PASS      13.61 seconds
MakeDistcheck                 PASS      186.19 seconds
CheckValgrind                 PASS      259.70 seconds
CheckSmatch                   PASS      365.23 seconds
bluezmakeextell               PASS      126.11 seconds
IncrementalBuild              PASS      1566.74 seconds
ScanBuild                     PASS      1063.75 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] client/player: add return value check of io_get_fd() to transport_timer_read()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (89>80): "[BlueZ,v1] client/player: add return value check of io_get_fd() to transport_timer_read()"


---
Regards,
Linux Bluetooth


--===============1102472909641013110==--
