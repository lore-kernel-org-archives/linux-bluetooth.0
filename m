Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271C19B3FF
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100199; cv=none; b=EjITNJhCypvUzMyqckFQBjoUmA9aCMlv9I3CYf8fPXropaacOjvsvRuQx01UsTCFAd/eyS0r4s7QAGvbSuWfOP8eOkGPQfS7/tdhEx6dPOmEvWv41AKRC6+P+9WJrGpq0eiq6VNNGH/a7PnlBzI2GrV1oPIyb5n9PgqVtSP9yjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100199; c=relaxed/simple;
	bh=UOZK3XqCiubgm5OHz37k2iZqvrqCaGTZY0bKLQt7bRc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ay6rLnVW/tnazEaFG+FsqTSW37ze1JTj9YZaoJAv6KjWeg7CUYvxu+ZVCr3Vs1ei9OdtlE5a6Xkq+RBHhmzWyrNuFxzXfWdTFxWMMkYYip+0SR97uJ3RB2gSmeh9RGCC4CQDdu3l6UxykDACdJKa5r+lhNlYkQ9tXFmlgX4TcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdEgEn78; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdEgEn78"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79c06169e9cso44755285a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720100197; x=1720704997; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1d9x+BrfdxeIaNHCwY3C7awPFQMlPH8g1loocUJF4KE=;
        b=TdEgEn78JkQ+Z+VIs+Tmbiq6dHNMK1V+VMt0FAHvJI6noSNyn+CkwtlxSQ7vj3YHZs
         tLClNlhP6pFXDBQmRLD3Sq2QBsimbhGjDv5GV881m9W46vzqZe/Stc+vNOpSEdm9sHN+
         Pxf32ANs8ufVHkVSkMTLHvGmFu+vql4gny5cKqPMi72gSyizzFQjyCvlrDHoynwl+Q6m
         Zb5xJeOMe1UqcZaw31dfbscjx9xtZKg9CRZJF0ELfD5mwlFQjabGejOfOYaFxHle7w/x
         zQrfEEmJHgQgMKCkF0blzMZcbM4NFT+yOQ8lOTPA59GeAukcedOasc/Dm5l1WYct1sxa
         vcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720100197; x=1720704997;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1d9x+BrfdxeIaNHCwY3C7awPFQMlPH8g1loocUJF4KE=;
        b=m8OCGSSp/TYQOSsUBdt4vvmJrRkTlx+wBjClQVigBaMy2FbSP02TvmDiMHu/U6Up+d
         ijcO1zY5MIxSvBRWgEriOFE7r4aRjxR56QWnmXQ33LySPGLezoKSXGlK+22ax3WobLFi
         sg18ew5OSyMXI7T+rW0ZQdUvN11UNSOBYkw/1kKSCXrZPmICSELW32J/MlDTBNYRyRZN
         QCEZgyBUSdqfAfD6HzchPRUARAS/hGTSXfE7FKDZhycyaHuo4RG7yDwg3jI1cXEXKwDe
         FMmcl0vWJ2F5+27vN10pOQl3OuflFK/e74/Fp7jYOmjt14VDgjDqOGyi+JVDIHUqKKXU
         n2lg==
X-Gm-Message-State: AOJu0YyZkKGM0T5KAS8h1/uTm8nVkH6gb+h8qyeitllG70e7Pmjse0VG
	O2p5aEpi8PURDGG7BlOMFrWmkKYWyQ205XMSHRu+zzr+fxTXWl3a4RF+dA==
X-Google-Smtp-Source: AGHT+IEmMswgeztz3fVfEOQSRbuWoTnAVc+7ct4ZciYKquDA1SbnabRGuzuXdPa6j7wT13Nk/fYfEw==
X-Received: by 2002:a05:620a:21c4:b0:79d:70c4:71b0 with SMTP id af79cd13be357-79eee20d0edmr164704085a.16.1720100196524;
        Thu, 04 Jul 2024 06:36:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69289b48sm673884285a.51.2024.07.04.06.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 06:36:36 -0700 (PDT)
Message-ID: <6686a564.050a0220.9bf0.aff4@mx.google.com>
Date: Thu, 04 Jul 2024 06:36:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8648379005289703625=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Add system suspend and resume handlers
In-Reply-To: <20240704125826.715387-1-neeraj.sanjaykale@nxp.com>
References: <20240704125826.715387-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8648379005289703625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868445

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.89 seconds
CheckAllWarning               PASS      32.70 seconds
CheckSparse                   PASS      38.23 seconds
CheckSmatch                   PASS      104.39 seconds
BuildKernel32                 PASS      29.64 seconds
TestRunnerSetup               PASS      531.46 seconds
TestRunner_l2cap-tester       PASS      20.26 seconds
TestRunner_iso-tester         FAIL      41.33 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        PASS      114.14 seconds
TestRunner_rfcomm-tester      PASS      7.46 seconds
TestRunner_sco-tester         PASS      15.07 seconds
TestRunner_ioctl-tester       PASS      7.86 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      7.01 seconds
TestRunner_userchan-tester    PASS      5.11 seconds
IncrementalBuild              PASS      28.17 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.240 seconds


---
Regards,
Linux Bluetooth


--===============8648379005289703625==--
