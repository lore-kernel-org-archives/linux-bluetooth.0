Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4B3A759C
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907864; cv=none; b=K1opvcE8fCyFw69qlf4+isw1uaceqoLmoTJb+797PtmunTFXwOGgHK/g+DDDCCgHWjYMW4omWpiYW4cU0Ht+nURvWfvZWF0IHb6WZxThyUHt3PsyA4zCc0UGEGLtwA/lLtZpchmLmIGGNwEvz806The+4i6YWHbdh2L1NGJgg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907864; c=relaxed/simple;
	bh=Pyd9gxJ50eix3KuEBZsl/JIvbsIveL77abDZQJFjOLo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XPa6wjrVKMqrPKz9ciYfmsbdfdaGYYJSToEirQ8BeyfiA1e8QUViJilnnuUGxRmkPzc/sNcpifZeMc37J5aS1walE9MDRI27Y7/zuPUgJgOKKnEuKzV5in4ij3ffDqFaBE51HxzoH+zZ1IN/D4hhwAccmZugeIjy0zQGRMUUvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU7/bmNA; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU7/bmNA"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so9816461eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774907861; x=1775512661; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LJxkhT3ElcXYjoTp4adMhTZ0HfUr8Nw51HoX/3A9IRs=;
        b=jU7/bmNAJKC7r0uZsu9JHV/AQW4EJTOMwU/BEbhUWjCefBK54nFtIys+yXI1Ye3S72
         ZCGtwbJq66Hl0g18Bp5GIPbCBxlNxA2wXU2ECTlE4gIpFUAz9oQLVAOIIZ4dmuVMcIaD
         wQGkddv1HuHg1F26CoqNyCGZcfIyehQy1sFdKqAmvUYM8kretVuOS8V3fO3K/4jsfhCs
         k9J3DoVWp6+WXaJu1u6oT9fZ644YhyNe6cU/B4s5VlAqY0/M5j/4hMBcP2/LnvV+hVzq
         S4x4r8TbWCHLNSVqDdZDsYqIPD8olr9CyqK0LGD9YCkRyY0blooPYJ1EQmAykesU7r5i
         Ykfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907861; x=1775512661;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJxkhT3ElcXYjoTp4adMhTZ0HfUr8Nw51HoX/3A9IRs=;
        b=XZkW7uaq72p3pH4X0Leg43QsGyq+AT7ix5ATe12urwBGFk67lUC69LEBHGLNrQtkrS
         91GuwOL4+3lbVSvlhKWCh9drbTVaslxZX07dTkqgj+ESOSGPpn9YE4lSYxToZ1BQSH4k
         MF5G3nA3f4uybnTgX2u2f/CniRJSZGwOAswgUUt1lnjR8fH/Wpq9gYvkQSAfwUis/Fwe
         v1NbDarR4o7sfAm15bsrktI7t86aNPa3K251IYN9F6Fl/wqK/B/xICce5zN0ZfstsQJQ
         46fNSvQghTs0VioDcxeN1xRlZuhMBRzPyLkZkvc0gxweSZ5zo5kLeqx5v5Ux44t3EgTQ
         xvQw==
X-Gm-Message-State: AOJu0Yy3uMLyrwxoHFArss95FOqsWY7u3Blvh7a0uHNxmtfjWZpRV0Je
	L2+noZgtQ+8L7vKHmxt7f4PwF4n6E3bmGZSmknPa8ZctKMPYIZsi8/Stjcy+8w==
X-Gm-Gg: ATEYQzw7u5c/glmLyLfOj259PraAsi2wLsV07FF1d0f5PwcTIG22oJjab5eKTAatybK
	APC349aFkMKsQm01bmOsGk5YcZtCesOOSKq3R78wfpcG8cJSfNniTKMOkN8IA6z3kCmFIaCssJ4
	FCK3zcQvPVPFGZf02126mYk+dJnKnKaRmcRCsR46xaniuGCtwJJ976MF1r+DRZDV3ujZKAJM0RG
	DVJntd0cfNmupLeOi879EnxG/u8XD2oWkRRtKGQRG568dAVdZFQ5N+x28LUAZrnmzjcPz0gPTs2
	qSR6eU5Sx7hSDvExYK90YafjdWRmlP4br1L5N3BauWmiQ7eefL5biElRrjjF8tD6uJiJS3iq3GR
	sAsO6vZ8brHfctWxucB0k8nnzWpPo9bq7PuyNFT80NpxEDG1nmIEiqFHBdYKwBVl/pn4lQBhwMz
	PASnEXXx/zYdyNeaBGHNnn1f8mVaLDoG8=
X-Received: by 2002:a05:7300:6420:b0:2c4:ec89:bd3 with SMTP id 5a478bee46e88-2c4ec8915c1mr4482966eec.24.1774907861416;
        Mon, 30 Mar 2026 14:57:41 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.162.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda306sm8299664eec.3.2026.03.30.14.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:57:41 -0700 (PDT)
Message-ID: <69caf1d5.050a0220.d473a.b0d2@mx.google.com>
Date: Mon, 30 Mar 2026 14:57:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7780547942037452764=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nathan.c.rebello@gmail.com
Subject: RE: [v2] Bluetooth: ISO: fix NULL deref in iso_recv() ISO_END handling
In-Reply-To: <20260330212129.319339-1-nathan.c.rebello@gmail.com>
References: <20260330212129.319339-1-nathan.c.rebello@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7780547942037452764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074820

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      23.97 seconds
CheckAllWarning               PASS      26.12 seconds
CheckSparse                   PASS      25.00 seconds
BuildKernel32                 PASS      23.26 seconds
TestRunnerSetup               PASS      515.75 seconds
TestRunner_l2cap-tester       FAIL      27.84 seconds
TestRunner_iso-tester         PASS      39.44 seconds
TestRunner_bnep-tester        PASS      6.22 seconds
TestRunner_mgmt-tester        FAIL      111.81 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         FAIL      14.13 seconds
TestRunner_ioctl-tester       PASS      10.14 seconds
TestRunner_mesh-tester        FAIL      11.53 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.52 seconds
IncrementalBuild              PENDING   1.03 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP Ext-Flowctl Client - Set PHY 2M                Failed       0.147 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 1                               Timed out    1.829 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7780547942037452764==--
