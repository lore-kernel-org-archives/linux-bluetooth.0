Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963BF14B953
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765402777; cv=none; b=QZ45MY+uvsuvAI3pdnlN3LvHeqzVY7WaJJ2SVTQds666mKXpdzkvc8YOP/7qC8mgu487QKs3JCEe25G67/Ar0TjMnPrOjj/+zkPZtLSk/I7/zbeQS3E+d7/Ctg91i1h8G+6iUyKjeUB3Dbw+cqKgZKJuelygYrfMLIYeJxthJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765402777; c=relaxed/simple;
	bh=X9ckWkIFLvtqrtqxQHm53ppRFUTNTpmzDNPkoYbdQq4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gryfOtEzbSj6Rt7rAKF6KeHJhVNwG377wqP64eW3omEupwjamvK7v1MQKx35I1ak7aPfMchAFtFPU61AVk+8UcMQcFoH/KTNxFwv9iA3rpZnSGa0fk8hCCHONxDxHE+YEKuXoVgv3QCmuia78zaLMleo+ChbSk9GlGptMG/eZaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciT17kve; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciT17kve"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3434700be69so471870a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 13:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765402774; x=1766007574; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Op94miY2xKcb9HyTyqEPY7kUl8qt+rFn0njtBJDV1mo=;
        b=ciT17kveGF/OuHw/r4c91ptiXgkC2zjFrYPX9FraBNNVInGgWWyvGsUsL99qfhLGet
         EUdvx3+eFpwvcuMtGQFxhzm0tB1W53kXL10a0oWFT8QdyTG2/QJu0XGBkYJV+oKfmHvz
         R7fO5mcwqxitDKaVjKX/TW6TB4KnDvjSxF4uYbj66rN6YQ93Df7pn5l9nwCggZy0zB7p
         gATDKWsKEtECO1uTXDEEcfuMwnNrbcGmhZSC16fIRWIOzULkv+SHcWmza8ZGqNwsz9D9
         57qBeiYW4HjpDAXkU8WrarimQEwUDbVb2dNSjNZD0By+FAyEiK1/MP1bE2W055V/hkZw
         Lumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765402774; x=1766007574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op94miY2xKcb9HyTyqEPY7kUl8qt+rFn0njtBJDV1mo=;
        b=ele3ot1wDFYbu36Qwry3WungTA2chuM1x3NUx5Aq7ogAZj4y1h5ZBdQmwjXFyPpQUq
         /Rvp+BTjWXC75c5kbumYvADQm9G0+rn01e8ezTT1AaNIuzwGRLSOsT/ztjBKAOPZmbid
         HsuwUdPOOw9ca5N0PQ06dzk1QeZFY2zaUtNa6nX6YZrBHiFQ7UuVMaglxL6ePlHGZVJj
         iTUVonXiPmsEqMuirZ5yUE9Ow6fP+Wv6hPVznEbtR8Q6vNgM+cXTBx2KUS+KLfbNyL7S
         XcYqf2x5LcfL2uHq5eN/qWs2rkcB2fzf1RbyNxiH/FxYs0VWg6bXri01shUY4yTOiDiQ
         CdyQ==
X-Gm-Message-State: AOJu0YwEc9j2bL0oSV+9QpOipYjwCyQpmcqQdigSi/0JAG6cUIDRoMTd
	xP/YahFidAw6LBrQOuMKKKKlymjlqe6W9sIVdQMLENFqoS5xt7f8hETp/HFHNg==
X-Gm-Gg: ASbGncs7166O7YP4nA1bXwawCs2/Mt/FKRN3Mdk3ifjpexeZRDumgDm0aXQgbS//aYS
	KcuLTC1r+tPYMYuHOa6DgFBJHa4PqB0NjyhP5YhwcL+WuZyfKQ47JQ72IaNvhhpcD5Vv8LJCTY7
	pW/1yPIUvIEHD5d3kzMyK9T5XmssHfbvhp3NsI0TLn0+ksyE8/4udglwWusBXfzuJWWz8pXU7E+
	kgfmCe30O5k4O7rMF4AZonSkZSi2YptGZRb6JPgqvlAjUkoqhy1P577q/HXvFMrMy2yX73v9+oD
	2pJcb/S93c9egtkpPwWvVot74kOg/zI29E///pP8TJZZmW/7+5exD4nf5gBjuw32Jc3m7UWDtro
	VPBN4zEKcd+cGYpGT6NKHU4RZZs34+93zJ7+6pUSaJQViG2k3fC/fXJEt8FSOqNeoWYxaIZ0u/t
	HdVqpYPdLhp7bWs0YQyg==
X-Google-Smtp-Source: AGHT+IFfrv6W3WG20UlDA9oPok3vg7iM7Xf/4wxdYvbUFasfvOqjEVVvG9eDo0HXoov9YI6L6a9aAQ==
X-Received: by 2002:a05:7022:6090:b0:11a:49bd:be28 with SMTP id a92af1059eb24-11f2966a8bdmr3080092c88.4.1765402774411;
        Wed, 10 Dec 2025 13:39:34 -0800 (PST)
Received: from [172.17.0.2] ([172.182.211.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb28dsm1809348c88.2.2025.12.10.13.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 13:39:33 -0800 (PST)
Message-ID: <6939e895.050a0220.108697.d953@mx.google.com>
Date: Wed, 10 Dec 2025 13:39:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5918081919939842544=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_conn: Fix using conn->le_{tx,rx}_phy as supported PHYs
In-Reply-To: <20251210205012.153919-1-luiz.dentz@gmail.com>
References: <20251210205012.153919-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5918081919939842544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1032101

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.13 seconds
CheckAllWarning               PASS      27.29 seconds
CheckSparse                   WARNING   30.65 seconds
BuildKernel32                 PASS      24.83 seconds
TestRunnerSetup               PASS      552.20 seconds
TestRunner_l2cap-tester       PASS      24.00 seconds
TestRunner_iso-tester         PASS      85.38 seconds
TestRunner_bnep-tester        PASS      6.22 seconds
TestRunner_mgmt-tester        FAIL      126.02 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         FAIL      14.66 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      11.49 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.55 seconds
IncrementalBuild              PENDING   0.64 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.180 seconds
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
Mesh - Send cancel - 1                               Timed out    1.858 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5918081919939842544==--
