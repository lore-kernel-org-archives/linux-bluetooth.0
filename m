Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C824677C
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755727170; cv=none; b=r8eNYy9GndFTPbHJ187BFuPZp36waEroSvitlG5TYhw5n8EQP4DRGeGTSWUZ1MyRcwwc19r0z70Nmk5dS5j8ynG+ejIrrxkgwuuEaTQxEGm4eICoeW+SuDtGGON+CfWru5RG0nGetWZ+51r4M/JSruJRg04YHg+r9OPEgx/m1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755727170; c=relaxed/simple;
	bh=gpT+m6YId5S0HuqazU5mXhsZARLewXPJJ2tEILLddM8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TnAZ7oZujzOdh5FwKfVSLInXnTFNsC+5Ovp0vdhhZ965FNHxB2oR0+m9HD4wchlTbB6US/L/+IgjLGX+yxuIHH52vSZbolIIN0Udyqd5j31f6rzk7PbQDLkB3aIonjx9Ppn/i1jPFN2TckU2pLK4mFtzKWoSunjhOovTVwyJBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrqRgTAz; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrqRgTAz"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8845da04587so7486939f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755727167; x=1756331967; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pi5Sijfqm+eqm1vcQwidb5zcMwhc2QhLhJF9cxt8jsI=;
        b=MrqRgTAzXmQjywlJlQMmZMbzB8pnCtNVXwYNmYeisF+t3uWYoIizBntVqgwCJNmxwX
         2IacFUd4L3CyLr7NOn0UmbIJRSMhKT3vbCCOSS/KZzzbd1KLEXzuscJVSvbojHZP0hSx
         9q9J+623q7NY10cV+C7PUfpNd7+r8aojeSnWmt+uAzWZXBgmesSqVPTM0nnWPd/ok0Cg
         VDwGmN6/S6ad3wEdfNaGwwxNVPwpyUQJBhjmv0jfCFcLyAUXxMFqfFzBs7ezTbJy85zj
         WuIY7jTNI2TlICK4M8iEZUDRrKzkEdh82nCjQvA2Xgexh5ae1zd0WvpAMN/sp6DShcwo
         4PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755727167; x=1756331967;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pi5Sijfqm+eqm1vcQwidb5zcMwhc2QhLhJF9cxt8jsI=;
        b=SMUEnptJRcbBbefMWfkAGFvlCSQnMTNiG76yBTZXk25Ib6TclzNlUT+Z1eazI/qqGZ
         Q8Md3eSm4SCtaLr8sjjI1OJFRsWJP9+aZCEDycDJSQZE9cRgzfbhVCQth+Qe0nzyN2XM
         EHiaL5TaEI2ek/jDn3+mjMIuao2epBVuQG2m3HPCn42dGYHzWW/a+Vtd+O5Yso4mI7gF
         UgCcfO5eeROgvCi56F05/qMibdXJ+K2sU4vySFQHY2IIGitGYpVg5V7Q8W4NqBHrgXdP
         rNCa6QkopDwfJxHYIBtK4/uTdZ33xAVZmpKIeeA/9Pzq5e2BvsFL4e2ehZOvqo5h5c19
         fMlA==
X-Gm-Message-State: AOJu0YymMxck1dgED6ijtEZDIND+Q6tioQIxUqCrhHAqbQssVHYzgBvB
	f8FyvXqyk9MaVtIlll/koarH/hDI0DBknwrzUx6P0Jvqs/P1H0YJimysMhKSFA==
X-Gm-Gg: ASbGncsMVF4orkbYR3ZMPpnVhqgw2EOy2hE16t+fjCK/tuBsv78ggHNA2+jHrpv9ffE
	iTyW3KK5sxQcq/ndDue2MM0v0e8QXM5FCgVEHEm4MIAQiosradk1Zk2HpexMT0F4xGld2KXGZU0
	WRFZLsSSlFwiw0do2M4OBk0oqRszLvBsd+2yJRsQHmTjZETafHX0liU8j003un/ox13UVtAfdXq
	XZpLG3D+kGQl/MhtWMLG59Uxa6a4EnpRN4A0RRIcj+wCOKjX68Vdhn8EGC62plXTmN3rRmh+NKj
	UWkp4awY7Cjj35shXCDSq6ZGNxbYRgrJpDX1/wla5mm8sYoErUP+CmFCI8V4YmNTJMo+ZDfdgSr
	eiaTSMBnZKZTwiRzyLNCkEQRcukLi
X-Google-Smtp-Source: AGHT+IFTONsqRJ9CaUV01os39Xs1YVYKDx1ybBSEpeKEPEy0jvPn99vLCDDr9haOLI3vqm9DDI0coA==
X-Received: by 2002:a05:6602:1595:b0:881:983d:dd7b with SMTP id ca18e2360f4ac-886b48258eemr77038839f.8.1755727167256;
        Wed, 20 Aug 2025 14:59:27 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.193.17])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f7f811esm523241139f.2.2025.08.20.14.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:59:26 -0700 (PDT)
Message-ID: <68a6453e.050a0220.170157.9393@mx.google.com>
Date: Wed, 20 Aug 2025 14:59:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8647234982685757338=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] adapter: Fix setting index in MGMT_OP_SET_EXP_FEATURE with debug_uuid
In-Reply-To: <20250820204117.1905780-1-luiz.dentz@gmail.com>
References: <20250820204117.1905780-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8647234982685757338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=993678

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      19.79 seconds
BluezMake                     PASS      2545.68 seconds
MakeCheck                     PASS      20.37 seconds
MakeDistcheck                 PASS      182.77 seconds
CheckValgrind                 PASS      234.19 seconds
CheckSmatch                   PASS      304.92 seconds
bluezmakeextell               PASS      127.70 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      900.50 seconds

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


--===============8647234982685757338==--
