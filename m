Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3508831715D
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136891; cv=none; b=ZWjXAW5ziFv9uLBSQ7RAiaYEQZVilQKkMxIL+qsm5IbV+ospA2TB/cGemnEO6CroTXszT276nl4ZxeT6/7rB0Xo4PY872ibYNvKfbF1XWPuqRHXZHcKDk2qEd4TP+Yp3P4BYaQtCg1s4ZwUhQSoSYAeF3uTYmEGgyQCjB3o6Kjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136891; c=relaxed/simple;
	bh=vwKuPBtHmsqc//vcg2dplLlX2NsanGCBhsv3Sk/MJDU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C90iycn5AVgYhscWumyfCH25sDDMi2ZAWs8j0uG+Jt8JiRBayn/qYpP6H+JzXfDrLd+POLTUHUoePPV1N8vzyWkOGycoSX/ZJ1cfgXUWGvHyrUz4d4wvMXH/pHZ7MrWuVivY3f4lqzQz6KIpGnrk+QYYhLWELkAvg27WESaCUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwdlfRuz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwdlfRuz"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9399d91ee7aso115320985a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789136889; x=1789741689; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=skFH01fvQlHPxbzDeE8F079A+6FUBkYQGbVSMNbaynA=;
        b=gwdlfRuzBMbUL+6jph4+U5driRzXmfiFcsUjDYdckW5XQdh+Vcl+n6dzDdUbkfL7LI
         9cs0V45m1M5BpM4lXG20yBZSmf+mk2W1qdLT1/+ULpDEMLJC8abq6b16Hn9mQtyQbq0f
         M9ADXLbmxIgtNqbQROFs1SXZ6kOVxmgYMsigiFCOiqc2rK/9Np/NPmvCokMejYEbzXDQ
         DDZXxE/hsSlq+zKAPvy/zuH8xh3lH0nZzxbX8F3tvtUlEKauGSqOgJAkfd8N2TWpVAVk
         /1hTbgszdPFd6UwfO0lCNt+LNUv58KvSaZgsdSs/ho2EIaNFk9AwvQjig+SfkfpJLsTi
         hxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789136889; x=1789741689;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=skFH01fvQlHPxbzDeE8F079A+6FUBkYQGbVSMNbaynA=;
        b=nlFzeZvzqd7abvBm4A5nkQzLufTnb0IKapbd8X1dNu5WEKhwVS1LFZH8BRpz1ZmmRi
         NvEQshgGDgtKCSYHnmk6vcKowKVk1WoI6gtKvX/nCvdadgfXUA7l8UMQVEYX9NNO9vPg
         fvPlUj0JMeOhOVSmiRlEyrQ6k548vmqlC0QP1Z8VTs8pZHVszypeDcKIkqCCli39Y+OP
         ATPDSLRfpW+KOciWwIROUe1Y3dmj74Aqt0ErrdT/OPtw8WnNt0ga2ujyCJWAbOvRoV4M
         WmzeFMviYZsu4GLPbvxaZAB26giZZU/T7iz5suSm7vkBPTJwOMG4EAk8t/NzVhVIZOkL
         OtBw==
X-Gm-Message-State: AFuF++nXsnE5H8B0P8YVQ9vaO0Ins2a4+Vk0z3ny2sxn4sHAvubdcuV9
	M9Jbk4PsDf+JbEvbutePHfzPoBn6zq4asO+mSkos4/I9JCnZZ/AumBF9QJDKXQ==
X-Gm-Gg: AYBFou2LyzXpYlc5aV3ZQPvVu3cBQepQDY2//r00Qo4N4WxXSkUT8Kj6iZVKmLZYqF+
	SfjBkVnFtRxBdqUVkI+hzOrU87pLBju/u9I4+py3f60aasq3XsigwkZdMT8oynM0l1JTEUuqhLL
	39NfVwu5AT9b8wSv1ZUvheBJmQNpsrby0tx8OoVINVOXybh/HMN5c9ecN5s+3eU/N8f4uBMYtBI
	7mPOD3Fak2NTbcKFqJjET1BJlEG6l+NJRGWPsJKymtzyFB0jpK0LhTp8S/GTT4WZslLW5cOTMbg
	QyJYg4TIqgfELV5YefqE3iEtktKy45ji9LBu5J1rDRY/UngM0Ivu2xCfmAG3m29+rCtWkaCAyPI
	DHoRUOx6WH/e+tgoNBok8FoInydgXd+tJBXAl6N4AiKjYWn1VKA5XTQsQ01ABDJ7ip8wJCnbZ/x
	35dG2oh3wrcf2byDzapqzOtr01/hu+xlayxmyqkW42nmbuv27PXKnrRXXZw5jQ5msmUOMG1RTTl
	FoaPI8=
X-Received: by 2002:a05:620a:3902:b0:939:7c5a:23fd with SMTP id af79cd13be357-939ea0722d1mr576857985a.47.1789136888784;
        Fri, 11 Sep 2026 07:28:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.93.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80e4c36sm254525585a.40.2026.09.11.07.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:28:08 -0700 (PDT)
Message-ID: <6aa40ff8.0ea1c686.34ff18.80a7@mx.google.com>
Date: Fri, 11 Sep 2026 07:28:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4303612649154656578=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: fix off-by-one bounds check in RX submit
In-Reply-To: <20260911115222.7651-1-aluvala.sai.teja@intel.com>
References: <20260911115222.7651-1-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4303612649154656578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1162859/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.64 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      22.29 seconds
CheckAllWarning               PASS      25.07 seconds
CheckSparse                   PASS      27.92 seconds
BuildKernel32                 PASS      22.20 seconds
CheckKernelLLVM               PASS      24.23 seconds
TestRunnerSetup               PASS      569.71 seconds
IncrementalBuild              PASS      21.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: btintel_pcie: fix off-by-one bounds check in RX submit
WARNING: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")'
#86: 
Fixes: c2b636b3f788 (Bluetooth: btintel_pcie: Add support for PCIe transport)

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14808199.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/754

---
Regards,
Linux Bluetooth


--===============4303612649154656578==--
