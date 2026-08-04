Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960641D63F
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828699; cv=none; b=WXjYfflQGR9MEDoofAaoAcmc5tL0W/3mJRwz82igmuuK5VruWYHs6/l9OMX4t/wx96Sfl8LIQzSb6HqpBWbwesG4MXDvH4dE+nA5wc1bHBcfb+AWxEU91MEYl3Fwy4X6QLvvE/LNbIzab/FX+BHFUyoiu1ur9Tusb25OzF2MZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828699; c=relaxed/simple;
	bh=P42uGcNfwIwKj0YKyn69hySr+wMcv9Z1oFKiDo/ny6Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ddKz/ur9FWFn6ehN3eHf52XC9KkkD2FFX9F1PnA/Eg3+4UvOZz2WTHD5OYxCtW5Pj7GHr3HxqbtccixyxwR6uFsFcb4Q+81KDD7g1GbMNBx6RdYheJKWH6DCo3JhaV+5RWCvIqN5nrTJ3XhzoeKDSWlIE9kLgK/DCRl6+fOuMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcqkYfvd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcqkYfvd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d0407aedd6so47529985ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 00:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785828698; x=1786433498; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ABXtGmHUNOF3YK67y4Nu+15BOfHjiAWs6HeqneukIc8=;
        b=TcqkYfvdSKBYvt2HS5hrArW0EVtUQ0mO3lZ5j3V9jtcTdm27XUeXEphAJuJmYxBNML
         MgsaTqutCGBBhyRH9/IcetcLQ4DF7zLb/Sjd4RApeAKEk64U4y5u6XQKiifdXTnJBQU/
         DAncn2j4IFZumtD99AW38AmcEimX6JV/C4iONt5sxbRMfnhGMPWywNmADRcAUxsgPsIj
         pdlQDzWDu1xL91p2sjiqDQdTvuCTf6agSk4R1m7J/UBYl6LG0HSwtUzkcdrG0xxvUTSS
         Yl0ThQ1N6gfS38Yw1zewLlhiWkVA604LfKBZL5YOIKsWufqbqxZnrPWVvvj1hBelDF0r
         /4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785828698; x=1786433498;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ABXtGmHUNOF3YK67y4Nu+15BOfHjiAWs6HeqneukIc8=;
        b=mLIban6MxRKpww0LqCi/cL3g3HPkkxrmjA2Nw8DiIhN4j2+VnHDrkqbadMCeBls5Xr
         nYxTubsq79wkO9sHOnV80Hp51PkTKSa3TIkcGowHeVNqW7AcIL7+IlH1QgFxz1XxgJda
         v3Uv5aYYPv8bqi1pvCZyIcrJUHEvfwdSOjBGwisvs7gpfW3pXrSOdSYW01Vsx4d2Y5AX
         kH7ychA14qPzFt0mHqkxzt3uDPBQMKkKlR7csOcRl8NWuooIuGXok5hPJpQDBb+BlWzK
         aDI6ThH+E5ALICm3FHp1J92nHirWSBKuQ4pNFdI8Vzuvzk+ddRjX0yEpVT/K95zZdTq0
         V+/w==
X-Gm-Message-State: AOJu0YyOjdEB5yR1a3vIQ39cmezKA1GeEwE/LPF2hOu58G2mwgiaAw38
	JgPWUxwfl+qRfOuD73eSBNmEsHOTA8now8CyRoGBPvTF8RWfAO7XrLZkh/nLRg==
X-Gm-Gg: AR+sD11J8UR2H4YJwbKYo5ftBpdWA31okoQwAwmvgsKOJ6eMAhnHSVK8Bk2GDfO/wUx
	AoeCxjCiaeKbOkWOJ7sklFwLL2n6CsBp6rF4fat6bH/nVtsSyriTPSvR/A0p1C7+PV2mkY3Yr9V
	goE/YNYIq/frgFMwehcFyaXPR4BDl1N60ZaYTXF7kukA0JIouGpd86gWeMTBQ9av+uW72/yEe5H
	jUT1G9M/EK2gkjzdkheaopXLyJ6giUxjZvk+DIYD+AP8dwrpqNzBd8pNfCM+17o7y8d8PlwkBza
	Pe5FXgbTtlPTImhh4zAqATbAdOTe3RXoO39TGeYOTa9HkIOLY3+7uWFGTnhH+P33/NBrEHcjACc
	kYkU/GeZCpSN/fsDoq1LGgV3aKGR0CfeojwrWQsEIygH666pPIBbwcJwN0BY4r3qEvyVxvNxQOM
	NCTitOwRduNosS4FiXrS8RTSlJBIlUGSeqyfXk2TbAhlf2QnX7fX3ABPHeeG/5cbGPZzzkGDlOr
	0Xk1w==
X-Received: by 2002:a17:903:354b:b0:2cc:d192:50b8 with SMTP id d9443c01a7336-2d052913c00mr142456965ad.47.1785828697668;
        Tue, 04 Aug 2026 00:31:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.64.204.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4b94e4sm1514455ad.56.2026.08.04.00.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:31:37 -0700 (PDT)
Message-ID: <6a719559.52749c36.3929a.1a8b@mx.google.com>
Date: Tue, 04 Aug 2026 00:31:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0433897868498551435=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dishank.garg@oss.qualcomm.com
Subject: RE: [v2] Bluetooth: qca: Allow capturing QCA debug logs in snoop logs
In-Reply-To: <20260804-qca_logs_enable-v2-1-587d584ef4c2@oss.qualcomm.com>
References: <20260804-qca_logs_enable-v2-1-587d584ef4c2@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0433897868498551435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1139805

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.09 seconds
CheckAllWarning               PASS      29.65 seconds
CheckSparse                   PASS      28.19 seconds
BuildKernel32                 PASS      25.90 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      495.81 seconds
IncrementalBuild              PASS      25.47 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: qca: Allow capturing QCA debug logs in snoop logs

35: B2 Line has trailing whitespace: "--  "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/530

---
Regards,
Linux Bluetooth


--===============0433897868498551435==--
