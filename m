Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DFD306B1B
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087373; cv=none; b=tlAZjY0kAWD3rZL/qBmrH8Pz25qGf7PwYKqoZ1fjPxJlSgiCAULWcMJr1alooLE7qnFCLvzRuB8EbqhhIVz3vPBnB/jWaaVkJe/U5shY3EiRFeCsNKqMsYm8LH/A4oB7MZliAjj4nbM5Iml/DZZ9oIopcZ0ByUtuS4fQzpTP47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087373; c=relaxed/simple;
	bh=f+JTcE3DRLPcOY8am3KMCMPe88wWg+At3qN8c009RkU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ut0qj6NAcf+nlAo5Odl33rCptyVORmWhXcu7c98KecH14LToI4oySQYq+a2/wGGyHKlXgWWh/ILwgQFmfVNa909Yd1EQpuRl0ikcWCa0k9UyHtvqK2gRnQ8r16Tv986YYbsfB5VjIGE4JMHma8RV0rSk3IWpn9Bitd0eO/Z1rbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A18dbmat; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A18dbmat"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-244580523a0so23878845ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Sep 2025 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757087371; x=1757692171; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Kdntula2IPeGyawy4hqpxOilgiC8j4J/eBWbMYyUvc=;
        b=A18dbmatsQE6JZbgNt1vChwarhShOS4FNZ+7rR7JoyZhv1z5ILZILYJyjM5Qsdd8Rr
         hVU/5eBIMpd2CstMr1sBhRMHIAgHYBxpDEssQY4u15WGdpSViysCeFyogDOKsIVUv0Pv
         yZVgiUt48OG5s+uZISqnFjjm12PBlmt3g22o/YDC0JQGei0lsKCmQMuwndY4v1YE5p1h
         XmOW8FWVWVDeA51syZmVBXhwUNOstyGUxea/PbcLaMJQZIMgDTO9bSXWlYojc3a9kPzG
         CT2l1zvQZZS1K+JbM+7aRGwIqNRVOuIlatRqBJtFZuwX1Px2S0mxR3HB2T7SO1Ie0vtO
         SpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087371; x=1757692171;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Kdntula2IPeGyawy4hqpxOilgiC8j4J/eBWbMYyUvc=;
        b=LQ9c9kmE2JELgZ4DtiSZesEkI5EBQ0DkW5AYIFG9pfkz4OvzThWqZRzzfoGD/Ry9iI
         S8CGnXj3mVccuSBZDzfDV3w4f2fp/DxFsU+/vBGPMM8V3ZvE1BVp3K7dWYcaxxVi4KT1
         Pgljl+GPFgcRndiZzQRP+5vT8li7vb/2bEUR3DlomKwFfpGgyDbZuUADPgNqPDaCTkM+
         q00VatdSQhfaSXBpomTNbnzZIDi93vZZP78r0vTO3PfO8Unshp/IiqKkz3Hso1vh7vV4
         xeZhOukZdaTCyEGemb0y16p9ybxZFO2oNJb01/+IDE/kgddqOAVPip+1swTcWpmdyzrq
         19qw==
X-Gm-Message-State: AOJu0Yyah9U4tEnMTjp6lWFBkd8xL3NpCmG3SCXb2g46NfRuc6Ey/260
	bs+iwcDSGoJ83Vx6Ewnxsc7DI23i3UzlHSYz7p7xv9kr/xrbejQKWYe5JdwDIw==
X-Gm-Gg: ASbGncsas45dnp/1K56eJVDNsthCdwP7sDriOFd0cruoc0kzV86eMqjbj/nlHAI6rPr
	TZKmlD3SI2uTlrZG4mYJUI25HdZpgqHcDPj61u9E06kC0Zgf/tpT1iMIAfiNnVAwK3Bv0lNnwY4
	375TuLZxJIgAdEzUo42M4i2spucFXaXJng+hPOxe9F6JrOzc3lqufngEXaOBWj5s4er/svT8EfN
	10gjrvipydSTLHaoHJXpiagN5U9GXeuA2HX4oqhmO66ReMa9qDVxxl8fyPzGlchuh6mWFq7MydJ
	EdBYYpWheKno4SvotmtgBYY4bH3YGMUbbkihsFLqUs/xuwk4hTK+3per8C/fl4Hg3WfZEHrbiVf
	231g3ziIzzaCUTXorhFzcvvWb3j7pg6zksSuZ9Q==
X-Google-Smtp-Source: AGHT+IHnqElgvg4KHWluhafufyJYWk1krS3dimNOEhleQuMPP5ZKOfAcpwIa+uBh1zGOC6lC30Jkuw==
X-Received: by 2002:a17:903:28c:b0:240:3eb9:5363 with SMTP id d9443c01a7336-24944a70227mr317491805ad.27.1757087370967;
        Fri, 05 Sep 2025 08:49:30 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.41.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b0d881afasm111234725ad.47.2025.09.05.08.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:49:30 -0700 (PDT)
Message-ID: <68bb068a.170a0220.328de.b024@mx.google.com>
Date: Fri, 05 Sep 2025 08:49:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2066449337176671573=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] unit/test-hfp: Fix MINIMAL_SLC_SESSION
In-Reply-To: <20250905142115.942982-1-frederic.danis@collabora.com>
References: <20250905142115.942982-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2066449337176671573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=999363

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.08 seconds
BluezMake                     PASS      2848.12 seconds
MakeCheck                     PASS      22.66 seconds
MakeDistcheck                 PASS      184.89 seconds
CheckValgrind                 PASS      235.26 seconds
CheckSmatch                   PASS      306.09 seconds
bluezmakeextell               PASS      128.71 seconds
IncrementalBuild              PENDING   0.52 seconds
ScanBuild                     PASS      926.21 seconds

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


--===============2066449337176671573==--
