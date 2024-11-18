Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513421991C8
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945532; cv=none; b=IQEtZRPnKnaglh+mEnmf7lST6b1Ni3042rIiW9OlacKHc1w16EXywZ9nJ1G0OlDzBeD32L8LDsl4ecDJ40LT5P/0ZEW9IEt+LslppZn8JJZij8xjJ0+lXXQHioY9zOsx5pUyskSPy4cOD4wqNHsxJxoT7hX3TKBr3djF59Jl1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945532; c=relaxed/simple;
	bh=HwDPlTXqaVHamFE2RymC6SIxrU7ZReR4RC1sp9RNJQs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Q1y5UEdKoVowJGtxLLVtUnEglwQZCrB6wNcG1TQDKVIv9hEkUNHKWwE2J6j+yRzY22SX8Q9P+Btp/lJ/OxsomIgwry4NMIRgCo284GhaIK8ILjNjiCgrWVcxFuzA66zop+p7e/b4LdbZfJKcQarTlRgz/ryN73W1+V7QznOujh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ips0DQp3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ips0DQp3"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724a96f188cso407902b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 07:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731945530; x=1732550330; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RuZYMeXJuOVaG282eD+/IYgE9GB16h8lwSQZ4fVfwEI=;
        b=Ips0DQp3mEUSOrpEiRriXy1cEzF7+3KRB1sLxNJgyiu/96LP9EjSQyHaOyxZatdzJ7
         HlhY8IM+VyN/eKYThiAaNZiE5nj3I3mobs6alZle8ZD3pIn7jBMGKTF4rrWOBVJju+MC
         irBVVAg1i31LuEaFWBf/ulczPaFvGfjeNsIqpX39x+IIktM4zaTFg6QxZFQg2xcmxr8V
         FKB68ZqW7xEyQzOXytoHpX5UN/WP9J+s/lAbD3EIvFRMuZPgw2oLtn/VmJCiDjC/qUXF
         14fY1X+X1R40UkMKUvmGdus+ibubMoOTitqiRJlJLRUvFTeoVE42dyc0v/yMgpjv6CE0
         SU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731945530; x=1732550330;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuZYMeXJuOVaG282eD+/IYgE9GB16h8lwSQZ4fVfwEI=;
        b=NmbZ2tnFmWtbvqQ6DOA6k0SOY0Zy3C1j6bjFfEdtLpS3+J5QPEeLiDS3Hu/b9rKHNH
         xsqBhqsmPKGiIqTLxKaU5RFe/MORDE39WS0SsJ5VMv9Moh9j2F+oLEg9X39BlMKeyaMm
         jBlln6O9H4aOeH686tinPNo3GkcczAAHjxn8vutcE9DxnI6rJ2FQY4uuVSX/NT6vGMaY
         H2cqvL2nCimhsX3ZaJVP3ayzlgYnqsfPdsu0HUQ9nDP/rsOA6/0xamx4/rUa+EGm/+C1
         7CEkSZXmu3KpCITwL20crFyrd15Di81UV3Um2IqdA57ZlG1QCgAsKnabSQOQSFRx167N
         VxpA==
X-Gm-Message-State: AOJu0YzLjIQKNcQZnFCX2aAKAl8//dGISdJ67iffiHwIsCq48Tho25Xx
	gIVcFkW4AmNpfSsWHmioShGIv2HSTf+1b0z+XltcvKjXkm1ypKMZ2KabuA==
X-Google-Smtp-Source: AGHT+IGLuwA+wO/Eol7uwOb8ddEtnNh7WDm6ODn95NsDSibqrTwC2ZTK2pVLHqt3EU7C+DC4Dc+8zQ==
X-Received: by 2002:a05:6a00:a0c:b0:71e:e4f:3e58 with SMTP id d2e1a72fcca58-72476cad10fmr15953138b3a.17.1731945530258;
        Mon, 18 Nov 2024 07:58:50 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711d2b3sm6304220b3a.55.2024.11.18.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:58:49 -0800 (PST)
Message-ID: <673b6439.050a0220.2bb797.a81e@mx.google.com>
Date: Mon, 18 Nov 2024 07:58:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5660977940625991480=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andre.groenewald@streamunlimited.com
Subject: RE: Bluetooth: hci_sync: fix LE init stage 3 failure
In-Reply-To: <20241118151947.3323927-1-andre.groenewald@streamunlimited.com>
References: <20241118151947.3323927-1-andre.groenewald@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5660977940625991480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=910673

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.54 seconds
CheckAllWarning               PASS      27.96 seconds
CheckSparse                   PASS      31.11 seconds
BuildKernel32                 PASS      25.11 seconds
TestRunnerSetup               PASS      447.44 seconds
TestRunner_l2cap-tester       PASS      20.94 seconds
TestRunner_iso-tester         FAIL      35.16 seconds
TestRunner_bnep-tester        PASS      4.95 seconds
TestRunner_mgmt-tester        PASS      120.28 seconds
TestRunner_rfcomm-tester      PASS      7.78 seconds
TestRunner_sco-tester         PASS      11.63 seconds
TestRunner_ioctl-tester       PASS      8.33 seconds
TestRunner_mesh-tester        PASS      7.08 seconds
TestRunner_smp-tester         PASS      7.16 seconds
TestRunner_userchan-tester    PASS      5.10 seconds
IncrementalBuild              PENDING   0.80 seconds

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
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5660977940625991480==--
