Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892C34E75A
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289166; cv=none; b=KvZBpcPh8wwrjHFCzh4AAYQJdK/Afajscmsjvn6j63bv+D1SakJGQxvI4waitgDZliYXgZj8L4MXqKtVmgbJVwTEGTz1N7fVtZATotlvsb4SVMpr9aB1TpWTj0mg6Mk/xk3NmuGrlNTWmI3gbuJ/ara7qEG20Onz+V/1ny6btmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289166; c=relaxed/simple;
	bh=bqRbwM675SnR3LHOLVYtxvMFkBzl+Dtu4aFnYRsvzLY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ihwkoVTbyFEJYWM1MkbhTooToPlNknk2SXZb6Sd5jtiLltInZbDXpLVm0lTwTniwxLj2l7uTjZkEUxekFzF9nNMD7ZcNEPKWauXGyMxXFNlaNpjFzV4Jegmv1qONuebUOX4lGXBkxFky6+aJYioIjsGW3REo/IOwwVCXaBYF26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V46OfnhY; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V46OfnhY"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51778077b28so13391581cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 11:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289164; x=1781893964; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e/JikpiyqIVP4O2zV4P0uhbKb9exv9UnpdbFepFluZw=;
        b=V46OfnhYdGC+G4lFonumFTEEC+CwQYUQrZ50EsNmSclarwO0M/AOLgNgudxVQjINIE
         cWobmbsnLg7+Hoe94V2fJP+EjvER2iys3yHzQqBaQpWFF36hWVoYb+knF1C5tu4Iq23t
         RBYkGyqCApJY5rG/HIlEeh/Ht/rbVsmMrrj6++pcQT28nS2s65HUeLlzxKN7AUkJa6Ll
         dbkGurVKHGsPDy2gKu6cXsn28qeqRbczbUqMdy/FrjLqr9viSSOCoG1vALDJ7BOTIPGv
         jQb6YfLn7+xBLnn2KZ7eoG9DaUfQ5KqsCEkCclkpUJPvPdzY0Lr3c9gQE+Iw4wU9ieVP
         jaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289164; x=1781893964;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/JikpiyqIVP4O2zV4P0uhbKb9exv9UnpdbFepFluZw=;
        b=VB7MO00ExIXCkvcaRJ1m0mjW51NctA9qbhkbpwCsBWKUy/8w0pU86FLmku++MRe7w8
         cJ/VdXxjDBHzkdymmxGC31th8DwfGzcHxrDeSCFnFDuO1E+226xbawCUB3wyv9geptwc
         iwXt6yqxDlPqpHcqwh7Yw0OO9lYX+JFb5FqRVbx9pFoq+46MdNkQGA5YloEvRKTwRJIo
         5eXk/SA00gG9RWwbIZmH+Ij5cGILCw3bgPvVJGRXlEXy0BERKqIWPWezJgZ+8iPefyzI
         +a4geMwXo05o5x8k+698y1+bEn35Pq5zlutxIMinKoQbNkL4k6u6qmx8oEaHWSmDqzvG
         LCrQ==
X-Gm-Message-State: AOJu0YwVLwdBQLx/Z96VTm3r2mD8klRjpV4Q5YeaBYUt0o0X/inGx36s
	a/nvbK1qvVbw1lsTqs5PYN/QYvPQI0WWKU2lYaRPQblqWjWGsCarp08tAUaxIg==
X-Gm-Gg: Acq92OH5H+CdlVlGvG4236btT/48VW56A3/tZu5jczmLHvoRmUTqaBqBS+VqLKYU657
	ayvK0DY0mDtGfLvbsiDHvCb44AKkgG19tpf/c/2M/BwhKL4Ic9ilbOVyDmGt6NyO0BrqZSLqXOy
	/CNSNY/9PxhrtM6q6dNQoHi8bv61EEt/3Eix53CiZg3xKjQHoxDde/TX4Jvqd8Qb54EMmr17eYb
	bGBqMjlchYJuM1XKUryldl885adk+Ds6Xd0X6/UWrbnCJ9+IKuUfV25GzxvFnAVS+iUAVizwaXD
	AWajlNe0VHv1S7SEJIJrpikA1HkE+EumDEIHavJNv1CKBUQ59BlCGB8Bd+WxOHhzKbdfaUunHSR
	IlaH+L6+eCntFmx8Kq0v3q8koJPMBJLSJllFj0j6RNfcYBPnEm5essgdMe0hbMmIpEmuf500N2I
	BciNPGbZ1jDQve1ndWtoXX6k9UyG5vNUOP2yP/bO/X
X-Received: by 2002:a05:622a:c86:b0:517:72e0:612 with SMTP id d75a77b69052e-517fe539d6bmr59487161cf.42.1781289164065;
        Fri, 12 Jun 2026 11:32:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.213.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30105fcfesm31743556d6.5.2026.06.12.11.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:32:43 -0700 (PDT)
Message-ID: <6a2c50cb.b7d808bf.7f055.c42c@mx.google.com>
Date: Fri, 12 Jun 2026 11:32:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2527335760970668177=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v4,1/2] Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
In-Reply-To: <20260612161753.3140707-1-oss@fourdim.xyz>
References: <20260612161753.3140707-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2527335760970668177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1110757

---Test result---

Test Summary:
CheckPatch                    PASS      2.09 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.64 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      31.25 seconds
CheckAllWarning               PASS      29.22 seconds
CheckSparse                   PASS      27.09 seconds
BuildKernel32                 PASS      24.86 seconds
TestRunnerSetup               PASS      539.28 seconds
TestRunner_l2cap-tester       PASS      59.68 seconds
TestRunner_iso-tester         PASS      85.37 seconds
TestRunner_bnep-tester        PASS      18.81 seconds
TestRunner_mgmt-tester        FAIL      211.24 seconds
TestRunner_rfcomm-tester      PASS      25.31 seconds
TestRunner_sco-tester         PASS      32.96 seconds
TestRunner_ioctl-tester       PASS      26.06 seconds
TestRunner_mesh-tester        FAIL      25.94 seconds
TestRunner_smp-tester         PASS      23.50 seconds
TestRunner_userchan-tester    PASS      20.60 seconds
TestRunner_6lowpan-tester     FAIL      46.95 seconds
IncrementalBuild              PASS      42.35 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.247 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.773 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
Total: 8, Passed: 3 (37.5%), Failed: 5, Not Run: 0

Failed Test Cases
Client Connect - Disconnect                          Timed out    5.128 seconds
Client Recv Dgram - Success                          Timed out    4.988 seconds
Client Recv Raw - Success                            Timed out    4.994 seconds
Client Recv IPHC Dgram - Success                     Timed out    4.996 seconds
Client Recv IPHC Raw - Success                       Timed out    4.994 seconds


https://github.com/bluez/bluetooth-next/pull/311

---
Regards,
Linux Bluetooth


--===============2527335760970668177==--
