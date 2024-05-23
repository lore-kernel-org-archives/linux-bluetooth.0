Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA62D05E
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446235; cv=none; b=mXug9mbR7N0lRRM29Fyb2i8vQgd40u+YyvIpkYxxZy/9ehvJLbL86HOaGtGusI7y/DXSSnvnx6OOfSuuInGRZSH9LPAJX4j8nHuPD58gQpYwtopksM7h98rhrEyp33snZCUYPgZgx3AQ9aQsj1g66K+iEwX6s3QVMxBEKtBVoTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446235; c=relaxed/simple;
	bh=lT6NZu3XKeQD6nf8b7nFmwaOBPNhzzTx9GmdJAUmR9g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YVwUEajPkjEDkRJShC7AGvjggCzvvDPQZFzwk+yjZQWNu11OYwRc2OytzoTJ4glt4jHOiy8ANLFCxpjJcezCQCXSOmeIF06rG+Ak9SxUL6laYau9EcyyoTJaNEjse1IgTSvpVmeEEBVGUrCB6pP/ILTA0h1RiH1Zo1X0R7UHoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgH2Pq32; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgH2Pq32"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6aacd1d24deso16910186d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716446232; x=1717051032; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=72BYdcQoIODiHy9DgaXGVOanPzJkwHnL0RrU5JrCvXs=;
        b=kgH2Pq32wLd/cXwRLrsn/rVK5Yj2sMbXA2/sWlUXLbxhauS2qZGwyHEShoeipPzzN0
         e+H9xLvrdtdQZO48E6s2jqcZVxzp3nHgwnuprkkSty0ncKqL6By84YzFjY6ZC2xaIbP6
         rPrv5SnDjpqYo2iugg1eSq5lb0/nZR7kiucYYa1qrNzzG15u2G1qt/tiK1NdH/3i4tEJ
         yOvadbmLCtWFOzfXTnDN0wj3jt+Dsu6IZpDejk6J7+vg9GoIKl0eyE84JYK6udUWWg4Z
         39SQIJea+qkRE6bVMBjzz2mw9O1+36q986Ki/jdOJhK9NwBNcGcSsXAA4GIr3RNqFZAA
         ADlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716446232; x=1717051032;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72BYdcQoIODiHy9DgaXGVOanPzJkwHnL0RrU5JrCvXs=;
        b=eH2uNXhRVNePOWbYlerK7S5rdAyQuSuqEgZtqXJIuOqL1T9RviGVvz7MOo0HuN2luE
         Ui7WsNGnqKbev6ht+BmtMl5+50H07U2VMxC+R7BD7wbHoVRdsKmDWrLvCoOicJgE1I0m
         s5ZDStJXKFUtDQR+ntLjsJc1sDkzF4HuIbxrtlOJNM4sRP7bXaRjq64AI4s4M3jcX2lp
         OOa5d2yPOs+gp7/fWObefVv3sonew3yaDoCeounX9DKOqJ9J6Gdyd0Zh7W2mO2i7SL4D
         SEkrjLoEol49TK00bS0cG5RoNT3uLvA4ppqsB6tBuAtObri4gkT801FRnnNDUG4YypD7
         1FLw==
X-Gm-Message-State: AOJu0YyB3zumKYMCYnISrCBjTgXjUuQLqgcPAQhv8K2AYD9LFqJ4Myvk
	+cZnyWjsypTVByTSCde39aQi4JjBPY1MpIFmCfOyiQq+s9pcF2o3wR551A==
X-Google-Smtp-Source: AGHT+IFd2lLfdMOFHUjsyhNZw14YZpJdRwt7cZlTC42M7xGG3FfL1uQBfjcV0B/TQ2ImmjXiHlsh1Q==
X-Received: by 2002:a05:6214:5f09:b0:6ab:8c82:4563 with SMTP id 6a1803df08f44-6ab8f630848mr25677116d6.29.1716446232358;
        Wed, 22 May 2024 23:37:12 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.14.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194d16sm139386746d6.66.2024.05.22.23.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 23:37:12 -0700 (PDT)
Message-ID: <664ee418.d40a0220.e6203.faad@mx.google.com>
Date: Wed, 22 May 2024 23:37:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2388033748147877336=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v2] Bluetooth: Add vendor-specific packet classification for ISO data
In-Reply-To: <20240523060934.2883716-1-yinghsu@chromium.org>
References: <20240523060934.2883716-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2388033748147877336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=855213

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.56 seconds
CheckAllWarning               PASS      32.09 seconds
CheckSparse                   PASS      37.47 seconds
CheckSmatch                   FAIL      34.58 seconds
BuildKernel32                 PASS      28.44 seconds
TestRunnerSetup               PASS      515.38 seconds
TestRunner_l2cap-tester       PASS      20.38 seconds
TestRunner_iso-tester         PASS      31.72 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        FAIL      107.97 seconds
TestRunner_rfcomm-tester      PASS      7.39 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.76 seconds
TestRunner_mesh-tester        PASS      5.90 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.90 seconds
IncrementalBuild              PASS      28.41 seconds

Details
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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.170 seconds


---
Regards,
Linux Bluetooth


--===============2388033748147877336==--
