Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F248536C0CB
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960158; cv=none; b=Ypu7WZdypQpPBorJJQN66Ra4FEB13UTEHvqfxwZdvg+EoXPUcHEiBfaJrlNzFkRA9yKOttwcT4HnANNRiV1MdAvpUbSMNtMxyWTJu0WINzvTSsGk9hMfvigzKCY7iuJcFpv5YYxBrI60yPV7IMKIDL/wVWNwaJ4QCnRVGSNn9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960158; c=relaxed/simple;
	bh=aTGQKci3f5fPaogUBBNFThRIuvVeTbwYTOkW7Z7GnSs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TVFa8VhphOO7RdvIqXML0MFB4HH+e0rVOu5J5QILcc0/EBD+MIJS4w9vAmlD5NWips26XPPTKvLCFrKB8DkGtWWef/M8gqJJaG8bKC5OkbGZ0Bb8wnItIjCqWMhmHcO70JnPsegIWVnIr+xZzrcePamj0DoNNKNRJUqgga7+iLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfykXTM0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfykXTM0"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee1fca7a16so19757731cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Dec 2025 10:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764960154; x=1765564954; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DjbTb1ZE5I62KsxGKYN7n+CwAvqMOM27qQVj4A1phgU=;
        b=cfykXTM0svAVQ0PtC5C0HZrvdQ4j2S/P9CPzS40o1S7vnKe5W7TcixRHXWZ9qO8lKM
         knB6pcyYKdmcWLvOooed8rjB02nyRGop2FhiYX9G/F07kZnAWKZFTJFPxflD1XaeW+Uo
         BGmrXqKSgo5lNrmeHGfiGjkyvOXPYrQ4jsniqRQ25eO8XhSYSHDQbFHrLhdn6xK7kV8f
         BiOdW+TyDIGoJCjoYl0wmXSpLis2U4DgOJ8aW1KZxXYJOrPxABCxGDJZdixVJecKS1ib
         Lz0WjjNeH+i2NLzNBuaEmFZpEK2LmaufFGbnip2/8G76MkzeS11Q89EYHSqYPK+X7Ynf
         e0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764960154; x=1765564954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjbTb1ZE5I62KsxGKYN7n+CwAvqMOM27qQVj4A1phgU=;
        b=kpqdYpHN0GoU8JhTnUYv2TpX/r2fGOmt0E3GdbU6+RdqfNvUt6n2/0ZHweNhTOw3CF
         fE6jva/QrZ0Vm+67m6T1Tz17lTQI03GSYHM60As2P4rNBNkVzRU0bycdJqNAI6WApKXv
         3iTn529FNzGsuq80/smAdQHjc+tx6oyrAfTC4xhPygkBMXM1lqK+9lbLc38HDDnMY3h8
         K1QyTFxwARiMAKJINDNXdV4TKYPdEEc9gaxH2zM7aXaBrhTms5K5wwTLw4uG4k9ZgfHR
         Nnt5pSspQkueAR0xgysUCaaJ3QsUP7P2b2D998wpYMaoiT6KY50p/IHzXyh5VQygn4mx
         GTdw==
X-Gm-Message-State: AOJu0YyRqy2QW0Vh0v5t0u24o1jb6ONc5CmhQSUSHWE342/KWaoG2tb8
	GlnX39YPZNJ3FLOU1iwXh6T/Zq3CFty70FJnCItJoBr7a+JMzGTk7S0Pi1qsbQ==
X-Gm-Gg: ASbGnctpns/AjVVA8Vkq6DJXrmb4/m8+6HfxIM94FPWW0FxRmCj32iaCk86kDYnMm4o
	nZe0is9Dn+HeMZQaFcAVICMYcsJcJUnrPQKJ5IVzwwMn/QIX6mC1e4pZk8hnv9Ljz0/n7/c0kfb
	o+sVDqqQyeLLjyKktj620CtVWa0Tr7TFycaAyRGUZKaWc4G6ZVi+6lO5qZCPluE8040iqbH9kUd
	bJUWkFwpLfVNbGE/ayfktjrF9gHfngyEqQsv8Ov5Y5cnDvJJC42+bba+bgtJRTsbacT6zAw2SHn
	M52QBHHCzNuK7dz1lkN2stRpLf7qoCbOo266L6xchnRN3JMnbuvdGpVaqMF12awQvfRLfWdlpNc
	+p5uDpS+BskdDDE32bWHNGHHRPb1xmVxxF0Z9cat+FAxAtGPrDbMCCfoTm8XOEKb9qW0H4Kw4Ej
	n8PQCAqlz7rvCd2CkW
X-Google-Smtp-Source: AGHT+IF75ANTFV4GDDLfF24c9qsX6/0EwejVjrpmd4ZnRHBFiFnC+KNNazGhzfg8s08BGnanhxIpfw==
X-Received: by 2002:ac8:5dc6:0:b0:4e8:9ca2:b9ea with SMTP id d75a77b69052e-4f03feda6fcmr488421cf.56.1764960154205;
        Fri, 05 Dec 2025 10:42:34 -0800 (PST)
Received: from [172.17.0.2] ([20.161.44.181])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f027d2a875sm30743381cf.24.2025.12.05.10.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:42:33 -0800 (PST)
Message-ID: <69332799.050a0220.38072.b8bc@mx.google.com>
Date: Fri, 05 Dec 2025 10:42:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6383811954997643512=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, katharasasikumar007@gmail.com
Subject: RE: net: 6lowpan: replace sprintf() with scnprintf() in debugfs
In-Reply-To: <20251205175324.619870-1-katharasasikumar007@gmail.com>
References: <20251205175324.619870-1-katharasasikumar007@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6383811954997643512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1030938

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 FAIL      0.45 seconds
BuildKernel                   PASS      24.56 seconds
CheckAllWarning               PASS      27.61 seconds
CheckSparse                   PASS      30.58 seconds
BuildKernel32                 PASS      24.34 seconds
TestRunnerSetup               PASS      545.39 seconds
TestRunner_l2cap-tester       PASS      24.18 seconds
TestRunner_iso-tester         PASS      75.31 seconds
TestRunner_bnep-tester        PASS      6.28 seconds
TestRunner_mgmt-tester        FAIL      114.12 seconds
TestRunner_rfcomm-tester      PASS      9.29 seconds
TestRunner_sco-tester         FAIL      14.31 seconds
TestRunner_ioctl-tester       PASS      9.95 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.52 seconds
TestRunner_userchan-tester    PASS      6.58 seconds
IncrementalBuild              PENDING   0.60 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.974 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6383811954997643512==--
