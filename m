Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3111F30A9
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104644; cv=none; b=sbfV3tJ50ST0exmLW5257pD+BU4FlMOAYRqg9g3R8h/rIC8U18fRU8AyGwd6R6crZclH9AY6FHnIYYQuOd6SYR9W5OteJpa7l0MET6EGr/GhIbZlHF5KjpdgkYOlVUyhicL7e31YRHmohvhXwvSujn52Mv8VsatoiaFJ70OLcK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104644; c=relaxed/simple;
	bh=kegckKHo7DPJhThHogXn/0Hihn/frJkJVdDn6izLSpI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j2Zl5cBSvSARdNytDs0wa810rV3reJNhgoOgJ3Q55gt6tSsyU27vmBSWZU6wzYoL+UM8fzU2v6uxISZpD75COHtQWy8saP2klP80O7apq9EhhbQGqMMr57sbgfOOwpWiYy7WV4oELdGtFBUvUxoQtLPvFCe3tDYGCH6r/Byt+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+9nJBec; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+9nJBec"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efbafa1bacso5865406d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783104642; x=1783709442; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EpZrwQqhtBenT7nV/+3EqH+GCyhbL07KhLcHPaPHOY0=;
        b=q+9nJBecN9g4UgIMxyBUj4mmam7T3Tdv2GuJNcNuAUEebd6X8vLDEFigHuthn0Ds7U
         U8NNzG5m23KVXrRemzINVDX9anNEJSviCxadGZtV9oMQz5/9eaPMn90PBCP0WeQwmQow
         ct+SnC8JzN5bOycV8G+VY2DfS4Dz0FhLEWgv2AFiyzSwVf2znnLopo8EeGnbrL1/1dmj
         UCsF7P4FvPcnXcIQg6VYaRyIEkgC+Y0OCTUC6bNNeXreoqHDwZBQnjYiAjWkOxnZo+Ie
         0Qyrn210Hq0+/pTX7semg8RHg3ec6maHcgERyEO/RyA9Kot3JPWsLJyNzpEAPYMJwfyX
         +f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783104642; x=1783709442;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpZrwQqhtBenT7nV/+3EqH+GCyhbL07KhLcHPaPHOY0=;
        b=P+Uhn6GbiUWN+wUx4ia23bdyrw87fyzYFqlbCUY8/RpfhubO2vFIjI9sSXoBpeizCJ
         jJAcaGpagoT36isa1aCM/mTvShiaXABFNIpVTClwJbARb8rZh5rKlwlODb00h2oBwQJU
         ofk+wOmLl+WtpgP90gFPN/VVYtKuX1hdGQmGfUv/Dl96+mqTQhF7cc/n9SZxPnq8GTJH
         nY9sos/4xp3CW6l+cV6uWsSj0ERgSH6pJ/9kRlioJn4JXMP4lNBw7gwK90uyAwlPbaUH
         H2Fz6pFtlEHzKCVPXP52T8Sn06ddXUqFNg/1sIdKPVqoN3jqelxmljajFwT4MCGK1xSW
         0Zcg==
X-Gm-Message-State: AOJu0YwSPsKkUxYmWmRVHLrpqbajEkds+0/3W8WKDtIm0W/5+AMZHhm3
	4dFq4faRcn760yeDEmwETcOP+4WiTjVF4DgYgzn/6vemEyj/au3qg1tWIqo+eQ==
X-Gm-Gg: AfdE7cmKTbL3dMimLEWytfI7w6vfKzpYY3gK6D0wipeije+N2QHdqtouJRmiea65oP7
	n7dHVutW1ZcjI1wqMeQWZAsHs1/pJ1snLE0CS9YT56OSfd7m6KNd76cFccQgG2rvMzWQ8FEhxvc
	fMbtrFt17IV17WoearVsRsxNnh6iETg0F1kiV10/QwGrQRz7JHLr6ykr09DdCOUPJrmhreGynM7
	KHbNMztl7yt++xkXS/AKIFTzp4oqIOSDqpVZDdfUYLThpHDstgGJW5wwICo19fGwxOXHBX18zvI
	qzp+I6sge18sb4ci6uzGLkZqEBwePSF6oHyVIPTlY4eHkoGQo+b8+94KBYFWs9TcFNqsgD3sDlg
	BOIOgDbhVqi/zW2ojkaMkP2N4CV8SamH2zmSZY47Wc2JEDmPkkXPmJQ8FGX+SZW5N1jlBUe4aGe
	LdFC04OiSYv9gROWojf+V8ozxv8b0yLns=
X-Received: by 2002:a05:6214:20a6:b0:8ef:e0d0:9fae with SMTP id 6a1803df08f44-8f74afc1a3cmr6727936d6.14.1783104642022;
        Fri, 03 Jul 2026 11:50:42 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.107.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d137sm61727106d6.9.2026.07.03.11.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 11:50:41 -0700 (PDT)
Message-ID: <6a480481.36695ec4.2a7238.4417@mx.google.com>
Date: Fri, 03 Jul 2026 11:50:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7079306447172216066=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [v2] Bluetooth: MGMT: validate LOAD_CONN_PARAM entry before update
In-Reply-To: <20260703172455.2363611-1-zzzccc427@gmail.com>
References: <20260703172455.2363611-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7079306447172216066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1121293

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.17 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      27.08 seconds
CheckAllWarning               PASS      29.49 seconds
CheckSparse                   PASS      28.61 seconds
BuildKernel32                 PASS      26.33 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      494.89 seconds
TestRunner_mgmt-tester        FAIL      208.00 seconds
TestRunner_mesh-tester        FAIL      27.05 seconds
IncrementalBuild              PASS      26.66 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.245 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.731 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/394

---
Regards,
Linux Bluetooth


--===============7079306447172216066==--
