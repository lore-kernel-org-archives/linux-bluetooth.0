Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3312FE56A
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790551429; cv=none; b=E+5w37QsDD6DxIoFRAG4w4Jc5wlBkBdmc2wfI69W/ufv5EJpYA3FvgsuyLVF01Gs2JAIxS6/wUwJROwcF4LqAS3vq7k2dhOTsXA+JHwaojOWQK/PvHOiHxyCABt7WUhAIB5VBL9mkorQ5H1heWrhIUelrNqVY0/AAx1QFP1puR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790551429; c=relaxed/simple;
	bh=f1k+V+hYN9ptJ5K0MisLAPjuCOOp3WDtH/fLh4n4Eik=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RHAPJUkWJaFp3oLsbDErVsexFJgC8OU2qHaHmUHkKt6yNgyFLQmdSbHaXU+qx8ZYWCGABz1Vi9FwLOiJWjw/iyxKuCTraken3qmMUGZ3fmWuxoxGDeurruAlKyO3T5LWp7KVI5WY1H8+/5Y5k01MDBs3m7PPDeCGGjE3PIz4fM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Twi6MQbz; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twi6MQbz"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso13083105ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790551427; x=1791156227; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nR6uMOz05UtcHnMecdFIPTE90DgBYPIKHrtNtkU88Wk=;
        b=Twi6MQbztZHQFB5ERmhnPULvDti6ag9Kj+ifDZw1HhAX5hZB9fuWp5wulB89K+Vgus
         phJyPwmgBvXc0cfTAE66/GXJugaMeYA3ZluM5h/86lxQMxb+yx575nTsjmxO622Josls
         nBA7PzERjtBdVyzwLKycERkbhrrQfE/q7Rib10zCxBUWjPdqwZROyVaEptqArTkTGCzt
         rSscv4zoFRQHMOzyKUt+z6vxMtR2JzEz+euKSEbE9bm1YscSgU8Zu7GU7t5BVVaWjFsg
         s8Ba7D9O8SMpw5a+8YM3T7lYqEXwqeAs4FdtJWSLgMRG7Tp6WVenwSASTPeRvi+E0L4y
         LD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790551427; x=1791156227;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nR6uMOz05UtcHnMecdFIPTE90DgBYPIKHrtNtkU88Wk=;
        b=o8xsrSH3q148q8M3gEGteR8USjINRLUXajJffA+oIz5i9IINNxa+CYqHhNSeZnFklE
         9mDBrNS+ksEl/Javqlw5xA+8MEaAUOqmMIHBKSdRVGA68t0SYyVgr5oCnNGrKBDlGlJY
         KG3KINRJW0PMvgKijZDQFV/ptjvaUFfpd9J8C6mKZF+mjdOO3i8Or1aN44bMB1Vf/yoL
         MnTipNqv6IUSb1/kItZL9TTt7lxk1n0vvyaGdu6nCX31NxbSnnLR7xWyvCSbsqzvv3g2
         scSMrhMAvwaG1Pauga9jfGqrbOa4++dAKhxLGRS7uGBjWlIlpngFl7ukF2DRQISl/nkn
         f2fQ==
X-Gm-Message-State: AFuF++mpfLXVOEvpMirtNNJvJDbkOx25f4JGG3TYP4eZg9E/HeLWT93G
	ADjTErFCaRbE4BhFIEwYmZvpJszgnxAA8qR20H8MP4cev5VGJ02HKO07r+ke1A==
X-Gm-Gg: AYBFou2oPAv2GFG/YU6tol3Ff7ldeVKyZvxxgl7lakBRb8xHjTsDfhJhHNeFrY8HpUn
	UXI2M4VAf+o3JOaUiYIx8tJW+dOGnC6gc3DiUMUmBjBKWaPjJ5TdAZB0SMfGJ/UAFkRs/rGXD7/
	MAku+aTO32nE19NbVsApEO1sLCWEV4WnWIGxO8SbUhSOPxV3+ul7NTiru/ALDlK4RFSFWZkWwkm
	ygQPe2GxixugZpj6c4kAACEwehKnQudsijZ9Sz/vGfadcUcxuuo8XGaFDC+R/SMgrLyuiASoHwq
	eAqrCtvrAEf5GplQSUUwYP3TvbTUIHNmWTISxL694H6wXighl/+Wqs3dU43Aa6ppXboaWsifM03
	7yfhDGZPE0a7DhymNgKsfDuCtlwBib54D5T06fXtUf1xu1F4KUedVxITQFMOZ88qSuuit1zmk/d
	LNuadosjC2yV8j5exNeh+opvD4YF7EhAf/fO9r9XTqn1gFIf2fvlCuMP9tEOaXxltAZ+NZoVPsY
	fdj
X-Received: by 2002:a17:902:db0a:b0:2dd:c100:4252 with SMTP id d9443c01a7336-2df7e24c1a5mr82908315ad.54.1790551426836;
        Sun, 27 Sep 2026 16:23:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.3.231.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91477b72sm32107005ad.84.2026.09.27.16.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:23:46 -0700 (PDT)
Message-ID: <6ab9a582.07c4b26a.3355cc.5662@mx.google.com>
Date: Sun, 27 Sep 2026 16:23:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2156196556212583947=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v4,1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
In-Reply-To: <20260926085302.2879093-1-ravindra@intel.com>
References: <20260926085302.2879093-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2156196556212583947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174568/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.79 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.88 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      30.53 seconds
CheckAllWarning               PASS      35.22 seconds
CheckSparse                   PASS      36.22 seconds
BuildKernel32                 PASS      29.30 seconds
CheckKernelLLVM               PASS      35.32 seconds
TestRunnerSetup               PASS      803.97 seconds
IncrementalBuild              PASS      32.58 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#87: 
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0

total: 0 errors, 1 warnings, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14849956.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check

9: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0"
10: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 1"
11: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 2"
12: B1 Line exceeds max length (98>80): "  btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend [btintel_pcie] returns -16"


https://github.com/bluez/bluetooth-next/pull/822

---
Regards,
Linux Bluetooth


--===============2156196556212583947==--
