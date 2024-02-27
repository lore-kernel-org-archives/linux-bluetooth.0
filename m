Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C034A0A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001541; cv=none; b=WhhRGj7+07iLtkhu3+YHjF3mWfnJmKhLvT7H5Wp/rc9N6tyDA4vnyNH6JzCloznuDD9bZDN0Fj7DqTgVEvUuIjz1HCpnl+LQCwqU7oG0aZbs6JEb8By+hk+rMqvCPoBW3wc89ZASRAhOx9KdXVtUzWodGnyj5MHM9Ffjup0DJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001541; c=relaxed/simple;
	bh=V8PfRW1fwJGrlIPFpvRsUNbi/cZop9qvx3kBOm6omEQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e3Sx6Al4JZfReOX7eHpW/rb3JSCaoFmOEXkEOCVSD7N7dn3HNAP3AUVd8UZjjABrwDbDwF94OAyJzCf1BhCLpVxUYDrtcbDB/VdYs+4dX7NqHYQ9hFRhOPe2V0jOsqMCK+mRi8dW+B5Xx5MBBScnZayfAK7ruSoCpSA+nKF7pKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI7G+Vu+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI7G+Vu+"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68fb71fc886so16431056d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 18:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709001538; x=1709606338; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nhfWXpUMw4FTa6ak0RZxXTfYMa8/zjLWuAN4AIx4tjE=;
        b=FI7G+Vu+fpbnR55Z96lm3q4Kp5Sko6CgiKrmC1l0nbVAmTKDdy5MG93FDCBKrCWwJW
         J9B8eawdlfBuXZJ1JfTdwr9WDDC1MeKM1yK41MHdou/HKtSC9D7PafWSqPTZzmlD0Cdj
         5iynmpNSQGWZ0HdeHLe9xTaMQJCOAJKqIwtdYKQ9W91r9cDidgCfydDYCivhF8WCwbkZ
         +OeHp+zcLqJOBnZsAx+bdkg7vmDuT+wgncmLdCtRBU3UynTIG+yH3W6lR0P7b8YksQZf
         tyLtTiYWM5DdNKQizUsxjWt1HK3nCIcETgZQ39gxOYjhVUzIkF5R+okjnfBr5xmALZoq
         Qm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709001538; x=1709606338;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhfWXpUMw4FTa6ak0RZxXTfYMa8/zjLWuAN4AIx4tjE=;
        b=jdmkDxDiuHEATBKbA1t//3Oinxo3IDlFLFgbu1G/2dvhxWr3D9kBuz31XeV+4plaS0
         ZPFgV56tlf5PkY2xid8v5/rzmpnx1+GK0dJqgsq6CiIEdVJaGEeIf4BtwXHcrszdYg83
         r44ds/CX3fldxE9l3JEgix21wHCILBExIWzk+FevDZxhqY9HmphSBtSyDLGAnh31MaMI
         Rua4Qd9zMBBYtvR1MjcRcXa7pKHB98ejzckaHGNgIfgsHAnvwg4oCDeuNK0tLMOhfK5G
         GBHncXjJedAfND3KW5M9Aipgd4GqHbY1DHyA0kBWSoThdnqbNd11PULmkfJl8C/T1BmO
         4MVg==
X-Gm-Message-State: AOJu0Yz6/DkJXB+Fm2VrEHhtq7hvXMUg0c1zOpdt1PdAKBo3O5fVzQVg
	pecuoPpzTq1wlTgywmeSs+qQIFuL4O/TmOlVm5DujIpsXxKKJPs7gTJbao2u
X-Google-Smtp-Source: AGHT+IE6th8TSHGLyiBWzrrLVgSmL84hbefqj/zWE+DA4wxA90ny58ayslc1MylE+v+Cy2N1ctOu7g==
X-Received: by 2002:ad4:5ce1:0:b0:68f:5d5e:59c2 with SMTP id iv1-20020ad45ce1000000b0068f5d5e59c2mr1182863qvb.10.1709001538631;
        Mon, 26 Feb 2024 18:38:58 -0800 (PST)
Received: from [172.17.0.2] ([172.183.131.167])
        by smtp.gmail.com with ESMTPSA id b10-20020a0c9b0a000000b0068f73372424sm3713434qve.90.2024.02.26.18.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 18:38:58 -0800 (PST)
Message-ID: <65dd4b42.0c0a0220.81a2.d019@mx.google.com>
Date: Mon, 26 Feb 2024 18:38:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5551997447554757791=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nukelet64@gmail.com
Subject: RE: Bluetooth: Add new quirk for broken read key length on ATS2851
In-Reply-To: <20240227014328.1052386-1-nukelet64@gmail.com>
References: <20240227014328.1052386-1-nukelet64@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5551997447554757791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=830105

---Test result---

Test Summary:
CheckPatch                    PASS      0.99 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.69 seconds
CheckAllWarning               PASS      33.84 seconds
CheckSparse                   WARNING   39.30 seconds
CheckSmatch                   WARNING   105.60 seconds
BuildKernel32                 PASS      29.51 seconds
TestRunnerSetup               PASS      541.18 seconds
TestRunner_l2cap-tester       FAIL      25.55 seconds
TestRunner_iso-tester         FAIL      43.79 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        PASS      119.65 seconds
TestRunner_rfcomm-tester      PASS      7.56 seconds
TestRunner_sco-tester         PASS      15.13 seconds
TestRunner_ioctl-tester       PASS      8.38 seconds
TestRunner_mesh-tester        PASS      6.24 seconds
TestRunner_smp-tester         PASS      7.24 seconds
TestRunner_userchan-tester    PASS      5.27 seconds
IncrementalBuild              PASS      29.23 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 51, Passed: 50 (98.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Close socket 2                     Timed out    2.554 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Timed out   12.278 seconds


---
Regards,
Linux Bluetooth


--===============5551997447554757791==--
