Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE973E1729
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981758; cv=none; b=c9J0slxAFEoUfuOlCu3Rtz8DfF3/4bZjH70dV+etTvB0zOaeC0HEbvGuVR4NA50Lr0SMrZ3f83ju6DmSO18px/IT72YmEU2XvYIR4YHAPC4fPmpalITvqKEdFIlzlkhaqRgWJ1pwq+AWfXfKsXILn4uKOWwED9ss5PWeiKd16dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981758; c=relaxed/simple;
	bh=bVyOZIiiR3VyWKg0fKoYLB8uM6vM+vHvJ/VG9bLAXuo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MO1Y1k5mi9XfYRzEXcngbbgAP/SILafvBTiBJQsphvZFxDvVVRlZX+eBqXcqWrhO6y3SpO7SgXoJIIvU5qgIoPpTlSyD82N4JB20UO9lkFerkczN5hG4s6H8wYj/QUDefGW742mBA5yC3uTMyPTLBsUpTevAp8wDTmCJiaOnd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAUUzo37; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAUUzo37"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52b4e988c77so23011461cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786981754; x=1787586554; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DIV8ZoDMPXHSDT7wxMxuglGH+SiEcM0VUeD2Ma9wq1g=;
        b=fAUUzo37jdGC7vFTGrXeMar5uBEYdG9PWZhADyOmndtOCjnYMPg56kZNvknQ1mDv4l
         qWPv1X+twIF87rYyhX8wlX5Nq1np6NuKadiNIwGjVDurYnQfZ1H4is9VsxHavg7duHs4
         84pI9/yXmvw8FJ5nw5JLfciIm/NRtUWLXOyF9rv8FmX8Xl4XpqpiW/hxSd82h0LvZ+/p
         scmVubv/KLDq2P7P01GUo3zJxDEOKyYMRuLj7//n7yercmDexVhyDYmgqI/X/ZaBPFgo
         1y7aUerPSymXxe05H5gFCyKnU1K5X2k4fH69N3X6LIStYgnzgwfWiEcZjFBMf5uD5fRK
         AAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786981754; x=1787586554;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DIV8ZoDMPXHSDT7wxMxuglGH+SiEcM0VUeD2Ma9wq1g=;
        b=SvJXRWcrpkwlkbZXbswPgTilroq8VKNMqC9oaB9pumBmydivGYcTF4rYS4kxk6YbYv
         lrZ1KFrNsE+Lb9F1b6NnaxK2qHgvIUaYs7/QX4n2SZ911Sc1v3H7ejl4aaXgYBDchG0P
         GnLw89xoEabS4je63zfhWjeosuhKohBxufSuLMm6MbKcmMegvbhNEGTZWFFa3x9aRKka
         uMrfsLnf8pHOQSt6V85zRcJgJ1bsBHznDRYg1W8W8hCJW1wDGNaoP8hqzLeA669Lh81H
         7z+Oz6yrlGTngvc211qL570LnJL5wrVTVbBauMUw4EgddKQ08dg5LMqrgpbfcuPL3nN0
         nmEQ==
X-Gm-Message-State: AOJu0YyNrWoS+cgkEfXoKOkqNjsrF3UrUhkCTFvTU9nXGk2v0Q+KX4wo
	hmh7ND1QmO4duQ4VITnph2M8N031pPi00m0soxeFZ/Smobzr2lMsJYik6UgOpg==
X-Gm-Gg: AR+sD10N7jnIp5oif27TuZWMfZAAVilLq6HosWyWSW2NrRO308J6VKdd3p4HlfVM9sm
	+E++kkDF5PX9emifxEyFQSoUgjbMjp3JNb5MDelK9bSjF9jBmVblWkxKO3rmE3JBGSOPQbxY53P
	w+96+JsfmdO2gh0gb5EqABgbPyO7x+08oLYdEYtly7ao8F7vBvFbym4F9z88QNbqzBWi/pCTA08
	2g554B+so50aXegSum7P8Ht4piXE0XboMfiuAFpMBc+tSJFmn/DT3x58vUWZk8yFQI7xiAnFuY3
	05RaHKXZnpUoUsbjRcunbAQUd4xeDbNPBkOTLJkCG74Sotquc7jE7a3GVLqUdElcr+fhupTHZC3
	5Ux5vwwclwxvILi328FHiNI+L6JM1YZyJKX5yGABGP4tWRnYn8Xh7gsB1v/F1XPf1Fi7p8sPFCV
	AuyXMHWEsnIVNqRoCUPJHvJT+bUNn6y08mWNyHfZYGP2YkO6tYJOCcyrb0IQ7jeTjXp3i7EQ==
X-Received: by 2002:ac8:5952:0:b0:52d:771a:231f with SMTP id d75a77b69052e-52d8542108fmr266508351cf.12.1786981754476;
        Mon, 17 Aug 2026 08:49:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.125.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db6217561sm16892941cf.18.2026.08.17.08.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 08:49:13 -0700 (PDT)
Message-ID: <6a832d79.4e600794.1c90b6.fe75@mx.google.com>
Date: Mon, 17 Aug 2026 08:49:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2334502413263522728=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, valentin.kindschi@fiveco.ch
Subject: RE: Bluetooth: fix endless adv params retry after a cancelled connection
In-Reply-To: <20260817150240.520181-2-valentin.kindschi@fiveco.ch>
References: <20260817150240.520181-2-valentin.kindschi@fiveco.ch>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2334502413263522728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147269

---Test result---

Test Summary:
CheckPatch                    PASS      1.65 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.65 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      27.32 seconds
CheckAllWarning               PASS      29.88 seconds
CheckSparse                   PASS      28.87 seconds
BuildKernel32                 PASS      30.57 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      499.72 seconds
TestRunner_l2cap-tester       PASS      66.25 seconds
TestRunner_iso-tester         PASS      80.03 seconds
TestRunner_bnep-tester        PASS      19.40 seconds
TestRunner_mgmt-tester        FAIL      222.42 seconds
TestRunner_rfcomm-tester      PASS      25.40 seconds
TestRunner_sco-tester         PASS      31.73 seconds
TestRunner_ioctl-tester       PASS      26.30 seconds
TestRunner_mesh-tester        FAIL      25.99 seconds
TestRunner_smp-tester         PASS      23.88 seconds
TestRunner_userchan-tester    PASS      20.74 seconds
TestRunner_6lowpan-tester     PASS      23.54 seconds
IncrementalBuild              PASS      34.39 seconds

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
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.248 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.347 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/600

---
Regards,
Linux Bluetooth


--===============2334502413263522728==--
