Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB133232
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732811719; cv=none; b=OxinhQ0w10ggmLvkETPsIvwZDkTyuXcoYkRWnmxeC7efQguY9BKb+Oo0DnqZLxwgS25xqQ5IeJjR27VjGRvMAjRdLKSb6wktbxAnz2BGVeAPy9q8IXlavGI3gM9UiJqMUHWbO4tyNjsYedaHysbpd39LKXMSJu8BhSPP3gx4iQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732811719; c=relaxed/simple;
	bh=ks+pUqYXaH5VPnTp8s45mspssfil7u1OiR21FeDIp8U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CrUTNR1VoouuBTdGCG5ZKYj7s4uJOKjjBF1vV2DKTS8VPiSR2X1QIkw5waTUfPtrTaMUnUS62i6G85sq7KMmCKZy3Vpn4MBATr7/f2BwWCHMU0TZUaEZ9TSJVu5xu26r2zMgcYginbu8dqurd4RtGC8HJfS1CyKpgPK+4zQ+rg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzSx8dzC; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzSx8dzC"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-466943679bfso9419621cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 08:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732811716; x=1733416516; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AYrfl+I28S7VoNJ01WaIaV3izE7aR9SZvS9p+JE7Jpk=;
        b=SzSx8dzCT9B1Igl66fS1d8IOQ61gh1A6wGLfldeueb/GhjyOTy/KfJFyJSUO6zy/0C
         uO9aDreqO3w8BZaP1amHvhMaBQ7EIrQT1b5Qo5Ekcs/bo2LrV/vU13AGf+uL/Uxfx8vq
         dJLfM6jqPcjWCa5gYMA64ub7Ci3Ltnn4LICvPvrXqMkMOwCdTQAFpGzBeHr7un1K7z6r
         nsiyaeZQh0X9cXklGslzuQIouyy/N54Zr7/Qhw9L8Wwq30EZxX0V3vtMv1KS0Hcugk6z
         uez79uXGA0TXEFV4Y6Re8SWWAMaObY+dOZFdCUTJIBGD1bMSGNnkHOTNx+lbMUpTBy8B
         Jxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732811716; x=1733416516;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYrfl+I28S7VoNJ01WaIaV3izE7aR9SZvS9p+JE7Jpk=;
        b=WVUEowydtLakaxPGv4V8x3D0l834LQQjgEyvFX68vdGoAo5wI42ihxQLVRuXu12ND3
         Nw0U4XAQ8hTfNFGx79DKR1lZiM7L1linj80PsqXf8O7z62r4+eLCVu4zmAzNiIxmJDWH
         udfa7WuyoskmgJ7hIRECz/Ucqs2DpUwA/b9x5sWgT1Q/JeDcoxQLOTYuHZmslg65Dzdn
         ztvtYuMDioqlpKdmhmkgLGHhqPIrsKVOrJ8vgkiZkM3NsgvlkJcyX/J8SJH5lSF7/uwA
         ECUlhn4egLeBY1sFIoB8WHXIVMlUf0KDjbyj6ozd2lvqHcZtMUvgJ1QDGlsz75Zjo802
         m9fw==
X-Gm-Message-State: AOJu0YzBMieCMgAnp80BrVtO5DGNgGe2GJroLVWzQTAK04lJA9g2s/rr
	USVdXxhsocMcv8RZmnri4D1Zj0MWLGFbfdrdCFWnsncBIc6aGG9qphV8vA==
X-Gm-Gg: ASbGnctMlpbAwD75ctWgUWZuEaGXHazVDrstr1yk1Xb9yi8TiBqLXOs8GDaxJT9WikO
	anTdoHQYBoXQK1DqIZ1Ax3Bfto+HwZeSgTidaFtkrFmAppP1JkzS63AYXTsImNNoATyzcE1olnR
	TWoyoLy/qwynyzTuD0bq2RevxfkTNgTyZHCLteNhbmBrT+PclKNr/NE1eWWG4w532VzQ1O9kPAp
	8/bXNdDbcx0ULxPZNR0nYl9GPzr2cXyYUq0umaE02d/xhC2sMJmAiOXqw==
X-Google-Smtp-Source: AGHT+IF07JfdYm0ePamkbOAoxbcm48SWNaYC6uG57TKcQz1RoLAcR1NjTDjRRH82MREODgNME1JPKQ==
X-Received: by 2002:ac8:5846:0:b0:461:18f2:ae6d with SMTP id d75a77b69052e-466b35ec9c7mr140058151cf.24.1732811716419;
        Thu, 28 Nov 2024 08:35:16 -0800 (PST)
Received: from [172.17.0.2] ([172.183.98.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c407dab3sm8061041cf.49.2024.11.28.08.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 08:35:15 -0800 (PST)
Message-ID: <67489bc3.050a0220.361f2d.22d0@mx.google.com>
Date: Thu, 28 Nov 2024 08:35:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4141114883441264701=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: iso: Allow BIG re-sync
In-Reply-To: <20241128155405.14910-2-iulia.tanasescu@nxp.com>
References: <20241128155405.14910-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4141114883441264701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=913156

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.39 seconds
CheckAllWarning               PASS      27.06 seconds
CheckSparse                   PASS      30.36 seconds
BuildKernel32                 PASS      24.44 seconds
TestRunnerSetup               PASS      438.63 seconds
TestRunner_l2cap-tester       PASS      20.99 seconds
TestRunner_iso-tester         FAIL      32.56 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        PASS      122.28 seconds
TestRunner_rfcomm-tester      PASS      7.63 seconds
TestRunner_sco-tester         PASS      9.58 seconds
TestRunner_ioctl-tester       PASS      8.25 seconds
TestRunner_mesh-tester        PASS      6.08 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PENDING   0.48 seconds

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


--===============4141114883441264701==--
