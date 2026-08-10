Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696E3AB28E
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Aug 2026 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360988; cv=none; b=NRzikrVjSrS6+upKr9o6Ao3452cM4EwpCri2FQGZLx+9N4uaOmPME/z1BofRughkbHNBgvGyUhlf612K9mLMYpYfCFeL5PdTQETZ3hz2e0fcfVDt96xhxiP+xxZjTzls1qgXkn2yhCsJfVGMW23F4xYzRgzqWsTg5kfVhCTyHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360988; c=relaxed/simple;
	bh=Y1nYi/VzXRgHBQ4yn8kl1oAOsSf3FWiU1pp2dKx1Jbc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Tzbx5o6th2y1Bc5oGPj9hNU4LPFGc16nRHUXnRuAhhey1k6bMd1RTkU2OfPC57EWOcldct4cI1WPHcoIqDA4JjBcClSENUgk8R4zW8M2HgJkSGP0VdTQmxDB82ooPjNr75IFXMpMijsLSQqtixyZf7uzqiKZ34g7QED6R/USM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEIslQ0h; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEIslQ0h"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e7632b193so108950785a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Aug 2026 04:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786360986; x=1786965786; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xefskm0uc1i4stOEeGlMYgVMg9C3NAtRqMUu2OiDUNM=;
        b=mEIslQ0hYKN7E6FZ0+ikJkjfYzMCOP+kojdOwcYHu6hmqkUvfdQsqsZ4EzchbOfmjB
         oo8iY1NaupwciGOya2KiJ9JtfzHL2cfvCLfTDAYAQODkHPdlgi6Z6q0hDToWsjPCYZp2
         NdqJt437S3sQ2r4SHlbHAVOV3Lhsqb1wRkBBivrgpHbT1g0FEEcaM0i01nyXLrong3Rt
         4DhXuOdnKoqDgTnp7zb+IBM0BPn+ga/rCZGjhMf1a2+GD9z6g190xScWcbv2akoGFjnQ
         ujmgi9MnM3s5NOdm7wOFcwDKCNCLrTwfquh4ULoJamQol6Q8cQKwguDTm3Zm/kFI3JSn
         QOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786360986; x=1786965786;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xefskm0uc1i4stOEeGlMYgVMg9C3NAtRqMUu2OiDUNM=;
        b=CA+RUrkYRG5TwBNiityCIBoMjy3mJfogOWTsk2h0BUfWflQXQy+aHxSscBPNRDQb0v
         tV3tBSBpSUHQBkD8YJrFzkYuKVvvjYvSibYPsJEeswjqI51ti7K7sPsgVaV7TRqUKb+V
         3wNqpc7TwL830TBVq/Z5+x7vbQ1GPMYKgs6dN4q8UQsVERR3RrcqpFigKCyo6PgYhz/a
         jULfqbAr0DsJoMjSHJmsEgNA5RXU6NwQt/EmsVvEiGOVIDtmyPLU6QwywSAdmcsZ2HeD
         FIz2dwB19JIs2i9pDokrkgMX86wAx2OrSHY6IF+4X76CmmJpZc690UtTiuL1MZiRoweL
         0fow==
X-Gm-Message-State: AOJu0Yx5HXTeU0k14P2yKCxdacpDDCkri+j2W27O34uE5ExVMYIQXpIS
	SYdom5s6QDypG5qEf9d2sMmzqhlywlPbVAVKbCZEfXqMNDYCK2Xv+5YoyCLi8w==
X-Gm-Gg: AR+sD13z+8zj5dTtnuR3u+09yMl5wNV+fMPVx68VJ2GvO+ciQJojuVzqfdlt3E/1sbk
	Pnj3C943lud9Of2Ux07rVip3Av8mptd4hE5NdncB8qp1FG7HvOG0dzAYiMLOssDjtIHimX/iB9k
	NRLVl2zNXw5FvwgNKaGYd2lo2ggpqfcF1ASKIWu8jzSHVdCzylgOpRYBQUZ0rSygzKiETl1bdQV
	3VmUWmfXlaUuZPiew/9Zj13HiHRsZF1oyTiqBeHuFKgIH+YAAieDn1N6DQ4fSFal6upnEHSL06X
	WD43MZRn3C9KTaNVMzvafx4UdlBBWb/GB6YoTupdQapOsJsGDU3qi6NSqLxnFMIz+d1qW47cApt
	wRpauCbLPMgulAvZAggdJ+me97ht3raDrhaxf88iQFx5zXNcgvQvKdJjQHQv95pE7JS+6eiJa0n
	7wXS077V4sN4duGixPNEfTzIYBjbOYlXEl4/Tx9EOMwbAO4dyMZmfW/o5vKGiZXiEQeok=
X-Received: by 2002:a05:620a:4513:b0:936:4c33:67f with SMTP id af79cd13be357-9367977a80bmr1856086185a.19.1786360985940;
        Mon, 10 Aug 2026 04:23:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.102.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e22995fsm767905285a.29.2026.08.10.04.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 04:23:05 -0700 (PDT)
Message-ID: <6a79b499.068af3ef.3a752b.5ca5@mx.google.com>
Date: Mon, 10 Aug 2026 04:23:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6777180604633408339=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaojinming@uniontech.com
Subject: RE: [v2] Bluetooth: btmtksdio: fix deadlock in close and reset paths
In-Reply-To: <81B94E6D2ACC0BFD+20260810-btmtksdio-deadlock-fix-v2-1-0eb31f9066d6@uniontech.com>
References: <81B94E6D2ACC0BFD+20260810-btmtksdio-deadlock-fix-v2-1-0eb31f9066d6@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6777180604633408339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1143277

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.53 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.15 seconds
CheckAllWarning               PASS      29.02 seconds
CheckSparse                   PASS      28.13 seconds
BuildKernel32                 PASS      25.31 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      463.70 seconds
IncrementalBuild              PASS      24.44 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/566

---
Regards,
Linux Bluetooth


--===============6777180604633408339==--
