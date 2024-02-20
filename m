Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B046BB3C
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450385; cv=none; b=XYH168bIH/YfpX6FelDfK5O4xpe4SReTYhnbXZjP05P5a2iEI1/J7BjiBauApYgfyO2PbtmDnfGxC+XKET0BRINu68jtqSjhm2htYe8JAmpC4GbHR6h8+tJXKY9GfXXjNw/uuS1kvgzSekttXd6xS9JGAXSOOL6N3q6gNGbHfnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450385; c=relaxed/simple;
	bh=UATUBa4GtkxqNeCyBJ8IxzvzbRQ4rFV00ZP8Z8R+HTA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XRUNPpWHrDYhK6YVtjWf97HMZMaeZuyoGZlMrBup1SVaYKNs5rJN69hnWD3EBnlKoouXdoiMbNcM+ttBWuxnA/uHzu8ch7AXi1IeYdM0scnJrgZyJhijA3Cc8twY9gWFX1XyNWspCQZCHga+sCP/shJg0NhqYmqgMkHOVh7ERjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i024bjCV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i024bjCV"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-785d60ae6d5so378002285a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708450382; x=1709055182; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EKkCW8PQ9LvoCa7MsCSa7nBMjGmSoXVWkqRRJp91aBA=;
        b=i024bjCVj9TII+9qrxBJ/uoitEPCbluC4Pu+EYxMQfPehO2KUS+A0gkAmFKM59PFxr
         iLgxyMbORkgk8v/7FGhPKCp2nn+R+et1Wny2PTSbU/j858/7KhVWMKmFHu/XqgrEqV8N
         KZrt4v86N92fxfSs8BgtAWMIMW7/XYF2KW1J45cCWJcinHEcfEn4FnSeN/60+RW0Xtoi
         mcnYNNcW+b6AX6R0r9uZ7U9nuEqqgPTYdil6SR+SMOKeQNWfA6jh0NP5IAvgUpYzqz8X
         QaOW4moWN/2F3rn7JbvS2Tzgt9nhQSuI6af9YBIbPTgTzbyWXtUnMas3J5nstojJuSad
         DIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450382; x=1709055182;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKkCW8PQ9LvoCa7MsCSa7nBMjGmSoXVWkqRRJp91aBA=;
        b=h3fgbUTbTnxPGKzkWCtkEt9UtxhvnSELo6w9l/pFJCpR5cqxHx5+Oon0Zxvx8tU7Hg
         X60hCa+f5ntKIGW2eRV/ewLb0aLGEUf1wHOt6f6+yZ5K/QUzoEZD2O6cdqU2F36kE5PR
         exIBqpQF9LswA82xz7ocYHXL2UTFgiIWgkFqd1voPRwH9qrBt3NAh4A0ZCjj/98VXHAY
         jpg29MJPNbTkbOyvE3eH4rODzD/BYlTIbJxjip85J2NH3S93iyg0SlZO6OXAWqIOyQW+
         U5hM92K/lCa03/n9h88abLFgI33vkdJ/WKq5PpEwFWPf/0yQwjEQ3woJO7wIYikZXAg6
         dH5w==
X-Gm-Message-State: AOJu0Yw4LSCt2Pmc87wVTXZUyFnbrOWSPFCd9PDRVO+tsioX3AG5COVA
	SmHfGIB41DO73jAQCQ+g+JtXqUvsA38WmSaody3rHowl9rQBpoPKL99R4Dt1
X-Google-Smtp-Source: AGHT+IHNPqPXkdZksWnmcrrckNPhGyPr+5Ee9rEJvhz1CuYV4Wrvc+JpCYATnGyDnIJ9xpZ4nsllaw==
X-Received: by 2002:ae9:f818:0:b0:785:dad6:dc30 with SMTP id x24-20020ae9f818000000b00785dad6dc30mr16486168qkh.45.1708450382021;
        Tue, 20 Feb 2024 09:33:02 -0800 (PST)
Received: from [172.17.0.2] ([20.109.37.5])
        by smtp.gmail.com with ESMTPSA id d17-20020a05620a137100b00785d574168csm3559381qkl.4.2024.02.20.09.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:33:01 -0800 (PST)
Message-ID: <65d4e24d.050a0220.b8558.ef06@mx.google.com>
Date: Tue, 20 Feb 2024 09:33:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1834520923365748581=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: [RFC] Bluetooth: ISO: Reassemble fragmented BASE
In-Reply-To: <20240220163531.2900-1-iulia.tanasescu@nxp.com>
References: <20240220163531.2900-1-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1834520923365748581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=827921

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.34 seconds
CheckAllWarning               PASS      31.40 seconds
CheckSparse                   PASS      36.48 seconds
CheckSmatch                   PASS      99.30 seconds
BuildKernel32                 PASS      27.78 seconds
TestRunnerSetup               PASS      507.72 seconds
TestRunner_l2cap-tester       PASS      18.21 seconds
TestRunner_iso-tester         PASS      31.13 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      166.83 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      15.06 seconds
TestRunner_ioctl-tester       PASS      7.92 seconds
TestRunner_mesh-tester        PASS      6.02 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      5.21 seconds
IncrementalBuild              PASS      26.76 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 2, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.123 seconds
LL Privacy - Remove Device 2 (Remove from RL)        Timed out    2.779 seconds


---
Regards,
Linux Bluetooth


--===============1834520923365748581==--
