Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998941096F
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496717; cv=none; b=jcDJLEbfnMBbsJovqw7EcEhEON8wnzO21GzCK+NMo5NCLZo2svweX2L6iAN0i+ZeYzn2QhpMTCgvEHD54EIjl2LOefLHzdrY4vECA1dSfU+L79VJCkiuY6SfIILF8HAPEmz0gce1/W4nNi+Bt+Qufpgo3M0/eAE2Cg54oMDIW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496717; c=relaxed/simple;
	bh=6SUnXUnLNRSVDGEpntEb/q8i4MJDtXbjRjvwD1B5+IY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LuGZIaqSJkVPGo6tSPBeKcicS8LizfBTNpzqMUbOHPdGqF62R3KGNks2Sph37GJrONJNiW2NIIQhNnsAL2i+W3/As/3C1VNj7KZpjNGkHqKoVjSecxEH5mHDG4Px9JOPOgekQjrAkqC/c1oVpdNFvm48DnCj3dOIY0RK0HdGZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjV46XWU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjV46XWU"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb4081e82aso670272485a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 16:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772496715; x=1773101515; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/WIu47r6Sm/S4YxCJM/A0P+752K0pMgbOQfuCqTarX0=;
        b=jjV46XWUuI8zWBGoAJXwIxfGi1aPRLhal4duKUeaSn0OBHjNB2XWghwn/825VRkE83
         tD9W+LKT16lmHWItFk1AF2hXb04wYwqVVwqi5INi2e1zFXmNkjgo0IbSsH2EOu74VNyR
         jrfn5x2QuPFrlHOKZqjUp2BTcA++VlZKLNr7d18xrHgF5QObonxfY/fWp9lhDY1PxWWo
         9q38nD4iEfhX6+G0zJqkjX8bXk6K0s0/uxOPkLIvw4wmz8e7le29pfDrrGQPqZOGjxTX
         dhuMZWk/wfVIByxKh9IEM2rJrDTX+jNLxYfeuzQ61Ivs1y+rdvt/S+Z5zDQqeul/El3D
         2qRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772496715; x=1773101515;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WIu47r6Sm/S4YxCJM/A0P+752K0pMgbOQfuCqTarX0=;
        b=eQ+2ChOu8ik0Z4IrC5J0XguU94v1F9qFvyPCeS6t/oTcc9vGwLQGwUhsd88PYOkofu
         Bvjzr0iqj0Ww1PPtNFF6p6zHr9OdMJQgxQEWBChkGVBylJOBWlxATRkSE9CoAQkEgUe/
         NSA4CTfVmDKyhsi00Afd0Oa7Y7gtj3OZ9gZCU+IlvdWg4Ak1RJBWQhJyjH60qvS9Zex7
         K3EoYfabq2fMjO0AobtQ/zI3Ftva4pJWwE20Bsx/U+l1riAF75/QFbDvEzEZ5QGun3Ax
         uUNxtay3pi4RX9BZWxry9/UIwDmYPn/5JnnSiubj83HQFH6xpG3sVLEghtFFic3SCvhE
         XRqA==
X-Gm-Message-State: AOJu0YzZXTlheZAiIxxsKbZbshuh4DiiB29Qh/gxg09CI6Oy93r9L2sx
	s5XwqFw5xZFdQvB7rXykF3VcxU4tbJwBm5y44poOW1YEEpxzw0qJjLu7/aVALA==
X-Gm-Gg: ATEYQzxLAMrdVHNp0lDeY4o8++PIampebv0YRiDPwJ7EZy8OEisz+J4KoTKksp+PCj1
	GMxypko7vwm/7OF9JMIEdsIr1513CVtPAMfxwOXvcMbYPi9d9PFfwqnbP7Xo0sH6kV+Q2RpThPU
	FNFcHlQAH5x2uPtAwuJ6xGvDF/GgY2VUKI8Ct3vQ3X4Fwv4rbc2+ph8axHPcrPcvZzOOLgC0Kgp
	/tbWWgLXVK9FVsR0Aa2CsLTZuOGdt9jm9Wo/TgX3JMSG55+UOk6xio4BZXZRVbfRWn5bO8an2tn
	xAldedrwMEoA0F+jzBkG7oXBF7/TmXs+au3c+pWCKlaOSv5N+JYq5vZ9pOeUhE+LmH8f0JqR7dt
	lZQPzLGVfqJgIhGovrH1yDy1r8d0FsZGmnCl6AssdAw0IAC9JeF9OnCRjnltAmtHvxCYevLJ4iR
	gaN5j673iLJFC4WwvIB7iRn0hrpbdi
X-Received: by 2002:a05:620a:1726:b0:8ca:2e37:ad08 with SMTP id af79cd13be357-8cbc8d9d7d0mr1872813485a.34.1772496715084;
        Mon, 02 Mar 2026 16:11:55 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f47819ffsm44005736d6.37.2026.03.02.16.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 16:11:54 -0800 (PST)
Message-ID: <69a6274a.050a0220.ce6de.a9b7@mx.google.com>
Date: Mon, 02 Mar 2026 16:11:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4061694347337142354=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dajidp.morel@gmail.com
Subject: RE: [v4] Bluetooth: Increase LE connection timeout for industrial sensors
In-Reply-To: <20260302233756.910702-1-dajid.morel@volvo.com>
References: <20260302233756.910702-1-dajid.morel@volvo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4061694347337142354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1060320

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.41 seconds
CheckAllWarning               PASS      28.62 seconds
CheckSparse                   PASS      32.32 seconds
BuildKernel32                 PASS      25.90 seconds
TestRunnerSetup               PASS      560.97 seconds
TestRunner_l2cap-tester       FAIL      32.64 seconds
TestRunner_iso-tester         PASS      104.97 seconds
TestRunner_bnep-tester        PASS      6.24 seconds
TestRunner_mgmt-tester        FAIL      124.87 seconds
TestRunner_rfcomm-tester      PASS      9.68 seconds
TestRunner_sco-tester         FAIL      14.60 seconds
TestRunner_ioctl-tester       PASS      11.50 seconds
TestRunner_mesh-tester        FAIL      12.42 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.74 seconds
IncrementalBuild              PENDING   0.91 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP LE Client - Read 32k Success                   Timed out    2.441 seconds
L2CAP LE Client - RX Timestamping 32k                Timed out    1.897 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.116 seconds
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
Mesh - Send cancel - 1                               Timed out    2.776 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4061694347337142354==--
