Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042BDF5A
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710297640; cv=none; b=GhRPvwJr9tY2xh4L8DzwP7VnAkAX7etDaBlyvnkFJRP/HQVYxKtU6RtIDjlWt71HgmPBlYpCXRaGOtqU6dI+9Hh5URUPhaXojmsWswa01FlnZ/+dlK3nhuZxOUUdcwQeHpCdnFX7dsblR6knNjNdViJWwTWPOIRu7nU4ksjzHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710297640; c=relaxed/simple;
	bh=SKq/IJv9NISXVWao7hSEh1cDXLDN0wDuI4SG7Pwuegs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tVjlMosEQA+5MQsREwacHB6xnOB1vxiuVUq+qdApOmXC0632lP5spMWIuPSr2tmjG3JgMUZKWn+CqYsdrcTh1NGto5sdkcKLrxs0cEB1a2yZZ8eajLQZlQ0W4shller1K3UtpgMRViWPW7WHag2GlrHSQSHImBa8+rfxIlrPy9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdmnTgVp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdmnTgVp"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso5127634a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 19:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710297638; x=1710902438; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u/nqQhCzxSzrh9re8pahqnLqJ6CjS16Jugas/c/+cGE=;
        b=DdmnTgVp8s6tzaO+3xIynlD4EA7VTyAY+nJO98UZtw06MX7JccehtZ4GXsUpBynD+F
         lLmDKy37nwLRkUDCBJN93ici9ppik6owEnDKcr/MriNRj2lsSxJcSMo+5XVjrvgIg2Bz
         3CJqNiuK9PrqQWBIZRylSKC8wPzoVgW6SZfolt9jUGGl/pOunC9Rowu/xDWEciFTctXm
         ftE6afZQ2DjtKuJz53+XKoXlyJd9cOw1J4iF69femVgI2ZdhAFUj+wr5rUM/PSFtKyj7
         VuTvS+cj+Kr82mfbPKX44TzTchmjyicD+3KwQUqwDCSnkamhRYcKRbsGLdqnfVMdhR0k
         4fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710297638; x=1710902438;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/nqQhCzxSzrh9re8pahqnLqJ6CjS16Jugas/c/+cGE=;
        b=q4NCQQLuo9wIbd1PiHu7XtNaUodVPfA4QT5/xFsB3YE00D0WyxKvRZu8z1A47ms9Bf
         WE6QkzOkNarSQH3UNN1HYrIUSTDNl1EawI6Y6ZauVnQvKw1bodrq1jl8CXCzdIioax1k
         kH57bUG3KcnJO6lDH5d3ScgllimNVfB2zhRRVhJAXlgLZdz4xB8WhgDetBmbXtHyg/ZK
         jYPquOVHPDGjZ7edWURF501S0dqlxDLZ57b1CfPXvX7E+AU7AOVkj4O9uWs3f8laDHSA
         HSdQPQMwfQsv5orPPi/GMI4daqKebPnMpSIUQYY8lYEf4QA6S5tnyMGdMjLwurnZ5ega
         za9Q==
X-Gm-Message-State: AOJu0YzHnSzP/BtNjWB2OBeg7EeekhIUjcBqRfhDepEYwuJVDVMot+/W
	X07JX/wyDAiYvQTM7lf2wNAHPz5VXq2w1OdlT0ohUXfo9lN0lcWmheQ9KIw2
X-Google-Smtp-Source: AGHT+IFXehtQN8lyoV1Yz4JJF8ubPEIWiIzEewN0OlrluXwXYPs2L/lgAP5iuzSsDLYn7CSLcJbzTg==
X-Received: by 2002:a05:6a20:43a9:b0:1a2:d991:c020 with SMTP id i41-20020a056a2043a900b001a2d991c020mr14499016pzl.17.1710297638581;
        Tue, 12 Mar 2024 19:40:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.24.177])
        by smtp.gmail.com with ESMTPSA id ft15-20020a17090b0f8f00b0029b3c08508dsm481742pjb.1.2024.03.12.19.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 19:40:38 -0700 (PDT)
Message-ID: <65f11226.170a0220.3e0cb.0e8c@mx.google.com>
Date: Tue, 12 Mar 2024 19:40:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0645296389336292349=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: [PATCHI] Bluetooth: btusb: Add return error code
In-Reply-To: <20240313015914.422751-1-youwan@nfschina.com>
References: <20240313015914.422751-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0645296389336292349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834820

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      27.63 seconds
CheckAllWarning               PASS      30.16 seconds
CheckSparse                   PASS      35.78 seconds
CheckSmatch                   PASS      98.70 seconds
BuildKernel32                 PASS      27.09 seconds
TestRunnerSetup               PASS      506.60 seconds
TestRunner_l2cap-tester       PASS      19.58 seconds
TestRunner_iso-tester         FAIL      32.52 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      110.86 seconds
TestRunner_rfcomm-tester      PASS      7.33 seconds
TestRunner_sco-tester         PASS      14.91 seconds
TestRunner_ioctl-tester       PASS      7.65 seconds
TestRunner_mesh-tester        PASS      5.81 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      25.33 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.176 seconds


---
Regards,
Linux Bluetooth


--===============0645296389336292349==--
