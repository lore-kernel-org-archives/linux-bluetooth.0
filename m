Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C252E3806DB
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437869; cv=none; b=cPwKIyzvVT8aFLNbSCDaPUPrgDcIxDdCNnlbWB0EtZRt41dnwKqD+s3JaAXBldSgsotMlTTEFXeayY2a2av6nFeERGJ4rPbqdKBzDlnvV+q951LQdRFKfkj4yB2QT9CNccvru9HKl6TAvNYWTQHpopALKZxInLmZGNroVIvO/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437869; c=relaxed/simple;
	bh=UlhL4wTeiAMjRJsRRxjlfnZLU+VM71pcg4trsP1X2G0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=blEFJQp5CQPnIA2FJPb0wJp5t+bLRuKZ28J7zETmB4Eb8TlVQ41YnZo+bZwr0xWe3ECsO5vhko9B924aT/jGfPohqzM6LVWpQXlgGA6fBGqjOETfNKAezsYT4ujlR4gLBOWdPjIVA/el+zBPStxwAEfDiw/25nlMK2jpUFnxnKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUxrItZs; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUxrItZs"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ccf6a63a45so45445576d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 15:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780437867; x=1781042667; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pq7SR9A9+zkyNqHjkfmaPIl8O6eVaolhzKxmCbU6NM8=;
        b=pUxrItZsdExgzpcyXlxuW7+7bqg2K5PUoMRVxmVF3nA+uQSVSca2H0e9UCYYYDCp+s
         HdswspQjAsmrC81ofUfr1KR5YoQ/TfeoKgoLpgiKh1BHic9pGzcisXVVcW9DyGI+LZLd
         9Fult+6EPrsTsT6WQ9QMdPHe40ojMYn7/pILpR1qGopDNkf8OUUT9EC5fTUdqr6Z+QPg
         WESRLfmC2s3BNjNUcH7p87u5n2HGV+y2KFM3YsqEQ4MybOWgQCKTEgH6zjWGW6HMaLte
         hviFmkjE5+kTLp+oqXjd/UXIvWT7QMGQLxArVGA6Fv/PLWErgLOGJ0djueMHrqgMJzrz
         WI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437867; x=1781042667;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq7SR9A9+zkyNqHjkfmaPIl8O6eVaolhzKxmCbU6NM8=;
        b=FM0IGnyaHuYANoZEmKJJ/MK3CZbldkksv3g+OJItbbSTwzkQuSmXGOIIgBHASespOe
         TGPbRj2Iqfofur4sGsyoD/iNtYYZ8/sKgQLr6IOSoCoBArerp8mEYI/tBiU18ypHKk2i
         yXE+HQXUYPPDrhTyDWY7mFmS8aLkL/+GMYTDUjREJEuKnb6hgv7jk9qgZV4yoOxMc9HO
         pbyoLg+L/lU5BAXG8Qwy1TgNPvhd7QMuzh7EVqhV55cY1fMgVXxh8yciVfyJI4aLAr2w
         CT8M61VnZ2Te093UTzFvMNBjb/oT18w+pFKUrqGqq7vNvW9haq1Tzoa9clZ/R2v7kNOs
         ovGQ==
X-Gm-Message-State: AOJu0YxfNGwLHvO19+fUqFFnWnsmnj1Ebkmtp1YEJ5ygfdaH5QZTEdFv
	KnONp2GuRFLfJE53NFV2m2+q+0frLwYHVtqvT0X3mcalBlVKHK5t/ElWszqTuw==
X-Gm-Gg: Acq92OFSi8AsS5NKhQEre+adh1RsV8hBX8Cpkul51dgSFCZJLSPDdCGNsVmQzVZF1A6
	btBUN+DdBfB+KQgPYIYrjFwq0J9nKHhpgQGpQZiHC1fK9k3iUEyGQwg6T6q8xFRqhqj+U8Q1cvx
	C+Yi5nQaSaQuJ3DZihNLS5mRpM3OVVTBJj9DPqpqAZzukGCZDvxQD0SkGh913vmpBYBZoXgg+rJ
	oktTI08B3AZrYo6ML3MdCZcprn36Q4gEc7AHodat3p11Jo5pzNAFE+HhfiZVyMGnmW3q5loFeIe
	cE9NJZtLi2sGU5M0YKGtSayFhPTu91RxvVdB5K7RHhhl+bu0gQ/fmEPr243178bF481lgRRLdfv
	Duiiv/01ZGpAqEzPPi4fpJIrlAtWfaxiOuwucJzZzfpuOvjPG27KObI4ac/ufLIt4a5Tq90NEn9
	JNsP71e7TKGHxTOxcA9r65Q/eqqrepYRtHCSnSai7XlKJQWE9VYyI=
X-Received: by 2002:a05:6214:e44:b0:8cc:f1dc:513b with SMTP id 6a1803df08f44-8cecdcccfefmr8199416d6.39.1780437866659;
        Tue, 02 Jun 2026 15:04:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd0535b0sm3513376d6.28.2026.06.02.15.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:04:26 -0700 (PDT)
Message-ID: <6a1f536a.dc7b3156.51785.f37c@mx.google.com>
Date: Tue, 02 Jun 2026 15:04:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6515851009652488865=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, i@rong.moe
Subject: RE: Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
In-Reply-To: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
References: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6515851009652488865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104801

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.53 seconds
CheckAllWarning               PASS      28.28 seconds
CheckSparse                   PASS      26.92 seconds
BuildKernel32                 PASS      26.17 seconds
TestRunnerSetup               PASS      531.27 seconds
IncrementalBuild              PASS      24.77 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925

27: B1 Line exceeds max length (86>80): "  [27505.196142] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command"
28: B1 Line exceeds max length (86>80): "  [27510.576045] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command"
31: B1 Line exceeds max length (86>80): "  [27515.948307] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command"
32: B1 Line exceeds max length (86>80): "  [27521.324380] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command"
52: B1 Line exceeds max length (86>80): "  [27569.196322] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command"
53: B1 Line exceeds max length (86>80): "  [27574.572040] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command"
56: B1 Line exceeds max length (86>80): "  [27579.948039] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command"
57: B1 Line exceeds max length (86>80): "  [27585.324331] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command"


https://github.com/bluez/bluetooth-next/pull/276

---
Regards,
Linux Bluetooth


--===============6515851009652488865==--
