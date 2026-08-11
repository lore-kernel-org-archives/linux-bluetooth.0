Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37444C670
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464560; cv=none; b=FPKs4pPMxBYc/GM1BJf4A+rm3yKjIO0C9LuGwE7gahlIaM6Of9q6ARlTrVZn4tgXzsgEaXIaFzMVL7WmocWxUYLWn0qyyCevme6g4olsUW17q5cPKxbCFif5ZLky4nM9UDvCEe4460//a0mPq4Q0itWaWyz2aoXSGtyC7h63X5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464560; c=relaxed/simple;
	bh=vc2WyX7OCbYPcMFgUPL13EO51GU0Tm+aFi9wLTgH4uk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=shKHsdzYUI/++aN3HW2hJ4oCSbp0zpZMpww0CepH4SxzJEhBJ8X5VzFAv/iBXCsjhbjEt5AEH8Y20h1C8wsGxXiF22I+SqMFmbwQhOw8O/XX0ud+KARsSENNOLI6hRtNeuWlXDNSpl57XFEuJuHAmE+d7Gz5PnET5AZpFxepP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVZzz7/R; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVZzz7/R"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44cb057311bso584049fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786464558; x=1787069358; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BEkQKWdyRgBgGY1eK+l2toqeI5KxNy4kZcSo/VAvtFw=;
        b=UVZzz7/Rtz4V9b0GAg2rwZoreUmDXqgWWcP8rLlwYwLSQOQapvXANKpSttvjhx7DFQ
         uKwoRJ+cou6B5FmCFz8a6Yjlsf3fbEAsDif01SWMnAHBswTavQKBjKs+86IPTekkmnRN
         Cw4Pkq+3B3sVxJJMWe3zSyx9Y5pbX67tF6H+YEpiogNeSoeOuj5k7lRARU2VEAKUwAbc
         9TqRcrlx/E/WVqzU1RFdsMKOrvX6JNH/mU74iN1Yv4wrv8wAzC9JbV3Sg1aC2QYA3jfU
         BB66i8ocvx4fLS1w8/6LF7gpmLaKUG5Z3oeOtFLikdE4GmEdSGJ42P+HqhUqC5F7zxck
         wWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464558; x=1787069358;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BEkQKWdyRgBgGY1eK+l2toqeI5KxNy4kZcSo/VAvtFw=;
        b=e0ruZT6LvERZvkjxZVccXB3WpJxyx1+eio1NR/XbbNCxklbiKLbdJVRZcCMQU3LW/P
         zUSWHYhKjEh5giaBae3O6YQQkNYsBbXiOcc2UZcFjHIusbDToe5ZhyepdKMH1WTiPYdi
         ZTPmlLPrLWNicq/5gr8N9XrnvZMhuthdnYgOxZeNdL6T1vOl9jtZp7x94as0KExpRRey
         jui66/4utN6jTYAX2rwJLCmLUjjLd2LP4LSBOkkDHEZyQ85AfMOW5l54OqR5MInUim/t
         D33xLSbBJmMxfMT3FliF35h+AlbQemvsAXez5RXzZtyfPHIznczzmO5YgjUEJl6h6Nag
         N18A==
X-Gm-Message-State: AOJu0YzYTkuRPQFUgtUobYyJFENhNSWOdrpyV6FFJ3cy1959HP8A9kyZ
	yop7MpZYB9ek65sYL3fQh+vC2+9QIhvWYtOmD3CIyJedPrIUxJ2fxyllHcylog==
X-Gm-Gg: AR+sD13/qi5hIb7oxcYCXBvNz9oaURyRXA0K7FKVhxgGb7HfF3IezJvqALIOqc7t7TR
	cOsxitDFSt0spOt+webpInXgfR6Tv8K4SJhU4YZokLp55BgvFc2IDHYLtuCSCSVXYoghHeFDohy
	1oSXyGn2FNAAgt21blsK7OdOmvp3Om5XSBCYSNluIcHGHblulZ1PP+uXLX8hecBKVDZan5Q7GUX
	ovKCyvkNjqICV4scD7wf4o6XkYntEUr2dujUFGtt+7MPFbA5jUkHNdDlwbOunIYJcbO8sjL5onR
	aTpTzuvrUk97F5QoNKihf6nlrH/npw9lm+RgPwhX6DkuLf6QFlhFvFTdxBbs5bjbb5ztQgCOCJw
	rlD69K4dU/stgyqQm+4c7xU7t/9dVXaZrpNwNN3B9RNFu6+hIcvAxYdXTv/G2HrchGODUAc3+zx
	CAOxQDLJb3+chdZ8Oknxi5SOoi0nM0RokYpNAfuW3wdKWO7R+AHLROZA7ffyZmfiLfet87
X-Received: by 2002:a05:6870:1f10:b0:43c:2d3f:95f8 with SMTP id 586e51a60fabf-45e313bfc83mr1088238fac.0.1786464557683;
        Tue, 11 Aug 2026 09:09:17 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.180.164])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e35645349sm8478fac.15.2026.08.11.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:09:17 -0700 (PDT)
Message-ID: <6a7b492d.29a6ebfb.30161a.1bee@mx.google.com>
Date: Tue, 11 Aug 2026 09:09:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0304145284112959912=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/3] Bluetooth: btintel_pcie: parse FW memory region addresses via mailbox TLV
In-Reply-To: <20260811154553.629211-1-kiran.k@intel.com>
References: <20260811154553.629211-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0304145284112959912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1144161

---Test result---

Test Summary:
CheckPatch                    PASS      3.05 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      1.26 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      17.68 seconds
CheckAllWarning               PASS      20.39 seconds
CheckSparse                   PASS      18.45 seconds
BuildKernel32                 PASS      16.77 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      310.33 seconds
IncrementalBuild              PASS      20.98 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/3] Bluetooth: btintel_pcie: parse FW memory region addresses via mailbox TLV

1: T1 Title exceeds max length (82>80): "[v1,1/3] Bluetooth: btintel_pcie: parse FW memory region addresses via mailbox TLV"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/572

---
Regards,
Linux Bluetooth


--===============0304145284112959912==--
