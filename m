Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583013EBF28
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770729679; cv=none; b=bTKIpjNbI8j4JKnFaOwn22ulritm6ETcNBha2qr7Lufhw4+dVhFYu0kZ7gQObD7uh6Yx5YZ9ycDuDxWyrwNs/IIIoR+4mBd0Pp3la1YsUQUWd3IXKULufXH+SV7ZCjYUWKrWR3QTYO9l4q3NNEJ8v2ohEwvOtioOvEaPlU6KypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770729679; c=relaxed/simple;
	bh=wvmsrQGXm8xCzSOPrNsvxazoXGAkvXabB3tin5iJU+g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XKDj9MhH7k4XvrU7KQClMhLcsZuN/ktt1flV3or2usYcGgeFdGEQ7A2EW9DjpPlZCGESq3Qfjg5ULqVhE0HPB4BlyLZ9WEaHGJU/0nyfpXfH2ZBz7ap4NjNZc+rEKeJ3PAfNtEeCodU2e990XynciOBN7kqJUM89Afcg3LkJ8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQD2Doue; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQD2Doue"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8947e6ffd20so77670776d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 05:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770729677; x=1771334477; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Iad9PErvsPxpRG/rKj0CEqyiBvC2+NlHOq0RSMO7J9U=;
        b=KQD2Doue8oP84RuxuAAYaMjrYRhw26LV38waeiireuVhvHqP+ousTrspsRwxDWioPN
         NlGv4+wg3OBSs6zXLXr/eTuNRW08aigC6+eyD48G4v4req0A3w3iuVWEg1L0PkhRodHB
         I2R71YR7mpRjH0dDv+9UxYHOXjgjnp5gaO0fdwfZkSO/YXjN/y9R+Sam2P/pIQT6wBcM
         tlTtkiD3H26GZ+S9Ca8V5eohHhMoCffBTbKazTn6K6MVnwCtmCWBAs3k/iHIFLaHxhET
         TXl72jOLaBfg/HO8fveZZYfFd6uOR3Ni0FWg+5lpSvnqgitpg/W08HbIXVyOUhPpYT9M
         VYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770729677; x=1771334477;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iad9PErvsPxpRG/rKj0CEqyiBvC2+NlHOq0RSMO7J9U=;
        b=hl9EU8KY6DNhamgMMiSiXp5qPeBSiaLG4joQw2T9k6D0GQ3FdVah7vsMxXojXHo1qV
         5Pb2gbakTMoFvTXYOuLf4lUs6HmHzmkhQTDLyCm4COEudv5MMP4u2f4CDoE4YaipS1sO
         BZ2d7T3ZWC6ZhV6cb0fxAhCjqaMvAQNHyHyEVSeAT5INMl/sXJTZA/SK06Z4p7vc1SEi
         6zNUvpWF+oeswkAcuqDx5wbUJPCxqB6nJ6FqfnxlBqIOtVAVyN4u+BFS8v7meUbwtZ6a
         3WpHsVktOBwsXIQx0GY+BV7asmID0SzbzORw2o4RJpQ8zSXobkIQGFYCIVBOCDksbXBZ
         L4KQ==
X-Gm-Message-State: AOJu0Yyisr9g16dyHVuVgwgF4/OqWhqsdALYoZkKQkWQJLbvET6FCyeU
	HO2XyLW2MuUuMipG8dyAKO8bfGI7f3flM6OcNKKYzQG9BRglf9bMYeLzdpP7+sEn
X-Gm-Gg: AZuq6aI8uxYIDRJt5NcZ/03QhylJnlAX+CQd85ryiM22PVvt62PgP1xQiWqXNBODCEC
	Pb/x7T+kUZ7fCNUoXC8bOu7pYrpunojxGLuEM6r3H0pjoYs3w9a+CTc2wrjPiJp3FYJ1KqdxjQx
	8RQ7nJxkYZf3JV47Yn8543FnmAhiWwv7SmWQOGxIDWh4TkB22pbd0lkqssk1dF7oVjpLSTurNDF
	xbuomuXa+v08b09CZq7HHXa5bmRskMf/2A7wtsejl+wc6zNEcry6+jVePz49SYy+EM1U/3f6Unh
	ut1vD6pQCePvmquTazO5Mpu+jJQAOOU8txpQdoDyOwKB0L0TTpdqxlv6K+4TnO8YXno5GJbNqzA
	8ar/RCAnoX/xPGtSVnRqCVIjJuXwa/Jb8wJPaZM3tIViwdwjKhVmKk9ywAz5flNn7VMKlsNTGwR
	AIpTjJknONEFp36OCfHpUqA6yrjxoukMYa64SrlQ==
X-Received: by 2002:a05:6214:cc7:b0:894:6a89:5ee2 with SMTP id 6a1803df08f44-8970e2a4c60mr24766646d6.31.1770729676914;
        Tue, 10 Feb 2026 05:21:16 -0800 (PST)
Received: from [172.17.0.2] ([64.236.177.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf37b9asm101179956d6.9.2026.02.10.05.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 05:21:15 -0800 (PST)
Message-ID: <698b30cb.050a0220.22bb29.0559@mx.google.com>
Date: Tue, 10 Feb 2026 05:21:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2555713211499210465=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vivek.sahu@oss.qualcomm.com
Subject: RE: [v1] Bluetooth: qca: Refactor code on the basis of chipset names
In-Reply-To: <20260210120101.1046091-1-vivek.sahu@oss.qualcomm.com>
References: <20260210120101.1046091-1-vivek.sahu@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2555713211499210465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1052703

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.16 seconds
CheckAllWarning               PASS      29.43 seconds
CheckSparse                   WARNING   31.79 seconds
BuildKernel32                 PASS      25.05 seconds
TestRunnerSetup               PASS      561.64 seconds
TestRunner_l2cap-tester       PASS      28.53 seconds
TestRunner_iso-tester         PASS      73.51 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      113.41 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         FAIL      14.47 seconds
TestRunner_ioctl-tester       PASS      10.07 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
IncrementalBuild              PENDING   0.65 seconds

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
drivers/bluetooth/btqca.c:1043:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1044:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1045:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1045:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
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
Mesh - Send cancel - 1                               Timed out    1.929 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2555713211499210465==--
