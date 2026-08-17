Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72A26AC3
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786938666; cv=none; b=SfljLbSONByD2v0I6kpzBldMibPXj0Qtq2lYro2zSo6smw/mo2UGUTQPdZQ81G1hoGAabF8seoBmltMnpgqezIsDIL6K2d+xNMwXx+OsGpNll0yX2X8dvjXzCnrkehe62GRk+9uKeidmhdSigwS3hsBhQC2jCGK1e6wWuFWkbkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786938666; c=relaxed/simple;
	bh=wpWe2oId2WR+Hja6it+zEgDdQN2k7kkSljXjgYxb9DA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YKgG5b0PRdv0Nb3RZ3fp+upZ/R/Q67x1f9tH+zxOCSnvUudH77h7uu3Tc5B3hYdCWUB8eCbubilrpI7ToIeWl/FC+KQeAW/M8GfO/8gQQHfbe8caKWliaJcoXhW08YjOKGNGRhf/m5guUVH2YZXnywKcaomckXVMspsn6r+rz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dckEREZj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dckEREZj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cace91f112so32605495ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 20:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786938664; x=1787543464; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wK0gwbiAUgDPlMPP58WUI/KVvx1bIwmXPCUblQ6Yzjw=;
        b=dckEREZjY86SYRlxPVZbQ5ATKXe/Fgzr4bkEOHtJY0sq5MGz1ap44v7yDsfSHDwSEu
         wbF/XRbr4lyn+JXvy+HQjFSJFAX8LKhnoAjU9fbUsbs6gCnq3S4P6wMeefn5+SBfipmE
         EceSPgCWDR4jKkQEKWKCdkzeXNzT7G8Xx1vWjOWTA0SdP76Vzvp6g9KDU0PjBpMmtPAI
         qkWSn60sqY7ThJKjY3RBCCEUSFhqVjabepFKKtFr6v5U+dPhA+ah6owXFSpVD2YvTeB2
         uOTUbKwEOc5PobtnXylw42R9ZnBzKC2O8tdJX1ZjLjH1kYH+4sTIjgMZbRB7YqDKus8/
         LB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786938664; x=1787543464;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wK0gwbiAUgDPlMPP58WUI/KVvx1bIwmXPCUblQ6Yzjw=;
        b=l+uM2IhQCaqUqq7UfujEodTNdqwBRFThDkqeEaxPxu4SIDciWZPCMkDrBTCKx8bl+R
         YT6cP12okcdmAvnGz2/ICkxjpDn4jrNzkqWF1c4PLtaBoQ6z3onZV9VGs/WNpAJ1Vv5K
         zh7GOaKs8CwJac4YAWivoJQM8fvcGU03Sm9/xvT1vzWttPtLDsEGLhy5JjbxXY8htoZ6
         Z5TZl618wNSLw4HI20/i2XKcOlkgk5pnw5695hAzhFey2aoJLgI56/T+bRpXoUTFGKLh
         z6F3IOWQqojDx/FHM5VKsa6cH2kh/8BLCt96eEE3be0NOYsPPchnHayKoSO5o8VTZcMe
         ZZXA==
X-Gm-Message-State: AOJu0YwFs4nM7eDcqLTQwDLwW7l/biT2ki+iP0kFCSMQuAuo/8UzzIQW
	P775p1rjzGaPKVNx3Ey/pjwNQRNGxIWqwgXXW557Q8EaR38NlMBy+1oLwKr+SQ==
X-Gm-Gg: AR+sD11GJvo/m/dcWpMUSOyxoG3fAQGr8zWu42dogV/S1u6IPV+PgW8j0cXKFxrDKJE
	cehq9jTJ5OcQ7WdKhk14dQVu+KQ+yxrKF7p/HrcPx9pdSDtndqoRydCeNsxFZrDQyDR98+EBKgt
	ICErmiJLDLc4X4urR6kqZaX8OZ8iLdu2atcUefS6+gzgDsK5L8WcnPTXrXrw0DuWJUTkKSOemzS
	aT7GrGt0j8J+8Jh7bf3wQp7OcUMKUk3ECSJk0YSzVPqaRe686Ed2gr3gmaRoeAD0pyrnvRNLu9v
	bZXvr06xi9mh14puijVAXxrgV95DkcKAfnwHXACGf4m2fKdAOnxheAgCXPX5NVjLlmKxG/oMJPM
	I6k2mLy/I4yWlIuQUnyHuZOGeWCJTAzls++PLLocB5EVoDXAUMfYuueLVTftwMcJ/t3r3Y4ZX4o
	Yh8h7vdaxaatpHLEmCpU24CRZQ3BwY9HD71yrO9aZaVAGy+zMyVNapbPQoqOsZoU/TWw==
X-Received: by 2002:a05:6a20:728a:b0:3c8:f342:132c with SMTP id adf61e73a8af0-3cc71ddb288mr20982021637.11.1786938664423;
        Sun, 16 Aug 2026 20:51:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.29.99])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14153044411sm1522018c88.1.2026.08.16.20.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 20:51:03 -0700 (PDT)
Message-ID: <6a828527.c5504292.7202b.bcbc@mx.google.com>
Date: Sun, 16 Aug 2026 20:51:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4193713724944498190=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sherry.sun@oss.nxp.com
Subject: RE: Bluetooth: btnxpuart: Check remote M.2 connector availability before pwrseq
In-Reply-To: <20260817-btnxpuart_m2-v1-1-a23e51020794@nxp.com>
References: <20260817-btnxpuart_m2-v1-1-a23e51020794@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4193713724944498190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146897

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.78 seconds
CheckAllWarning               PASS      30.24 seconds
CheckSparse                   PASS      29.08 seconds
BuildKernel32                 PASS      27.00 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      520.32 seconds
IncrementalBuild              PASS      26.09 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/594

---
Regards,
Linux Bluetooth


--===============4193713724944498190==--
