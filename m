Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5A30F94B
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 21:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277040; cv=none; b=Qetgqj5wJJVgdtK0iSNO476UfSHADvka3YNZwLCiDjsLkhUiUgJMU86sQLPDEGQ0SX32ni7fomQjY7Rq+7EcBQSlqYXdWy9xdwF3JIT25n0R8edQp1ZLkSMQaOs468FuUKg52cDLklfJCsr+yNeNIc3nDZho9BXsb2JcSiDMh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277040; c=relaxed/simple;
	bh=BVoddQAZ9tboyxPm5T65W5nC38uV3UE31cAK2UPvPwU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pSiXSfmAXx0BAS1CNBdfWJxDPP3zI/UWzpQFPUbz4dGNbHgHtaLuOVsEfMJyXFcfl0voib8ARYOJEraQKpjrgBZuogKif7Jf2f0vPcH1uDeOFhBK3YjE4Ozt2JumsR8KE9eukM3bCWNj5+AD/OPdb6fkwKH7/mlNWLn0SB7KkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pX3J+Hn+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pX3J+Hn+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ee7ffd738dso397042685a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 14:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778277038; x=1778881838; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J/4/iWArbAw2sOU7MqC2GHFgY94rICMGAVy9JGMXbwQ=;
        b=pX3J+Hn+V9Nmgf67CibydqIOXIQqzOolXTuMDIEN0mePXdNliTyzdtEbidW1HpS3/l
         5eBYv3fFiOZe2hLy5ySNZFBd2w/Ycu8TmLFhi6bNeKKU2DQl6UqVw+IhMpZ4bLxDYhnz
         3xDC5WSZIdha294Oab+xgWpyb15P1DQhNV28PaQFK25HePHhMBqCyHoHJQo7Vgov6oR3
         qqHAU6ZtFksn9zVisHYgRn1x6lhXlz8XELL97k5Z8HUSs9MvWWIZdrBjaKqqh1eTtBCJ
         Fe3pi3+fs/wNm5+rWYFrF0FbkTYQJYzNQ72P4jN9CKm57UPeM6HzKYzz7w6cWVSTU2bs
         bKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778277038; x=1778881838;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/4/iWArbAw2sOU7MqC2GHFgY94rICMGAVy9JGMXbwQ=;
        b=EOw9hAn+2IjMR2AXCYi567hWANw8E5ByUOwGqqGjOMqyjR36P95yzIEHSpiSdHgR4b
         FDW0UUc5j1vuj/4MF7ZsdiNIEcoOd4BFtTaR427VLKozflCnu0xl1zsChc6AkFKHW3C2
         G3Xxaa6rQAKWOzJgw6IqLb4n2ZmYPyPf87sAQfKu5rho83RN91hJgJk5npV1L9+uQoDh
         Xn4Yzy7LSYng7XkJdrk9iCCdjj2S1oywj3GGnTR41E3jwvRMcj/s4nD9TcOiVN/WJ4Ba
         4aZjazyMmnGJ8uDoAl6v8jui9GHm/ier7fUsAmOQNyo1OwTaQqRiJn+k/f+hhCZ6kYGH
         Ml5g==
X-Gm-Message-State: AOJu0Yx8NGbTU4U5Xxc2SRQijcfeAhjRfaKEO/M6jLXKivqPU6Cl04P9
	/Rn9/a+4Sy2XMy+wJ5gZA6+LBSLjpgLfhZWdH5BKnsAxfhp1LhKgG2LOefw0SR4w
X-Gm-Gg: AeBDievd63cdg0+DmqzcPMBpVkcnp1cj8HVqbTNJuXFEo6yzQR9Li15BUxKarq/Uvy9
	txqtjQUCWxW62cIUv3YeWB0RT8N0JqvTBy3RAG+bh03lyo59nhLFgVOa1LgSUo8x0wY9duec7Ub
	sZrW/ac2cCJZwQqvLrvncygFO4GOF5fws7TEj/qIk5Mg2YsL3X+bFZCAbtZuSXK0GErl+uLSq5M
	J7YYzTz5/DyAWKM3Lp3A8xKgICntWUTRhYRghxh4d7tSvyCm+4Yr36O/jE60OcMakM6UOHQ3RDf
	5YnhWcUYZyE0f7ZV83HxcOqmiIkL9T7hRzxU6S822b5rRx16ecSx5gdEL6ZQb2VDG6Y9GeLSXio
	LgIW+jwptxPmRFmmM8WR4FNrUGlfy56t+tOrH2IfRWmXa1FxV3/wTUJ0B0GhA4qDyDWG+rA01CW
	ErjC1hV/MA4Fjw3faO7Ne0uf+nJBxGUsAaahIZX4dF
X-Received: by 2002:a05:620a:19a7:b0:902:f040:11 with SMTP id af79cd13be357-906521905a9mr1202019885a.23.1778277038121;
        Fri, 08 May 2026 14:50:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.102.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b8123sm243436466d6.35.2026.05.08.14.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 14:50:37 -0700 (PDT)
Message-ID: <69fe5aad.d40a0220.29f164.fdec@mx.google.com>
Date: Fri, 08 May 2026 14:50:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5511654677592473073=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ] monitor: Fix RAS CS step mode parsing issues
In-Reply-To: <20260508191728.428868-1-luiz.dentz@gmail.com>
References: <20260508191728.428868-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5511654677592473073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091796

---Test result---

Test Summary:
CheckPatch                    FAIL      0.49 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      19.87 seconds
BluezMake                     PASS      597.89 seconds
MakeCheck                     PASS      0.94 seconds
MakeDistcheck                 PASS      231.44 seconds
CheckValgrind                 PASS      199.29 seconds
CheckSmatch                   PASS      319.52 seconds
bluezmakeextell               PASS      163.67 seconds
IncrementalBuild              PASS      599.15 seconds
ScanBuild                     PASS      913.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,BlueZ] monitor: Fix RAS CS step mode parsing issues
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#113: 
Assisted-by: OpenCode:claude-opus-4.6

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'OpenCode:claude-opus-4.6'
#113: 
Assisted-by: OpenCode:claude-opus-4.6

/github/workspace/src/patch/14562283.patch total: 1 errors, 1 warnings, 161 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14562283.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2111

---
Regards,
Linux Bluetooth


--===============5511654677592473073==--
