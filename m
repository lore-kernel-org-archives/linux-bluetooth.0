Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B21D5CD3
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679050; cv=none; b=jQ6bbNef5Fw0CyXDa0xUHnhELsssZ0DXWXqwP7P26oUgbXEVUGAeKU0La6UOKhgymmZtc9yaoD2uizT8KhSO/Y+GRMQL72HGV1f/0QO5CS6MezrlBm2RDcAVnJDvL7u9W5NieOdexATA15Vo9AtXm/KthAHOkMBFYhDnxsrQJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679050; c=relaxed/simple;
	bh=39GguNJfy5UyaP8C1VFMduBFebpqO9OMl+FbBAq3z/I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WaXMiwbV5B3cJdOcRvKni6IwAKzTuzBtFSgeNQUZnvsH8OTdBlFVddtt7jkdtVG4vGFF6v7SCzu3eXr5IAWAAfgidHp8jnmnVQXtcoWDd6eCgure3D3vXJzedCnuv+esaQT5xM++lHfNiMEvBXovKxXEDfaubTGu2tN6md9c8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+cb2PuS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+cb2PuS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223378e2b0dso20754405ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740679048; x=1741283848; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq4Ri+DNXa1GjJwsUpAhu2O625z95Zsg6+VdGGSqkxE=;
        b=g+cb2PuSXXAW67Z+QirnQS7gVWt4p9p2xyVUTivF06oa6ftpbex0Vuse4C0Z1dY5yF
         d3Zgcr0MDbyDLeqVE1OAPUGmPm6oHnpG/rRIY+xI9UnJzCwmxyZOKQGw9Q2lNiW9Jg9h
         fYYjJlNVAoP8Gng8C7pn0pxbRaNmqXlGdjUdmanALVbtciw0FVqImowr0ahk4Y0gt3fF
         cmiIDJP1bu61fmNnLFcayRJBFjSha4scAosd4QgAUhx0eZ1tVM11au6gLewc7XR04sIo
         3t8vpj0NwpfcX14X8Mit0+onST98QeuhADYFSu55azA6CEDpYwwiXjfGXJzoNCwChH5j
         AYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740679048; x=1741283848;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jq4Ri+DNXa1GjJwsUpAhu2O625z95Zsg6+VdGGSqkxE=;
        b=mv83GDeuO+oczTyC+2T2oz71Y0e0Nzymk6qEko3+9kmV6zGGmFzGJSm7LXkQo3RPHX
         Lr0ga2g2XcgBGpXZqBK1y+wOoA7elogkOpk2rYqjXNDRAPBCBfznQKGDlaZaynl8wv0x
         UeOT9b5hPMcJe7nwV5v6fIal8LP2t2vwlDxVgNWqfNf1zWzSZMMqJ9uWEakW8HVkFX5n
         P+iqNW2UqBDZekkKM9A8FcR4kmhXN4uQbSjo7x2g6OIi8ZfWzqmrjelYxPO1IVGjBNf7
         1KTcboESVZqCM00VW2vSfWnQaTCXIC7NcG4vi0nsx7QAYRRB0JoCzcTMrRbT57sAxKK6
         WkOw==
X-Gm-Message-State: AOJu0YyWQmCASz5T6WfnSFhlSz21RYrld3gQxBfSZioX/UECpfoIfWqG
	wQTg7nbf14jczqy/AXza2mkDnYrU+BUQISVHO+PERnLaWkgufZtmbXaeRw==
X-Gm-Gg: ASbGnct+dJAA+5IoulENw90K6NpcvvKHrVTDdk5bYq2krD4TaipM/jeis4XucWN9Xhv
	lysDDmEwRa9ckDUNtbErf6uug3c009CwH8Q4f8nkTAAp85Cf2U9nFmpe73QXWnJB0DiaPRPI5yZ
	v04QUZJfiEP/sFzJwCqOaSU9Av46F+gXiVDMvacqNLJ+IJF720fzdnWPO0R9WPFf0loj09HT7NU
	uah7dZmtlRWBXIPZZI9lvkoG4UsZO/zXV7hXAylRtwlS2MqiZlehnQANejLie2YVtkz/hTuqqVQ
	nIzJadqult1RhTfunxYqt96Ht31qLupt
X-Google-Smtp-Source: AGHT+IEfka4XX9pgGSpgsUwGgcO/D5gKClWQhkapsDtCCRWO+50VupXw099jP6iU+8q4EXuXPothcg==
X-Received: by 2002:a17:903:fb0:b0:220:e7ae:dbcf with SMTP id d9443c01a7336-22368fc9332mr1219495ad.23.1740679047815;
        Thu, 27 Feb 2025 09:57:27 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504db7a6sm17707305ad.160.2025.02.27.09.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:57:27 -0800 (PST)
Message-ID: <67c0a787.170a0220.a8a1b.1bf7@mx.google.com>
Date: Thu, 27 Feb 2025 09:57:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2072162762096283367=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [v3] Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL
In-Reply-To: <20250227171417.4023415-1-chharry@google.com>
References: <20250227171417.4023415-1-chharry@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2072162762096283367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938624

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.68 seconds
CheckAllWarning               PASS      27.29 seconds
CheckSparse                   PASS      31.01 seconds
BuildKernel32                 PASS      24.60 seconds
TestRunnerSetup               PASS      441.41 seconds
TestRunner_l2cap-tester       PASS      21.31 seconds
TestRunner_iso-tester         PASS      35.17 seconds
TestRunner_bnep-tester        PASS      4.91 seconds
TestRunner_mgmt-tester        FAIL      125.40 seconds
TestRunner_rfcomm-tester      PASS      8.04 seconds
TestRunner_sco-tester         PASS      13.36 seconds
TestRunner_ioctl-tester       PASS      8.67 seconds
TestRunner_mesh-tester        PASS      6.28 seconds
TestRunner_smp-tester         PASS      7.48 seconds
TestRunner_userchan-tester    PASS      5.14 seconds
IncrementalBuild              PENDING   0.52 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.191 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.209 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.167 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2072162762096283367==--
