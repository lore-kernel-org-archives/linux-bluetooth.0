Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644593218B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908624; cv=none; b=prl59QWyPbolk5xcdPlguYfwGz7LYR3bX7V366Fu/jJ1GvehlWQpB841QVZiIOYqJ9JfUISaUWgbcWDZfgFBpF0AbV+bjuiNVPmI6PTb362nrVDAw/yxurcjkOMsRTdUb7Lm28xzPUa8D5YCIZejejz9Q9fllXjYQexOUu3uZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908624; c=relaxed/simple;
	bh=SwQF7x9OtgMsY1ExQgT43L6VNI1uM/RJ4atTqxJJ8TE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XH21tgthNgUZTdOhYHwZMtyEg4VHUmlN2Y5xJMfKkiBzMxjmyfaVS2CqgoeSbfQZZBBmS98k2h6PtcIK4NbbrESNz6bKxYY2h5PxaTpFjOjA6eP/A3CWnk3TLpEQEcglXGJVxNxZmqMJjt5hXfiEafwANuh1N0/aYbrhuENZd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV51wGu0; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV51wGu0"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea2ac4607aso413495a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 00:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712908622; x=1713513422; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QVyYKK9k2RcFuYy26v2f1bCuDbMXuz3PZ9p6R/Z4EhU=;
        b=GV51wGu0+Lsh61I8TiKjI7W9VLWzLlt/PI5xzWZeTz79bMwEMInNGzeujtqy10nVu5
         pdaN6Wd8lP6sbcyXmNSHqzxwn4RTMPptvorU9WwtOy59fWPADZnztXBkgoW33wOCVK4w
         YQx/8dUGiyB5oxcKpLLaX55blsTAisP5YVT+ve1qMIxxNQfw6aPY3JTdx1zf1HLfLrup
         LohCiCanKe7Ghj6A4byr+PVpgTD5tRUpvtgst9dAJCp6E1Cvoa88dp5nAva4e+F6EB8F
         jVyS7c1eE/uKPzHUB2AI7bHSXiQN2ehIZ+7Cl/f9phFG9/+8vIV/Hi0xcvRLpFv7shbB
         PQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712908622; x=1713513422;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVyYKK9k2RcFuYy26v2f1bCuDbMXuz3PZ9p6R/Z4EhU=;
        b=eGJ2qH2lQebmybT8532azINJwTBt6QhwnQy9fCIQMCKqyFOPL/bITDYyVrgIeRafNG
         m3c53IGTBqj5QXycW1m3s22ASp5TO+AqcXxjAbkl2LUl+rK5cUarF/Zg0VovAbQCoXrh
         NMz46VSeGbGBR+i5rsmxwEyI3ATsG0oLf3UEAV4mOev3piEdLhXlB24VvgmaOQHSyDie
         Urws444L8Nn7qowLoOzz156WK2tFfXPxRUqhrA05lwZie+2Nf879BQKAwKV4BUZysqzw
         5T+4emm7Tm9prS7jY0FgJ1ST0uj7lfu8weShpBPXTovHoUpsL/9/OMnk7FYDuFQe60IT
         w2gw==
X-Gm-Message-State: AOJu0YzfNkUjJOH/BOHYVRiFyukusL1xEK63SWyBrs+N+XDjDN3Kotpu
	rEFos3LH67dhcpUG/V7pio2JTeGCOjRMLM9eB+XIkmK0LVNHgjMAlJlE6A==
X-Google-Smtp-Source: AGHT+IE5l9EWwXBxahLsbVkMarytdQl5i5w0haAy1rdNM5mIbCumO1GK/8LFqCOaDymNP7urazeX4A==
X-Received: by 2002:aca:1707:0:b0:3c6:eb0:7471 with SMTP id j7-20020aca1707000000b003c60eb07471mr1965933oii.43.1712908622187;
        Fri, 12 Apr 2024 00:57:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.154.241])
        by smtp.gmail.com with ESMTPSA id z11-20020ac875cb000000b004366d3eef03sm1535727qtq.68.2024.04.12.00.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:57:02 -0700 (PDT)
Message-ID: <6618e94e.c80a0220.3c0a4.379f@mx.google.com>
Date: Fri, 12 Apr 2024 00:57:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9159953713800985537=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wenst@chromium.org
Subject: RE: bluetooth: mt7921s: Add binding and fixup existing dts
In-Reply-To: <20240412073046.1192744-2-wenst@chromium.org>
References: <20240412073046.1192744-2-wenst@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9159953713800985537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843894

---Test result---

Test Summary:
CheckPatch                    PASS      1.52 seconds
GitLint                       FAIL      0.77 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      29.88 seconds
CheckAllWarning               PASS      32.17 seconds
CheckSparse                   PASS      38.03 seconds
CheckSmatch                   FAIL      36.19 seconds
BuildKernel32                 PASS      28.55 seconds
TestRunnerSetup               PASS      514.71 seconds
TestRunner_l2cap-tester       PASS      18.44 seconds
TestRunner_iso-tester         FAIL      32.95 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        PASS      110.31 seconds
TestRunner_rfcomm-tester      PASS      7.42 seconds
TestRunner_sco-tester         PASS      15.09 seconds
TestRunner_ioctl-tester       PASS      7.69 seconds
TestRunner_mesh-tester        PASS      9.75 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PASS      31.76 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
35: B1 Line exceeds max length (99>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml"
[v3,2/2] arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (81>80): "Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       6.221 seconds


---
Regards,
Linux Bluetooth


--===============9159953713800985537==--
