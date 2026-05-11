Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A6CA4E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525384; cv=none; b=He151lqW5MyFioHy2n6TludDjaqUJYzZ5Ukhho3otII8N4D16miWI+M8mg8daiodcZY0W/64828whPkxJTmsPVi0PdiMWgI6kJ7MzhFl6tv0b/OYJ6jn9sHvvFJGZx706O1PsMfPcJSDHEo+0aMLtp6E0NylR3/975OFm+Mvm7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525384; c=relaxed/simple;
	bh=k2R+tt+w612Eq66ur9hQ2WtwYbxAO92nza9BDxJxhqA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fcE+Pf3i/f7VQ/NFT68U9arhwCrNuD5hBiqrmpclFLTfR0zjITntkGrgAieLBR3RSEe1NGu4ncuL5O+91Tdb33TrBSh+UMg+dP9Otyhrkx/Hj3yIYqPiXe+dKFhBTraO7RA/lk7boO+KT/jyLTdOBBduk+7+Eeph0MrSOJlfPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE9qZdrd; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE9qZdrd"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-900fa9f178dso505173685a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525382; x=1779130182; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zexb0Fpg7+5HVQ5wzdVMeSxz06YVVXn0kOYY/OebCvw=;
        b=PE9qZdrdHhDHq0zfFx5n7yToExTmd5q4MLaALG2lyw2otXZOdPv/R/TjCuZvFAG2zU
         kSHDXaGvy4OehlsyWotCZXF5wDtGXZ2Np1fdSg8A8NW6RZtRM6zCvdO79Y4cfDqKDkP4
         6kYE3RPYtBCqCqN57U1Xlc+EbWxigmQ857eMjyh1A2kbMbhgDCrks8hMf4ooMBRzd1JL
         CBGN3SqW9kFnYBMOukFzGb65TTra4lfsHCwsXvwVx6E2bdrbRX2ZuSa+iDjm3S9kWh2c
         O8cREouvc4yuCb1J6+X9QLbpu0Y+ocF4YXagh/1gaWskEhkVBDymjvKLdlSuswuBAVdw
         h7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525382; x=1779130182;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zexb0Fpg7+5HVQ5wzdVMeSxz06YVVXn0kOYY/OebCvw=;
        b=f9hG+mABl8TjOvPvLT14gSKPH6DXhcR/JeBWedqG+a+rDaxKU8wbW+hid8+32kglgH
         1sNvSNHwybhazGbKaDI9gL40Htk+2FUIsZK/e10Tawb+2ZvWn14xcOgLG/xgIsPxZzZW
         +jIZL21/PmkljE/pbI8xsazdhRCHvmDSBv69fbDOLxPHcaz3IfmTReobGuiAH3zLWOGF
         VBOXDMekvFO7S70vICsqkciRGL8M5ILRJMCCrQf2TwQkdVuhyR4Scqptw2T51KuYJEMd
         Ivaipt2DvRizyjaBIbN09cO3GWUHr1LpuJLW2g4K0YNWh1l36fFY23AV0kyHUvIKhays
         p+5g==
X-Gm-Message-State: AOJu0Yys2UEhovMjNOD+e/XOZdEb8Lrvp1eGADC1oCMDTwJchSdbTrSY
	SV7yCFPZyqDrjxxA2WNy9h8W5Z+27zj4KzZKEMVvWdzhFgkTTgETHxeDw1nxDg==
X-Gm-Gg: Acq92OHSE097hxsAh0DgG/Iqc2OXOIR5j35u5Iw9yvpAcdhW3Qtge9/s/pt+F+J6z/Q
	quXmX9JJ5KPCna1SSnDUVDAUDdm856dK9EbGtyjIFb2HVD/qbeSi/29kYdKbT/WVJJCMxK3tzu9
	9+7j9wNGkzr0d7sEP71g7T7lDiWRpaXV8rxd6Wf0dLqm6RZjNvPJ6/MFAUhS8RFFhCEpxq35L7d
	5PlIGDF+fVBaHRohHuq3FkT5j0AMWGuKC5WozOzBjkjg27p1W32omHhur7Q2enG4CjYsIoW3HgU
	cMwH2JHvbZ9ibkz7mDet+bJ5pX+FFQeieHtYT6fQbEJzpPTDW3ruuIUk/EqPvszQSzf/gmpQelv
	CALw8HT7DXCpTT280w0nQKuqq1pjrx79b+WSwk2ZX5bEYsPKREoBdMiCFRpoqjZWMHid8nBSx1p
	xmUtg25MNszTR5/gdoZA3iAUlj9O1NIw==
X-Received: by 2002:a05:620a:4084:b0:8eb:10d4:a471 with SMTP id af79cd13be357-9091092342bmr1554736885a.43.1778525381647;
        Mon, 11 May 2026 11:49:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.196.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b977274csm1092406285a.6.2026.05.11.11.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:49:41 -0700 (PDT)
Message-ID: <6a0224c5.050a0220.32432b.e35d@mx.google.com>
Date: Mon, 11 May 2026 11:49:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4448234459826631502=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260511170929.709823-2-oss@fourdim.xyz>
References: <20260511170929.709823-2-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4448234459826631502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092984

---Test result---

Test Summary:
CheckPatch                    PASS      1.40 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.78 seconds
CheckAllWarning               PASS      27.90 seconds
CheckSparse                   PASS      26.85 seconds
BuildKernel32                 PASS      24.71 seconds
TestRunnerSetup               PASS      524.97 seconds
TestRunner_l2cap-tester       PASS      376.41 seconds
TestRunner_smp-tester         PASS      18.41 seconds
TestRunner_6lowpan-tester     PASS      51.29 seconds
IncrementalBuild              PASS      23.95 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RESEND,v4,1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[RESEND,v4,1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()"


https://github.com/bluez/bluetooth-next/pull/172

---
Regards,
Linux Bluetooth


--===============4448234459826631502==--
