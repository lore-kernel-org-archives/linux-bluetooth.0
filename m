Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6080604
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736362917; cv=none; b=FVHHpImRRGTizI/piTtRAPyXSrk3a9rBnUZSuX6pv3HMchcWZmjQ8v3lfd8vWNA9ndw99pT8I4I+quY2yyMXGHfumzO9sA455EY6p1STrawp3Ze3ywHb2ixfz+8r1Wqs58ZeBvClOBUF1m7jnlmF690v36d9syee7oRNfihLIv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736362917; c=relaxed/simple;
	bh=WPn0EeE7RcTm54DQYydjcZoqeveI4PVak8YqPf+lmqo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BQmKBzDSovxhD8MJfULChPK65XaxWjTIOGYB0I/t8fl4MP3ij8VccoRyMXSOBJh65jHTFMth3WCrmfGQVt9hRv1xXxUDHvXIcFd+3o/MaX5aRFKJH5QjgVMlH3KbB6PIN3q6TL1Xrt5mG6GPS626YdyZoKXpq/lOcb8CzRG8qYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz1Qy2Fr; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz1Qy2Fr"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6f75f61f9so15212785a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2025 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736362915; x=1736967715; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=unV4Iq0+fXkmOP6N671KYSqCRvNoA1pEEush7DiOy4E=;
        b=jz1Qy2FrgZu0GpNpTfJjXAogpgy2pxzyoo2ptGT+Sg6zaxHFjUh2bNIu/rJ4oeFw40
         KZnKUmDM845rnhQjZjiHIRAy+ga+ctRF13LDJwhnPJJO/J53yzIinTIFxC9BGXZEV1kS
         36oxkFMoG2N8Sx3j3HfUR6NzQSn4f35b6S67DMUA9j8iBu5Xi3EAmVqPkLdU8DwweUOu
         iCs40IUYA3Gw10oTWCVUzNDoyS2nnjUznIWn9YB6j+Vc6cqhfQJpr7Rvd93VySruA2fl
         t92SIbaX+u01KgPhg5FVELtWvvLxx9zoVrLY8LO0dpaYcqbjrYXkyzqzi+fjD1MBklPN
         QFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736362915; x=1736967715;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unV4Iq0+fXkmOP6N671KYSqCRvNoA1pEEush7DiOy4E=;
        b=pWMDzaftLV9SRqNCMOZy+j1Cr4pTnak1gSxyTfFQLzbH9RqlPtHzysvBfxtOacZPpx
         NakMTRzvrCopBwATGAebDLloBIQEwUZcSeg+ExZCw+BjWdqvRCbrqdHJ4T46yTRRbBB9
         r84n/ER62V5Q75bTd0N6BivL5JfdFOQTFNOBINUlAt2jxXI3r+E2ZeRsXhEQ8ry6g71R
         PGfCDC1T5RC8/sQ1KDfVbKgSHqaqBWVhRxV4L99dp0dNZ9lqzdRh8z+G6C9mnwUb7V56
         fLRM4Bi8PL8W9NIm9t/RUCo1CUxYMOBIJhw8UQjR8UqrhqACCAuonK4iqlMsgkE7Y7n0
         VfJg==
X-Gm-Message-State: AOJu0YzIZH/K0M8lTe/39YGOuQP7AeG3l1DdukAQ++X8fKIBtGbiS3I6
	13gm9j+6dhyN1JsQ5AY1A/xvZk83cCOzrNjThBclOikJ5+jXfBajE7ROGw==
X-Gm-Gg: ASbGncswg0vUyTnKIjUqGUCBNADzXyEOyHkn6C5RMmkMLNJIdfVb6taBg6pajvjd2Tk
	4auW/SnYJlHrwkVbv00ez+XvGPiqFpuoKNQvxTfyTBK/7ClZ3oOw/v969TB0QoHjVdzpjWKuKp8
	Ql4t8o7ZYqMyY9GEOas/eHnF/ktwd++/0gLz18OZ7j4XkPpvSQIe/FB9NQeioipi1z/D705+gtG
	Erbc1e7Tjjk3sM1NCKpRkDQKwu0C3jUwiPX3SKg+T3EY19CebYUCYFpHgEbaUGlOw==
X-Google-Smtp-Source: AGHT+IE1BOpOuUddr1y5vV9ZPTueD14oJAuoh3+/0GpMZjIv+UNh49OyYWEbRxGlhmk6sG9xU0mpQA==
X-Received: by 2002:a05:620a:472c:b0:7b6:704e:3529 with SMTP id af79cd13be357-7bcd97b4788mr629870185a.46.1736362914753;
        Wed, 08 Jan 2025 11:01:54 -0800 (PST)
Received: from [172.17.0.2] ([172.190.111.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bb9085c7dbsm173220485a.13.2025.01.08.11.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:01:54 -0800 (PST)
Message-ID: <677ecba2.050a0220.239d6d.9cf5@mx.google.com>
Date: Wed, 08 Jan 2025 11:01:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3452607071530902614=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tcrawford@system76.com
Subject: RE: [v2] Bluetooth: btusb: Add RTL8851BE device 13d3:3600
In-Reply-To: <20250108182213.23326-1-tcrawford@system76.com>
References: <20250108182213.23326-1-tcrawford@system76.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3452607071530902614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=923486

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.11 seconds
CheckAllWarning               PASS      27.65 seconds
CheckSparse                   PASS      30.99 seconds
BuildKernel32                 PASS      24.85 seconds
TestRunnerSetup               PASS      440.08 seconds
TestRunner_l2cap-tester       PASS      20.60 seconds
TestRunner_iso-tester         PASS      32.29 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      124.80 seconds
TestRunner_rfcomm-tester      PASS      7.64 seconds
TestRunner_sco-tester         PASS      9.39 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      7.08 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PENDING   0.68 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.147 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.200 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.145 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3452607071530902614==--
