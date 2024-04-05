Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2971416ABF2
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313198; cv=none; b=YHQir3etdlVsC3Wfhhqr5gTY65JRAkVHuthX6Ozr6f7Kv2ffbooRYCnf03gur8eQvSELwf1yh0tl9RdcOKg/Fas9+8h3ARlO0g6wmJMNES3LCSwdyU20BDUqLt4fqUrjdoccdAIzgnF4lmaApksjUuIeCeH1s1YuNCFBdfIg5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313198; c=relaxed/simple;
	bh=R92Nr0n3GJ6nKLWobal2gLPwyGhaR2mdu+Uj9L85NXA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Po5XmXiy2PKZVFVHuf9e7bFYDsk8R587C2F+3Ef9sSLcBsbacU4u+oqcsE+OiEHACOvuhHMGsFbS4YkCFO/CP4Q8YDytcHfpmcnXdv/5gy7iewmufGNZBJmV1f1JBjlgDWW5NN7yGr++HbZs0PF2p/raijg9t1AXqS+SFG2LwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1fcFXzW; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1fcFXzW"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61518d33293so22593477b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712313196; x=1712917996; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KftUVZH67Az4UJA37tpQjOqtGDjoVyhQNV7oA+6FEhM=;
        b=G1fcFXzWLm8syXEF+YcGxQR5vCE77bdq/cdyeZstuQVESMHfC0aifrYUZ1l5pYGJ59
         h4XxuedaQ/g7CW/tg4sl11VbFUbEgdJAiFnlsKQKdfpG77rriOpZ4Xz6ms1r43htwQe7
         bUW0kzY4bFZMAgGDoCjA4P/4c4EuwyPkvMAQ/7pvyxTPi2Mz6BxRIioRamI+RJ8i4o2v
         FbutZ+wCKTDxW7Q6zcvV0IcXLUHUI02jjRa1Qm8uzUct38FPDNQLbGZnLaomLow29ltc
         n3BpuNCeg5XkgRrmtkqs2GcxWuJQzWZjzTCf5/m4gStpJ6HfWdd0O/3TbWV2fQ0DFTnW
         JHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712313196; x=1712917996;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KftUVZH67Az4UJA37tpQjOqtGDjoVyhQNV7oA+6FEhM=;
        b=fop5n820y/DFC90E0dD4V6qZ543PQrzn3SiOrRfO8/6IHRo3gJxjzVRyveRtA5zjmU
         jjo38n6dhqk+/JJ2mWdmsKoX6JlJa+nZUG867x1qx+ONPTCTnhKJltbXauvbukFEOaZc
         5F7jYJXfpRvHV6TBKguvj02hXqvW9NZyZKsBiG9VXl/yfit/lAXIN9Znv/XfQn9+IlYF
         Cbb7qD5f47VvzeVbZo499EtG3OQhxceJpS+4lNd6Rdjh/GhvloTwWS3mR8C9MmqZIu+p
         GTaJTmsYF8UW/ofkggUvua3jqUTQyQ66MgqrW22V5RdGMY43j6Cmt5G7X+ZeTtjdI7hd
         FcJw==
X-Gm-Message-State: AOJu0YyZu1N93QmHSvBlX/PV2+gP6hFtLqi7dYNtjez3I1XF7X3Q7pWG
	SFsarwHchcM+uCpOVjzIQzoI6eMCBluatGa3b3U/xRuuKcLHBGd67akj4k7h
X-Google-Smtp-Source: AGHT+IHHBycwtPituXWAvhzCCXfmz+QsRC3KTcF7zetnsOGrk37ZEXi54MlddaJob8oq8oOSe6zKug==
X-Received: by 2002:a25:4ac3:0:b0:ddd:72ab:233e with SMTP id x186-20020a254ac3000000b00ddd72ab233emr733537yba.54.1712313196010;
        Fri, 05 Apr 2024 03:33:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.199.96])
        by smtp.gmail.com with ESMTPSA id dk18-20020a056214093200b006990a3d9e93sm494498qvb.139.2024.04.05.03.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:33:15 -0700 (PDT)
Message-ID: <660fd36b.050a0220.311bf.27d9@mx.google.com>
Date: Fri, 05 Apr 2024 03:33:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0999228072789545822=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: l2cap: do not return LE flow credits when buf full
In-Reply-To: <20240405093834.63666-1-surban@surban.net>
References: <20240405093834.63666-1-surban@surban.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0999228072789545822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841735

---Test result---

Test Summary:
CheckPatch                    PASS      1.13 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 FAIL      0.36 seconds
BuildKernel                   PASS      29.62 seconds
CheckAllWarning               PASS      32.32 seconds
CheckSparse                   PASS      37.84 seconds
CheckSmatch                   FAIL      34.71 seconds
BuildKernel32                 PASS      28.82 seconds
TestRunnerSetup               PASS      517.48 seconds
TestRunner_l2cap-tester       PASS      22.31 seconds
TestRunner_iso-tester         PASS      32.29 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        PASS      108.24 seconds
TestRunner_rfcomm-tester      PASS      7.13 seconds
TestRunner_sco-tester         PASS      14.91 seconds
TestRunner_ioctl-tester       PASS      7.51 seconds
TestRunner_mesh-tester        PASS      5.65 seconds
TestRunner_smp-tester         PASS      6.60 seconds
TestRunner_userchan-tester    PASS      4.86 seconds
IncrementalBuild              PASS      27.56 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============0999228072789545822==--
