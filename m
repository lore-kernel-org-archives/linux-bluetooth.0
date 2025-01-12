Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190221B6CE1
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jan 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736695776; cv=none; b=ijFiLNsGAPanwUgUb5HZqzErj6xQ5jd7RiDKhyKHDuSqz96GzN1xDzADzkrXCnOfaDqmyrVwN2fi9xDo1AzwZC+5sIp4po3vNI+vslsc1W/XcTm2+hgBFNOfuESEMzP/cTDrgnksJlhM2Z7rSZ+aorZCgPc/sLbbm0F+T2KOusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736695776; c=relaxed/simple;
	bh=IoAm1vk8JdInY2sz910hmxrdZKxUDHtI763TvGowK2g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NLx2u7OmVRLpe7th2uTIM14YWGcSzLBmqGMjzIY/qo/Yyc18rjw1R8EJ8uuacG2VjL0PJMsC9qflUNrBi31JY28K+u6d2M2/41wtAZ/dEML9MHOb0lPm3sEaeZggmnihVxybqbOIzWbd83x76KgEvEmxGWv6J9XNjHaoBFkb3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl3ao1kV; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl3ao1kV"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso29777906d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jan 2025 07:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736695774; x=1737300574; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cqo8fW772tjK1d/K6b+AyyFbbSGOH9ngtWhbin0btRU=;
        b=dl3ao1kV7UK3QgVOBdP71fXqgBDbptbFtlHgQeQVVOQ0mjt0yMO6JbHSuAzFpSNc3Q
         TslDJ7KI1oVPiKdjEKE0nzw6OZPStdtfqMcP5yHL14c/ib0tPmGLjpXckENuC9T9YAsD
         +wA42ARENC7chZzksouvELzCLkKQBiL460u3Mg5W2GylsBpdewCY0iQDJ7h0BJmoHxn1
         HHIWZtRyG8RF9uT6HK3aR37sjch6LNLNXcfAgwbX08aStEvTh/5TPpkgQSIDTMk+IvB7
         tEEYSDSTVP0NAfJfTL/kLjJPr9mRxZ1tXXynNxX+Vx564WaKPLKveti2QbjNg9g7LUZr
         V6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736695774; x=1737300574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqo8fW772tjK1d/K6b+AyyFbbSGOH9ngtWhbin0btRU=;
        b=KgjHqnxu7xMoS3iQ9WMkpDqpZulccvdrcVPBbUWkKBnrlWwNAxWY1cWxUS3b3PgDrJ
         2CNt3Kk+fadbl29U+7AbHhUr0FqjH8e7z4WfdIWSIa5WlUMdQ/bcageWZD24Oc5XXPED
         7UPBGM7qdJ4z3/9a2fEzE+lGbDmLXWZBoYHbgHnbZ5GmI+x1fA76v+lYZDNL6DO7rqFc
         13hq8U+BQNZJINHqb7+x49rUGQ1f9pdNLLhhtaf4UY8uAUvEbTGxsONSEv2ezMINlusZ
         jFVSPOzLQMaU0gcGWw1Lv8om67JPk1RXeGhsIbjrLncC1zkga7KiGJTtBUE71sb6x0Ni
         ubwA==
X-Gm-Message-State: AOJu0Yx6EIDN9Jere75UIvC19u4PIN3DiUBRNAqlv4APjiPhjJ5D36yR
	uGo0miKUMJS5Ei0Ilt2St47KR35kBQOcN2u7/Rg+tPUpQy5vTThAdChRAg==
X-Gm-Gg: ASbGncv12a3W+KJdWB1zKsIbfxIZNkXuNEe+qHQPRI7f+bqhX/8ScCz6FF3VC2zkISi
	XTjglfwusJHlu8fUn8323Kn1WI2YAv4WgibRFQ9Mr5LxHYInYefBSmjklSuGablJN5lpZlTFmXi
	pTsccJ7XVP8gOkB83s5xEplNQh3UEgR+NMLxDI+VW+sTk4Kvi1OSxFBeJ0BBmnwszhMnODLPnG1
	kb0hY9zD6aFK0nps6kVzEvcsOt+difU6z8Yr7svICZKBgxV0SwX3K1NtNlIkw==
X-Google-Smtp-Source: AGHT+IFF9XxYONoa6xlOt4uC8ayiyRoxXWiYZe2DT8meX8VtMFctZPqLR8pBuwbbYK6Up/ZxdpCL7w==
X-Received: by 2002:a05:6214:5f08:b0:6d8:9e16:d07e with SMTP id 6a1803df08f44-6df9b1cf107mr273032086d6.4.1736695773797;
        Sun, 12 Jan 2025 07:29:33 -0800 (PST)
Received: from [172.17.0.2] ([20.25.192.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad880c97sm31054746d6.36.2025.01.12.07.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 07:29:33 -0800 (PST)
Message-ID: <6783dfdd.050a0220.24a354.b3db@mx.google.com>
Date: Sun, 12 Jan 2025 07:29:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2824431553297719099=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, stanislav.malishevskiy@gmail.com
Subject: RE: Support of Mediatek 0x7902 Bluetooth on ASUS Vivobook 16
In-Reply-To: <8caab2a9-12ef-425b-a26d-d4b3481475ba@gmail.com>
References: <8caab2a9-12ef-425b-a26d-d4b3481475ba@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2824431553297719099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=924654

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 FAIL      0.29 seconds
BuildKernel                   PASS      24.15 seconds
CheckAllWarning               PASS      26.48 seconds
CheckSparse                   PASS      29.82 seconds
BuildKernel32                 PASS      23.74 seconds
TestRunnerSetup               PASS      421.64 seconds
TestRunner_l2cap-tester       PASS      22.66 seconds
TestRunner_iso-tester         PASS      28.49 seconds
TestRunner_bnep-tester        PASS      5.20 seconds
TestRunner_mgmt-tester        FAIL      122.32 seconds
TestRunner_rfcomm-tester      PASS      7.66 seconds
TestRunner_sco-tester         PASS      9.47 seconds
TestRunner_ioctl-tester       PASS      8.29 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   0.53 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.148 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.169 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.186 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2824431553297719099==--
