Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA824AEEF
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 00:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789863645; cv=none; b=YzAdlk9h1/GUkZ8tR6RRBSJa0aqdH25p0+/HH9kUqAhiOpeid9r+I8Z09T5GhzyfZoDE7jLSJEiPRpBt8MDRkgEX1wAsHmiih8CtEZOKko5avQ7UR1bpy8DtQBxp3RFuHr8nzBTOuA4s/3emVH8kxI88kwRngVzGB4SR438wmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789863645; c=relaxed/simple;
	bh=3mtb5jO7uxD0AkDW6vh1lFGD/K6cjEphZmMX0Sdr0fQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MZT5aHWr3aFFrtvrjb9vQiuMP6AIjr2riOrkTeSO+hTeTh31JTP/JoQsjJXrRQUldPZ89pDjpOqfMRcj9xr1YPUzrEuGEzJvOay1ZOdnW+SrOBDAOelkq1ZNcucw/koDFou34kc3FRYad+JP/656u+mFcHNAtGH9lJx3WfPpZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO+Q2vJ7; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO+Q2vJ7"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1729891a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 17:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789863644; x=1790468444; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aZY28RMe01M5Vd+SjG3Npzu5zIw7WOiBAoYl1tsmxy0=;
        b=aO+Q2vJ7F4F5LlEnqN7762jn1yVOvB9Nx3y2xN3TrDmml75EfWzy28E6f8VH2FsAdq
         YExpmmbyRTQ8nrx20T36pVmxSSsXC8ivTBnh2Wu932wdpEg09q0Bd7UkEfRrZNKRNUs3
         qx35o7mIn7mra7li7zlDULuCEeEjLb5WGzD/l23+71aczpqfiJbckdw/LcPSjB+coUQQ
         pWtsHXRd2hw4Rr+bkmtqPdMEEqSk3dFxcl2Op+3g8zqEBD7ZVEfENihAtdyAI9b81YDd
         qSEkDOBhtxlNOClMXSzMk8N7C7ztrqBUmv3cYJiPhKoUZ+PzSxdaqlYznm2hqT/yKQGM
         mhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789863644; x=1790468444;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aZY28RMe01M5Vd+SjG3Npzu5zIw7WOiBAoYl1tsmxy0=;
        b=MksZD5Iq596KWy9lbqBpmPWm7Nstp7bxVmmchDvZD0IoYBuGjON+yuzgJ+H0C7xzPT
         2w8rVFkdPon/mEKS04gfMQgJCd5njDbYtd4+IYWybZZFXH1ncdwhR4H638ooG3TxscaY
         OERy8eiJPApQMEjV6FCtGpm82e8VtVbT3ixxvSSqwwFgcmR3a+LDKSmyeMk+IiSdUOvc
         Snuht4hNXkm2YL9t072kuVQemPTGjcZmQ14dGFQGJ2dgVUJ5J4MKPiYRV6EaPBp5ZaiX
         pKJdxGt/R/yNvpRlCa1BrAntlH+SJ0D6Ejg61d4dc0K4a00oYNSp28t7f5NQEgkD95Ye
         y7Qw==
X-Gm-Message-State: AFuF++mJDZA+QKFvUmUmw7k1Pg4cU9+TEfS3Y0fsC3Bzot6HlMpLA6ld
	AV0iuE3YLvr7a1y4a/08F4TwE+Vcchz0e4gijG91BrEdx15/w/7LOlQ7IaZ96/Hl
X-Gm-Gg: AYBFou24wai4zbBRrU2hnYYTl7jbaOypNoVlZng3BTPI+too9f+3YALUwwXhhbL6HOq
	hdpRlMT0Ay421O0kMoiCkCGLfrgdlOqzgKrbrOOtzww0mLVpVPxKw4D2/8aUc/r/eHshTGFFOtk
	UZKacB4tO/6In31NCrsTpk0QLLDOxPxcsn90HO+QDClNbY/T2BbCdwbeNxjJPlbbDIWzc+JFv/Q
	/X7peAuCPzrCbGgZlC8CMtMC2Q3pKKqm/FlWxXUE0QhI+8DrTQzwHHNjWCC17spqEqwuqG9vh6c
	7i9oQZNE88DcicLtzw+WTeVFUOnAdL10ymN+MWtwXB225ttYTfOWnMSnwvV6NGpi/tewTwksurp
	s7KeIijTQ4VwZMFr5lEThBEgj5WpWGeQbRoQlTXMx4xxDihcLlswPZSqnVUwtAvwaO3wYU44VDK
	rzxZTurGdztaxUv/l6EbW/YHgYtVN+T9bRd/C31ouW27EzdiHRcNpE5k4rtCslIKa6Hb9WP3vr7
	Ke/
X-Received: by 2002:a17:90b:4c03:b0:39e:4c80:44ba with SMTP id 98e67ed59e1d1-39e54dcc3ccmr11607851a91.29.1789863643821;
        Sat, 19 Sep 2026 17:20:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.37.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3311a716sm9576174eec.8.2026.09.19.17.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 17:20:43 -0700 (PDT)
Message-ID: <6aaf26db.3efc6ce7.3d21ac.d9a4@mx.google.com>
Date: Sat, 19 Sep 2026 17:20:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0329744814006817492=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benquike@gmail.com
Subject: RE: Bluetooth: bnep: fix out-of-bounds reads on short RX/TX frames and control fallthrough
In-Reply-To: <20260919221738.3708655-1-benquike@gmail.com>
References: <20260919221738.3708655-1-benquike@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0329744814006817492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1169457/

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.26 seconds
CheckAllWarning               PASS      33.50 seconds
CheckSparse                   PASS      35.64 seconds
BuildKernel32                 PASS      28.73 seconds
CheckKernelLLVM               PASS      35.74 seconds
TestRunnerSetup               PASS      792.48 seconds
TestRunner_bnep-tester        PASS      4.48 seconds
IncrementalBuild              PASS      27.85 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: bnep: fix out-of-bounds reads on short RX/TX frames and control fallthrough

1: T1 Title exceeds max length (86>80): "Bluetooth: bnep: fix out-of-bounds reads on short RX/TX frames and control fallthrough"


https://github.com/bluez/bluetooth-next/pull/800

---
Regards,
Linux Bluetooth


--===============0329744814006817492==--
