Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC581397E83
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578482; cv=none; b=FqbK2UeMgBCol0ss4mvreM4YQnaAOXKQJzC/MUjBFbAjc7ZEIlJy2wAYfDNOPWVYckKzESjeDYTAYseARLrkcSms+huLouFFO7ZS37kLOiDM28jxLfZt8TqJpfs4MmMq/gl1vxZ7T/wc9PxthnB/PE2qnzOHPxTaOBD1y0LFIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578482; c=relaxed/simple;
	bh=QbCPDKlH3cgapl6FlowH/IKKnIZ5VRya1KnLgEI6s8c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SsmO5FoEFmpuzCTS6WuMkAfhh2/Zz8F0yioJoYa9T9grKzYZD6t/tpM9CpDS+FuMru/vR766c80dQuCmLLnjlpk757v2xqZQm3iAf/MluuWIlLQCCWXXNB2ykRSkb2pWHqJFRRpy/7NGwCrMAUAsXG8TuWdCVB8Ye9qbTXsYiCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fdj5yT7q; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fdj5yT7q"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c70b5594f4so4703485a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 09:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578479; x=1776183279; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T/4zEaf7FCiOXnkHw+kYBxBwaPjzQWcog5B8cKl7YuM=;
        b=Fdj5yT7qfj7Pk9bQCfkQ+4wQJCEnMAJRzCzgj7RPFrObdTUAdGJCa+2+F9NmaoSbFL
         L8FbvBt6aA/8mLzwYnctFFWUkCn1OItHTPNjT4vYVDB1SCgG+GuPRkOvKNarCUCcb0F0
         0U1tZ4AOdgM6yoGxHmXDyDZ5D2BoloZHTgjzHrHPhaS8M0PxN1k677fBNVgBlTJWGBpz
         i1vhYNf7t1BYa+0h7yAz91v+v52qavANwvX3UgjO8DjzP1N0tGmuwke8tGti5FKN6seJ
         CUfe2wv/mMaZhfWkqiZ8DqE67CzqkL7h9OYw7PwCO4V+txMj65QcRbgobx6Cgt94t8FI
         rdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578479; x=1776183279;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/4zEaf7FCiOXnkHw+kYBxBwaPjzQWcog5B8cKl7YuM=;
        b=BW5i9M7gxiXmEsOyqhoPBPQ8Dp6x0AD+B+tkydUYP4BcHCrQhX5y6S4pqu4L73rfqp
         WJPoqyCw1+PsZFTSDovCbZYtv9762DTKgdso34H1QckMIdRqOXNhLLX1PhY64lY90CBD
         NT7c9312wF+9Xh5JEGI9oz913S4J+SE7vhcxRlbvqwVqSyhFuIQgmrTYzgpru7iCfC63
         vnBXvKTsGM8qh9f1RNz6BCTrze7GK5ZvLM5ffB5M8vSF6UmMum90RCCEUeoCsiYYqRL2
         zFhqEJ0fm4cy9AR9G+39DjV9e2RMW07XPKj90/FWqy+eAOYIJgWe4gIIxfo9vo/48FWi
         9qpw==
X-Gm-Message-State: AOJu0Ywf04gg2ILpGesj21rleJpkAPqFDwlu6CDVHYcko7AqinSsjNrq
	UX1wjviKkCMOyRRcLJanajeDKJ4XaknlUwBxxLaUYJMPCZHKIl2BpPJePSzZ8A==
X-Gm-Gg: AeBDievEPP3DN094J4z9A/VR+hu8qyf88bTBTgxSyJYdvtiKGe8MclqouIOO3/k3mrj
	zW0Y1vgGSQ+jkr0o+iHrM2CiZFf/21+zSDc3t5uexO3rDzHJozmRpkr69Eg4HS0ZZYo2OnIOOEq
	F1bCDLTrf4Ri4f2URUcymy6vE+7u2r7NjoYUdf4HoaxVIW6DCZy4upI+yu6piMDCmAjb225+bPi
	UjgxVjKj07IiMTnu9S0Vukn1v/NqiwivCOfWCkLxmOvUi6+PkwBnjZbMtN1Iw1xgkBdKBQDYpT6
	pSKepAXqu8zfqbgfApstVOgMWNik521SzEoY1oiPs/RWnxRGwpmOSO4ZibkLTuYt2uioXaLne1x
	Ti82CCcn8VF1RhnCby8aRpXQzAuI7PRL0vdt/jgx8U8+sH7AHSx+lLj8RNMNuDf+WsIotRveCSa
	RLnZPGVckwNBGIIcsUcysPn0WJ5UmD8pTHBUomDB27
X-Received: by 2002:a05:620a:199d:b0:8cd:b024:114d with SMTP id af79cd13be357-8d3042cd918mr2323278085a.40.1775578479437;
        Tue, 07 Apr 2026 09:14:39 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.73.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593330593sm167389636d6.3.2026.04.07.09.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:14:38 -0700 (PDT)
Message-ID: <69d52d6e.d40a0220.6c5b6.1701@mx.google.com>
Date: Tue, 07 Apr 2026 09:14:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5472314047731399165=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, metze@samba.org
Subject: RE: Bluetooth: SCO: check for codecs->num_codecs == 1 before assigning to sco_pi(sk)->codec
In-Reply-To: <20260407151345.126999-1-metze@samba.org>
References: <20260407151345.126999-1-metze@samba.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5472314047731399165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078240

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.44 seconds
BuildKernel                   PASS      24.36 seconds
CheckAllWarning               PASS      26.63 seconds
CheckSparse                   PASS      25.66 seconds
BuildKernel32                 PASS      23.82 seconds
TestRunnerSetup               PASS      514.18 seconds
TestRunner_l2cap-tester       PASS      27.33 seconds
TestRunner_iso-tester         PASS      38.62 seconds
TestRunner_bnep-tester        PASS      6.27 seconds
TestRunner_mgmt-tester        FAIL      111.68 seconds
TestRunner_rfcomm-tester      PASS      9.25 seconds
TestRunner_sco-tester         FAIL      14.31 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        FAIL      11.61 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.63 seconds
IncrementalBuild              PENDING   0.53 seconds

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
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    1.969 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5472314047731399165==--
