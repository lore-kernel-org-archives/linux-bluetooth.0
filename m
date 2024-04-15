Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26B78C72
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192995; cv=none; b=X5Jg5iyOtKfd6hFFF9xdrsWre+RXB1RWyT6rn0h6scG/1mHIQhLi6Sx9hVuuZ6/hteH9fzzvYiHS4Mkq4smiLMHOD5B6UPfB0FKDbYlM5vXJV1uSIqux80TjZVpjtRqcgnkIFrpkPC0mUHHY/MMFC/CKoKKrFPlSSPSoTwEMg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192995; c=relaxed/simple;
	bh=JgoLiVZwHaUhiSHrntFDX+HB+8upRPn3hSwEHWn5N8c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MUkCc/fzCknz9nQDFwx6ol8Wm3l8W7SL70GEQkYhR134teAMgV+erHFUBpVnSLyy9jn0nL5fedrp+c/dWKTpl9pxID8KrH5ttxLHqJRHRQzwKt3zTXESCPKOGpRU8Ob7J2/77UkkQxqsSQMKdO3eA1QY88HQIgIhGAcvitwq9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBzCbX64; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBzCbX64"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78edc3ad5fdso135488085a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192993; x=1713797793; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V/U+n8ae7RraFB5e15XlSKUxLV3Yrj40XiDvYs2colY=;
        b=SBzCbX64IqBtGSooCeWHNAdmiE3S45cgTP7chQbrYb+pKGm0ezWP/M/my/P1bqBzQC
         zfHOvaMalme3j/EgSa6OCbVNZcfdg15WsCdv2HMcT+rmHwA+3iFhfvG1vyRXZzfx+C0+
         DSv8a0Wf4zgNwNwAvS6GqUo6LThapKJbFjOYDqGUMJan/HwJZWWCy2shWWMORsJSjNx9
         +uq6yyy3wsaQVyPuthZeL53PCLevW644KTPgX4n0AdHGMg+dXn5d6z1KAv/gh01BW5nb
         25hQifRp3JQwR07E1c+drDGqySWfqPgIVbzjA01OdHMmQZXha7vPBTmskVOZAUStGX1x
         ci5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192993; x=1713797793;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/U+n8ae7RraFB5e15XlSKUxLV3Yrj40XiDvYs2colY=;
        b=Qb2PLxqR8jr53+GrRdSBbLcHRQ9rt5rMsQ7Qbh9OrFUvSXafBdHLsc4mNdGQUXLr4v
         JHMAlv+Pzj/R304sjFMaC1lv5y/9IwCHsb9CpIHokzF66hXETS9JsaaTRVZrTNbeM2o3
         MoIrdePXf32nMK+mPTVZV/+prWMLkr6L38W4BqWWKhMc/9S0q7rwo1kF56mvAhJju4Hy
         KsUBzuBcmEhKV4jhtFDE8FXwLzYz6OPIoT1LVoSBKbcfKaN8+NCJT3FGPZnvj90TBjuq
         GBwxH7xPxLasMSHJ6F9jCmuZgOPoytxUrzTb4lGb0Vdf0QuGaIfaI+Nn6bJ4gzmteCts
         46ig==
X-Gm-Message-State: AOJu0YygAK566RphEaiU8FulA63knV2rO1mHYvpAOmyDXhCVGYdm6SyX
	cUbs0H5im0keZN+LuXTUH/9V6mTiiNGsiWYI2HmtlSA6AwCyQmv+Ct9x2A==
X-Google-Smtp-Source: AGHT+IE6kYDBGADO/9EUFWp3Rxju4E6yzQBPlZpoJXlrK8qFDzubBTVieI0S/Urkb1iBkNQz/EJAjQ==
X-Received: by 2002:ae9:e645:0:b0:78e:e3b6:ce18 with SMTP id x5-20020ae9e645000000b0078ee3b6ce18mr5315623qkl.23.1713192992954;
        Mon, 15 Apr 2024 07:56:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.50.158])
        by smtp.gmail.com with ESMTPSA id k7-20020ae9f107000000b0078d65fbde2bsm3009116qkg.86.2024.04.15.07.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:56:32 -0700 (PDT)
Message-ID: <661d4020.e90a0220.b1f56.4a3b@mx.google.com>
Date: Mon, 15 Apr 2024 07:56:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3618584236432937099=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, peter.tsao@mediatek.com
Subject: RE: Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921
In-Reply-To: <20240415141922.25055-1-peter.tsao@mediatek.com>
References: <20240415141922.25055-1-peter.tsao@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3618584236432937099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844667

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      30.59 seconds
CheckAllWarning               PASS      34.12 seconds
CheckSparse                   PASS      39.61 seconds
CheckSmatch                   FAIL      37.61 seconds
BuildKernel32                 PASS      30.35 seconds
TestRunnerSetup               PASS      541.29 seconds
TestRunner_l2cap-tester       PASS      20.82 seconds
TestRunner_iso-tester         PASS      33.08 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        PASS      111.09 seconds
TestRunner_rfcomm-tester      PASS      7.57 seconds
TestRunner_sco-tester         PASS      15.20 seconds
TestRunner_ioctl-tester       PASS      7.91 seconds
TestRunner_mesh-tester        PASS      6.02 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PASS      28.40 seconds

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


--===============3618584236432937099==--
