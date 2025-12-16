Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4134A21C16E
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765913953; cv=none; b=dtDX7GDny6I5EvvPyjyiRnuHx7oq732KFiU958F2AS635lR5GngJxDl7sSHmF34o1G6S9TpAO1WZgKBllhP9JeEXE0fBjZGfEefiYjgYFQjZlA2gPcZMnvX12ICiFs3gynb/g9J2PjeYaaj1Uk7DEm/eRrQHt0PjevqWI33pby4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765913953; c=relaxed/simple;
	bh=pqxNfLfphae2ciJFlX415E6qgN6kUCbEfkfmQH6laMo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TnBFZFo5OxDYM+z07MZXeb7MArFtE78eXgTWg6aHb4mpCUT6/5cU4kQLZAnZQzcOHNcfyLvbIEQB1yRqy7/3qUh+diEWE7rZae3Q8kGGykP95ykUM/afDzhLzwGuffmwSYEf9I+fq8W8xWyDSll/5f+6XOmPGxXCJ3BV6kmTw4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGvadCRF; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGvadCRF"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-4f1b4bb40aaso29927571cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 11:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765913950; x=1766518750; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rWFVzwKzQEbfwAAoaeEkya7wddH5EfM6a6zerhq4Um4=;
        b=CGvadCRFXWHrRABWjlLopA+2WRhOk5OaeM1jOhiV1Wpc/7O9kMRMwxMONAuJ1/4g2D
         bA9dYpD2sfeO91r7m8OQfr0Mox3wBJFMcIwTcPbg0XuMTRi6Hm8/KQJjpT3Ba+eNWWkg
         q42MewRBuBgwHhpduZFWwTZdPBO5VQZAY3X3wvfXgnn5gU0Qwsa2A4r0lq6eYSWTO+zr
         q7xoGAXdHmKhTZRDVCvW+Wr0s8l9fiQjzbzXyM7zsI1kwjtXeqiAa637DXGvXb/YKf8D
         ojmWYKKAXxZHSFoMyJK0pxcyP9TDRXzKt+KzFwl2tmOe6U5acUbBBkSxGej2cUeLDhr0
         M0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765913950; x=1766518750;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWFVzwKzQEbfwAAoaeEkya7wddH5EfM6a6zerhq4Um4=;
        b=BXn8/FliO1TZM9IivVrnZKlp7sk4jA2iS9AZ7oMF9fR3vJiVTYQP8/lAFbv6XGmLzf
         c30RC3MbM6PrQMwYXJmUraeesbuarL0/DP3ELssmEBhkEQuMETRrHv31PPMPMRLPOm7X
         cAj6i1QZq0Z3vKNpRg9agT4C6MtQprzfLq+Ow6OV9dfZTmqA0ao+enHmLTqu1Zqty8Qt
         DbdSPBq7ReXhQQieYqxUM/KSgbgL9jXsqYKOoAcBxn4+Gc7SQIQvlSj6B69/An+Lm7bF
         7jIQA1iNmWMXYN6rm9xvuUjEz9ndEXcCNLBaE3uOBEqYp08U0lBYLywPiH3fiFk8xnnX
         4G1g==
X-Gm-Message-State: AOJu0YybUPYwipdNjtwUHg6XTS19tZlZOWUnLo837ikPwSw64KmYxgk7
	u5ipkgtC2Y2Gc3x6QFoTU19rdLJaWBZDiaij5RzWdw6wFMRMkHE4XPkQYDtg1uCB
X-Gm-Gg: AY/fxX4YtdqY70aBnTqVGj39hARkCNq5ZJ9fNWc77cWjggJGz7hvekIoKEU8ULZVfML
	Co+3xg5xnJdhQk/25/Y0fyWueHKOTO+4nMOru3uRxaqAGBJ1UIOZvPyXrj18pHOjBreYBlyv4pr
	deuE2TbKk0qoHbcx1PiV8hFIFIYVc+amThS/KAoqpUyTy3872kc82trHHMZRxAZlao7fq9skbJX
	WQMEAIPCTN8YiBAFgavRZMpXRpoGbS996HCyfjv2/M61QHM4CiFPYerjXat6T9D6DlPTR1GMSOB
	glNxKbmKDfTULg0cvCUVtHlbyfQm/vLxO7ttm/BOJMbb2g43n9zEEEwdbg/r0pH3EDRXTOWOqbm
	A+yj8UNEtC1vz7uaA2PAgUf+v8vxrn85hPjW1lZGrVZ5hCY74EMb6o795tVaL50SeBeXkYB7NIy
	amz03ian/819YL4Hcxx54=
X-Google-Smtp-Source: AGHT+IGFo3FqXlxSz0QC5OvdEXzJHFj/7QaYLnq+o1WZahmkeRXFVqmdNyNiFtkEuYwTZUyqTHh7lw==
X-Received: by 2002:a05:622a:550f:b0:4f0:441:96be with SMTP id d75a77b69052e-4f1d05deeaemr204685181cf.51.1765913949648;
        Tue, 16 Dec 2025 11:39:09 -0800 (PST)
Received: from [172.17.0.2] ([172.208.126.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8899ea360cbsm84191876d6.37.2025.12.16.11.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:39:09 -0800 (PST)
Message-ID: <6941b55d.050a0220.3c737b.4d6f@mx.google.com>
Date: Tue, 16 Dec 2025 11:39:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7155037813580058084=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cakturk@gmail.com
Subject: RE: Bluetooth: hci: fix refcounts in LE remote features command
In-Reply-To: <20251216191255.882653-1-cakturk@gmail.com>
References: <20251216191255.882653-1-cakturk@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7155037813580058084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1033902

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.09 seconds
CheckAllWarning               PASS      28.88 seconds
CheckSparse                   PASS      31.99 seconds
BuildKernel32                 PASS      25.82 seconds
TestRunnerSetup               PASS      566.38 seconds
TestRunner_l2cap-tester       PASS      25.56 seconds
TestRunner_iso-tester         PASS      86.13 seconds
TestRunner_bnep-tester        PASS      6.20 seconds
TestRunner_mgmt-tester        FAIL      116.07 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         FAIL      14.36 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.52 seconds
TestRunner_userchan-tester    PASS      6.68 seconds
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7155037813580058084==--
