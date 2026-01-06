Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0506309F08
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694162; cv=none; b=Iofq0NKcFAH3jcRHyfhs0kVPSfvklZGKpLFVO4jdyAx80BoljeUcztf67inCPnzCPwMCSlt9VffmZQP42zpiCtd6MDQB4E+zUY/K1i9fbsH/8447nay65iZEnybvGuGCzHPkq6Ln6eW+a/j51EOFht0NprNZVDLAHLPetAgU0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694162; c=relaxed/simple;
	bh=x81cOLtLJDlL9U+/thP8M1V/RMC8eU3YDjYEa9T7pcE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bruYIwzCDzK/kvKdCR9I0VMRLS/6Hm0XDgsUaL5InAOD3kMoIN9iPwVU5OH9qrCsU+SFYcbWA6r4EvigcIXLTeYC1wiqO/rLEzQRq8Yvvfn6A0c2oB20HjLF02pahwvdj8SVmz5ttqeodd1gaG+dpEG6eguIK7YvYDp4OcQPkZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQyHe6mq; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQyHe6mq"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8b2ea2b9631so80756985a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 02:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767694158; x=1768298958; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fWbOjNkddVHvTthqWFaY93sseI89uEqjPsv3sLdY9z4=;
        b=jQyHe6mqCwKAyOEbkCovBKU3t3C5V8qLxap5cxZdMtM0xOqZN+FiRu6yLZxlQWDMfV
         okR9ta68ruSAi3mR4kQjbeqYBDIcQOh1bJVeziF2Rt/nJGOQvoRnfCO8MJX4Hxno8sRH
         fQ2Bb+taWUKTLvd4uDRdX9q80GUD93HKkyMgnIhdBvrxuPmv/xgw3ehwzh6lf6KD0pFj
         21J4ETV663pB5SPHUSl67SE1vPr5FzRG/U3vpfUdTNZZgBoNwRunO/L0LoEqKnkKhpK7
         5oMov34JVdH8kziwUX/ajgUyptF+6SRRKw/TXJiF5WlN92w9hU4ceva/U/Gqm62CcW+5
         2GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767694158; x=1768298958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWbOjNkddVHvTthqWFaY93sseI89uEqjPsv3sLdY9z4=;
        b=bVaQ6M0WsFyTEW9vOG9JjG0cN3G5iub3lGRViLr/XMQjAfIaAFI/aSDQWGXCpQnIwZ
         tUzsjwB5eR/wkrOqexi4/AOvxVrL+bUFmBPbHY7pnHZBuONUZQmV7IrgIwbkhrmE1XfF
         mb1wyq6MDOHucC5L195oxjgajPyNXyV0YNGgNRqgr0w31loBnSekldu7XFkwrj5Wvbz1
         qBVuPzpggGDBSgkFPVYHVfCtijXaPIOMQhZ+dE7U/DCOD/L9M7AUqB9KRCmDViTVnJ/u
         zUMGupHOjVbBKwHjVl8XBgi/pIoKGLzaK2XDtnANuA+M0hMr7ZJhpxtje/61xxCm3blh
         RBQQ==
X-Gm-Message-State: AOJu0YzpdaLVZMRA+IBGbcm3qmZA5dIIf0blX/5oNBwx3WmT3yR5TDxl
	m06LtjDZvsR1e2r5+35SX5EGa51ZFuMHa2AA+4+RjtkTylLMSVPlx7BOSO5+yZYK
X-Gm-Gg: AY/fxX5TfDNIXAfbbtz95sPYrbiuzaFm/nITM5Lxp+DxChwzjilNt9KMxJUiNaVuvUH
	zxEDB33ypdfrJp7mo0N5UQZ+NOBAhGBudMQtvRKu/tpz45d0uqzt2vU8HGZPrYCRoMT01GTHoIb
	cEBZMIHn7MZ9zYI5NoySQaHQagQu4PC5L/6HvqyFiSArue27odg2w8YZzlYilPd4oUqbER1GgV+
	jo13okBw0CDsfoHLbUspL8uq8d37tIZQnUw7pMW2aKq6XLSen91paUZYtaXcsqUeywDb8bscp1p
	EDXrzVdE9BmtLrw3lp3R/2uJU2JDO0U9GSoZwUbba2jQP/6h0977n2mwlbfMh3qq8e6wVTSTPtm
	u4mjoXPW+fDUQeOXZOkKUSBnp0W69Jsn53qSb5C8q/P+inHQZFdoGKVdjk/aCPd7RY7d6mj7o+5
	8FmwD+POErDzmLrzsdSQ==
X-Google-Smtp-Source: AGHT+IHuiPFPPmbN2s3t0IkC0V04CVc7BvezrJIYnrKlRBD4gxNuinh+SoIUNFQjsT6Hl+py42sLgg==
X-Received: by 2002:a05:620a:2849:b0:8c1:30f8:c881 with SMTP id af79cd13be357-8c37eb63f1emr332251685a.2.1767694158163;
        Tue, 06 Jan 2026 02:09:18 -0800 (PST)
Received: from [172.17.0.2] ([172.183.132.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a63acsm141651385a.6.2026.01.06.02.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:09:17 -0800 (PST)
Message-ID: <695cdf4d.050a0220.308bc7.8765@mx.google.com>
Date: Tue, 06 Jan 2026 02:09:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0581168530479296700=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v4] Bluetooth: hci_qca: Cleanup on all setup failures
In-Reply-To: <20260106094310.784564-1-jinwang.li@oss.qualcomm.com>
References: <20260106094310.784564-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0581168530479296700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1038894

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.56 seconds
CheckAllWarning               PASS      25.96 seconds
CheckSparse                   PASS      29.20 seconds
BuildKernel32                 PASS      23.95 seconds
TestRunnerSetup               PASS      514.15 seconds
TestRunner_l2cap-tester       PASS      28.44 seconds
TestRunner_iso-tester         PASS      77.34 seconds
TestRunner_bnep-tester        PASS      7.71 seconds
TestRunner_mgmt-tester        FAIL      135.25 seconds
TestRunner_rfcomm-tester      PASS      9.76 seconds
TestRunner_sco-tester         FAIL      14.68 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.60 seconds
IncrementalBuild              PENDING   0.42 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.844 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0581168530479296700==--
