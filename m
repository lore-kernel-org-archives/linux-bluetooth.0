Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876AB18FDBD
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852288; cv=none; b=F7HDE4puig8cKHMbuEsWF6cfZHoFnuWK50L/DcDhiSd5wOedS+b9m6hMQ3B/2BXOOZxMXlIKvZBYv6WwqTsRzuMhZoiz4FvFTAXKAtppSOqscIk3reI+uOmuJ2AqU0zltIOFuctf+KF9iJCanAKHOuuT0M0lQPc2vWbBjA6NKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852288; c=relaxed/simple;
	bh=RKJKEcOwnnd6snGVee3Y+oma7wG1SjaKwPGiNDDyMG8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rN0Ovt0mCe2TEqb4RF0FCmtYHtTPMng+TIb9Ikhc0xSaJcHg9QV65H2rESZ7nAhKL2JkKC+tJpVMgPf0VxkuV9uRD7atvxhjNo/jcXKXhtqOm1xXVGASMjFBPagaJVTa8tj1CEltD2z+IO9tI3CegqXI8xh7+j0IJRDPa7gJdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4JldiGv; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4JldiGv"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5069df1dea8so38208481cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 05:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771852286; x=1772457086; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DhKVlCkh4dbowAcQfISlS7/gPz8UlC+DmyENbZ/7GJk=;
        b=T4JldiGvkWs7XbU3K2BmjnCP2a3TK33Za8w2+yeNcCEgeRvPuDGRaApdkcHOFQK4zj
         UWGjkgnLECbt0GcdsMiM+NMNrzF8Lq9WI6p5qewjtvBzy4SmP4jT4APiWPfMH5+AH88h
         lbkHYmtTiClOQ6aI05IyGTY6ynvlqWqo5nuoAwdaCUw1liIdTQcVzSmQczCt0wEA7sZw
         mKToxxVe1AfutwCgW3EGEa035pUMeYjRPO7nndINsQeS/nLJZXCqFSSRdD7rh64yuO8+
         ZQgHXt/VG9CU8nUhKgP8XvL5kXJZbj12UhkcObSFaS53eePgO3yEPoo6jncIFOAilxyK
         FRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771852286; x=1772457086;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhKVlCkh4dbowAcQfISlS7/gPz8UlC+DmyENbZ/7GJk=;
        b=MLanok41aBvAK+4rRJ55ZVnygjiylbh/FTSwk3TIoQaFJFxh/sS0YCUUh/EIrPhSK0
         fx0fXZUCLd01JuDSbaube/bDpwp2OFh+EH2nZ2vrvk6qW3rN25tNxgIjAX9+TyTLHIed
         91Xxfw0cKpH4YLNwejFt4P6MNE1iXDli+fX0mDj86PskSThpc33U2/RoIJiTto3XdPbE
         HKnxsLf9XPOrt2PaEJgcSu8Sx6iObzg/skRASUnkclNcwloubGJpqVDS4Vjga7Mr7qoO
         /ChX0Y0cYE4Ib2/zuLHrbCoqU9dHFAHScUXK6wKL9b01FSjv/ocJIWM/KwyRSeUPuyIv
         ShLQ==
X-Gm-Message-State: AOJu0YzjfuHHWtLQitgo4K/KaBY1pkbSbRWxxBJUvuHyya0kBf+0VrSg
	LiFHM4LSmAEqOxuqf6IY3VkCDrVbL5pwlruRDvOSRhuInYPIZcy25LqaY4sKno14
X-Gm-Gg: AZuq6aLmLrUmwYBhS5EPbQejA8CpetmWS17MpfBIPe7jdkajjPX2zoQV/Tdx0v10PNh
	sRwZeqpmeJLWq+va3L4/+XFftauPntOFCAXqiGTKQ9sI22xKodObtIhPTWdnHd+EpaDgYCU4pFm
	a3SDcjB9de2na1PZkqeQtPz3apVynZQ/JGVvyIKdgQZ+78eVnZ9Vydg9MU1eQ4APbGSxBMk+SyB
	VDjFH1Kuh6WLxyyNz+lB/kuAkdqtTRuRRcjoTm3IZ5FAqM0RlvE140r45WQRTbnKBOZlyqzSzr5
	Iz5MbYEQr3dQiZb7pifiRQCBAzfeGbUmzCT4TlPw2MynKPbGdgCNFncn45VzmkXoheDf1EVlEPK
	Oq77jjDlr3r5YIBjc1tQZl1LuX7XliXVpo/GzFD3FbNzKXDNvM7NBmxFtoGQRwlzrs9Dtf4fAp8
	afE30poiHVJyaphVBc/Nsc8TqrbjY/
X-Received: by 2002:a05:622a:386:b0:4e7:2dac:95b7 with SMTP id d75a77b69052e-5070bc6b791mr116484571cf.37.1771852286287;
        Mon, 23 Feb 2026 05:11:26 -0800 (PST)
Received: from [172.17.0.2] ([20.161.44.230])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6a2676sm65178671cf.18.2026.02.23.05.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:11:25 -0800 (PST)
Message-ID: <699c51fd.c80a0220.c3732.da5a@mx.google.com>
Date: Mon, 23 Feb 2026 05:11:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7334282464223990566=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, stefano.radaelli21@gmail.com
Subject: RE: Bluetooth: hci_ll: Add DT control for enhanced SCO setup erratum
In-Reply-To: <db4c7eab9d0c2f71eb61baff240957596f099401.1771847350.git.stefano.r@variscite.com>
References: <db4c7eab9d0c2f71eb61baff240957596f099401.1771847350.git.stefano.r@variscite.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7334282464223990566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1056461

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 FAIL      0.54 seconds
BuildKernel                   PASS      25.55 seconds
CheckAllWarning               PASS      28.47 seconds
CheckSparse                   PASS      32.15 seconds
BuildKernel32                 PASS      25.25 seconds
TestRunnerSetup               PASS      558.65 seconds
TestRunner_l2cap-tester       PASS      28.27 seconds
TestRunner_iso-tester         PASS      96.32 seconds
TestRunner_bnep-tester        PASS      6.34 seconds
TestRunner_mgmt-tester        FAIL      114.13 seconds
TestRunner_rfcomm-tester      PASS      9.54 seconds
TestRunner_sco-tester         FAIL      14.50 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      12.51 seconds
TestRunner_smp-tester         PASS      8.74 seconds
TestRunner_userchan-tester    PASS      6.66 seconds
IncrementalBuild              PENDING   0.75 seconds

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
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    2.667 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7334282464223990566==--
