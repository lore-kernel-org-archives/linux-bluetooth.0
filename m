Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51EE223DEA
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717564; cv=none; b=nltBbPrpt8bBX3of9PI4PdKpFzFjOcElWkObLq3Pz5AvHmbLcImP8oLcP3BkvAo1bW6f7+6NeiIEZjbzKrSoQzDXBwgapdjcsu2SCbidBukOfnRRcgvkrMPYTzyMevwsol6s0RPSDbQbBSJcgQ0An18HkODzA9EdoBv3DPDhuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717564; c=relaxed/simple;
	bh=tkJCek5zSudCgoYwPzODkQg/osu1ayqruadBgVeXORI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cHY6/1whdoikn7ZOAYrOIVSL01r4VIXCBJI/qMxH6TXFaTxBJ93rwkakrm51cnX6Cia6EDxYHSHfzjrBJUTABIyrTRnkEaRObOHg39+74YnPf8U5L+h4cbKt9lmzIrLjdnmsoAwn0xAkFmE+CC7Cfz9aa8Rd/dxj8H5krZiGFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVO9+fpk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVO9+fpk"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c46611b6so896612b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717562; x=1750322362; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+JlUx74RepV7V0ZcEw8NEFRipk6RAFsEPG62bZS3Vvc=;
        b=GVO9+fpkxuLbSlaE9bAor2B6dSzoZo2yr5JYMYxT2gerlTxv63A0evw1CNyudV9sST
         4kcvWOxF4Y1Em3ivC2eIaWNtHgDRuXjtCGZc0CrGOvURZTLaCRemhfP/dnAn4oWmicGH
         kCy2V10dE+OHyl+QXOFR+xdf2UpohjsU/fDy6fbV8tVgc0eKXdAGxRRQzR6Ee0gVxVOH
         SnOD+2vfAKrmIdIBa3l8ZZseRChncVUtazowTGkpPYFlmx3H0m2W8xpjCnfTyXR9x0ot
         ea8a/eio+CC4ZLqIZp6HWJXMZUfn0FEAEEDM/v1euH24w8KwrrGOKzpjNIZv0tldyudf
         zrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717562; x=1750322362;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JlUx74RepV7V0ZcEw8NEFRipk6RAFsEPG62bZS3Vvc=;
        b=t3pfSm3yIPtEKBrSh6oF63Kq6BBNX73MxRnyM1hBdicsHEIC+PUp/C3U/cQfscOmzM
         DzuH29CIDqpluj7RMfayD75LoUzLgAUC3uux7goGygTLfilD1nOcsvGVvFTwzPzhS34+
         ZCV2cCbbJenf4GNl6QZBhUlKrFjBLrSOjfDEv00xZqjxNilIPuDYcnW3uPsfwsItKM55
         JRv5gZQh8dj9aEJK2ZmHKvVTR9HUij0SFUuYRBuvlRDYiirsG62g2feCMYa+OkHBl+/J
         xwbhzB8cREH+GIkgLBjetycJY9k2beRQKBdsWaq00SIAh2W5Fps8OA8u2rAYYtOiLUnb
         I4aw==
X-Gm-Message-State: AOJu0YxIfEGm+5IxPWzPV8n3b2kZ00P8tShOXgHkbI6TqIQA65d76CIh
	7rpx6jdV8wPqh89nexqyp63agyV/cwKBts4e50wf1zJ/ol5wMmXfThWGDaJb1g==
X-Gm-Gg: ASbGncveAacfvezc1a6dY1DGA220eDMLK24CaucDZhtCXr+ECA9rYANNGoBDqTtAY6w
	wPaXIjFMcdvHvsB+NdzUbyIZH3rlm/F7jkC97fwK5+eKOifM/8EfY1u6GwoJ3RtGxl7KuHnU7Vt
	dZ8N2yew1XpnJwaumMgc5sgQps3ZjZVrYHMEErdKKH64xlD3AAJllkUqqADKJLJNyVaFxpNU3ai
	lQObRIW1vLuCJKpRfPWxhKugS+UgQcYBwFq33PqjVnPPrUkhnWisov/xd/gMKu/CvSyvbJ18z3R
	r3fY0Ypbr36hWcFzmYHsBbconw6Cas0l9iTUcbFBKJVFC9yk7EKdid2CPrr9MjL49WpL7iRDzuT
	GeSiN
X-Google-Smtp-Source: AGHT+IGZNllGhDyAxGzWzbkgaM/8X8DI/k+gCBZvy4/nkosaXx9P0Nv7oo6U45NbYQqNFUCeISRLJA==
X-Received: by 2002:a05:6a00:3e29:b0:748:2ff7:5e22 with SMTP id d2e1a72fcca58-7487c239e74mr3565525b3a.10.1749717561804;
        Thu, 12 Jun 2025 01:39:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.160.165.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809d317bsm918236b3a.105.2025.06.12.01.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:39:21 -0700 (PDT)
Message-ID: <684a9239.050a0220.3b4bdf.205c@mx.google.com>
Date: Thu, 12 Jun 2025 01:39:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6078992361993710557=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: L2CAP: Fix L2CAP MTU negotiation
In-Reply-To: <20250612075034.190194-1-frederic.danis@collabora.com>
References: <20250612075034.190194-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6078992361993710557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=971193

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.74 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      24.96 seconds
CheckAllWarning               PASS      27.33 seconds
CheckSparse                   PASS      31.12 seconds
BuildKernel32                 PASS      24.78 seconds
TestRunnerSetup               PASS      468.50 seconds
TestRunner_l2cap-tester       PASS      25.63 seconds
TestRunner_iso-tester         FAIL      8.02 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        PASS      134.91 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         PASS      14.84 seconds
TestRunner_ioctl-tester       PASS      10.14 seconds
TestRunner_mesh-tester        PASS      7.44 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.30 seconds
IncrementalBuild              PENDING   1.07 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6078992361993710557==--
