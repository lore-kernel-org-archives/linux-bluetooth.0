Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487C156677
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385088; cv=none; b=duReZbfZ18y8K4EfmmKbABvgvPlYnc+OUYM6rlV442m3MYoEqA1mOlp9g4DhQryjfKaKVHNkdhxxFAEPbt8jr7Hshe5+Ie5C1G3DWV/WXDJhLUrOirfTqxR6P1DFIn0DCBL39lq9XFLMcew8lepQt9ufTLDZma7Oxcv1I6kJtg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385088; c=relaxed/simple;
	bh=nXDsJvKF3uOrl3/q9YMnEq/ucsdNXxbnLkr0PbWpVjU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nZLPeQhz+I2v/TFjeW+lOF83d7P/MPQDLhoGNM6uYr0cHEJ27PaIt4Coko6fJM721vSMssgk33LrYFBs7oDETJXf9O6kHxvTXAoY3OeaMnols3Ld/eSpGhESrPJiTpOQSnPmdFR5k8vzXsxY6rmPxwbj1StUe+NN+i2rreXDT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RffdVfTS; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RffdVfTS"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd8576a512so33115985a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774385086; x=1774989886; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf4JolZV2qS5sIU7luMVOevrBkfNs2udbaj9g6YhH6Q=;
        b=RffdVfTSCseb9ZhDLu78TrXk1CTa6ywBVILd4XplEmFlYrFEgDZ/CxamkVgilWKrk8
         c1b9hxPO3sIAT2tNDZEeesnqPbkkcq2gHNOqcUZJ0NdlFcbjRD+9F8vqTy4WVzATrWGT
         vXdp72WyknP7F2XC+CzmiZ6Y2FV0wS3+zO8mxO/DPi/HIKoIGHSMhgzc+t0oOTLvZYej
         yvAm6wmqCtX5u/lUSFR/rvzTGEr/XRxPtRP/2qs78MGwy64+RDDR9K7EKL67EzRAUTSF
         3haTpi5V2vB4+jv4O0rmyNBFovbrgyA8DHsg7PrOYv60NAVT6AwDy0BcgmbinrarkvMg
         8bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774385086; x=1774989886;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf4JolZV2qS5sIU7luMVOevrBkfNs2udbaj9g6YhH6Q=;
        b=IywIbeOaixaobZ94mXMKfDoCp+7ovmprYqXsuj2v7oxBOWSBIo5c9m55GptMCtUySj
         HVJJo4myGyBJxN0llj2v1GaHFmQDxPfwkeIdE9eEXiCCN1WqSMAWgWti3Tajq9+DdXdH
         jpiqAxr+YXYIq9/ha/s+Opv5bDX6bRECDmPzbYYrptZ37H2Q6kDz/ArIDc+DSbU34GCZ
         EQGlq1eUTk8qKjzjKJHD/CoVfR+dc+1p8PY1oA7GBjRHA1lDTykt3bva6O9mSfLTI5mX
         UfIqiG6jM8U9X7mggleqKLGW6xSECPiPO5EI/iZ8KTTSRsGlDGzpOSXFs54hs68xOdRF
         SmGQ==
X-Gm-Message-State: AOJu0YxwIISwmLWm0fmhkWMviX7DshfkztBcOh2+WGIyZWZuUxyfGeVs
	qkHuKMwvVQZNdbtWY8hacqW4LK3c3d5z7X9qrwSgocC1WF7+Fa4nxRW9rxgMbw==
X-Gm-Gg: ATEYQzwQ/DSTxEjJKns3/3O4QNQiu7nztKh3agi6YxR3l9GB0v71H+34l6Z+CoscYrZ
	s17q8ThBTTysBFmTcyZWkStrw5IHOLqIK4Zf5vHJoBBa6g//uzBFypAtYT/GQAIexcP1Acgu4EG
	2x2+gsP+SH4LACiyAbhKds86gxM3rRwMc/ld7OM5VkqNTn1L5nPsZCMUHTiPPlPvcEpPgyQji8c
	8yHNpAI8QQgxTeLFlEcVQOXsiR82ql75KS0SgCMd0VWJiwIijyiBXyTQwGZI42N+Cvp64odQQQD
	zQobO92RU7NwLuX6o78rW9aOBbf6pj6IKqL7fBhe8SgBCRLbaYSOv41qvZkZYXmA1qxeC7AKLV4
	BOnC+JQ9v4S43QhOqj0HyvNRhErcZJXfNcc/0pcLWFlfG/MUh3Xo7jBhrebImZ/9TiKWL9/YUWk
	oN3xb4xLMtkCjnrbB84aAG9oW481e/
X-Received: by 2002:ad4:5de8:0:b0:899:a586:2923 with SMTP id 6a1803df08f44-89cc42f9299mr17403116d6.28.1774385086205;
        Tue, 24 Mar 2026 13:44:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.237.143.51])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c852555a8sm127951286d6.18.2026.03.24.13.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:44:45 -0700 (PDT)
Message-ID: <69c2f7bd.d40a0220.1ab7a2.03c7@mx.google.com>
Date: Tue, 24 Mar 2026 13:44:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4613188161377020927=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/9] doc/btmon: Split Advertising and Scanning into btmon-advertising.rst
In-Reply-To: <20260324194946.109349-1-luiz.dentz@gmail.com>
References: <20260324194946.109349-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4613188161377020927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1071883

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      17.80 seconds
BluezMake                     PASS      613.03 seconds
MakeCheck                     PASS      18.24 seconds
MakeDistcheck                 FAIL      49.40 seconds
CheckValgrind                 PASS      275.57 seconds
CheckSmatch                   PASS      307.47 seconds
bluezmakeextell               PASS      165.34 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      891.00 seconds

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
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

../../doc/btmon.rst:758: (SEVERE/4) Problems with "include" directive path:
InputError: [Errno 2] No such file or directory: '../../doc/btmon-hci-init.rst'.
Exiting due to level-4 (SEVERE) system message.
make[2]: *** [Makefile:12166: doc/btmon.1] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4145: all] Error 2
make: *** [Makefile:10665: distcheck] Error 1
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1986/checks

---
Regards,
Linux Bluetooth


--===============4613188161377020927==--
