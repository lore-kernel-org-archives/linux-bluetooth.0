Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAD3D9057
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604089; cv=none; b=mampDnolvaMtX0HPLUEvYIDSZa4zGrF06LbxGnnlDBnKgnUcSwMko1k8XduwMhF8VAaIx2C7xkSHZHo6k96/Yq1ginvqBwNlgoBWPgeE2YwJm2af6KZVjtph/XMnYyFkQ6C2ucvTJ0mkVBYUFiCKD/tEJy39drRG0WuLH8hrj5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604089; c=relaxed/simple;
	bh=NDTdX/08w4aFuhx7NCyWd8h2EhQzQIGH6z9sskAmy00=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oy1sDe23LHe38D+rCNMYQvPTZWGIT4owlKgAu4Qvz/LI5OO6ILt95UHLcWBJmibIn+fl6gcnBkOYBbLJan6WVkZ7grIp+GgtdtTJOgJkD9y98Yy7z+xWdzjuSucxkheMM7aQtsW3jJRg+TGvEAE+o7EWPfK825kz9/aKado8b24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhUzqInS; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhUzqInS"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40efc77933fso1210839fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774604085; x=1775208885; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BZf0IvF3LUQv0DfoQXd7SDPLEDqFOLURgbVzv4Di5SI=;
        b=HhUzqInSBWqnCeQNm1XQ2+N1zzhJ5XmvuhvbKr1N/tzDLB56PSOuztMV7COBFQAbGG
         J7m8HERwTv+j6yt6Sq2gw9yT59aSw+8FPUrBboKQl0qpRcfFQmE6Zw5yraIzut8xRCbc
         B1LpSQGXZbPn/luSmeopV+wxZ5Pbg75MrF041v9KsBq4JIRqvS9UL2A95LIAnldOTgfH
         AnkiKIO7uVGl1FTqUx3lONLjs9WO/otR7TmKaWq4AizGb3mDIcti2Xflg6NY5Hu5mwbz
         3TpV68ciGc4JOjVI6rKQcwY9j8sgFjGtJ4TWxHdztNEU6GrQG4c1qFLfY/SMVJcSAo4z
         MnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774604085; x=1775208885;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZf0IvF3LUQv0DfoQXd7SDPLEDqFOLURgbVzv4Di5SI=;
        b=r0KTnlCK/cGdwRTFNzq/L8bQr0jnluEdgoIGsZ6pIZ11pK359PNdQ8aUhBJZxKVLdk
         QgQMvyioh7gEaG4sE0UzSrtwnlJslRh2RcsDULlj0tB5mhRmeDSqJYbnsVbFpf9UcqqQ
         FPKMIYKvmiOA6kf1gVFdojAgfk1k7zz4kSY3mnrAna4Wma1JBwhUzXOh57F8sVTpTeCM
         V0zl0VE6dqjKIFjbyS4HWkmam03yuZUVRg3Wk9S2h6z0q1YiAEkLgtKp8lTyNZ6Bzpmn
         YLTGgCBQzABPHoSl6xbW2vK3HGSTvC6nLHLpcHAU2ifkfwhiqKqo9P13cyuV+Gg2PnLV
         tHFg==
X-Gm-Message-State: AOJu0YydCH88D33Vhl29RsKLFzf6xtL9dfI0fnBIUPY4lREbUUNN2QHl
	CDRXX/XVN9SJ+Hnw15o3zRC4yqQ6t07lh5zkZFQPDH3lRYwSLSVZCbz/mVrJTw==
X-Gm-Gg: ATEYQzxlHJs7nOPSQnI7vvPcEqIeHgkD2Z1p5+rIgvyl5zSy6qRedQxhemFsB4j77rb
	XQQ7x4C0Mk6FLzx0u3XFOaNdsCjcnGMalV/uCLt/Yt8UngJJAMFzKh2mGPrGXKNf+EZRF4iYVPR
	71qnQL/GUymeZy9R+nr3wmFT57D9KuXF9HIZeiEqIx7zSzm+5yARvo2jFm9P5G+WUTVP18rm1Sz
	WcU/bihPOqF3G67b/IqFnABrxp/uQZVzS3sCwcR2nSS4TrDXtx8sXHTWUFeqFij1B6vPyiF3MAO
	Sg8hfAtihxIqbhq66sP0mVF7164/G9xziD5t/GOyrQl/5ZpdfVexkvOYG9GkvFFfY1pPDjUSxl3
	fFC0YHHjcaXcAMQXy8HgQnmvwc9EJI5JIMSwoAiNwcvzqyrf/Wdci74o/XRdp3Ef7UWkRAYctp8
	/8UsxYzJ1+35rnjLY15I0X5KDdHostRQ==
X-Received: by 2002:a05:6870:b0c7:b0:41c:4e6b:3673 with SMTP id 586e51a60fabf-41cec068177mr825357fac.10.1774604084950;
        Fri, 27 Mar 2026 02:34:44 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.124.229])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41cc77c45f0sm4025546fac.7.2026.03.27.02.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:34:44 -0700 (PDT)
Message-ID: <69c64f34.050a0220.1114f3.98df@mx.google.com>
Date: Fri, 27 Mar 2026 02:34:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8462229417485238713=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v4] Bluetooth: hci_qca: Convert timeout from jiffies to ms
In-Reply-To: <20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com>
References: <20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8462229417485238713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073413

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.77 seconds
CheckAllWarning               PASS      28.56 seconds
CheckSparse                   PASS      27.34 seconds
BuildKernel32                 PASS      25.15 seconds
TestRunnerSetup               PASS      560.87 seconds
TestRunner_l2cap-tester       FAIL      28.06 seconds
TestRunner_iso-tester         FAIL      35.85 seconds
TestRunner_bnep-tester        PASS      6.17 seconds
TestRunner_mgmt-tester        FAIL      112.66 seconds
TestRunner_rfcomm-tester      PASS      9.23 seconds
TestRunner_sco-tester         FAIL      14.38 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.42 seconds
TestRunner_userchan-tester    PASS      6.64 seconds
IncrementalBuild              PENDING   0.75 seconds

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
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.116 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
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
Mesh - Send cancel - 1                               Timed out    1.873 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8462229417485238713==--
