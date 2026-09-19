Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACE397949
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789820088; cv=none; b=kT7LeuVWlebDXlbAQc9Z020kAWVwKVaK66D2LNXkWGTChpCFWIpr5N05i+apxk5+ZQx7Pk7/kSa1+woimtCjxtbnC/gua0Gf+Tlb4dMm01WjanHyapQo2i+sAZru+bh+rKcoBDRrMBKITP+sLjJ/QyADylkHkf7HdRe+1kHyyqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789820088; c=relaxed/simple;
	bh=czcbgEWXgm4ynK2nish5YmSukMEkuk3Hc0lQrHQ9+W0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DCpSoT7OIx3h1HzxtRTfLS4MAm4itAkd16wo5VNnIWl3Y/sk9HZeCjsf2/93dlNswqDp042cxXyMTB+97c2YQXE3W6eEXiZ+d1j6pannU+Y4BfWXXii7Uwhy93pMf4HmdLlqkBct6UYTW0IAGh3XmTEDsJ8SYkbHmztO7TUIIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov/IGdsF; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov/IGdsF"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-910537b51a0so14655906d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789820084; x=1790424884; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0uKVttTrtm1E9qW2xwMzwQMNkzQioxAkK2t31V1F6g0=;
        b=Ov/IGdsFPCOsHBQWL0f45m933Txh1lGQ2vCflUfZ4uE1L//t8vY28gQI+jIBAMBQks
         DII/+25j4I4iDC1Kx83PxDoGDa+/MjWYcNBWvI2Wz51RArRDn3qESsVC57N0RC0dvrdz
         NAC1+vDE+VPtSgKyiX6alSgFXU2UlI5lA11j3hgz3cJN88qC2D4dBUAK4pWziFCkyXdz
         f/1iVJVEHxg8dGNyM+4GbelOL0FiJQlpCNbRwjPDuEdyyzIc6/ZlUF7ByfbQ9tXDA4Hg
         OwZm+JHmawcWcDURCtqy/lTayujp40KohknvsVpkh7clckX7EwCaLauJ+BPTZSgmMxMg
         Wr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789820084; x=1790424884;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0uKVttTrtm1E9qW2xwMzwQMNkzQioxAkK2t31V1F6g0=;
        b=DPjFvrL6OL/W3Hz2yJrBQF/c5hUGZOcROyCs5/9Rdq8Ze7Cb/8hI5T5MUFTCfU9PSj
         PyH6bfshZcLhJr8/k21AVorhpsK/BRcXfqhHM6PZO6ZayjUvpQe9Ju4sqomw3LcT1ENC
         qUTtDNQeAdEvk4TaNixbMKQRTLZdDQEaQy6V0ESVlLghrfKPMkQV1nY+tK0u55ma04Dh
         uA8OMPKBMiXvsbTWIQGBqlZ9RooGDTUsQ3PL5ua9Ep+PPqlVCGcPFGoLFvJptc7FozJo
         AXMX/hdIRg56dleENq4TzK+aD2v3wlKtecQKMMmgtuo41TIqm29qmrDYqDhYiLSTGHUJ
         0Lsw==
X-Gm-Message-State: AFuF++ktfvj96d8oz80WX8I2peoy2A8aPBtuzZXfcG5u2QBhD0TFFho7
	ANHNZXSLQBeFA7ssmW5dP09Z5aYYUsA217FVL4Qjr43aQEpTtjDcSsf5wc4AJ4nv
X-Gm-Gg: AYBFou0LaKBQlAGbpii//y4MZKLC7Ul9HmKmgKhURtfHRcYxFCOo2wvLDSGdObcOvA6
	tEuI7XXyGeqVJpXMrw8MeejPNyfxpoRkToLCuX71SjLLlVzWYy6sNNA/i5dsAWRJ8olY/q6JgIT
	WSiRT384xdhAPM1kUsaXRom0wY+OS5eo+2xjJIoN/nNSUyxf6hAQKMFikaYbAcvSS2jzgtt1r1U
	mAKR1J7Wsq78nJ3QEHLI4UuSHOO+t/ai/wGYDN4yPsfTYwvEoDaDCFLKCjLX+MgD1emkLn9mo7Y
	V1JSlk5fng3GsoG73XoCQIOwP9CkJl+ilFonEs1lLG44JMegaav6M3o8OOfxZ78qoeiJLBzY7to
	bl49emCB9tuyEJkWbGmSzyqXGAxZUcS1R8QIYB96SHuZrnn51E0eF/694llzoU4ktRVFcOaoLpA
	K3gFBPOpAeGA1DOMbty0/AcAXH84r0dynlH8Cxau8/TAcRldy2pjLNzyfj93aiZzC6GJTfWzful
	z07uaM=
X-Received: by 2002:a05:620a:63c7:b0:939:7fc4:fb1a with SMTP id af79cd13be357-93bf55ac687mr122314685a.27.1789820083640;
        Sat, 19 Sep 2026 05:14:43 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.109.210])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedb6759bsm180729085a.43.2026.09.19.05.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:14:43 -0700 (PDT)
Message-ID: <6aae7cb3.45a667ed.1fa4a4.a5a2@mx.google.com>
Date: Sat, 19 Sep 2026 05:14:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5121874539350296979=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benquike@gmail.com
Subject: RE: [v2] Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
In-Reply-To: <20260919112518.3872094-1-benquike@gmail.com>
References: <20260919112518.3872094-1-benquike@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5121874539350296979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1169237/

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      23.02 seconds
CheckAllWarning               PASS      26.91 seconds
CheckSparse                   PASS      27.97 seconds
BuildKernel32                 PASS      22.45 seconds
CheckKernelLLVM               PASS      24.55 seconds
TestRunnerSetup               PASS      579.05 seconds
TestRunner_rfcomm-tester      PASS      7.01 seconds
IncrementalBuild              PASS      22.17 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO

6: B3 Line contains hard tab characters (\t): "	if (sk->sk_state != BT_CONNECTED &&"
7: B3 Line contains hard tab characters (\t): "				!rfcomm_pi(sk)->dlc->defer_setup) {"
8: B3 Line contains hard tab characters (\t): "		err = -ENOTCONN;"
9: B3 Line contains hard tab characters (\t): "		break;"
10: B3 Line contains hard tab characters (\t): "	}"
11: B3 Line contains hard tab characters (\t): "	l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;"
20: B3 Line contains hard tab characters (\t): "	d->state = BT_CLOSED;"
21: B3 Line contains hard tab characters (\t): "	__rfcomm_dlc_close(d, err);"


https://github.com/bluez/bluetooth-next/pull/797

---
Regards,
Linux Bluetooth


--===============5121874539350296979==--
