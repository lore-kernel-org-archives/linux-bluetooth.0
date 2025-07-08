Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE906220F22
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 04:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751948616; cv=none; b=VqG3dDm/hQhJuDgiz3dhmRWgYh+cFozT3Vf06wg1MhYvfQlmLsaP6tibppntR/VQfb8jZn+kjDNSz6nVYuMU4oUsW0ZoZynZSsRvXzNGBnOPnwvgpFs5TdEZeCgoyNYQBRgV57YjJ+IxeVGZIxTztDeGmsSM0yzVLe7aUXHIi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751948616; c=relaxed/simple;
	bh=GN1ZDG/7JJiL5Be50SPJU3b7o/p0iQdPZijjOkJCetk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BBvUtd1rOIa1CNo3aJ8bafG3y/nt+m97CVTkp+hEjxcJryDIO8YlKlX1JUxrMKBuF/nO0AaJr9q5gJDixTS25bh81mdfaLn2ZCcewDoZ/8oxvhIoYBJqjSLFeFgCoxPlRyGrPKXafJaiuYMGP8U7au75IV614aUuU2Amb3OQr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPkkKoYl; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPkkKoYl"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58f79d6e9so47168201cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 21:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751948613; x=1752553413; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Om15WFpDH2Tt7RH+VVf6SRCHfu1704R7RqT+krfb4F0=;
        b=VPkkKoYlJFJQbqzK7Srp7wAGJ5pk25KB6itxzyWZWnxDFf5uMeLSod5q/72pSFd8kX
         THfGj4w+URXj1LaYkRYVygK5MU/NABjEi0Se0IsB7d8t8Xfqqx7xR3WRUPugXCQvDQCU
         m8l1ZMqmD3B0Gq2z0ZLt8TvC7LRukkhPWM9E6danKY9v1GXO7bUNCoJm7oG/f2MxWLek
         fVJJyCeaDa/peRrelDZKegkXSh6FAkERucAtq8K/rCL/5Iq/WGhFvMaG2MM3vmcvlhUg
         WF+qYgkAbLDDR5i1ymzP2kUGcMKrKVCAO2ge8AEW+WP1eu5/OtlJTM1eSI4XZxif1Gt7
         S2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751948613; x=1752553413;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Om15WFpDH2Tt7RH+VVf6SRCHfu1704R7RqT+krfb4F0=;
        b=l2HD71CEHymnMKxKGLGkoqES/zG2JolF8OGo/hNmhL0+xx34aBlBUISwl6fXIYOwWi
         6cR6/hEENFOt/9sZK25MtezmmXodQDVdDHqY7UIEW9OSrs30uYbCGLABE6461dPx28GA
         Csnpei19YSTWZ+5qDawezDnRI4Q7lGhHc64ya2WMyHeEzj7ADMOwFQQcWBOG7IzVTqro
         aNYSZQZfieTNyUVn1OstT6e59oDYsnvTrp32qCZl3PN8Ie9A+PQSKBuVwvoYKJuW92g1
         ZzqO8hie8f1eMBQATODi9HAKg0+PTVfmRE9a0EyBbT2S6ruhxW5mcGn86Kk31W6m1q83
         061A==
X-Gm-Message-State: AOJu0YyhIRfGqwZ+IJYi/6t04ulZ0uIeJXXor/we0J2V3oPAChMdYsqs
	p1e/XJKdlUKhFnkncRmvF5KZpdVBBSayIt5/EV0/mxPzAX0aFF2DKNd7JPIAgw==
X-Gm-Gg: ASbGncvNCTVt0+w6YHoz/IgGyhvAkqs1Kvdrqtg8LhBVu/H7IhxfGSpOcYBgs7ZrKL6
	VbxzDUDTFjxrzzwJOVSLdq3/iB9FmFruguHWxp1vgr1ASgMePPBHDfxmLfmCzLsu7Ow7SEOVAgl
	flma6PgqUs/1gYkHwkUR8aDhfiSdp7UyFf4i4I4TnITp+tzCES6KD/+5S6D40qFKhgW5k8A1K50
	8bu59gBeBV+96fE83fLxDIHtXdg4JVGeG1ZtBhDI+ZbqHfhST1eRLPP9W4Wz9nV+NyP5ekolrIU
	810POoo79Gb0zpHVgLZdOA4T3oahvlSDTVZss+xDoEdry4U+qgtjem3DpLvF8LdJt1xZgQ==
X-Google-Smtp-Source: AGHT+IF2Tb4xuXpuUbXgSWvC7CHL5FL3ix5ygre/0XDJggYKJjyECw8UkQyUboACYgKgJ3pQ8mEqMA==
X-Received: by 2002:ac8:5745:0:b0:4a9:a75d:3310 with SMTP id d75a77b69052e-4a9cd7e8596mr23019401cf.42.1751948613360;
        Mon, 07 Jul 2025 21:23:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.171.195.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a995bef739sm72273181cf.55.2025.07.07.21.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 21:23:33 -0700 (PDT)
Message-ID: <686c9d45.c80a0220.6779d.8ac5@mx.google.com>
Date: Mon, 07 Jul 2025 21:23:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9125253539681766950=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangliang74@huawei.com
Subject: RE: [net-next,v3] net: replace ND_PRINTK with dynamic debug
In-Reply-To: <20250708033342.1627636-1-wangliang74@huawei.com>
References: <20250708033342.1627636-1-wangliang74@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9125253539681766950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979865

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 FAIL      0.31 seconds
BuildKernel                   PASS      26.55 seconds
CheckAllWarning               PASS      27.29 seconds
CheckSparse                   PASS      30.12 seconds
BuildKernel32                 PASS      24.01 seconds
TestRunnerSetup               PASS      465.05 seconds
TestRunner_l2cap-tester       PASS      25.09 seconds
TestRunner_iso-tester         PASS      38.08 seconds
TestRunner_bnep-tester        PASS      5.97 seconds
TestRunner_mgmt-tester        PASS      130.40 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.83 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.99 seconds
TestRunner_userchan-tester    PASS      6.31 seconds
IncrementalBuild              PENDING   0.74 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.153 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9125253539681766950==--
