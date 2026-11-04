Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781981;
	b=e7ZLUywQLNoM3sDHI1/CReB/I/rauy45gn4LG9Qm/WCxy33XSWaEbhRoCOK1AsMFOrPq
	 FLcDpNsNpaB16pVaLgEpwNuiWC2puDO70vyATw55pjsxRL7NA6UO7oQGcBde+1f9kL4X5
	 Xi5sgc1pz/b9LLZH+182JJLXGELnWqkNPPnNP87TJ+Gd9YcLD8gH9vywkUBprw+mBt0J4
	 nbbiXRagjfhQjkRD5njLw1F6gxXR665gmcissWHnaqqhvM3ktv3Fq4QRFdBp3DATcArOd
	 TsvSU9+hzqvY1iHL74/6GEeNaluPKoNGtqRqR7Pnqjqo3G/RAbRiVEMO1tAQf9uRM2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=WrygPNYLj7J7aaQ80H9R7ElUgaWEDKAfkAsfpoYDfyk=;
	b=apjzYzl7XcDQNFTJiMgq4aj+gTFGhx8oG+m/AxdMfoFSU03F24ipm1x0y8v9EDl+orSC
	 R7z6rvSU/Yi3YEMGcTBn65bZraIh5+XJTyAqLxHiicsPcairSf/BEsbegzgJQqAFDoiIn
	 Ql1i430X4AAb84rPvSxAsJ2DbE3aSoxceHpIVp4DUlaoy2pEMN8V0kJ8tFEREV7YX7FsC
	 5B4Hs5h9JCUasM4twPcR2Pkn9WH5lFbH7IrKY6kyavuVjECh3hDzReHoY+1/TR7vOzdoZ
	 vFU70C1U7L3aY+7tHNcOiUxJ9XPiawdqfMQuUOsrBhGTJVi1SPvHm5n1uaFN4tkMcAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8EIRqlO;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2D606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE2D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8EIRqlO
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae702d28c4so264086a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 00:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793781980; x=1794386780; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WrygPNYLj7J7aaQ80H9R7ElUgaWEDKAfkAsfpoYDfyk=;
        b=U8EIRqlO1zEt/b8LWwzxL4Z/IPgeCMU8FQ6PlhruyFhxVvMLQMDcytbww9ti6pIvfM
         G/ZoKNAd2wvAAXeuNXwxsAmlvq8GmGIFvnJ5JlpSUly2EFkfzodkS6SeaDcgJBYLhTwR
         Vys/X5/OOuqBAva47qg3BsX5mv4UKZ3GIXHUAexBAvp/lCkSVeDH9bkSwbqwU84dMXGa
         wvQwtj9To2AA6PuwiOjkaQ8kPnoW1CCoMIGw5HxaSvPHGrYJZaw0DN3mP4UqCppzGx9T
         dJKlPNeQ7kwdX3gg2hMmbbU3gED0ttQeU7mRaQtWc4EDDnsFoz06BKsMnjhI4BwvGmml
         KU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781980; x=1794386780;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WrygPNYLj7J7aaQ80H9R7ElUgaWEDKAfkAsfpoYDfyk=;
        b=BnoOV+AfCbYCEgCzZzE4RYLPlMveQawcFKyMrzgvru7h8SgflHeiOMenP1cJmqk9an
         dqSl1BxqCygI9WOcRnOhZEmHrcupt9SHxzf2AH7ZTIkTd6EDz9xldyfcJaqLTiuY77R7
         XSYPalAZqH1TWu3S5qjd3qlZV0WIXgaH2CeLLOLJVK+l9RrTpEbHb9McKiUUGJrg4vuF
         i+GgS0WFmtV+VH++dqwjmGdWnk5m9QJrorJ1FoX+hKHmayvkeBetFVEIqNMxCkJnvJfq
         EpEvBwPZbv8UK4+lXVGYhr7+Dr9GMjf02M+qQgCy5jQ6TmD/wv4RxD66yeSwEndUySeV
         pk1w==
X-Gm-Message-State: APuU4Z9f5BuVu7yD8Cw5Ik74KF8P9kIwRzbczgJweZcWvGSyA8CeqSQg
	v/Zotxus60Gt7XVxvFOsbZG3lNKuJJCAitl9DQ+a9N2ADQASIuKkX9HVG0Iz0w==
X-Gm-Gg: AYBFou0zWwBBbTAUOuDfDhAQQPwxO3wDQ4xy0JllrFliPCbYZy0/24qmYGxtM2i6gbK
	ZRshadE9na8IRuDTw9E52KMCCbZ2ycrikRENOY8nH2wxCnk+46PtT9iTeq80Xw+UgLtFCPZ0GMF
	epFWMKF571W5vbdOgXA1jkXbsLFucNv3uEwbuaZSBFabib2vW6qnZHDlzJA74tzHcXBCvcp2xzG
	CKdw/u3AhNGoHkccfPkjrM/rE9YwEwiEEkPzm4wUM4Ls6Em4oRgmphvUYAZxgPIo13O+pS6jezT
	54IIUD8TSkdr2r56Kz6mL64sZhKIMZYpROnoXRKMdeMPY6nmJFBqESMuL3KNvIiwxsOCObVwaxa
	tsM6SWv3aEx4Mq03E1Qn9FZFl+T5ylJjF1NesIwMBw1S9+aEufz8HDzDUhQZaoAnj947vq2UeHh
	9w2X5yZpUzIbWdeb/R9v0+1guB8JjslHe42bg862E8K3hWimDh7u3/FjkOkYxsG/6a2R+GrX6KN
	Jfzr6UqIZ+AaX6LHwHY0DhcKfpTThc9V1TnAl0cGg8U9ftx+KrcClyRvSKUAx0=
X-Received: by 2002:a17:90a:e704:b0:3a7:e11c:4e6e with SMTP id 98e67ed59e1d1-3ae8984b3d6mr14184891a91.59.1793781980037;
        Wed, 04 Nov 2026 00:46:20 -0800 (PST)
Received: from [172.17.0.2] ([4.155.252.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09445f7b3sm3028624a91.5.2026.11.04.00.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:46:19 -0800 (PST)
Message-ID: <6aeaf0db.408d4ce3.823de.eebb@mx.google.com>
Date: Wed, 04 Nov 2026 00:46:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1328943849713832282=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vulab@iscas.ac.cn
Subject: RE: Bluetooth: free the mesh tx if queueing the send fails
In-Reply-To: <20261104022809.1484148-1-vulab@iscas.ac.cn>
References: <20261104022809.1484148-1-vulab@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1328943849713832282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1201154/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.32 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.33 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      32.95 seconds
CheckAllWarning               PASS      38.51 seconds
CheckSparse                   PASS      40.00 seconds
BuildKernel32                 PASS      32.80 seconds
CheckKernelLLVM               PASS      36.78 seconds
TestRunnerSetup               PASS      781.11 seconds
TestRunner_mgmt-tester        PASS      89.21 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
IncrementalBuild              PASS      29.87 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: free the mesh tx if queueing the send fails
WARNING: Non-standard signature: Assisted-by:
#95: 
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex

ERROR: Unrecognized email address: 'DeepSeek-V4.1-Flash and OpenAI Codex'
#95: 
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex

total: 1 errors, 1 warnings, 0 checks, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14942650.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1058

---
Regards,
Linux Bluetooth


--===============1328943849713832282==--
