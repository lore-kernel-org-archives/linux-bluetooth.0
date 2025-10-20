Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0430242D9E
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974580; cv=none; b=Pt6FZJN7v2AvhcmSghe4Rdj7eBJoU0MDvyT2r8H/kR/N5bF2vSJOHADVmWikiEPw6BPR++vX0rhGNYB7GcDLw0YIErNWi0M8vvN8w5YNi4Otd/CJbDXy2NUui6A2oi/r0SfJ5MplQGSKpPycHs6D3mfG+/jzx/q1wkwPU2ylZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974580; c=relaxed/simple;
	bh=AzL00cejeUXsWDVN34h9Kgx0KbdgzNPnc2MoNtzbbC4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OF71ZJfhvGqrO6Emq67UZEEOOWEYUkR4HcAiKsLejWO4vdmLQX46ub9B7SLC0fRNdlAuLD4C8NbkCNwyUCu90PkHEUK9XM0vJF34hS2lyEKUbmNMbByxEv4/TGpsH78OuL3/q1s33QttarpHVTzY/4zdr4bL3TwRmbykzQtvABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9ogzahG; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9ogzahG"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-93bccd4901aso392474039f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760974575; x=1761579375; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3O+PJAHbEmR5rvW2gkce1PWoyY3cG641K6sFY8HXAOM=;
        b=J9ogzahG51m7oboWjVdf3wBhPv9EUvJAV4VuomPVNX7YIZLw1oyWAhzFsTjuWV6iUX
         oK0DOtEFfXmapIXQtAHlJGlWiJkgsVX52vXzKJeRRqPXrRnbY8XkniKU29AbuYtPhIii
         U19vYh/gt3qRUc76olASGq9LwtJH6ve8TSXMw3AK9127iY4rWPL0MkSYWoKl1wS2Gql5
         pS7j+JaVNpRZmv/oGD0witJ9ldWA/ekXz/P9waZqrvKDD/GM0PpfHQgpRKwXPcDwv9Vt
         84mqMTxsCCHjsNOaPnZRhLpchUDWqZisJaezsTGWKMikGAwcm2oPPAo0K/0Qugbiimhj
         JHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974575; x=1761579375;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3O+PJAHbEmR5rvW2gkce1PWoyY3cG641K6sFY8HXAOM=;
        b=mGcVg8SQ57MFe9kEBtNETcUQc/wfV9PlVuW/1aUwinedakqb/nHaMM2ctZzy1SHB+j
         hbezVRbCzWGuOKBY/oqRIZ5BXV1buyv2FwkD9pZY9xrW2lHujjcmwNW1Tut1NF+eI8Xp
         29eFs9Rf/2QSm5RZiTVvLkMjd+61xBd5a1MJUZvSbVTTPFl1TavOKwzZcno4TxAgSxzl
         hW8G5xgC1PvcHvf64MK/4pee89HiowAWjGEAcD4mEIs8FXEb4cha19eQNkZ9yRxX/Ho2
         D/Xo4lIlAwS318Xb5GUwbvbytUldUEqyM70A78f3lDS44A6qy8wX7sonGer1cvTw9mXS
         1OXg==
X-Gm-Message-State: AOJu0YyJvUZrTM9x2lx3jxrqL9iNqQpSgdMxpaEqWNn422n+lnOZTEZh
	QtdoQiQuCz6Ufrwz2PTcwTkGOjsVZylTmMqHAwZzq9gASgrlYdegG+0yGb17ww==
X-Gm-Gg: ASbGncvNVwJ4nMNdH5UqZLB2JNs7j8+EeTdQtYHeH3i4wc6LjRBnEaguKmZBVGXUtF8
	raE+LX0HLsZJb6GB0kg8DHIqJCZOjO4jNIhQE3ZrLUcAqnMzUKPGlBLPxuzWh/It+pwf8EW6+H7
	Nfb3d+6u4FO/dYchv2SyMLSSG9VRkn9lmz7blr0PoJY/axi/zejGA8JVZ0rC6AuPIYpHE2W9m/E
	L2+lx1mTWTz8vYZzC4ymMSSS1kmmzzi4P6GGzcVpw65iXhw8qoN7DT+xota87GLzaeyq5oUELTB
	y1YA/m3nidojYhmmt+yRzE3e9JHa1m3+mJjOU2D6S51qp91qx7LmRwzb5orrWCk0d7iSwvFKysu
	yfGvnmwN7qqvFGcfo6nbp/kWmn3tb+VEAO4ZdyLHe4VMCwd4fmG0+Qwm26cibva6kEzgP/KkQMI
	QHgnw7XZ/EFG6dYn5rKOHmNnmeM0A=
X-Google-Smtp-Source: AGHT+IGjKlJS8L6zLeqU5R8L7Mtq6J9t7BdOUBwnt+d6r+nLJ/dI5Qkdw2VG955i4Y68UnTCBiJ3Wg==
X-Received: by 2002:a05:6e02:1b02:b0:430:bf89:f7f7 with SMTP id e9e14a558f8ab-430c524fb13mr223728315ab.13.1760974575407;
        Mon, 20 Oct 2025 08:36:15 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.83.38])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d071ebccsm31488645ab.17.2025.10.20.08.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:36:15 -0700 (PDT)
Message-ID: <68f656ef.050a0220.f0b80.4b22@mx.google.com>
Date: Mon, 20 Oct 2025 08:36:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8203524995299986575=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Ilia.Gavrilov@infotecs.ru
Subject: RE: [net] Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()
In-Reply-To: <20251020151255.1807712-1-Ilia.Gavrilov@infotecs.ru>
References: <20251020151255.1807712-1-Ilia.Gavrilov@infotecs.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8203524995299986575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1013638

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.53 seconds
CheckAllWarning               PASS      27.03 seconds
CheckSparse                   PASS      30.34 seconds
BuildKernel32                 PASS      24.41 seconds
TestRunnerSetup               PASS      488.14 seconds
TestRunner_l2cap-tester       PASS      23.93 seconds
TestRunner_iso-tester         PASS      93.03 seconds
TestRunner_bnep-tester        PASS      6.17 seconds
TestRunner_mgmt-tester        FAIL      112.90 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         PASS      14.47 seconds
TestRunner_ioctl-tester       FAIL      10.38 seconds
TestRunner_mesh-tester        FAIL      12.31 seconds
TestRunner_smp-tester         PASS      8.52 seconds
TestRunner_userchan-tester    PASS      6.40 seconds
IncrementalBuild              PENDING   0.46 seconds

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
Read Exp Feature - Success                           Failed       0.108 seconds
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 26 (92.9%), Failed: 2, Not Run: 0

Failed Test Cases
Connection List                                      Failed       1.059 seconds
Connection Info                                      Failed       0.133 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.764 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8203524995299986575==--
