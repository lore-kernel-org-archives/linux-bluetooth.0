Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DF38396
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552025; cv=none; b=iSLOM6X8C22/zTjWTHZgniLnngZNixLXutZGWccbi8HPIS3wcrXpf4K3OND87Fl0yNAOB9O76UmGQaV/sbRUFxzQ9rI/z0tOIQ42Cu70sZcO6CTm77GeL3BHj1oXEliS9jys2ZN5quz7RhPHppvGNaeQgE4KMTgSG2PWNda4xCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552025; c=relaxed/simple;
	bh=bt5YEx0vo58jlRSaQB+ETRwBaItBhzefJjJnJW0A110=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XAJvC65esggpK7uU70/K7eebGXA2omakDtdMyZj/cUdlTYNK2AStwgAe7twh9Q4Hh2MA7/t2hA8LAeXT1e1AZIEs6412ta5Ns+2c0NzcKhgHMLIewoj1vYowCyHwhQGgO7f7j4HDcXw9huRFdxwad/RomUV7cdc8fL306OuVW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfrudHPr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfrudHPr"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so5224042b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711552021; x=1712156821; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UBsCX2DM/XbtWg7/5i75/6SgJpopif7Pct0PHeRnecY=;
        b=HfrudHPrQpgJZ4ZyKXLz/C9RljCgwRIXEQW+p4Q7Mk6K9GQYjbRD+PAHg+6LaGrkxC
         MqfXDN4w6Lu3kXq0qW6pECCN73fZqwF4qCzyERJonPmOrnLj9/MJebqWo2P8iRkrGtFz
         VoGjvlg5ESdSgxdROZSeYfjghFDW5UiZaKwnLlDIZov40h1Iifrxh1r9BZBapY/hdCqq
         o5nopA9lLzYAo+DO82dWGbjR+TAeZS69GJrfz5ITmgc+XUBGuxvtRzi8P0jGrCAIja4A
         Y1ViMR1As3dF7xqMlSnzLTK/wSbSV4QU9IxTVwHKyBjmqvL7bTpNFODmokTKP7GVUhiO
         8l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552021; x=1712156821;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBsCX2DM/XbtWg7/5i75/6SgJpopif7Pct0PHeRnecY=;
        b=YFESThbuJxy8rlVmszLB2zPVC0zNVGV01qZiOYysCCZri2hwXt0u97VCgJgaUUIsKn
         HcZAIQIChRBVeAfGAUkm0OEZrJopD/AzCt7NNiAqvx163/LhCC0d43VOvFVgPQJ1VyYz
         9AK7JQVatau23lw3DSx0aaKiL2pJD4UF1DFyT+Lrk7Ppxo7slWwxxy4v6o1au5M81hjO
         Sv3Y7apvmW4p0KWzct84fwHQNIZJ29mQxW6q7Y1tm7xlSTJH0PpD8315PmFrer5OJjho
         iTopBzP+wFSz30zxvrn4cOwrGAF/Bq54i9TBssZGIf6veybMJvey+lNgU3iDePfr/b68
         As4w==
X-Gm-Message-State: AOJu0Yyb+UJ4EE6oSajDAiVIxIHL6YOUxhMawt/0YmhIuQxw8ByWeGJ8
	4ONBZnJAN96AtKcVNupNafyXfP6/9zeamytwRfRxHZ5IKEdbyBdPREulG4Fq
X-Google-Smtp-Source: AGHT+IFYcrMO3vSXjfGRn3oe80J/XFx208Sfz7cIhcB9JlsmuHNZ5W7VuNVboy4DVfvgEyFxAisbdw==
X-Received: by 2002:a05:6a00:3cc8:b0:6ea:b610:eaff with SMTP id ln8-20020a056a003cc800b006eab610eaffmr77068pfb.21.1711552021530;
        Wed, 27 Mar 2024 08:07:01 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.26.80])
        by smtp.gmail.com with ESMTPSA id y33-20020a631821000000b005dbed0ffb10sm9318595pgl.83.2024.03.27.08.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:07:01 -0700 (PDT)
Message-ID: <66043615.630a0220.e77cf.a138@mx.google.com>
Date: Wed, 27 Mar 2024 08:07:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3630044152600932224=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Bluetooth: Fix TOCTOU in HCI debugfs implementation
In-Reply-To: <20240327142526.332756-1-hadess@hadess.net>
References: <20240327142526.332756-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3630044152600932224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=838901

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.85 seconds
CheckAllWarning               PASS      30.40 seconds
CheckSparse                   PASS      36.02 seconds
CheckSmatch                   PASS      98.47 seconds
BuildKernel32                 PASS      26.97 seconds
TestRunnerSetup               PASS      519.49 seconds
TestRunner_l2cap-tester       PASS      20.17 seconds
TestRunner_iso-tester         PASS      32.68 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        PASS      113.85 seconds
TestRunner_rfcomm-tester      PASS      7.31 seconds
TestRunner_sco-tester         PASS      14.94 seconds
TestRunner_ioctl-tester       PASS      7.76 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      6.89 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      26.45 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix TOCTOU in HCI debugfs implementation

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
20: B3 Line contains hard tab characters (\t): "	if (val == 0 || val > hdev->conn_info_max_age)"
21: B3 Line contains hard tab characters (\t): "		return -EINVAL;"
25: B3 Line contains hard tab characters (\t): "	if (val == 0 || val > hdev->conn_info_max_age)"
26: B3 Line contains hard tab characters (\t): "		return -EINVAL;"
49: B1 Line exceeds max length (89>80): "Link: https://lore.kernel.org/linux-bluetooth/20231222161317.6255-1-2045gemini@gmail.com/"
51: B1 Line exceeds max length (89>80): "Link: https://lore.kernel.org/linux-bluetooth/20231222162931.6553-1-2045gemini@gmail.com/"
52: B1 Line exceeds max length (89>80): "Link: https://lore.kernel.org/linux-bluetooth/20231222162310.6461-1-2045gemini@gmail.com/"
58: B1 Line exceeds max length (81>80): "I've made changes to the patches that you submitted in December 2023 and that are"


---
Regards,
Linux Bluetooth


--===============3630044152600932224==--
