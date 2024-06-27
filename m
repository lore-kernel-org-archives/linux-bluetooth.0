Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CF24B5B
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470352; cv=none; b=KS6mpnCvljfMe4Ip4KXvJwTCbfLV3sjuF/0cLn/lNwnvr/09AFPnSqbBsSZN1qpumyZRILwQ4b4CljKHvamf+fR1ko514XGFPJAPMQF5rJhH1TrN7+ZaXDLQyj6yN111S5O4XNmStwjhFpUvwG9JacQ40uKEQXOLjKqy8RIHPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470352; c=relaxed/simple;
	bh=CsEqKP7WgsojCNP9jiLo1JoGi9pJg6KzUd26BxV/fZw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=etE9WZM2RVYuBfyGKdhkxAE9kibDphLlJZJGLb3KVFD+21lcv7adk8ASDdZpv5HV3WeQBFxQPJWwYVV/kvSp5O/1y0LbTyOgKKCbA0fGnuGfwvGRbNEXO6QfAJrZieuCBRJKjPkOLNEjNysSP974/MRD8bCJi27j2xzLVaWb2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mp/aDsnI; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp/aDsnI"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79c03ab3cc2so134239385a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 23:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719470349; x=1720075149; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RMJ4cSS+1N0AVmWDNwqr7N8tp1AK9P+q9eFtv+34Lw8=;
        b=mp/aDsnIeL/rTPK11JZGRXzYL2VVaMUJm4MYyP9fm5YviKM2EqcOUE3WGD5DttY0Gc
         5LwCKaR5+MYaDnyBquZ2X3xrN+91JhNgx+GhlgeR4M+PWZhtK2lyGY3idceWG0nb4u88
         NE9ek1RRnMSyJUXdUzvceMX5nzKPdYUV4eTnCphGhpl3dvnai4FO0f7QfVLuJi9g5g7n
         c1yu6EU9Y/Q//znqKvESFPGM5qUPLxLudYZZWl82fwP7JpU4BMFOsrUS5D1Jknt0b3Dj
         px/eaAMciGOH4wHr79kGQ2DN8slyvbLfqGKEKCiVRnn0QPHomZa98U80NoV9awjMPZEu
         TQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719470349; x=1720075149;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMJ4cSS+1N0AVmWDNwqr7N8tp1AK9P+q9eFtv+34Lw8=;
        b=QYXdGLBillGNeIA4yT/8wn65QCiLknouoGuXm2aewrN+GkGDVhO3zTDSMZiagyros9
         ccVkUArTdJEaM21AwSaIpHU3DePE/et0CdLhAFFAmPLD5wn0AAT4uHky+KRA6N3yGilZ
         KBXAG6P++eaDWmF5QZtJnDvR+yrVW8oX2mgTaT0Kp+pnd0gOHIMtiWyCKjipUitBbEMk
         P50G7YSc3KGQsd4PO6hzcoeTnREzm/8oq/1uADPIRBciNafMt0tFPNEX9U4ylexh9Wqs
         dXpzpx0PqGWnEU2BsTHJp0L+0NzbsoR1fQYMsdJnuRLRjudeXc5Rd5FvI1Ts9owbbUAy
         Pkfg==
X-Gm-Message-State: AOJu0Yz/DpzuIa0dKtwj5IrDetCURjdRo7qafcNHyN47Wp0dKIgOYTiV
	5V6cIuAzfaH09UrFu8rRUKqI0+Fz4mvK3uFTsdH24i0mzGYGRPkunoFILQ==
X-Google-Smtp-Source: AGHT+IFAL5FTpuiglx1d1MVyPyvt/if8sLlVp4Sl8Kz43b/AZedcGVWzHZWXliVXFaY4L8RQHQewHA==
X-Received: by 2002:a05:620a:2911:b0:797:84f9:cb22 with SMTP id af79cd13be357-79be467dad5mr1401622285a.9.1719470349326;
        Wed, 26 Jun 2024 23:39:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c8c4977sm28463685a.128.2024.06.26.23.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 23:39:09 -0700 (PDT)
Message-ID: <667d090d.050a0220.a6ea8.0f7c@mx.google.com>
Date: Wed, 26 Jun 2024 23:39:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2248594209766958280=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zajec5@gmail.com
Subject: RE: dt-bindings: net: bluetooth: convert MT7622 Bluetooth to the json-schema
In-Reply-To: <20240627054011.26621-1-zajec5@gmail.com>
References: <20240627054011.26621-1-zajec5@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2248594209766958280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=865996

---Test result---

Test Summary:
CheckPatch                    FAIL      1.30 seconds
GitLint                       FAIL      0.46 seconds
SubjectPrefix                 FAIL      0.30 seconds
BuildKernel                   PASS      30.01 seconds
CheckAllWarning               PASS      31.85 seconds
CheckSparse                   PASS      50.82 seconds
CheckSmatch                   PASS      103.34 seconds
BuildKernel32                 PASS      28.50 seconds
TestRunnerSetup               PASS      528.92 seconds
TestRunner_l2cap-tester       PASS      20.54 seconds
TestRunner_iso-tester         FAIL      51.84 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        PASS      114.07 seconds
TestRunner_rfcomm-tester      PASS      7.52 seconds
TestRunner_sco-tester         PASS      15.10 seconds
TestRunner_ioctl-tester       PASS      7.95 seconds
TestRunner_mesh-tester        PASS      5.98 seconds
TestRunner_smp-tester         PASS      10.68 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      28.40 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
dt-bindings: net: bluetooth: convert MT7622 Bluetooth to the json-schema
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#117: 
new file mode 100644

total: 0 errors, 1 warnings, 100 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13713830.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
dt-bindings: net: bluetooth: convert MT7622 Bluetooth to the json-schema

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B1 Line exceeds max length (98>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 116 (95.1%), Failed: 2, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       8.231 seconds
ISO Connect2 Suspend - Success                       Failed       6.252 seconds


---
Regards,
Linux Bluetooth


--===============2248594209766958280==--
