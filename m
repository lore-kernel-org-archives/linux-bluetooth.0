Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73945039
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786169294; cv=none; b=fVXtNWNeTJ+OvtxSpo7tdLbVig85WrwjALVR1jfmiXQgv/m/+RSEmegQvygcpZxUPjn0pT4Qd2sxxSAE4WwC1W3pNn9rVKbdrPE1t8LRPMe95VqEWF/NoJ2LvfBAyTpDVAodV+cC1gIjUwRI8gLX1M2pEwsq9ZPcUlJN5pLa1bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786169294; c=relaxed/simple;
	bh=qYGyjgCU/g51gyxJgGdcZHrzoU0FQy3s7Jc+lhdLt6o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fqIfWMUeFVxw30fo6fhfHC15mFUdJUmnkHsRgz9NwIRuq5HiZb3TcaJ5mCf8Fzv51WibHfXGtDwpL9mX8394qSaqwIreLlAxBPjSNkRT9DRDpOn5ekd+cBozCJAtWSckWrSA0ZDGrhsdhVtZDMDKmBG8UCJAo8VFmfNWWoZztPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6KOpDwd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6KOpDwd"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso3262095ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 23:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786169293; x=1786774093; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=35oCVuud+Xz9EniePvGueFqNwhGfJaQuyxZcPs8KBfo=;
        b=L6KOpDwdAaAd40PnjUBx7C4EGW+RD0c/cqZA2w5PyYdPEDxc9FIraLCwVu2SWfhYp/
         3MXr6bVpG+Tn8J6UqGfUJ2l2gm9P8mji+T+5e1PQufkO76TYoEEIVUjQw433+4+HNqye
         C2sHnHIhwE8wilGEPDNXAUX/ADsmZ2IVC1oCWecBxvAblF6fkDoSTTfwLyhcxEI75h6+
         K7um8BGtcP7uSMDDg36tydcjRfR7Jys1S01CvIolbfp4395MoT3flqeER27bmxSRGHIK
         nn3Lrq6UKaBepTU73fPGWPAg6qs7CxQnXNeSLGyBV+umb29HG/y3xuc8VatNS7XEaM9q
         MAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786169293; x=1786774093;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=35oCVuud+Xz9EniePvGueFqNwhGfJaQuyxZcPs8KBfo=;
        b=f4mM0UHgFYE8J5FRgRHDroOgFjSKwBtCX1ZSiIFsO9y+RjiXTsCjU5xCeV7aVFQtei
         sHbD7rfrVvuEJnzYyLOiMjUlJdLbkSwHGzplrh0wlYnHDZHjU7zlJelDzIgrzVMz7qDz
         BF7C3JVoQ9O4Gp7T7aH2ZyWEJ8U/F1u42086A310DeYiTH69HBkwb072PZesE0zpN2eB
         6FN+UcrJ9yM5CpZrDeq4DH8WE4e4vi5bgq1neI14HFIoMSCiywbDvoDiqAUDEfYobf4s
         X1MMPfKpY1lcwKhmFe5VmPL4DtR20x89Ry95Em3iWHko96zzXh2gQyrojemaTJ+/CAlL
         098A==
X-Gm-Message-State: AOJu0YzcfmPXYk/SysZe8vAO+rQLLKVSg94Js8YRtI+Hs5kxUwSqEdp2
	ymd8ShDuRmGrGvsvHr4NAIxSG3g+gqcvzg6YPboCMIe03SDJcOHQaO4h0EAinA==
X-Gm-Gg: AR+sD11vYc599rOahF3lQLT+ADs2i5Fr0LOxIAUQdmbtgU1V9qLWbEqXH1DTAiNRX5t
	bmNG+SBXMtxLj5teBCA5+9hSRsInHX52gd0tut2SDvjUJQMHE+H30/slpzKEJ81x1BIu5xP31uh
	QgIc0pk5gY0faBNUp1P9z1i/PxVz1eWhKv7m0/L4vm0YebnlvffRrU/EKtHh7n5Zd9S7yjRGcX/
	JBkKvBJS7P62KpmaJ52R2YajSF8+632F9Sqg50WArcLPcRoYOImTi9RYLT+eKsHS+BlTYk1QQG4
	dE3XryrqBBSI4PNbFnNDJ08nb28jl6KCc/Z5oVb7jUFU1OCM6WJh1+6yQM5G/B1RcyrodLkaiKF
	Kgr7EoRnYiuGccyCBx+3lyayQkuUNIlwKqUULhmwUojKNdCK3DxKt6cARkgL9DtKhANtUnaZsWW
	EdHBdVUC2IK/nm2aF8fuoxuCY8qml2niI108PtzQ2A3odAdM+1wKYdL4KjT+V/dHgl/3i62A==
X-Received: by 2002:a05:6a20:7fa8:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3cb85ded9c0mr31106687637.5.1786169292785;
        Fri, 07 Aug 2026 23:08:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141018f18d6sm14375704c88.0.2026.08.07.23.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:08:12 -0700 (PDT)
Message-ID: <6a76c7cc.492e23e4.1b03cd.f086@mx.google.com>
Date: Fri, 07 Aug 2026 23:08:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5753900605366303590=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lgs201920130244@gmail.com
Subject: RE: Bluetooth: hci_intel: fix usage_count leak when autosuspend_delay is negative
In-Reply-To: <20260808053057.2566366-1-lgs201920130244@gmail.com>
References: <20260808053057.2566366-1-lgs201920130244@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5753900605366303590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142536

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.38 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.76 seconds
CheckAllWarning               PASS      30.64 seconds
CheckSparse                   PASS      28.99 seconds
BuildKernel32                 PASS      27.02 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      507.22 seconds
IncrementalBuild              PASS      25.80 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/557

---
Regards,
Linux Bluetooth


--===============5753900605366303590==--
