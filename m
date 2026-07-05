Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D8357D08
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783265743; cv=none; b=XSTB2iUpJF3BFZF5HXE4wkNSK6m1+nJ6eXRu/Hoa5cF6yUZZsYNgxOVbmWOkiyhdjDWfrzs34syT26iny2xUorwZdN5klRCwdniMZWaCbBrZ66GMSV0m3Ty+pfp6fctqKtGwO6Rh+MshyziQ23lyYUMM33FVEpLNh7FcsElC6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783265743; c=relaxed/simple;
	bh=J+0GP8rplDSmOsLb7otPplTUrCY3bQn+MGzycPHVmqQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JZKPcWskLKbA0/CkUxZMyGZjf4vX7IkS48g3QaM9F6qMxoIzbJsXYegpwdevyA2TJob84zsbGnrdpW2mWjXvK7fL3iHPJjcxGkKe63btrbNruYe8BP1sC/s04dHXrb0u5J7+0E/fPB//0FvtoLotEZgoKHf01/cQthlgvh6d3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsJwaL69; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsJwaL69"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e6391b114so150183585a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jul 2026 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783265741; x=1783870541; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Frt92mM8SowZrmrrKk9joqOjkgGhmxgpUn9k1FbQwwQ=;
        b=QsJwaL69F2fkjrg6aLa2MFmCsqGTIPfRJg6TFrs83L6v2bCj4ZB4KHCSKjyC6sd93Q
         hRFe+lLYYu1dfHg+UCDszsWPwL92I4HBDFJAizf04Pc8FDpneqDK/giBJfUwNqv4h5Zz
         GDidIcg+iYA5PID2Je+pNod4YNL6tUSiYuy7cOnSBHNTfbjS+ipFnDFCfr6wFI5Z/GuT
         mD6/wF9o7jqojWWax0TttDaSmPGPBjVYHHGtn+10PzKoppE2HzlAgKlw/YxnXQduSslE
         1RewdtAyjb1UNv4cAs4ii5SdioYugR4atFGo7FwojvIt4p2rjAYEYNgOejqJW5T5DpaG
         5MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783265741; x=1783870541;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Frt92mM8SowZrmrrKk9joqOjkgGhmxgpUn9k1FbQwwQ=;
        b=jYTrjHvCXOI+9/XY5akcP1JfyjuPQRtLatTGZEDLLYklrPvMvx58T0kOyxp5ygBEzp
         znuWMYrMqmAehtdd1gDU6xjjUwhUoZcY+uFTIARE/zhenRMER1fMQCc1OzT89pyscZ+k
         F03aWwIC56xcTKGMn6HnqFXlwNKNLjCHlx2jTCZKBALP/9WHTmoqEE3qnpuZxtbnEi3A
         J8UKststK0tbcCg0zoyowMdjHT4y7OuHcmExKclIuSZlm2rkM2Ls/+1wYJ2MkHilHg5n
         HP9F4dhds9e8W7MrzetZndmgkspi2KTgO4jDbwfId9lmCrxFTHvu1OrtLyFxCf5foWdz
         XkFA==
X-Gm-Message-State: AOJu0YwEpzTeUmEbmkw2sUB7lrkY0aVAV/dM/Rf4WCJ0PyFu/p9kHWzE
	p+vwaOXV4/2A99jZaxW01gxoI2Oz6up8xVtKoZXk2QgwCRLKKGIi7aE0b6ovTw==
X-Gm-Gg: AfdE7cmRIPZmyLIPorlSSehl2Moq9dTxeukruHZxBKtj9qFzpG3V7M8P/oYXCdFVl/X
	Oi0xJLkJgZhx3Fh/M0hZQTUDdB41o5++8flA0cC0wAFMp0hknm3g6GZ6zOef8fixO99wuRtwc/M
	MT9O58sTyk0t0yag0l7sQjIKzHuQSK4A56Nmby8Dloec7ezMY04QpJw8mQd3G6TZ7Kb+0RCmwQN
	IUb96yq7n48PqpNjaqtuUBaZc7gM7sVEF4GmByiW7DWgkFp9qaj0KoqPydGj8pwep/vGIl5hgH9
	K/5jJA0sS07jkl8spH5HuISdTp2u1sZlrDXQr2Fht88eZsJMkTvgkW339IjVnMv4QtOuQddPy3I
	R52LLUbLEh8VDjfGD5tndp14L5MnglPmy4YpfdJerXbXdxhbxPnFON5RGjH84iSTq4A575fINTG
	6847RKllgXya7B29j+A6Q=
X-Received: by 2002:a05:620a:4710:b0:91f:3793:d90 with SMTP id af79cd13be357-92e9a2f69dbmr970795285a.10.1783265741127;
        Sun, 05 Jul 2026 08:35:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.235.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ccde4fsm698409485a.39.2026.07.05.08.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:35:40 -0700 (PDT)
Message-ID: <6a4a79cc.62b4ec9b.26adff.fed6@mx.google.com>
Date: Sun, 05 Jul 2026 08:35:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3425357518156391286=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: fix hci_conn lookup RCU usage + holding refcounts
In-Reply-To: <acd866db0f2eb2cb4279f3b76e4be0e76feb39c4.1783262689.git.pav@iki.fi>
References: <acd866db0f2eb2cb4279f3b76e4be0e76feb39c4.1783262689.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3425357518156391286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1121810

---Test result---

Test Summary:
CheckPatch                    PASS      2.69 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      1.13 seconds
SubjectPrefix                 PASS      0.41 seconds
BuildKernel                   PASS      27.19 seconds
CheckAllWarning               PASS      29.07 seconds
CheckSparse                   PASS      28.22 seconds
BuildKernel32                 PASS      25.82 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      492.77 seconds
TestRunner_l2cap-tester       PASS      58.33 seconds
TestRunner_iso-tester         PASS      85.88 seconds
TestRunner_bnep-tester        PASS      18.66 seconds
TestRunner_mgmt-tester        FAIL      208.80 seconds
TestRunner_rfcomm-tester      PASS      24.69 seconds
TestRunner_sco-tester         PASS      31.95 seconds
TestRunner_ioctl-tester       PASS      25.39 seconds
TestRunner_mesh-tester        FAIL      25.87 seconds
TestRunner_smp-tester         PASS      23.08 seconds
TestRunner_userchan-tester    PASS      19.63 seconds
TestRunner_6lowpan-tester     PASS      22.07 seconds
IncrementalBuild              PASS      34.65 seconds

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
Read Exp Feature - Success                           Failed       0.241 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.721 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/400

---
Regards,
Linux Bluetooth


--===============3425357518156391286==--
