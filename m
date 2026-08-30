Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3741D19049B
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788094853; cv=none; b=uWGUMvy/VSpBg2z7672PfhI8Ktjxn2njOtwyqJ8jsEmJT4Sc2VRCDFcqjRLIr0s7KOdOTpZZDUeSqE/vc5J75XWCpvQsVKWRG7tvpdcf6rZ3SjHurIK9/kP8s2c37wGO5ooev5fK+Me5ETfA2V5gRMOqdrGiTwIK99eBZ6n92CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788094853; c=relaxed/simple;
	bh=CCk6xuD+TjRTYa5LGIaqBvb0l7jSZxhMMSVt6caLn0E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lQBT2wLZ/5QEHiyTVa1QmhaFZgvIf5Ubh1kD+vebfy9bKxdF/NOMTS6+LhZoEKgWTtE2KYW0u5U7DAGivhYVFNNaFPn+bOLFXMfr2aPDbzwJ7LcP8uEdkJtOEI7Jxt/EM9vBfCFNp2YyGXcFJtyqEHi+/zBLDosFAqCbQkMxmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxO/F59R; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxO/F59R"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-936e393176fso151977985a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788094851; x=1788699651; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LJhMXeB0JEkDk3Rtv82/C7YnGpToSwS4HESKLe015yM=;
        b=mxO/F59RI5kXL56g6oCzffJvtBQvm2BUNfLOYWQ7PLQl0P8z1RfD8tbY+XK422mZw2
         Z6bynu+ixeA5BZoYcdbfnYVViB4dvUHOPwZsllXObA9pUZafrU96lpKShWVEpwvsVa4O
         IkMaqYWjYKUdOlIx6f0zkiHEHh/tD0v1ZVCJu+EIKjtQYeipKD2vDYBp0jPiaBrgLzcg
         0pCywXUckPgG1xd0Vs4EydJH6HdTbkPZ4DRY1y2TafhAcEebjkgwX4oQcNojMmpUp6Yv
         XSWAFrG5gTH5GsBBYt8fPDfeM7J0fidsgvt9oG1oLUrCNffT3XW2htjWAS9Yot1ZWwgH
         rhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788094851; x=1788699651;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LJhMXeB0JEkDk3Rtv82/C7YnGpToSwS4HESKLe015yM=;
        b=UdXHD5r2t1cyCYc1jNWfyY4AHgFWdvAkqyzZxMNeK5ZCXIp1Y+4tpD5B13iS0rlXTU
         jbm4PakPvj9vcVWYHwr3H/PiVlqQjN0gWoBqDShorJXYDOJldl+wJlo5ez0nekF3zJiy
         vDYwXJTGUkVoh33z9HghW1+h93osa+HHNx4izQ0G4MeycBooyxrdw4U9GnXlZUspB8RR
         6BIIcp5Vh5XNAUn8CnTRty4+ZAi3uWZwXNJvzalv8OBuX8nCKi7C41i6xiF15b62xEgd
         DG+3A3VWtv3xdSUt+05YsJ56/EWJ9e8pHnqhn1d3E2d3oLaEN4rJCDKQWpOPNlqVrjIy
         yj8Q==
X-Gm-Message-State: AFuF++kqxeIpu3mEdJnfJEK/1MeUtgyubFgyt/rRAf4GST7YL69cN+RN
	Kff6VO3vF3kiDtMIGqw4LXde/xbkzK5kyqy4Vexw8LLqvbJO2RumyxUPpZ78Nw==
X-Gm-Gg: AR+sD12j/B/LNtHpf11MnhW5SRTGEwY+ESsH5vnDFKaYoNz3357jmMUP5/XmJH4p1j9
	tRoVEKpN6TrqmHW2IoUPdA5XlR4s4Ngg6TAH1X4eRRFlToVovA41+5qHZb1h2dlzSDZ86NfkZcE
	BAU54ewQPi4U5Htonkxey8YM0Mx0hN4MgRUyU2/ucTEGbzwWNrVs1VY7IuuFjToVXofoI/Cis84
	m97q0prQ9vdvpveWlRtTYShCJk7+PmDMeJx3YlRzY2DJ1jtTXPJPyuEk87VD2efW71G5WBwGcgu
	AFGQ3ksTdGM6J/JSdhjy5KZb2paY1Gp8auSOIq5dEDR/lwhYvz7J/Ew283+6v6tiNao8PL8dfdA
	+wx88BMM+W3yzXE6oCl4TcBtvj0df0e8U9RhLA8K+sjgoZY9BUSkubMG6ndmBis+/zglRT8Y+LP
	PxXeoXhpC1ZxP3SvuNJijf0Ih6cT4JrzUnFRzVBvuJCLsVatXvPt16RKEbNpMClC+tEje24NAgT
	+Vu7Q==
X-Received: by 2002:a05:620a:8a16:b0:8ee:bae8:2bb8 with SMTP id af79cd13be357-9391396bbfcmr1510485785a.36.1788094850959;
        Sun, 30 Aug 2026 06:00:50 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.142.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939172604f3sm569888285a.21.2026.08.30.06.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 06:00:50 -0700 (PDT)
Message-ID: <6a942982.35b683e3.3afc09.08da@mx.google.com>
Date: Sun, 30 Aug 2026 06:00:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7211791168202509683=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2,1/2] Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect
In-Reply-To: <2b863abeea0ada6e990b07a7f3182e261ecd8e09.1788091154.git.pav@iki.fi>
References: <2b863abeea0ada6e990b07a7f3182e261ecd8e09.1788091154.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7211791168202509683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153829

---Test result---

Test Summary:
CheckPatch                    PASS      1.96 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.67 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      27.91 seconds
CheckAllWarning               PASS      30.37 seconds
CheckSparse                   PASS      29.43 seconds
BuildKernel32                 PASS      26.83 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      507.47 seconds
TestRunner_l2cap-tester       PASS      64.99 seconds
IncrementalBuild              PASS      29.26 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect

28: B2 Line has trailing whitespace: "    "
[v2,2/2] Bluetooth: L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM

18: B2 Line has trailing whitespace: "    "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/667

---
Regards,
Linux Bluetooth


--===============7211791168202509683==--
