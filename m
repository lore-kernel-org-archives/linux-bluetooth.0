Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9A35C692
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446796; cv=none; b=aFYitKgJetHARK//UbnutOmiJjYAcacfIfIrzS4rhM3APmzBZJboe13ZgfV5CbhB6ns60ifPKGuFsaP9gDJvYN8oW+QniJ2OI1QGPTNIcOZFkTk22JYwU/tAPFfWIn0tTTl1J1kOfzIJHvL7Ppa88E9ZbOG37soQhamrK7p8Tpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446796; c=relaxed/simple;
	bh=Ios9SI6C2fWMbQ8mEjKrixeu2jt+d2sL6kKSBSpqLGA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qwZg4tl1Q6HZgJMFe4+ymf/5ekYaU/dKbTnCXCsxzrZwLWClb3fNRFa1Q5oCDtcGFWBhLQT2EiQmzknsoCrRbwUkgOGO5HnQzA6GxbFEITzFwO1iGdTKmN/x0Rbpg0Pq1BPUiVJx4NlQ3NJm+cnvaRck52kW2meu4kgosXuVoUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF46aeHp; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF46aeHp"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6deb848ddd7so3407878eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446793; x=1792051593; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rhJd92/NzBBD4GLX4AokrdepeGSh6JUjC1hHA7PKdSI=;
        b=VF46aeHpSEabVbn+FwWeo00SzZ9LPYJVc2XK/lYfnghaz/N7nEx8xIswSDl1lGOXVY
         xDbjwvD21sCVmSWEVfPnuFeUOWqdB2fb3CANSYw54lyfRvsbz3dV22CQH7YeKX31QWDk
         oMQ3GgxVKN+NKifKz/hLmrtf4WyiBy8Xtz7/cvaqZwkDxq2wv/Rin6JVaY4UJT3J5rrR
         /fXV0Aiz4WFT7rImf2T6+JB9Q6xb5w9STflBI3q0awTFN1AVE0vMYOw9TYk2Ql4kMYRA
         C/+JrkF8yIw9FL1dBadnhTQx1cDJ65aaVTDyIvy5x9r4TKBGPww+xmXuxckzA0dKdcSH
         EiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446793; x=1792051593;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rhJd92/NzBBD4GLX4AokrdepeGSh6JUjC1hHA7PKdSI=;
        b=stdcRkgQPJN3CceMlSQGGo3G4BWmO1deKZaqKz+Kdbq4codmFt0tDWVyyiZdwu4iSc
         TQkWXHzYpiMOiP/RwKKv/uv8ae5eOoEqEonM18fXRoB+o61yZvW+xNuVU+uj99lgzRS/
         k4dGEh/vEZpx4G7XgPjUPGVnWuIeJ317gCCXwQw+XNZlJeybxrwEGhVoqmHP6eHXml8a
         vTnBWB1z1tcTJc/hpVGZIq0gh8xtHBudwUjaAiLIUKovO+R/mLf7XD/HenldWdm7og78
         dvgdXeNOtTjf8+S0ZKM3/RMm/q0e+rVP9KuvzUR1tRL/SqPxpbDKaZCG3lqT4gHh99RE
         xJqg==
X-Gm-Message-State: AFuF++lR3yP3F2DSGKksc2ka/GTGnCdDZc6wjVccPwHCqkR1NOdWEyBr
	APq7MO3IW3cIwHGvOn3JS9tpJb2NcIvtbQwY8B0IpmISrmDntNFnbxkL6Kwjqg==
X-Gm-Gg: AYBFou2phI9SpeMT5LAPY3pB7MeV+L2y/bkPBrSBwOeDy24XYYx2fhvg3Yi+63ZKoUe
	JZDFQYlPXbThOubzDjgMCMbKYXRhrZ0MW6BKlo16g7864O0rmQSfJhUHnDZH3+/wOL5cZD5QYc5
	K77rIKflfLgxEuWOeJNxHLIb67daO8mr/WOYhC+Zr2sStEyJb7Uvvf2MinG82777KYdOMn4EM9Y
	EJTk2mXq6xDbqhnc69VEsyyVx0UAp0aI4MyUgb4Ae4mcJq2gupm1K/iyf5XYmCEMZrwJltM0T6N
	9hAynsMoABEL09vEp6/NhtlPGaVMD84Dpx+BEshmixPo2imjLd+XeYcT3GMHrfbn3WYs+/iOo9M
	wAGWT8hoUmIFvSVKaVfaNCB1c/ixrQOG8pFDIpaDdSTis4OAfkSDyoBl/pvpPsH+a4v+V/bTZ3Y
	w7/ZjyeB4puNEVYYevMeH5v/+7tNNkFZnmwipDSZuQOv2na6kiNB2R/mnDlvq5aPiEG8xbKHWSO
	mt82/GJ
X-Received: by 2002:a05:6820:1517:b0:6dc:e1c3:b2cf with SMTP id 006d021491bc7-6e7a72967a0mr4832044eaf.55.1791446793384;
        Thu, 08 Oct 2026 01:06:33 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.239.161])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6e79447d888sm3710867eaf.12.2026.10.08.01.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 01:06:31 -0700 (PDT)
Message-ID: <6ac74f07.7406aef7.3045c5.0dc8@mx.google.com>
Date: Thu, 08 Oct 2026 01:06:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0458705151239114645=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_sync: Protect IRK identity reads with RCU
In-Reply-To: <pm-bluetooth-objects-candidate-0130-v4-50db5732ff5e26d28412@gmail.com>
References: <pm-bluetooth-objects-candidate-0130-v4-50db5732ff5e26d28412@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0458705151239114645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181244/

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.43 seconds
CheckAllWarning               PASS      30.99 seconds
CheckSparse                   PASS      33.17 seconds
BuildKernel32                 PASS      27.35 seconds
CheckKernelLLVM               PASS      28.46 seconds
TestRunnerSetup               PASS      669.82 seconds
TestRunner_l2cap-tester       PASS      13.97 seconds
TestRunner_iso-tester         PASS      14.36 seconds
TestRunner_bnep-tester        PASS      2.94 seconds
TestRunner_mgmt-tester        PASS      59.13 seconds
TestRunner_rfcomm-tester      PASS      4.26 seconds
TestRunner_sco-tester         PASS      5.35 seconds
TestRunner_ioctl-tester       PASS      4.44 seconds
TestRunner_mesh-tester        PASS      5.26 seconds
TestRunner_smp-tester         PASS      4.14 seconds
TestRunner_userchan-tester    PASS      3.01 seconds
TestRunner_6lowpan-tester     PASS      4.21 seconds
IncrementalBuild              PASS      25.98 seconds



https://github.com/bluez/bluetooth-next/pull/879

---
Regards,
Linux Bluetooth


--===============0458705151239114645==--
