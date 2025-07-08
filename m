Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD11A288
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987079; cv=none; b=cgp2HUBNcW71tvW+eeM2UzXtRu3lvJmwxKkNP/di1Rb+73Jp3tXeB9e8QqQ80J4wdnyFmmKZtn24pIwGD6fLqJY/gM6ZDZ7fK45W+7X56mGgNP+rZiSksRzDKUCGRYsewrVVWPuC3r71J6/kRnB0+CTDxLQuGrb9LpgnUPezOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987079; c=relaxed/simple;
	bh=Zp4CNxdW9hvJ7ZCzMyKKFH8g5shcikOB7BE1ojPyw1E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aIGIJMlK1R0SHfdKteFuzjK+P7LSxrGsyASclf7XpPkXAfD0e8buU0zEdZO5JIKtVR58/iAo2SwmV8DGRHr0T0qqWHthS8qlDdYsl2aO86k0NG5u2RqvHeqljzQKtpFLj+4Nb+k4VAlc8pwZQJOT2ugLt48kQ6Ktageef15GoTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rr2GyVfI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr2GyVfI"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a6f3f88613so41242311cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751987077; x=1752591877; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sGZNY6jggceJhnNipSYA0QoqLmGzjkUBJZ1UtGDzvHs=;
        b=Rr2GyVfIYB2r1KyyKEnMH1Dsu/9roCVxZVT/ZmCQEd6Xj1B3P8kl/NNuqB0LoonTPQ
         Jc0PLMJkXrBqjdNp93vER9sLFAlkL7qE0BHodPxVd23d3KI8/aoplqn6lmhXX/e+OM1u
         aRMm3RPs5r7/cpY2bcWqBIQ5V6R+gj7TenEY0IzpxWIOze0wMujHjCTw2szH4OV6vmsD
         YuNj83cN5Uf5KfS+B4+5cuxZCyrn2QNkhSED+1kcBelatLK1RCBbPgGLc1xJ9RqGHetQ
         VXMPskWErEgOH59zKQPyUzldmqlr12Y0tm6VsH8/A3hWyLi6j/7scrXdmUNHsiLJLEgy
         BWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987077; x=1752591877;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGZNY6jggceJhnNipSYA0QoqLmGzjkUBJZ1UtGDzvHs=;
        b=F1WS1ded6ZgrWoUiX08bxlhF4nJ3/EU/6alTMxTJmwmiTsIkE4XecIx5IMsFl0/j0G
         X21z+rsLYW56Iye7S2s1u76ROo/b+PAz9FTFEz8QuXHrBOjILEiaCuW8c5lh8RsXCxZ2
         D48sPbVs1s7iOVeVq4hA4WT2p2nZe2bNJ272Q7uszjKLNgKmbRQgjMwO+WxEg75fwQSw
         U+SapEla7Wo+m6UNb90q9yon4OQTbRTlhGmO28/CwFg1niSavvQMfHhOsUx5pXrpE58a
         4u1UiU38DWYH6vrTR1vXrE+loMhxGoZ9drKI9h25MSU1ujwr49M25Rj8ULxAEq+dMgIo
         iKwQ==
X-Gm-Message-State: AOJu0YwCg4GxxbjowvKRksRO9jvyy20ONibD2tOC9GFAt8rdLUFQDIsS
	+J6Af9N8bd13eqLIrZebKCSnO3nMP2Ydormcmpw9X3+s5G1KQEknFivq+yVT4Qqc
X-Gm-Gg: ASbGncvpsrZiDQLMRq6YInOFUPXSsYOfg36OjtySTLz8/KSnCWw8OoarBOUL7pdvsEP
	8++MiDEkpL4sChtB3Y7c2e+Ke+3+AeeElxnSHskv3EeRP58neND5pBeNX3lDsjF94K9GfispgFp
	II6qRuO7nNiC/pARAu8ncwGKR+Nn8Rlqj6keuiQj8JNrxFfTbLlecFl8G4LQ91MWIQroD2uFhQK
	B/aY7oPLtEjQ3Iow5lS+Rgbm43UAX2Re8Ct1HMx9RIkqITGIKgWh7J1miqTdNb4oG5RX0iSqrh6
	61PQ1Ycomp0hO+lZE1Wv8jevb9M9sWWgh04T6Ib+0E6qE5JrZ/ORtMHiluJW5+cJskV7
X-Google-Smtp-Source: AGHT+IE7rdfWvgidGwygMgXqb3VoKOPEKJbtDFDR+mXEl7pu7bXoMDpNwz+jrlFcQlCjMQUiNngzyg==
X-Received: by 2002:a05:622a:4110:b0:4a7:628d:6cb7 with SMTP id d75a77b69052e-4a9ca59a98bmr69745141cf.45.1751987076644;
        Tue, 08 Jul 2025 08:04:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.218.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994aa88f2sm80594691cf.79.2025.07.08.08.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:04:36 -0700 (PDT)
Message-ID: <686d3384.050a0220.1d4732.d32e@mx.google.com>
Date: Tue, 08 Jul 2025 08:04:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1079372771920980656=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alex.gasbarroni@gmail.com
Subject: RE: Bluetooth: hci_sync: fix connectable extended advertising when using static random address
In-Reply-To: <20250708141617.3691-2-alex.gasbarroni@gmail.com>
References: <20250708141617.3691-2-alex.gasbarroni@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1079372771920980656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980080

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      23.92 seconds
CheckAllWarning               PASS      26.39 seconds
CheckSparse                   PASS      29.64 seconds
BuildKernel32                 PASS      23.89 seconds
TestRunnerSetup               PASS      466.10 seconds
TestRunner_l2cap-tester       PASS      24.91 seconds
TestRunner_iso-tester         PASS      40.61 seconds
TestRunner_bnep-tester        PASS      5.94 seconds
TestRunner_mgmt-tester        PASS      129.85 seconds
TestRunner_rfcomm-tester      PASS      9.27 seconds
TestRunner_sco-tester         PASS      14.62 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        FAIL      11.97 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.12 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.164 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1079372771920980656==--
