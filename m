Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4D2C859
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Nov 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762110212; cv=none; b=IaAj8DJVxroQIhUyjuntAVjqsYHFzVQG9dL6vgY+1pTNd2ZOkRL3oXBlSpXnbEGKmuqKB7bDxx2VJlLeGld7+WGpmeKd+RR0ye96qLKOBpviBcx6ztSQeZTMkkFF4KQkd0uVkDj0LMrOLoo3N11eqlduJqyJnhbRmMuZ1hwGV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762110212; c=relaxed/simple;
	bh=+Ls8RzqBRRBa0b22Ct4E+FoUEteAwJMhoijPWR5jXps=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ix2r4IRetbUe8HtDfoWqXhqXX8KRD23OSJEfAoUTTYtqZbWXRJSxZK4pLfIVL4D0cuC9EImMZSJs0c/skR23BWOK1AHgreZvlg+pipUte8LtkNRqZZJ/OpNof4WVPRXmcTq4tVlOYI9Jc24zbptS5oOXOx6rZNcqoy2zMF9/GWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/xKTOk4; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/xKTOk4"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8ad29388523so115602085a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Nov 2025 11:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762110209; x=1762715009; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3bp3PeXFARQVrbA+um2aXbzzgiott01MYkX+4ICXhHs=;
        b=j/xKTOk46UziXy1rt0Z0KYqKv0RZoh2HA36d8kKPRxxiqErQs9DWXs84nRbkEanSTg
         ezNeSQYbbLKD/2wVOPkLPFzKbJ6GLfeiUy08ct2bJaT3xqJ76AGWNK16BROZsN2nMAcy
         6glKOWh2qYoR8nIrf1NwDcrHrvmpx8iNDsFuMwbmWUGkLN6BMCFPtwpSG2hXvNFyO32Y
         uRekBtJfwBEoro4kNOqAiSswJtHikOb5MsbgkF8QOMkGcqE299dVYyEZoh3BvJxdEi5J
         U64wQl+atFvZaRrX3Q6bVYn6zccGduNXA7jbvseN1UzdJ7DkH0cc4q1e86y8RRGVJbyB
         Wh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762110209; x=1762715009;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bp3PeXFARQVrbA+um2aXbzzgiott01MYkX+4ICXhHs=;
        b=UCbiLJilwoEvYf/9wikYFoebBiLCrA/WkL5qUVnWLSSSS/IhfrQq61EVpHZDM66t6l
         scNI4aWmLuQAg7aiHU83Hy3Jnjh3IQUazz6PPbV3aKl/xcGH75eMgycMc0nECs+IN1yM
         uzaQ/KaYlvBlbuRTGkoGYAPKUYV4kxwDYuKldaP1B+7Ko9ULJnL7rSpKedr7Mbe+yJOm
         I8C5beEA7QXgSEYo4sTGWmWGxcym/n4K1/S89aVfQfjYo8FR0D1mmWIArd1lCq44At7v
         cSDZmv558DWuLPu7clA5uKicQgDSeRQTgJiqWHPTnWZ2Ba/3G5uIAPftgFIztV61fX08
         jZCg==
X-Gm-Message-State: AOJu0YyxUEyrPevxJwPIF+5UABhakI/89fu7lglHqwZRQpcDURbfRQZy
	ShEFg4aYNfIWyaCphKOSzXbjuZQy0tzESS1TRLGW9nVB0CgHsy+jYO/LaspNacWA
X-Gm-Gg: ASbGncuA4VunTOMwewju0F83SbHExHoIlShpXN01lxpkycdHBZTfKOjsLS2nV3CJpzt
	GqG3ihf0IHEOJhdPBwfDOvcl086vMva8mmupMhcgjtf+lEW5AGs2qZr36rV2z/5oS4XNu0fFcwI
	V6hRyqoCMKsNzMlGINZgvB97BqTg732j01NnP20PFSIbv35Lx7VN2+AIbYQBZnst7QoD4643QeJ
	3yfYAuCnriZ1g9f8JOUwR9Inzj+pswiUFUpNcRpiU25D2q8uZNepbKnzpDa/J00wJ1M9DwosT+a
	FmgOj6ex1PQU0CfblWvVSajo22ka3iDrS24JUBLTmoxSjQfPozXZyiYuVN3KE/Djd6avkfI3kKB
	1p+f+ZCW0vB55T3h/idKx4qakl97O1LXbGw4Ma91w4MrzyoEs+bh023Ixgogdt7S6hkJ/tY4qUf
	Qi2SqM
X-Google-Smtp-Source: AGHT+IGgvG6RklMyciWt2+YtKTHHGYFYdGzLEs7YdlY/Zyglde9G3bgjKrH1LGUxz+M6f3lDMedhhQ==
X-Received: by 2002:a05:620a:1a0b:b0:891:d993:1bdb with SMTP id af79cd13be357-8ab9bb6e274mr1183583185a.86.1762110209353;
        Sun, 02 Nov 2025 11:03:29 -0800 (PST)
Received: from [172.17.0.2] ([20.161.60.20])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed35354982sm43557991cf.34.2025.11.02.11.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 11:03:28 -0800 (PST)
Message-ID: <6907ab00.050a0220.280034.9ef9@mx.google.com>
Date: Sun, 02 Nov 2025 11:03:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4131201846033079824=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: MGMT: cancel mesh send timer when hdev removed
In-Reply-To: <75b74d712d9eff4d79f05476973c004c226c08bc.1762107269.git.pav@iki.fi>
References: <75b74d712d9eff4d79f05476973c004c226c08bc.1762107269.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4131201846033079824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018649

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.18 seconds
CheckAllWarning               PASS      27.33 seconds
CheckSparse                   PASS      30.74 seconds
BuildKernel32                 PASS      24.50 seconds
TestRunnerSetup               PASS      493.07 seconds
TestRunner_l2cap-tester       PASS      23.43 seconds
TestRunner_iso-tester         PASS      69.88 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        FAIL      109.59 seconds
TestRunner_rfcomm-tester      PASS      9.04 seconds
TestRunner_sco-tester         PASS      14.06 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.38 seconds
TestRunner_userchan-tester    PASS      6.75 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.134 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4131201846033079824==--
