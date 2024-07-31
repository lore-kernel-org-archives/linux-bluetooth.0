Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ADF168B8
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441517; cv=none; b=baQsEdXXEV07CavU6hmdjGnbYgdPXuNy60PR2U3AzZlv+QWFg7DzRhVEkBAs9ly22BbI0zdf+bRcWS8ZqJOEiZLBYTSPCiY/x+rJ6OIt1oTWUtmMViqwg/1lPtUH5qJ/16qhDaXXdYDUYnLPxfgAmWeNVX0MKlO4D1U3oSTBR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441517; c=relaxed/simple;
	bh=X6YiIXwe6MQBBoOLr7xM2Us3VDnLATtwS2wiIiYMfnQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VfREEIflKaCK70VLrhY8ur9NF3GXjVwBd2xVQJT/xadWWlHhvvgLGI/v6tLJjxVvzpJ/AOT+AAyMpVsdAJT12qz7icOjAqXL3JR/0qDIO4jsdnbs1TwkcU6A8Q2l8za7Lnov7kXnV44NrVVuPSeuLSLAJZqDbGUcMhTOtzgEvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4ae59QS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4ae59QS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd9e70b592so40663355ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722441515; x=1723046315; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OtY+x5vQfBzz4286XJrUZufUt1VANHOslEQ7SKHr6W4=;
        b=Q4ae59QSLTsfhD7r4dpp/9sNmlKsKyYFwwFgo00p9nrO9ro4s9LveHsMCpqk8ZszS8
         J9WFIDSvbW6FymJPOPhNjBcayNPx9T1XCT0mZobOKmsRG/EIJCAgU8CLhKbEv5P7Xrtc
         wBl4vVba9iHFu55Nok+jKULC+xBRBPqRP+5zWluTeFe6oPvZy2sNlLLEnsmDf0yqOtiE
         3aPQrarHCBMaXxhealcJCzE5JXN+8CCeZp4ktsxZV1ADPxYgol/z69afSOPujcJ1Q9ZY
         9BoKJRwVrrH3mBIv1SXig6xrsGd2ANsR8UDFV1qXdKxadi5Uu6UJ5kD713G2rr+LzvWE
         b6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722441515; x=1723046315;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtY+x5vQfBzz4286XJrUZufUt1VANHOslEQ7SKHr6W4=;
        b=FWY/gLsrpGxsF4IEQnsyFo0XseKmFysr6qNnUQoGE6lgLx/ZN8efNAph9K0MH/Zfe2
         82wwPTlSRqOqzb2PGHs4YT0N6VwjJ8/y0c7tvDEEtVi5AeWtA82n15axoX6eP+VxCE4O
         2qHTW6fxnAw2+JNLAKwxS6GK9jz39T7OWyue6mFYgXwWkT7PPXR6CBULwPsNdHV42nTL
         w5Y+/TDHlrF4W+mrO5uYeJxiIYPgSa2l0MG/frXqMAgu157CoVW4V9rWV8lkYfHtKEU2
         tbhTwMh/XQMdiN4vMlTK5XtcFdISdM0Lp2WyWN/YKCkHSTLHqepsYMvPjkPEmFzIfSjL
         YWDw==
X-Gm-Message-State: AOJu0YyEvrglNTdiEwws/jjsb1XJF6LcSG+gh0N3bb9HD7NBMYf8FfKh
	VtzGAUiKeFmNYeaAQZEXGIWYlv4BW7W2TGAteRzjasUWRo4IqYrMER5mCQ==
X-Google-Smtp-Source: AGHT+IFD9wT30OsnfvzThUdPALh0Sr4lra6X+P2kKSshlzvdonVv7YVzMhl1lFk8CVoTSYDDDp4gag==
X-Received: by 2002:a17:90a:1786:b0:2ca:f33b:9f26 with SMTP id 98e67ed59e1d1-2cf7e606caemr12766562a91.28.1722441515479;
        Wed, 31 Jul 2024 08:58:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.29.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc42595dsm1525808a91.4.2024.07.31.08.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:58:35 -0700 (PDT)
Message-ID: <66aa5f2b.170a0220.15cb2e.3d91@mx.google.com>
Date: Wed, 31 Jul 2024 08:58:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7859804283173045658=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: Bluetooth: hci_qca: fix post merge window regressions
In-Reply-To: <20240731-hci_qca_fixes-v1-1-59dad830b243@linaro.org>
References: <20240731-hci_qca_fixes-v1-1-59dad830b243@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7859804283173045658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875539

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       FAIL      0.96 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      29.58 seconds
CheckAllWarning               PASS      31.85 seconds
CheckSparse                   PASS      37.57 seconds
CheckSmatch                   PASS      101.64 seconds
BuildKernel32                 PASS      28.46 seconds
TestRunnerSetup               PASS      522.64 seconds
TestRunner_l2cap-tester       PASS      20.28 seconds
TestRunner_iso-tester         PASS      31.33 seconds
TestRunner_bnep-tester        PASS      4.95 seconds
TestRunner_mgmt-tester        PASS      118.54 seconds
TestRunner_rfcomm-tester      PASS      7.55 seconds
TestRunner_sco-tester         PASS      15.12 seconds
TestRunner_ioctl-tester       PASS      8.12 seconds
TestRunner_mesh-tester        PASS      6.09 seconds
TestRunner_smp-tester         PASS      7.09 seconds
TestRunner_userchan-tester    PASS      5.13 seconds
IncrementalBuild              PASS      37.81 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[2/3] Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B1 Line exceeds max length (102>80): "Closes: https://lore.kernel.org/linux-bluetooth/27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org/"
[3/3] Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (112>80): "Closes: https://lore.kernel.org/linux-bluetooth/su3wp6s44hrxf4ijvsdfzbvv4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j/"


---
Regards,
Linux Bluetooth


--===============7859804283173045658==--
