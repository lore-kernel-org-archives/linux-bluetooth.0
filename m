Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82BD2BEC43
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922945; cv=none; b=U2uajquqg0blc3/s2CdgxLzIvIpj7+XloxyJbbt15IAHC+9gzJM+7R+aTEhbCAavqUt+UDimSaqLj1uhTzDsE90Jk2tM09KsmKt29R9+uyuUnEDPpnt22+3G0cHenjYEpyBgJxWl4IJe74eyPQbY7h438LzTeDnbgyJC5961H0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922945; c=relaxed/simple;
	bh=VGegiL8S2p0lrbo141JV/DSRhKSSfEU/wDPrrk1vut0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=brWAA95eoHG7V/thN5dmFuQxU8LlZJ6IudkfMcNjvNlbGZNjXss603WMXq4cnc0Wlna+3qORguetK4GtGjkgEj2HMZA6xcqY1ghI6HH5YDsHBhJEiDhFblgXxLI357xFeFB1oZ1rF29xhyjDETSkIMg29QoaytiLk5Qaw1PJwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3kIETDQ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3kIETDQ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-477282401b3so74253841cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745922939; x=1746527739; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fnjHxbEHm+/zY0LSq0PwbPJMXXOlfYAcAav7pxy+ZhE=;
        b=W3kIETDQSjkTFocyZMR6L1R1k1RtRtq06mp/dm2po7WDAVKdeglSkrwxU31Dgu+9tk
         DTM6BGrwC3Ewfmc2MpTmnK6Y31RU8lsxtY83Kmfy4CQNvLNnqLV4gx4zQr7vkvBr2tPe
         gIuw9XvMbP1QA/0qGzRvv/rMKFQqjwKQDFG7QSnbnAOfkHFxrempJF+dpU9z+c/1qnXJ
         1b00wwKEPZ90n9sHfdh1YhAkg6aL3hhrCgWTbuC9uTlN9P89cYu+Vzuq6XLdKZvD1ZGC
         0S+EyDmVBfzxONhGWdEXyf8tnF1r6116Gbwn9oIGkYt169RwFCQG/6tbVDd4B43Eu+hI
         WLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745922939; x=1746527739;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnjHxbEHm+/zY0LSq0PwbPJMXXOlfYAcAav7pxy+ZhE=;
        b=RTFPxZzwt2/H6Ab2y17JK9EyAkAT8s4/L6BgTVL6xdALN6WXg87xw96OirudTfFpj8
         b4w5B0AH2k6F5mkK8QRc7tCy7vM8QCx0ma/ixOU7An8JHGSXhkkRqr1vvcNQCjQjGQPF
         Ubh99BcdN4tOLUUfPpp7gfJSZ2+NxJLMZgw6gfsuwRNb4wHTbnN/CHjZFq7us16TBQBe
         jfQemQkGR3FSQ3Y3rjh3E2ym38SCNCAA4ue7Xtvxry59BAcv/RQWXuzzacJ9ycYUkuEc
         zNw8KA8Jy7MdONYszaFNLyzL/7r9QuPLjN1BdafZpK+yeHQrzvrcjISOsddH3Jzxg+zz
         SwZg==
X-Gm-Message-State: AOJu0YyRVIzHFiPmuG4XUw0Tf1rhnAhKTt9nDZIzx8l8YWY6G75a0k+l
	TizTPQ9nvydx/kOnPjGWNxliC2gjlObUbm/faDoEMmuAbRjFAsJSVkUuXA==
X-Gm-Gg: ASbGncvCfWF5oMGDedRhdhb696DwZDzqqLvq/+RL8nvD8MVVbPOWaPFAShxhXVjkVK1
	qwxy+lBThrPFmO3b4z6+zokr9WzUYFn8k3vWCLdSnxqc3PckrubrogQY2EbCk/EvSGZPyvwwaTj
	mbdWPjJxMpPe5iKBYmNwMoVaPegmT/5ueA9KYbkEe/5kme2jmX2MgJ+lhzBpCTbI3g1iFP/P9P+
	Jge5scqOnlo//YkOTDKffG5I47rASBu/e9TZt1wtsSpvFSFywhFGfH+yi5FDb2O79FpiU45PrrB
	UqNT8kndMdnQ4ti00VLdKkdoXO1fZiViLGe0uoh0G4ZV6ika0w==
X-Google-Smtp-Source: AGHT+IHZvDJYgqaznvlYhrO+hKMRZqjz88xTUG/IJ4quebjnG8mleLwr4peldtxiouUQX2C+hPUk9w==
X-Received: by 2002:a05:622a:5e17:b0:476:8225:dac9 with SMTP id d75a77b69052e-4886f5c091amr40124411cf.45.1745922939184;
        Tue, 29 Apr 2025 03:35:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.165.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7aade9sm79501891cf.40.2025.04.29.03.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 03:35:38 -0700 (PDT)
Message-ID: <6810ab7a.050a0220.1e1bb4.e149@mx.google.com>
Date: Tue, 29 Apr 2025 03:35:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2474454774340038943=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btusb: Add new VID/PID 13d3/3630 for MT7925
In-Reply-To: <20250429101605.2862004-1-jiande.lu@mediatek.com>
References: <20250429101605.2862004-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2474454774340038943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=958052

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.29 seconds
CheckAllWarning               PASS      27.71 seconds
CheckSparse                   PASS      31.08 seconds
BuildKernel32                 PASS      25.11 seconds
TestRunnerSetup               PASS      469.94 seconds
TestRunner_l2cap-tester       PASS      23.03 seconds
TestRunner_iso-tester         PASS      34.46 seconds
TestRunner_bnep-tester        PASS      4.88 seconds
TestRunner_mgmt-tester        FAIL      121.15 seconds
TestRunner_rfcomm-tester      PASS      8.01 seconds
TestRunner_sco-tester         PASS      13.32 seconds
TestRunner_ioctl-tester       PASS      8.46 seconds
TestRunner_mesh-tester        PASS      7.17 seconds
TestRunner_smp-tester         PASS      7.36 seconds
TestRunner_userchan-tester    PASS      5.14 seconds
IncrementalBuild              PENDING   0.91 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.206 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.174 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2474454774340038943==--
