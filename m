Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248CD4D8C3
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556719; cv=none; b=I0ajBxLPKKjcfQ160afYdG2OJKAS30mBBAMarKfGlNpHAnDN1t5TxEw1rMVdwKFOG7jtUGgAzof5g2q4SU09P77HGnw9fq37I901VhgRO8jOXbQBDO/DPFlnDsV1pQ+r+QK4pLaB7AmZT1gGkq5OzWtVgx1pUR7GHXpOJQbqoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556719; c=relaxed/simple;
	bh=+cW++oNjvYmbPZfQxgqCIJUmrmosLGD1mqDxuozya4o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pkdCFhBPFJUtIGufgvIUREDjlHPdO7WEVmXHblPiRCmwjpGhg9QDcGjSJgsjLA2qZoOFMBYLO0fo968zxRt0TGVYVDtxY8LjbseWjIFZjyx5LwnknVSe878IpK6JFH97FO9O4ev+jPw+WileTGq0TFTzsnt1vYMGuaTNYSQ8buc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqJpA5y+; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqJpA5y+"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-64a7de97729so2228307b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 23:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556717; x=1720161517; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OjJmisB88C0ZWcIfSEP7wxYX7ny1B8qRYdOP0I+VbsA=;
        b=UqJpA5y+LUiqRDDihtNMTECWh7yJSfMatsaevZNZyhMKkupzZ0XZdcF3MJnNawBgYI
         /arvehf+3ytPTBx8rExmGKFD1MJbaFp6K+7AzGa72ghMivwrVas55lMvISAh8cHnoajR
         rznsUNJBjVSgTRdzV0mPzBcfYrrqxAXJuWyNJYyYmi3rk3XN+bzpF58MAR0VpLnF+mAe
         BhgR62w4KEaEBeQdXzK8eNv9Me45kl3IRc59n3QMMtq8fa3TSIjEG+uPYdN2WABosaav
         rTSedL9toA3aU9wEBMPMcLsoedRNkcbsE5Q4ZWvdKFLij4P/0t5b0W6DhXgtuhkWhbWA
         ZoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556717; x=1720161517;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjJmisB88C0ZWcIfSEP7wxYX7ny1B8qRYdOP0I+VbsA=;
        b=k2c83ABx8WywC/kn45dqI7Q2WvPQTKVJBVde/hpe+PV+kn6RYpOBKfxGdxCGX8/fPk
         2928PSU2zuDykOvFdkunZKRUbMUNMn4dtsNhwhSzIMmvyBg9QpC33bjLbhfDMIU0TlJ9
         d6n4UgjcTFj4D+9NyeoT/tw8PQfIMpUeKKLxPCH94pP/Tk8sGKmy5/NVAODUbTHKAJr7
         l//1osHb10WWwIui9LlSkszM02oD2/tJzyo3pBegP+O8MqqUAS71MjmaZ1hdm9eDDPLN
         KKl0Jc8izilQxtV06c9/jhzRe8eAb0Cy/zw1uypqX+3XdoSVCPtTcj2CDdiaG72qzIL/
         8a7g==
X-Gm-Message-State: AOJu0YyH3ro4JJBHT8JYr5f0BMB/K9O98QQ2D1M20DmalEXRcXCsMUoq
	eM96TIZLXl4j1b4Tj7sxNW2w5MkXaFQuby9Dfc0vNyd5W6qX1INpMoxTDA==
X-Google-Smtp-Source: AGHT+IF4DHhC34VZFqUQsWrt/mB7/K5jSERuwN4znySAPKWPbnAegAmRd4klogiGtO8i20ervGHlNQ==
X-Received: by 2002:a81:840c:0:b0:64a:8640:aa27 with SMTP id 00721157ae682-64a8640ab80mr18280797b3.37.1719556716781;
        Thu, 27 Jun 2024 23:38:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.122.246])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9ba5a8c0sm2386017b3.83.2024.06.27.23.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:38:36 -0700 (PDT)
Message-ID: <667e5a6c.050a0220.e304.1a71@mx.google.com>
Date: Thu, 27 Jun 2024 23:38:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2999251187876789541=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zajec5@gmail.com
Subject: RE: [V2] dt-bindings: net: bluetooth: convert MT7622 Bluetooth to the json-schema
In-Reply-To: <20240628054635.3154-1-zajec5@gmail.com>
References: <20240628054635.3154-1-zajec5@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2999251187876789541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866412

---Test result---

Test Summary:
CheckPatch                    FAIL      4.99 seconds
GitLint                       FAIL      2.33 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      29.63 seconds
CheckAllWarning               PASS      32.01 seconds
CheckSparse                   PASS      39.62 seconds
CheckSmatch                   PASS      103.08 seconds
BuildKernel32                 PASS      28.62 seconds
TestRunnerSetup               PASS      520.84 seconds
TestRunner_l2cap-tester       PASS      38.33 seconds
TestRunner_iso-tester         PASS      36.89 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      112.73 seconds
TestRunner_rfcomm-tester      PASS      7.44 seconds
TestRunner_sco-tester         PASS      14.99 seconds
TestRunner_ioctl-tester       PASS      7.79 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      6.92 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      27.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[V2] dt-bindings: net: bluetooth: convert MT7622 Bluetooth to the json-schema
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#121: 
new file mode 100644

total: 0 errors, 1 warnings, 90 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13715485.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[V2] dt-bindings: net: bluetooth: convert MT7622 Bluetooth to the json-schema

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
16: B1 Line exceeds max length (98>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============2999251187876789541==--
