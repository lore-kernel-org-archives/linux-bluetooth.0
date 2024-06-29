Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E512FF91
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719683827; cv=none; b=mprigyVpRiuBYPGxG4YCOBkL+rKZvQ4GGbuoaqxTuBbYnko38r01/SE2Uh1lFzp18WRKSAQZoDs/p43y1wAne6U+5L5RiWMv3Bcrs0h4LvZoXh1r1ArhsNbQluaennfrCHwbVyD7H4UA2Q2ea29pvjok6RY5uEfZSdmxo9tubao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719683827; c=relaxed/simple;
	bh=H4ZjMqLPJD/w5Zjc6z/8/ttyRLPUHtMFCSPq/iSXiZo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JDCe9+1rf8BFQbdXusDh9QjvjZAcl6NCUSXus3Mny1wgDEoGO7THh/Ql0Z2+Tq7NFfrC+zTrwBi47Y8cRW7jdmuS8ecICmL1oLweTLI7Rl2ETgiZAx0F/2Q4sHfEvnZvC2RWBBhV76jPO0mGNxUQm9Nk1FPV9JNjs1K2HuKCdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0T3bxTJ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0T3bxTJ"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48f550b29d7so479902137.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2024 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719683825; x=1720288625; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8tPZWBRAuobMCAUJBABPmA/in7SJsiUCYJL2dQW94vE=;
        b=B0T3bxTJFKsj/k3ZvwCo84BTZcLNynP2b0OLZPesFUn/gfsZve85QqL+HjUtIwYs5I
         WNEFcJq/fY1KLqJHX8EkSLlq1zxG5G9XK7Ea8ZT9RDEIrTzolKxAvRSDtI6nSxfOLq3t
         1u99HzbKAnSPeYTn1c7ju2naIyMys67BmAqS/x1C6//+m8+cPpUnfukKz6eNnnFxTm8d
         TB9E244SjE8Kgec4vwPd48XRQ8i/3qJiu0ZwDAkujCOObF8iYXBZQaqsnraA2JWQnzMf
         pMrIsG553mZiSOhEAyhWXka4yFC0Z67310brH04d63GHoZw97FM4jFVcpIw0TvkvqiIg
         PKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719683825; x=1720288625;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tPZWBRAuobMCAUJBABPmA/in7SJsiUCYJL2dQW94vE=;
        b=ZD1rzHMs26txwJHiM2YXVbwqQDTVb3bSZJ3pbflcoXWJouGW2KuntlpVVTAAbCNJsa
         9JSAYi185lUx+S3SnJeCYHl0VOtt1dDmMZrdpt8eu7c3wL14Xnjo9GJWsKVYliHg7AkB
         UHVI7Rqs+DkpDRP6cqSAyviRPvUDo5EcVlFFUddz2YJ6nwm+VDp/3mRaHi0p0ROaZ1h9
         hddgfsIM0jLBASwc79Hqo8LTyJlBahv7HfqOlVZA60+Y2Cp6rs5ChJU0XuwnrIzTf3fh
         8wrPapQU7hqelcvUev/MlL/WFaAzFlF7M0DMil7aWY4TjGdBH93K/DHcgUtvMVQPxXfV
         lvqg==
X-Gm-Message-State: AOJu0YyDlyE3C62Jpy4yTweLPomy22kf1OnUgImdPek93lUVny2U79/J
	1KykiOBOVHPMZtqPXifIiqA9wxnw6XZcH4TwWfwMPaJeSNgejEN/CsL8BchD
X-Google-Smtp-Source: AGHT+IEN4bX9kMRPqXNatGf8M81Baw6jtfBllXT8Fx0TEdMuywgy9nSuMzJ+/jPBXSjTb7Kfn7U6/A==
X-Received: by 2002:a67:fe49:0:b0:48f:6009:a924 with SMTP id ada2fe7eead31-48faf0c64e4mr1667107137.17.1719683824811;
        Sat, 29 Jun 2024 10:57:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.124.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69298fd5sm180005985a.64.2024.06.29.10.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 10:57:04 -0700 (PDT)
Message-ID: <66804af0.050a0220.b7c8a.81e6@mx.google.com>
Date: Sat, 29 Jun 2024 10:57:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1296855440404969788=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, marex@denx.de
Subject: RE: [bluetooth-next] Bluetooth: hci_bcm: Configure sleep mode on RPM suspend/resume
In-Reply-To: <20240629172235.29901-1-marex@denx.de>
References: <20240629172235.29901-1-marex@denx.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1296855440404969788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866844

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      28.77 seconds
CheckAllWarning               PASS      31.02 seconds
CheckSparse                   PASS      36.35 seconds
CheckSmatch                   PASS      99.34 seconds
BuildKernel32                 PASS      30.39 seconds
TestRunnerSetup               PASS      504.07 seconds
TestRunner_l2cap-tester       PASS      19.65 seconds
TestRunner_iso-tester         FAIL      42.46 seconds
TestRunner_bnep-tester        PASS      4.64 seconds
TestRunner_mgmt-tester        PASS      110.15 seconds
TestRunner_rfcomm-tester      PASS      7.21 seconds
TestRunner_sco-tester         PASS      14.80 seconds
TestRunner_ioctl-tester       PASS      7.61 seconds
TestRunner_mesh-tester        PASS      10.21 seconds
TestRunner_smp-tester         PASS      6.67 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PASS      26.91 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 116 (95.1%), Failed: 2, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       6.185 seconds
ISO Connect2 Suspend - Success                       Failed       6.233 seconds


---
Regards,
Linux Bluetooth


--===============1296855440404969788==--
