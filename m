Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BE35280
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 05:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750828221; cv=none; b=KP5B69Ik1I2c1775FSORQLBBAsFFl92IV1vHluEDtDXhJiBdcGncL/LOO3DipTY65woQsQzaSbL8HZzUiRNCMYSPU5wbLvPmXn5229gtAHcIVlPFmLea+Lrmdl68Y+dNLOKTs8CJk8dI2SWM4QgwvFAqAweH6yuxmdhvnzrQm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750828221; c=relaxed/simple;
	bh=M6+vATFwpppR2ulW0eltn4WWKFhJSJF8Q8v3/oFJ/h8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HwYzTJhFT/CJvDLu0UArH22Dtz67rFmKSIlLCmd5si0VC8CRxku01bIdyw+x4u9Nv5yaNsM7dsa+JCRmLG7VPikn9Cj6KGmCCxdGQrtmcIuVncrDYlWtTfxn7HMosEV+PR/s6fl/MBK0g594csO3nbbHpfyqibSnxEgtgFOYIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9yXMk85; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9yXMk85"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c3d06de3so7029525b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 22:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750828217; x=1751433017; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N+487K7p6Cvos9w0mILJWaMstSWO4/ii4fJXLEpvcwM=;
        b=l9yXMk85yv6WAuBhLOsGrWqYQ7KkTaBh1LAPLg0ZvwHH0sgGFFbCHETlE+P03P92U6
         TRa7IBBKybFowKXLibB7NzC0EPCTtzCfxByEy0EL4/JodYns8XaJmKsOGo4SCli3mrb+
         J1RvNjkiW0kXn328mEN7/Y+40QPTnv1RCHpRLvkBoVNF9Epx/S2iCSsYsb5yKYS4cynk
         vgsGLIozY0TG+5YnVzMKYb0bzM1FHq6xmFWvIPnlpo+8szmw9AR8wu7AHyeV38cVTm2b
         CxB4mhyXsAQF2P6t3SEFEKFjnuanuXQTfbqe5dJe02c1qgIzBQ/tLxs/JXxONP3EfmKy
         DUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750828217; x=1751433017;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+487K7p6Cvos9w0mILJWaMstSWO4/ii4fJXLEpvcwM=;
        b=ETRk61Y7MD719paVki9ksgVDaxTjMzcLcYxWHb3ldIvTiAy1i+o8w64dPgTf2QAbiF
         wgdJT3EAv0QcAaj8k+UM+kJi7xum75IZs30755UkB7EuWXd8ghhSYyj2cgXrmDfRDXuz
         Ovsb8YS0V7hcrBR/wnRsjx1y8dxgckaDbCbgrqLZGMNzSDNhhjdK/QPiZ/nemhgtbE2g
         tSCapPubLW78yJYWLI879WctSka3O0ukAXL7jXnt58xwZMv62mTOpbJQhpKZruY7Gjh1
         0RiTN29STmfEbTGoDtCa1qCr4/UeIkpk0UqZ5YTcXr5+zViykVC2QdfaSpIC+MZbNvzP
         02yA==
X-Gm-Message-State: AOJu0YwFpUfKulDNqhjAFNxjgUj2mKZIuQDDcWlt0wePo1itdzu8T0mx
	KxuMzSmiCZC0bLgyNqmgFlCQS33s+qY4Ss/oM2uLzIrPNVlcKgR5J0844DdAFw==
X-Gm-Gg: ASbGncuPC4TbVd0boSy67VGWHYSvonmiRR2hNE9ownPbxUyG9kLQ1MwgX4NFA+Diqrs
	Qjr6Y/s9Zjz5XFeg5XPEbRXqTC+j2vJOqe1fJ6LEneU39rLAsvj644/QtG44bWrnL8h2dt4/qkF
	PHypvFUxZaJtHLUiWEEy26YsYqZS7lmGmkPLTbR64b/0I1SfSkzjd3ZdZ7MB/3frDxxg4zTdp+S
	2flK9NyDjeEEv99rKD4dbmxjJViXfkhZgObP0wYY1Hk2qWN7Jc3FUl4+7Jt9JwJPZLEDUUKXQTE
	e4plrjKx1QjKICQv7nf1vxTssP/34TfByca/p1zt9BQH3xFl1LgxVXf69BLfYtWFCvI481ra0Us
	JdQ==
X-Google-Smtp-Source: AGHT+IF90S3Srm1V1AkvGaJZILzS+7Ms7sGZngXjR0EYrA5I6Z7ppnq7eTYqTJYNRaQiK2AZuACdqw==
X-Received: by 2002:a05:6a00:2d06:b0:748:311a:8aef with SMTP id d2e1a72fcca58-74ad458f6f7mr2688353b3a.12.1750828217427;
        Tue, 24 Jun 2025 22:10:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.29.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e1f61dsm3396572b3a.37.2025.06.24.22.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 22:10:17 -0700 (PDT)
Message-ID: <685b84b9.050a0220.2b201c.1207@mx.google.com>
Date: Tue, 24 Jun 2025 22:10:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2079385222350037277=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nichen@iscas.ac.cn
Subject: RE: Bluetooth: btmtk: Add missing usb_free_urb()
In-Reply-To: <20250625040703.1021358-1-nichen@iscas.ac.cn>
References: <20250625040703.1021358-1-nichen@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2079385222350037277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=975548

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      23.96 seconds
CheckAllWarning               PASS      26.58 seconds
CheckSparse                   PASS      30.03 seconds
BuildKernel32                 PASS      23.77 seconds
TestRunnerSetup               PASS      470.20 seconds
TestRunner_l2cap-tester       PASS      25.11 seconds
TestRunner_iso-tester         PASS      39.79 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        PASS      130.83 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      14.69 seconds
TestRunner_ioctl-tester       PASS      9.82 seconds
TestRunner_mesh-tester        PASS      7.34 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      6.08 seconds
IncrementalBuild              PENDING   0.63 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2079385222350037277==--
