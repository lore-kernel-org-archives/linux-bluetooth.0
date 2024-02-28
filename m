Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22A5E06C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709152450; cv=none; b=Ab12WwYsupv+9rD7gLbmtn542ehoGVzYybhdHJD84fQMmYXYNaudx/rw81PdjY3SBUOO01LLSMgc3ufOj4Bvdiitf1rLKh39Kmk7wCok4poCpMoQ6AqU8SHQNKFC+FqcgiuuSZTXms5rjYmqfJ9qWbKVit/NPjXj23h5PA2iHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709152450; c=relaxed/simple;
	bh=2fxYIhAHJlqa2yICN32e/RCGk6anICFNhcWJbE2vr/c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gKpx0JKeenil/1NYJgLE0EkHFF6zJWvtuspwNY1gPInj07ZJrzYF2uuDW9kGsJL6ob69A1eWO9/YVkdFS7E+Mgt+kr68sro37RKylCX7i08LqLdaQG7/ARj1DUVNCxqWye/4gvfCgVDkjn9V/9BNGJO9NTBaNPpJiLlbD+7aai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vts0xC/Z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vts0xC/Z"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc9222b337so2265585ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709152448; x=1709757248; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GnZ/zNQuaJQXIw3NunIUrkuwxIWIj26vtcUJjkjpb7M=;
        b=Vts0xC/ZumIaEjItYzZF+jpRutrQw5MyzbprKbBAHBk0cz4gspDEqNNpLN4NTI4oPe
         Fc0BrbkX/ybruEYyv5wtSvzp9EvQKtOQ7ijUFYGiVdU9A62WGlk95Rh2pzk0dwgxB1Sp
         KIGimB0QYPSt/UByx5bKaC/+h1YJ7KM3OHKbS04BbmwX2HtA6BBY2OqOZ9vFV4EgmvWr
         O0pG5Duvxtgci9N6etNfTYhwL+TmxSM+iCsgW2X3SoTY0Iaaj+6tv7pl/XAThrcVS+Bg
         fYAcwpukNaDO4H2+A1sqbzscGQPGRV5eJ7EbMuMQiQK+VLKs4uruR4WrckRjSyP2CBBW
         xm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709152448; x=1709757248;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnZ/zNQuaJQXIw3NunIUrkuwxIWIj26vtcUJjkjpb7M=;
        b=HKI/QSFZjmbctcaod5EX+rZKM8JbgiAz2d3c2K5zdlgvSPs58aKsov6MyyvLSzkHaR
         LpfVze47A+5VTlA/8V6paV2KIbwnQlCfsJD1raDOR1XWqLwOx6XKz8zqDhq6tj94uCPQ
         GCXjOh7bCCm6Lnwa/24JhQKbobM1iKq/EHtYdKXRxf76HYUuovOGg4PNxHTdtpA9X0Ok
         YGSsh9nleDGoCVmZ+K++tp/iGhglObJCNWJMmvj8733NYX4uOSks4sxcChpikgYAOYIX
         Cc8toLAGegr0d11ksDL7CtibDq8uX2k9c3K42c9dv/kRndN9lRQvKZwpxXB7pDWd/guu
         /Qew==
X-Gm-Message-State: AOJu0YyXt45V14u7blIIbGkYnCO0bIAhQs/C+7sMQv8W8P50Ipm5Q8tQ
	taS73DgmiHQdAgknSS9KX2CV9d7bGdkUGY5lMVPVnsznq8Rzwpc58kJCxn20
X-Google-Smtp-Source: AGHT+IHwifEsL9Lg8cVC3dxRHYvqOl60Vr7k8qMkA8AJa8Gk9sF2e48lGzWdYSd4tCSTDa74JpDJKQ==
X-Received: by 2002:a17:902:ee86:b0:1dc:ce28:a47d with SMTP id a6-20020a170902ee8600b001dcce28a47dmr79725pld.17.1709152448335;
        Wed, 28 Feb 2024 12:34:08 -0800 (PST)
Received: from [172.17.0.2] ([20.172.6.165])
        by smtp.gmail.com with ESMTPSA id ay11-20020a1709028b8b00b001dbf5048712sm3674742plb.93.2024.02.28.12.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:34:08 -0800 (PST)
Message-ID: <65df98c0.170a0220.550bb.253e@mx.google.com>
Date: Wed, 28 Feb 2024 12:34:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4679466763611035885=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: add transmission latency tracking for ISO & L2CAP
In-Reply-To: <c99ba1062eea9d1bd463bafc7f052bd2d93de172.1709150574.git.pav@iki.fi>
References: <c99ba1062eea9d1bd463bafc7f052bd2d93de172.1709150574.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4679466763611035885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=830847

---Test result---

Test Summary:
CheckPatch                    PASS      2.92 seconds
GitLint                       PASS      0.64 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      28.25 seconds
CheckAllWarning               PASS      30.98 seconds
CheckSparse                   WARNING   36.36 seconds
CheckSmatch                   WARNING   98.52 seconds
BuildKernel32                 PASS      26.86 seconds
TestRunnerSetup               PASS      493.62 seconds
TestRunner_l2cap-tester       PASS      17.87 seconds
TestRunner_iso-tester         FAIL      32.55 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        FAIL      112.87 seconds
TestRunner_rfcomm-tester      PASS      7.27 seconds
TestRunner_sco-tester         PASS      10.88 seconds
TestRunner_ioctl-tester       PASS      7.79 seconds
TestRunner_mesh-tester        PASS      5.82 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      73.74 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       6.215 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.182 seconds


---
Regards,
Linux Bluetooth


--===============4679466763611035885==--
