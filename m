Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312E1A6828
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788047778; cv=none; b=cEDUyocY8nt2VA5e2UEvAJhsvcL2iUrsKZOYcM+k1hEtCv/UGkHdTRSkU51hbgT2E7C9GaKTPpwRw1JEYZ9fDwWBmHf4RJcgWoYqAf/ExPFgvc0x82gbu+ra6k6zImRbjKa2G1hqihg+DD5EGllMJaS+Ah3PGoRFqglLyDQpTYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788047778; c=relaxed/simple;
	bh=q8PirDXMVcQF4ivD5TGXmFWvuSd7IGFbqoasIb+JGTs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dyzFAXJ+BZmAq+ePzBxhSLO9zeumcYvfiCFtK5gTMrFq8Z1PhMBLnW1R8nVbF+CT1PKQQYe0BsqaCxbvqK9QXxOt7gHc+B5sAhLmi7127bKnyCWPRXAbdprRs8q6ResYdKI/IWB5cjWXnTDTU4Y6Zb+ElJ26I0C0kM1KPBfCZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzxIJL+b; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzxIJL+b"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1932735a12.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 16:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788047776; x=1788652576; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1vdsaNklpiry+/TUJQRtKiCCy4AvIQ9yne0ongmh9p8=;
        b=jzxIJL+bpVqS+y1mfQBJaijxf42IyFWBonM6T+2q0spFqTk7GsLRhK390FzRBzQW79
         Jw5/qNLGPDBvY/T3NkRPt7b5S2y7VyR5OouCJJutnGhJB1grnzSaWr8Yf7OPvVSK5Shm
         N0yYBFJqX4Z6HlgSNPmr/WJC88xpouqk4BTa06yBj/eq7kiyEcToJ7IiIHugTKpUdOD9
         BUi2AExaSIH6Cv1CpBO1jRLqETg6ICPnpFPG1wcivR/YKi2qWYsOdMeybI/CsQRNhzUF
         7GtxCJxjcH3c4xPuPYn9cQ0L1AVenh7A2J/jrWt2yutF2/wN8aU7apsjTuwFveo2S43Q
         uAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788047776; x=1788652576;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1vdsaNklpiry+/TUJQRtKiCCy4AvIQ9yne0ongmh9p8=;
        b=Q+zEgOE/1ajU94vuZMsP+ZJuRFScQNwqwVU9qkobszoA36P33hK1pt0GIDUMg9lAXi
         iec6uA8Dv3SXDvgG7zlMA429jsgcGKk7aLO4t3abRp0ptrAWQ5Dj7Pojhc8UiQjEO/3c
         HJ7HysVe70lypoekysHngBXXNAG5KmHXkc8F/xBq8hIKAYGoUJuRV1JGM/QUbksU4ady
         cnqyBZUjAZqNW7bavmzZjDUYHEeg/S+JbL0+Pyk5slmoADR1It094fCq6N0Q/F5Jko4l
         6EAZFTUNWtjjsXcQBTxT0/WLoHqLmqGyo6+aJxkf2RMFmMedXhR50JaWaRqfT6oGp4dj
         H4rA==
X-Gm-Message-State: AFuF++kqLOiqcY00o0DzKS28XpyRxGaShnFdL/mHPdQ7rEpXTPLrp7Yh
	WtggYxihtxgtlqVTngmUKHG+z3tgsA7XYFdzOdSkn7m5gwy3TPIp5XrS0MCoXA==
X-Gm-Gg: AR+sD13GNn2yKvg7ywu9Z194Wc/yEzSS/9WOdJCtW/MetL+a6Zsn12zLcG2uexyFkav
	6zQ1lvIoge7Y18SymzywE3CMAW7keCWAInBiuOpIER8dV1MCa7qFn5gWwZ3AGBwOS4W/BD/+t0y
	rKEE0cLhz28pyrEWDcPydvdBkBQlDJqRzHltQN+pE6QDtOJ7byywrlSX/I9buU3U1DKCkFgD4r/
	ShxttXHHC9jmC6D9vVTr/atZBorJsM4eVA76wqkxc0DVhNfGnevHLKqHokDCWc23JSpl27WLYIg
	TxCbCGJvYsXw/BisRJ9pjI8NotWZlO8OfDcPvRFxrV7JV6m6Ycb7YI4l7YrylSTOaDUZaJOMSbQ
	Et2QboZGba4FM/qQ394O5k4ivdTf4JHg3hu0V49YOWY7kjxjVxYJrcmJRejE9y65WulTTHDelpM
	Pbq9PSXJto5Udl9cX8dfc5MU6n3G2w8N/Z0L0FsThBidJpnv9jGLGc3fRi3QDNFdgK+A==
X-Received: by 2002:a05:6a20:ae2f:b0:3c3:875d:c52f with SMTP id adf61e73a8af0-3d267a6b517mr32053817637.10.1788047775994;
        Sat, 29 Aug 2026 16:56:15 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.217.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f959575sm18652697eec.15.2026.08.29.16.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 16:56:15 -0700 (PDT)
Message-ID: <6a93719f.92d2873c.3b6c2b.1f75@mx.google.com>
Date: Sat, 29 Aug 2026 16:56:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7011358680918359827=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect
In-Reply-To: <42d4d3cd947746c677c00f2c8aae0a0c2189f1c6.1788043687.git.pav@iki.fi>
References: <42d4d3cd947746c677c00f2c8aae0a0c2189f1c6.1788043687.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7011358680918359827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153726

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.81 seconds
CheckAllWarning               PASS      30.29 seconds
CheckSparse                   PASS      29.61 seconds
BuildKernel32                 PASS      26.43 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.96 seconds
TestRunner_l2cap-tester       PASS      64.99 seconds
IncrementalBuild              PASS      26.38 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/666

---
Regards,
Linux Bluetooth


--===============7011358680918359827==--
