Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3798634EEE1
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602966; cv=none; b=PuUC5RsxeggI/Smx4Tf4+T49mJsgFlr0BhhmYaGvphUhtCdUzHjmgldqbuWG7Q8rzIw87J47XZKfsTxqR3uxtdFmOnLdarxVd81S3nE+Z3wd9chWugfk1W1v5HcsjrXqwwqqe7OT4bR5zsedMRTwGKdHkYSbGkEeMttBTHPWwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602966; c=relaxed/simple;
	bh=c18KOwSi3S+6cuNM0XfO2RuOJ73LnOLKlXpX/dmT0Dg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IHGKmjn/aQn/Yd50+w4CO0iKybpaG0q9PdO9tIIul4wfXSHn2bhmFoxJ8+nlFdqMhqpJsotBYDEZXO3npwfDBMLsiYhi4wq8gKXiDpf+fxhf+jLgj67H7rzEjs0icnfJviTh7WjKR/zLI3xkY0JJ5fz7PeB5ViouqdvVUHnNiBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaLPD3iK; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaLPD3iK"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d4c4b494fcso1330604a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 07:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771602961; x=1772207761; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6hom1s6eUAx6MwIZyPdhEhMI+rM5dQi+LM/oBQVJWS0=;
        b=TaLPD3iKppt1aPTkj4tPCBqpxIKApNTbkH/ayja8XseeAbxyTRXp0yiyYP1MUIPA35
         lzOPDAsOVTYt6jhVAiOa0jTJ/3jbvK0be+ILuPEEUNU3oLTySa7PGJPdVmaN/6+NjL1W
         CSwIYjSeQGSA3q1C0ZV8gM7yOal7I6TFUuAcqrnUTLlxcZ0kSK9ShCTILSF6aZvtEend
         ZXpjMgW03N0cFCdaL7y/J1/buM/hJ+Sq6VqfHdrMB3lLsyDqnf26Y5N8AoVE93Blyacb
         jXPa2EEfNTowAToqBs+7POSMkKjpiGVeXvFbaz5K5d14Zg7XvZUzZqXn72uyXPWTpQId
         ANLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771602961; x=1772207761;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hom1s6eUAx6MwIZyPdhEhMI+rM5dQi+LM/oBQVJWS0=;
        b=dAlRTT+hPaE1mnvx6X71cQkyaIMgE4JLREhqcxKyfuDzyiN7O4XVaI0/UsmMCYX6J4
         9tlit9a6rBUyDu8fdd2AGhAIvGQ349tOMBJoutFEV46HMRXrlHDIxK5bEKMykoPWUN9N
         FtgNBsKA6yLCJKC+Ww2J9a1XnPgizfwZ5+wrws+W174dsRGoTDpFeUh8PIKWRJ5JEJ82
         etqLDkHxwipPfhTeyOu31ybrbGfQH3d70GgrEFetj+X/N9IB4dxfKfTQZQGyiFux4oLM
         XTo+YjhCSjNAp7GFWvMvzOO2xVdWLR3Ve+jyKrqc0diXiNTgHwBSoZfgANyZUb14zTgR
         XRbw==
X-Gm-Message-State: AOJu0Yx4BF7cwq7gDqYq1dDWi3XZKRJiWqHRwvJZpGHCKhTT8uA87d/i
	Yu4/tW3pMIdKpYVcB6Gvud1yX7Xh3Crf9i6v0ZFgOgpIUVZ8RBarXqYDn0jbqLxq
X-Gm-Gg: AZuq6aLohreaIJkoGcW1yMxdqnzcOEgmf4ZFQ2QqWgErcVogq9ZfU1vlvXgjgFUlNHT
	8LDrG/VSV5j34DwVexNPX6I7ZCJ9RP2lKiD9mQ4G+eTlpuFHPBdJL8y2rw8DDMeRH0+bZJII6oQ
	//N3NHUXwMbqdMJDLiKTUmD4KbPxXTbrghledTeFprQn9P6cMP0CtaFfBYSmLVyml0oPL5bUa86
	4gEGIhg3l1PFHlUd1TLsvgUgtNEi7wRQwP4pel1RpnaDWD7+bGwreVtMoKkhfbA1sLvA3ZUUPkE
	8FvPyNliMn9gLJkWZHN5+DVlsgsAsaMOVeta5MmpkRzNBsjTP300D3aBC9+R6XWjd7u+WaDlASA
	SJOoUZQM3wUzWtlJytqzl3Od0ORjXNBYgBDdLwOUjYUspRFD+H3IudK7xmNq+vH3xkiWlI3pgSU
	glrk40wZj2NZXkvDFofZ75G5/UW1xUPw==
X-Received: by 2002:a05:6820:c82:b0:679:a4fe:f024 with SMTP id 006d021491bc7-679c44d0e3bmr162167eaf.46.1771602961496;
        Fri, 20 Feb 2026 07:56:01 -0800 (PST)
Received: from [172.17.0.2] ([52.176.138.195])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-676e3b52902sm15492350eaf.11.2026.02.20.07.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:56:01 -0800 (PST)
Message-ID: <69988411.050a0220.3a2b2d.a151@mx.google.com>
Date: Fri, 20 Feb 2026 07:56:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2990249362936692442=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, maiquelpaiva@gmail.com
Subject: RE: Bluetooth: mgmt: Fix heap overflow and race condition
In-Reply-To: <20260213072205.18404-2-maiquelpaiva@gmail.com>
References: <20260213072205.18404-2-maiquelpaiva@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2990249362936692442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053815

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.56 seconds
CheckAllWarning               PASS      28.22 seconds
CheckSparse                   PASS      31.74 seconds
BuildKernel32                 PASS      24.90 seconds
TestRunnerSetup               PASS      559.18 seconds
TestRunner_l2cap-tester       PASS      28.66 seconds
TestRunner_iso-tester         PASS      93.95 seconds
TestRunner_bnep-tester        PASS      6.40 seconds
TestRunner_mgmt-tester        FAIL      117.96 seconds
TestRunner_rfcomm-tester      PASS      9.62 seconds
TestRunner_sco-tester         FAIL      14.87 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      11.44 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.64 seconds
IncrementalBuild              PENDING   0.56 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.785 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2990249362936692442==--
