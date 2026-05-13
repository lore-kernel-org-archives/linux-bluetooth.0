Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834A3955F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705105; cv=none; b=hZDylxvF018sPdkn25gfAWrTZQ2z+b67EAO45sj9YLDf3uOWhi7eLL7VkmO0gUwqaFxFG61xYpKAapGvEa5PRSoCnFh/1/IYDoWY0leoNSiYSMXO7QV0Z1eULVs7J3X399M+4hA3uMQeynGgzraI9bd+X6RXI7vNvgrVyEbNarA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705105; c=relaxed/simple;
	bh=Gay+WEtpK1quK/d2FHBBirKXhKL+Tu20QQ8TJAQ7R2A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nk9a8Z4GV16JfXMNqh4IPQQMrJgNfCmVLen+3rfCualPw4lB7t6Hpb5iQ7fFV5hiiAIcKhI50qMHo4qkPy9my2g6PU5p+3bMb234JIpz/ry+Bfof3oUykOEmRTTb6sEDpYJ8Z+R7Sg2KOISuXjj9BTXihF2KlZX1xw4/TGGHvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og37RPdU; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og37RPdU"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8acb856a674so87488176d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778705103; x=1779309903; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2J41aJaD3V6kelN0IRYL39+CuvIbNh5NxXi9LZ8mWbk=;
        b=Og37RPdUOqhJryEVEaLECXtzu7/noIEoDYS8/UbqplCUx7TN48YAuTNqhAW9RXLEQw
         1WzQEXBIvKiIH7bdr1302pyEpxq6kOxCDOycFDOH+JpKkwCusQ3i5e8HXpBeAl/WEoHa
         3osSU15OY3+BXdv+bfJ03IzcJNZKlxVM1aYyxclHOrpH7fWjn7YBrrZ+jUE3z6pF2nFW
         KOS1jh9McFg9QnjvR0MBaTIIn+eaeo8EDkDaC2QGqwxWU+ROrMKBtTlNVBgaXhs/NMyR
         dVHXzzdyys2DhBT2MUEaP82dEPraOG0zzvbeqsOYg4YGkBWgLZf61sJpAx0i06zYsCqM
         PdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778705103; x=1779309903;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2J41aJaD3V6kelN0IRYL39+CuvIbNh5NxXi9LZ8mWbk=;
        b=EVUvXEJceXPbtUWVsX+R/O1GG9eagAwRRiYnhnhwOda2srKvSsDkFJFNr8xtoQszLA
         mAEvuP/2QlWohI69clfA+EsmwvFUIFnp35ktLTwUB0lMxjHDKxSdH1099OKgLFLS+Xbq
         p73cL/Hyk5YCMvNwE/UXPVDBf5t9oRJywEC17SZyyGeKGZ4eOaXK/8UVWJEC9oZEcDiI
         ofpYKYCSqhsV5j+QUJOrFelU2xpN5ve/514SWp3KvXGfXwab5DpcaQ6ZTkJMg+Cue0ig
         Gq3iP7RYEZ0H1fe1jPaFpYgZxnUYdGLUS/Uy9n+mZ+THocXlBV0z2c9Vy5YFsimbUMKH
         oedQ==
X-Gm-Message-State: AOJu0Yz+S9do2DwLMO6Fa+ZPdCrhLOgVUccHkeWo7C5GPtuh1oo0jgQN
	1L3T4LJOeTUUPoJgMjLwI7eSwMmB6cvHqIJm42GpQG40ivgr1ibFjw0KgVcA7A==
X-Gm-Gg: Acq92OGZEr3TiMBlDEZNQtYGV/Qz7yxv1IiMuEulDU33mRo9EV+htc4s0oroOm92d4e
	Am9d7VJQ1YknO63pFMOUoDHrJOUgmnSRni4frqeR7dImF+tai8kuv89NzdRGKklcIjhhFKZYBXM
	/MrsOCI6hxsO0j5FrEhy8oZNMJFWqJN4Ydna7AOg3FnxC+CLQqBF0cfXIMgXQr3o+OlIN3KT05F
	KaSlL8LHs6CzcS5R9Ic7bJgum5XLRjA27dLxm9GTIcT8mVHdr9dNqrQP29R+3yyjot84aV5DP4Q
	YoFf7e8PIzxnX7wQReCkpO4h94V89Ed/Rj7uWcDBRGtd6YD7PlFzk9l3TNYblP9ZkmEZshfEThK
	0SmKve9sadtbis98sidQHDTXturyBsZT2Qoj8wkTIctHxVrYqj0cZfOlrzQYAgZk2S0cPmY+A41
	D0u49y5LwH55xMMcp3sBZjPuVumBDPyUlS
X-Received: by 2002:a05:6214:2585:b0:89c:3f06:537a with SMTP id 6a1803df08f44-8c8fda1e6e3mr18137546d6.21.1778705102945;
        Wed, 13 May 2026 13:45:02 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.102.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b2dc41fsm5676746d6.25.2026.05.13.13.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 13:45:02 -0700 (PDT)
Message-ID: <6a04e2ce.7f7f1747.324c72.f10b@mx.google.com>
Date: Wed, 13 May 2026 13:45:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8929372129479093574=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, halves@igalia.com
Subject: RE: Bluetooth: hci_core: Don't queue tx_work while draining workqueue
In-Reply-To: <20260513-hci_send-v1-1-ae3eef758280@igalia.com>
References: <20260513-hci_send-v1-1-ae3eef758280@igalia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8929372129479093574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094429

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      25.24 seconds
CheckAllWarning               PASS      27.80 seconds
CheckSparse                   PASS      26.72 seconds
BuildKernel32                 PASS      24.56 seconds
TestRunnerSetup               PASS      528.86 seconds
TestRunner_l2cap-tester       PASS      374.94 seconds
TestRunner_iso-tester         PASS      604.66 seconds
TestRunner_bnep-tester        PASS      19.00 seconds
TestRunner_mgmt-tester        PASS      2024.13 seconds
TestRunner_rfcomm-tester      PASS      63.77 seconds
TestRunner_sco-tester         PASS      141.62 seconds
TestRunner_ioctl-tester       PASS      134.21 seconds
TestRunner_mesh-tester        PASS      59.93 seconds
TestRunner_smp-tester         PASS      18.06 seconds
TestRunner_userchan-tester    PASS      19.33 seconds
TestRunner_6lowpan-tester     PASS      51.00 seconds
IncrementalBuild              PASS      24.65 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_core: Don't queue tx_work while draining workqueue

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
27: B2 Line has trailing whitespace: "--  "


https://github.com/bluez/bluetooth-next/pull/185

---
Regards,
Linux Bluetooth


--===============8929372129479093574==--
