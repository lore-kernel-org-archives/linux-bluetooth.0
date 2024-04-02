Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2760269
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061750; cv=none; b=AI0FFrUsQm0Mx0XUy/8Uqsn0SEEQiNXd73qD+rEPcPtAAtqWWABjkbHBAiNnAz/vZD3XeY8iyJ1biC5NdAuGKKuVBdAbROHm69+axTPE/AcrLvuMGn12MgdzzADJDJTT8MyccFS2WTuPzRUypxr5ZcGUeL+JO/J1V7znvq9UStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061750; c=relaxed/simple;
	bh=drouzYnDhp2EP2Te03c/0N2CMqbJB9E8p16KolM6l4w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oPj/HhvJaVxtEaKYp/WG5imU41pu4ZG30ipoyXxuSZfdNjX29Z8e5G2YrX/BBf3J4xaNCnAqcJRQUY4z6fW6JAavxGZfUNmF/kQxahga2X2+rQpOVlqw9qRsc8J7W9FFx+GCWgFrtJD0/LcnsLu7JQ57lPIKa+4pz7meTXvuZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsa6yzR0; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsa6yzR0"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22a96054726so4022314fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061748; x=1712666548; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SonKBB6hiJP9PXcCj1i5heSg7Cv8K9qk+QaVsnEmSfY=;
        b=bsa6yzR0l1GrtM2TWaQCI3WyLHx58m37mWbZ03Fch2+Qo3GgUIpc1K3wssNE/m6MqE
         LW65wV4QcfiSNAQIxQXX396A/jl9dNfdkpGeoOdIoRQ3zEGiRkDbcCTn3Wd3ufxgsO4m
         jTG9L5gA6LMHC77hXOXrOwFG9ntfIe+GTBDIWdktjSkHN3iawjRcSo54wY+rLW2vBm1Q
         hHbFaELmSaVxvi2s5q7dfjk6nFGRUMf0MC5zkYIocEPOnRC/DHguQ1t4Jlcjz/iPGBx+
         OBWmAuXbSYeYEh421AfbMNWcgAzSU6Z9ntZYUXWNAGNuV+QVvOPHfazuJbrmPa0hsF+0
         2hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061748; x=1712666548;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SonKBB6hiJP9PXcCj1i5heSg7Cv8K9qk+QaVsnEmSfY=;
        b=TG7gxl3RfaJhd73xZ7CDj/Xze1MyB2UuQyd/aSw7g/pO60L5vSAwK+PqeCUyKfNyDM
         bjdsihqJb+p7c7a7ykFvZzZC3eRycDkfHhnRJbvy/ndYYL6Jlx3SY/+R4nKWEhXhX4pD
         7iwvrf11Bf4bZA3gW+nLUqh4VPqT9fe+x2sXXgVgwDH+C6bgooS4lsARzCVcsYP8RT80
         MpbJKRvXeFv5FIerL1roukTTf3jrroZRNuWXtfLb4/3BuBNYpVjh7UXjph1fJy3p0BQr
         IZwFjEOnbjaWht6k9GV1SODNukXN/8MEI8OpM+Iqk2OaWx4FYXRCj6+WvWvPLrVXH1NN
         jhUw==
X-Gm-Message-State: AOJu0YxXYHUzWxpyavdUzA+X8rYORfEDhA8LQ6ostRQy+N9ycd/14sPp
	rEKs52co1mi/GqKFCpHTzfecsL+gmmgsWg2izpQXVfrfEKhUCMu2ByxaGY3g
X-Google-Smtp-Source: AGHT+IEZi3slkEtGdBkoKMNaKjcKA7IXEaZ438lY7p/tQgw+sBhN4nZoVxn5nyxRaSRUvCKTzI3rTQ==
X-Received: by 2002:a05:6870:458a:b0:22d:fcf9:f771 with SMTP id y10-20020a056870458a00b0022dfcf9f771mr12580851oao.25.1712061748146;
        Tue, 02 Apr 2024 05:42:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.84.127.17])
        by smtp.gmail.com with ESMTPSA id bv12-20020a05622a0a0c00b004309f67c186sm5561031qtb.82.2024.04.02.05.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:42:28 -0700 (PDT)
Message-ID: <660bfd34.050a0220.54a88.a53e@mx.google.com>
Date: Tue, 02 Apr 2024 05:42:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0631804665084753765=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Handle PA sync when no BIGInfo reports are generated
In-Reply-To: <20240402113931.3164-2-iulia.tanasescu@nxp.com>
References: <20240402113931.3164-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0631804665084753765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840593

---Test result---

Test Summary:
CheckPatch                    PASS      3.18 seconds
GitLint                       PASS      0.71 seconds
SubjectPrefix                 PASS      0.38 seconds
BuildKernel                   PASS      29.86 seconds
CheckAllWarning               PASS      32.45 seconds
CheckSparse                   WARNING   38.07 seconds
CheckSmatch                   FAIL      41.55 seconds
BuildKernel32                 PASS      28.85 seconds
TestRunnerSetup               PASS      519.08 seconds
TestRunner_l2cap-tester       PASS      17.95 seconds
TestRunner_iso-tester         FAIL      38.42 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      110.75 seconds
TestRunner_rfcomm-tester      PASS      7.29 seconds
TestRunner_sco-tester         PASS      14.86 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      7.54 seconds
TestRunner_userchan-tester    PASS      10.42 seconds
IncrementalBuild              PASS      51.97 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       8.248 seconds


---
Regards,
Linux Bluetooth


--===============0631804665084753765==--
