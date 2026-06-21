Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B413D994
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782054680; cv=none; b=cbul831FbXI8Ubnn6JT0XWOLLhZx4C7plUe2xN2eeAs8oH6oczQuLmXeQwxEw1owdr++PF/TuOQwXbk3HpNovoDNH9kNnwanvmZzBglDvoRG5PCho0AvSH6BIBbcv7ghNlXIdZ4XoBIn+LL49RX5qiDNg998GlxH9+XW8aahZk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782054680; c=relaxed/simple;
	bh=hh+twfglxzDKFjw+yqbsnmRxMVGY836a1gCh7F7XTnI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SNYfsI695TOlxo4kdX03vwVQXDj3ZTVZmdTbtGYBJXs77b4NxaBO2WUQvyVzfDOWWkvchaIoE4fLPS0xzCCglMWIdQCk3x2tn/dWsisa//dvhbOAqkS5j+nkYj9x5Y04jzhAi7YeBEljyJBqwrM5rxAjiK2evcdjQ0orInZmnO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkp7AdRH; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkp7AdRH"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-139a71baa35so4538456c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782054679; x=1782659479; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FY65Y1Aeic4k6/LI6ljmJF5nQvqs7zJBLGU7v8uLmx0=;
        b=hkp7AdRHBWfPQ2gzhE39cTIZ1hFX/7DtMD7L3IuVqF4gcZ2YrBLMwz4AEPkozxj3A2
         gFHBc1ymqIKjExx+1SvF6fPbqK9UpFccxjfxgy/nVxy8Y0qfu8Q+B11W7hUIpYALGvmp
         DmL0gaJAKdBzrv+LtPjo+2CSRTfNtx0wnilaN783uIsHbGmjSqv/yfbmVr7JsD77kdXF
         A2Aop80I+kTk3SbZFaO7e3dnHOr5csrY7ANkUzyqv7Y2rGqRw24o37Xtq/EoIpAa+fou
         t3Gj1BIJzNtDqNAr2IHTYEn7lKio5vgcUKz7Yl4b8ArN/jYI2sa9V22tWRuE5E5ukxsU
         ntgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782054679; x=1782659479;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FY65Y1Aeic4k6/LI6ljmJF5nQvqs7zJBLGU7v8uLmx0=;
        b=LSl+pTZPm+NvfqsvV+qFIchztG8cOOfjLMxc8trVr6ESzyJfV8IzkSDS2ayP9IjU2z
         Fn1KuEkIHJl1u9BofOtVW99+vDm6szG/yHS7JsnjabMdMQBX2wgvl70nbki7LsqUu6ne
         STlUvCxbR2yMzDDeauX6nlTgzpYTekfRGRxZ+0D8hvzA1d9a6/BXVzWWyenJ+5qh9ZqW
         j1bVkAn+rnHIcg6hoylAVKq4jGyHtdPVqJ8IXQIeevZ2EXTzKA22b6bfDncKOUIPv84a
         dYNEwUR9CGBkS74Uvt5nXzj72FNtA7t9AY4ZJb8a9NfmFuyO3uiXCCqI9bimsbCCq6Lj
         lfhg==
X-Gm-Message-State: AOJu0Yx5I2yad6LMUSKQ1uSw3h+LSL54WCRZgF6p+2N/ALAmFfSSXZcm
	50faYpNZId2A61SJ5X9Ev1r/+9FNAWBROOzHIdohgp2cHL2mLTsCEvi71dY1UQ==
X-Gm-Gg: AfdE7cmvyyHA3PhlJgbCf6WQrMAd+EPJGUaqbEHPiTmnYSyDFkfr2PKivHs7Q6WQ4KM
	PilKfHj3ab9Crcl9Mu3pUm1Mw9PStPyWV9R3QJilMrLe88JMsZOxne4cHdSM2FTon4gLcAa1GWo
	VuK7onFGfTGur1k4ackqQEBkouV2oBtfRuIk3jh3TN4LcN60+IT9kEAw6jsVTZyQtpYMDcBOJDw
	JJW9G2KI6N4cPIpfKrqi5S5xY4wTOdh0BrnrD8UTBpnPFJo8xrk93xs03+L08p6vIWhfXigsLNI
	4K3GaI9ksSd/8Fm3jvI9oRuhAdZeUDypmEdHuw32B4vBcAob1CoYwTtmfyB7JZWofBs4A6cfgfe
	iFmvTalUkbMGN+N486ZwToY2MtWxuDKE+pB7hIaLvABlGNd7vC+qAYad9HAOwjloiCOPhjNJVH3
	+50HX0/hb11cnqOuUg7JY=
X-Received: by 2002:a05:7022:2201:b0:137:ed4b:c9b4 with SMTP id a92af1059eb24-139a3686b4dmr7511343c88.28.1782054677521;
        Sun, 21 Jun 2026 08:11:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.53.118])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcb7aabsm6163814c88.5.2026.06.21.08.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 08:11:17 -0700 (PDT)
Message-ID: <6a37ff15.3d0beb03.1a7042.509c@mx.google.com>
Date: Sun, 21 Jun 2026 08:11:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5226660851534606103=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] unit: test-bap: disable optimization to speed up compilation
In-Reply-To: <e0650488e684f464f69cf013d1654f46bb862d46.1782046466.git.pav@iki.fi>
References: <e0650488e684f464f69cf013d1654f46bb862d46.1782046466.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5226660851534606103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1114334

---Test result---

Test Summary:
CheckPatch                    FAIL      0.57 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      14.54 seconds
BluezMake                     PASS      454.07 seconds
MakeCheck                     PASS      17.38 seconds
MakeDistcheck                 PASS      101.41 seconds
CheckValgrind                 PASS      144.56 seconds
CheckSmatch                   PASS      177.29 seconds
bluezmakeextell               PASS      60.70 seconds
IncrementalBuild              PASS      465.69 seconds
ScanBuild                     PASS      521.19 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] unit: test-bap: disable optimization to speed up compilation
WARNING:SPACING: space prohibited between function name and open parenthesis '('
#104: FILE: unit/test-bap.c:18:
+#pragma GCC optimize ("O0")

/github/workspace/src/patch/14638248.patch total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14638248.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2246

---
Regards,
Linux Bluetooth


--===============5226660851534606103==--
