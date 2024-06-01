Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A454685
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jun 2024 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717204377; cv=none; b=roFV4jB6MOuoo+972qcBZx/OZS+F0dluAjsCK25o51hKqc9PtXowNyHDhAav1HxHegt3FXvL0t3KlMMX6Ssg2uEftcs+1B8wDuEXbZ7jwDq8BonIHLpoamqL6HF6hMQQTDHXlnmA1UiO0kuEhHl5xJf3he/Vgwu2XwbZ9D6wLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717204377; c=relaxed/simple;
	bh=Fr0MiqppxIBwSAt0wwGe9/vFeQAmvOuf6HOgL23whws=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a/RhTR9sAjozotXOqFTSJ8khnswG9DLitPoT0mZoQg/SyTZbzZ/RNA0PRMT1PNFYJiqAUuzs7/SN7w7rizvT4eI2/fc5kjlSKaQGy9n1bN+yr9f5Po4xzGQvRxRIoyEC186A0UtM9VDJ77bqq188giQgW1noK9IYVLg3v5V5s4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIp9EjIe; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIp9EjIe"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-702492172e3so1134362b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 18:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717204376; x=1717809176; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gUjQCvpP8ZKkhsiKBy3qUXp9m3ZLrIBEQZVrf+BuDps=;
        b=DIp9EjIeKXmMxEJ0RHhNzOeHoKL1zeYk7oA/8ZM7JWEAUBpRYWZzwIJypoEBSrDWwg
         /uCcKutig/DvaSat34oOJbPH6lipfFLJNDe9zud990+u/BrcnOmYceMUOjekHHT7dlig
         0VAj4BGlP2gBejrf0rVHaz1ZKyQJbHY74YVz9oQhGpyzpa4QVs2SbSFtivvEnn/jZG0/
         2Mn5f4TMf9pgsW0rrm0LJYvAv4Metp0znQIPH7fXlZ/ZE8XY5BBC1AOh3JfwASuXu4TK
         4llZWiJHxX/dEpfyZepmloiYvarEieagyt/LlHXhiWmGr6tHO+QhJ8yAYKlWwk4FdxbU
         BcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717204376; x=1717809176;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUjQCvpP8ZKkhsiKBy3qUXp9m3ZLrIBEQZVrf+BuDps=;
        b=JBZPZTvC9KVXRTRd7+Z08SnG57dreyslwunuW3VNLtnUfpfBsbpkmiLV5FW/nxVdpD
         s8841BjAyGsK2zfuE/OtsydBCnQGUBz1203FkkCs5anC5UMIBsBpRFgqzT7liWcLopU8
         ptcaQPxar1Ukp4nCOIitRAKIlEkEMf5iEcYcOjtjWA8trUNNzMqg6cUm0zEqi37La68Q
         n1gTck7S/V+FhrM+pnupTNUjqDYHlpj/7SCy5oH9WHdVGlOxHu2hxEYcHzXlwj0ewYkn
         oEZ+hEFXh3JD5G3T1Zo86kP/mLCU05S2Eh8jUMqY7QLdwffFKewtznXAc4dqlKDApi0l
         2xtw==
X-Gm-Message-State: AOJu0YwMyncsHC2d2s2uOFSV8GzW9Fp+Tmp07LlhpDlbNKAplYa7DBto
	o6G4P7JllidbkGe/2SuolV1rTEs/vtBmo7brk2CVHLXw9LHTcQGsCnvBkg==
X-Google-Smtp-Source: AGHT+IFbTUqES5+WzBc9drq2TiTxlkKyxxLgOa4Q4vCc4r+9B3Mt1g3zAKPoER+ZObnAujO3N4KNnQ==
X-Received: by 2002:a05:6a00:810:b0:702:5609:630f with SMTP id d2e1a72fcca58-70256096440mr702131b3a.23.1717204375474;
        Fri, 31 May 2024 18:12:55 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.68.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b055f2sm1950973b3a.166.2024.05.31.18.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:12:55 -0700 (PDT)
Message-ID: <665a7597.050a0220.2b179.5dac@mx.google.com>
Date: Fri, 31 May 2024 18:12:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6466782227847371789=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thorsten.blum@toblux.com
Subject: RE: Bluetooth: btintel_pcie: Remove unnecessary memset(0) calls
In-Reply-To: <20240531235132.664665-2-thorsten.blum@toblux.com>
References: <20240531235132.664665-2-thorsten.blum@toblux.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6466782227847371789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=857876

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       FAIL      0.43 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.44 seconds
CheckAllWarning               PASS      32.63 seconds
CheckSparse                   PASS      37.72 seconds
CheckSmatch                   FAIL      36.01 seconds
BuildKernel32                 PASS      28.64 seconds
TestRunnerSetup               PASS      517.96 seconds
TestRunner_l2cap-tester       PASS      20.27 seconds
TestRunner_iso-tester         PASS      30.58 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        PASS      111.42 seconds
TestRunner_rfcomm-tester      PASS      7.33 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      7.91 seconds
TestRunner_mesh-tester        PASS      5.86 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      27.83 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btintel_pcie: Remove unnecessary memset(0) calls

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B3 Line contains hard tab characters (\t): "	/* Allocate full chunk of data buffer for DMA first and do indexing and"
10: B3 Line contains hard tab characters (\t): "	 * initialization next, so it can be freed easily"
11: B3 Line contains hard tab characters (\t): "	 */"
12: B3 Line contains hard tab characters (\t): "	rxq->buf_v_addr   already zeroes out memory, so memset is not needed"
16: B3 Line contains hard tab characters (\t): "	/* Allocate full chunk of data buffer for DMA first and do indexing and"
17: B3 Line contains hard tab characters (\t): "	 * initialization next, so it can be freed easily"
18: B3 Line contains hard tab characters (\t): "	 */"
19: B3 Line contains hard tab characters (\t): "	txq->buf_v_addr   already zeroes out memory, so memset is not needed"
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


---
Regards,
Linux Bluetooth


--===============6466782227847371789==--
