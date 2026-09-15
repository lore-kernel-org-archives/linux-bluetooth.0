Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3192395AD1
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477054; cv=none; b=L0R7AMXFLbYH+aFPXKyIfP9ycWqNHlvrSaYpeaF799s0Lryo0C8whtj3lHUmtLxiaZNcNvFjDdzv9Zk7GF07Dnwre8FXOWCnOQyORGBQGqoGqPOM9HcMEy3i25Vf1HKgBYZd6oKMKazyXxt8VPAogGSrDONk60XdRV6Qk1hPgpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477054; c=relaxed/simple;
	bh=3QZEPoVca/rLzB1K3aSZCFejfDRS7/a4GLzN/Qd9Kbw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S5mYooWG9YOX5gNHvoWtAC81oT+0XVP8U3WNteMkwBzKFIJstKntj7ToQRMw2oZ3yxArYJtwkjm74TW3lUJ2JAoSnbOcUjCnyYooBBEilx6J+NP6sbMuc5mRwAqUFl6b81pXvSnvXXP5Z/X1OHpxfYZOt1UsQtCycaIKEBYHf0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVLtfchL; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVLtfchL"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109fafd6so337078285a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789477052; x=1790081852; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QZXkNwsMIIK/vxZZYkXZjkLGqh78LoEcTCMvoFEwYBU=;
        b=fVLtfchLgeZQT6NYG2nW01oxUaAo49fulUa/9ymXepPcBx+kJ4YEUAqogDIXN1g7sF
         N5IASXkqGaLCYb9vlPTknPkbwDsuO1/JNrBDEQ0kU7brLODHdp7LpstwExSGEyObgzYc
         ae/iol6DL+oL18m8UJtgulmtyilUztadi5CEhXkKYQ70ZkaWVOMXHClGsBR22ZmjNzDB
         +9N+t/qhfqkuUpTKno65XhYys2AjGv9+/Ri4pWV+25ffLAaaLxAaZJObnvC3tBloEkTk
         ISnD70MkuFm0LC25WM4B3SCq2PkyCgcTYCavPhP2E783GqhGyyFrTbDluneq2MogXYFR
         2NUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789477052; x=1790081852;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QZXkNwsMIIK/vxZZYkXZjkLGqh78LoEcTCMvoFEwYBU=;
        b=P9AizaIwu7lPsJS0/bf86VStzUKXBZUvtp9B6/jk9YIre8/RKiVjUDbOZwRMvgwWY1
         tygoG5macPPnEk4hcl+OlirGvRy5c8FIeIeLIaQIMBEzKr0LihtbjdcKDaC+05pYcIQa
         5286jj6G4B98MxiFv4sBwZy8YjBnQemADt63LXKXt+NU4nSRNO/vC3GJfcs89VM5uFj2
         8zxufW3C4eW+k0lgzUxRyaQXPMpcXsb834R9YFOcjEOQuj1MyZN9IQTW3OEsJsOamrzk
         oG3siQP2kVNWDKZIwjoenXzKUqD/tu9bcXaXppMxKvV2oQiZMXpy5az250cHVepYG7bm
         IGjQ==
X-Gm-Message-State: AFuF++mZMys/Xzo5Ksw0VbvwYT4GJio/tYOwaH6x4hyN5muC7ZzNxG7z
	nLbHQIkaV/ZQQGpcTMAGeoDkTVsZTr0mEDFIPWMoBynpyevgnU+TmV7bxm/TwA==
X-Gm-Gg: AYBFou3xBf4gjEA7birGzYLlNBOKAosF/hmOt2fFQqwQpmGPAhgwxUGB3ZHDDX0Tjj+
	p7FyRqyjCY7L+JYplWtPL1rbzrOItFshxCK0Q4fPf8XGEUTJVPq+KI7ea0iCGbQ1BNEiG/ukbFE
	SD5ZDKX4x5ZKkIjOcbQCR5YBrh+Q2O+KvbsmOWl2NrdXBWZaIHTBTnyqgUtvKEHlp8cAkVPJ48i
	vpj8iNILt0ARlPRxnsvRLg/u1PanaWcBTmIVGQNc0Vd5Zo4FiT3B5aQlfDjLu5zn7IqVydAbMS5
	M2Wl+nZ2Mt3y8WY2qYvd+zkyDcihQuvsCL6opwRrIbg+iTzgOEm9GhsOcPpBbhsyK/MXuc3MczK
	zUvrS9FqfdNM1kVP2P8RfwHySMX88j6Fzgt4GM/u5+gkSTlgQaZKfRT4Jcdb9KB+ovv95ak/qtx
	Q4nMT/7emYyFoszHDYY+rcKSZmSZIAGrEW5DZ0WRiXH4Md3KUZFVZFBY8RbcPwJFZGLZOe4+hlR
	Me2gSg=
X-Received: by 2002:a05:620a:4620:b0:93a:1101:a21c with SMTP id af79cd13be357-93a299f084bmr1061083185a.25.1789477051788;
        Tue, 15 Sep 2026 05:57:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.44.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ebda519bsm1223721385a.26.2026.09.15.05.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:57:31 -0700 (PDT)
Message-ID: <6aa940bb.7f16daeb.bd778.303f@mx.google.com>
Date: Tue, 15 Sep 2026 05:57:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8797965701362135438=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, skokovmaksimevg@gmail.com
Subject: RE: [v2] Bluetooth: RFCOMM: free the skb when the DLC has no owner
In-Reply-To: <20260915070119.45143-1-skokovmaksimevg@gmail.com>
References: <20260915070119.45143-1-skokovmaksimevg@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8797965701362135438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165161/

---Test result---

Test Summary:
CheckPatch                    PASS      1.02 seconds
VerifyFixes                   PASS      6.17 seconds
VerifySignedoff               PASS      0.49 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      30.36 seconds
CheckAllWarning               PASS      35.00 seconds
CheckSparse                   PASS      37.29 seconds
BuildKernel32                 PASS      30.42 seconds
CheckKernelLLVM               PASS      36.83 seconds
TestRunnerSetup               PASS      811.83 seconds
TestRunner_rfcomm-tester      FAIL      9.06 seconds
IncrementalBuild              PASS      28.49 seconds

Details
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/771

---
Regards,
Linux Bluetooth


--===============8797965701362135438==--
