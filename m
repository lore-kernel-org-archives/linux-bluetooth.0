Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F83595A
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753925750; cv=none; b=VNlaK5H/ntu79KJYjUwvaiTx4Soma/VQrQTYzm3k0z5ZhUalKHwBcd6P+S46Pagt4SDnElVSOGM5pjwU9vUmI/va1wd6L2Ak3EEGwLLBu2SpvUA3grHWvCyGvGjUeVWrtsTXC5jxnLMnXUFQL/ki1vfTItsWIz73GRFLdqFD1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753925750; c=relaxed/simple;
	bh=MMD72nw2ckXfJaVUUzmZqmvXWygy0gbydJ/qVuJz0ts=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YfntIeFpO2uJdn+yvQ1XSHES4bpZ+UUZ+K04U0c0Debxi6Oa9GYUzPfclcpQoX6MvFGQ5pxedwEq2Qs1hhXOY02RHPrMAHyFxp8KbAY8gVpUJd1/daSr2U7KM/LzX94+aKE197hgdOJ7Ndkb7GdKCcWW3GiBk2WTHAsku/N0pZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCcRSIZO; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCcRSIZO"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e346ab53d8so47319185a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 18:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753925748; x=1754530548; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw0ipqH6lSZt51l3vtY5H5FKwaxMDPEXzlcHCKMq4Ak=;
        b=BCcRSIZOiC9P88Ivu9gPhlNgyYEmQljLd++TkCFnM0seYl2ojYeu2AItmv1dllKW2l
         hF+lIwfAcHfEb4K7Hxa0l0FWIjuUJh/ARNaEq/kdDUwSpOMpmR/1oazPgwkw32WjT9lD
         OTUkRpwcydmWilyfdnPRSorjQ21iCHwjMn5/wOql+Db+WGVtje5frXSM4sFj+OHv9Dm2
         J85VoQiu0KusHJ8JwAkEypAXL2k8M4Xv6ys3KpHxa48lzXGthGsi0Zka9jZWDGJdiqK8
         Vz9XubSOetBgteW4kkGpcV3nOJgAEMd1UQ0oOYJ9PwZ3OgWXLYaKb1GxHyN4aqXuu6xI
         P7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753925748; x=1754530548;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rw0ipqH6lSZt51l3vtY5H5FKwaxMDPEXzlcHCKMq4Ak=;
        b=BVv73r/XKwL00fM77PDDUjzwD113D9ov5QcuFPnZKZhOF3Nm/i2deeY6NnKMqK2iKR
         TWh1GzMQhOxxi1QrYms2KS94KhL+R4bYG1iMGnoKJhpZpCAF3k/wa5o5QDErvF3AzN2e
         C8j0jy7yY3upgvYvetMHkgSyfqxbWf5GXEHgJclF4CZVYrxhGwLEsPmSex+BzT17oIYw
         taXt6Jl6hGfSz1bIkvQI/crC5b0/HN+x6yWk7QABLl9nDrl66KjVc6366qcV6PRJNi2V
         qrf5IbjdibWQex546Hu6zx73SwXMD1k9zV6pXzJ/kAi1eWjN3Ut4MhwGEWZ6f1prEWWI
         wVOw==
X-Gm-Message-State: AOJu0YyzmXZsLhUqgUWlf/iFm9vIE5KyAdLMySCyzeICY0hBmqrViJG0
	mu55weUmspF+rErIFtfLsl7DQXLhrM+G95nWmUkqcoMldS5Y3DgYB9G2lkd1yA==
X-Gm-Gg: ASbGnctACqUgQ5Rgv4GiBm/lmBynTAHLt7owE5PNjCO2dXgSa8XAdn4o87DYkQI2tmj
	Z2DFa7PFK1E/Wked2hSPABrxK8XTCH0CYjZPft5A+2XFb1MyWHB68ypjNo9F63dIeCoscT11erc
	PDJfjweIrA4PMA3qZtVn/y9TcwIuW4+AqCCrkhu4tm/ArlspC2/V6QfZ0RKTFsTb0WI2FhGzdM9
	O8upSBzwx21JqQFPVxK29qpz3k5irAY6qoAJ9N/+eYSdYG692YAko1n4M9LMOddBE7h+d0C3O0+
	AwOJNrIckLJGBrs9fnE9oxOOUOhwI9otQq6qaS+fv5UIMEXw5awVP1DQKVNEOj2i8ILxa8z0+XG
	NO0kGLNUwfYJ0DkGFzDDLHm2HYzbBLQ==
X-Google-Smtp-Source: AGHT+IHkshcwkCvXoYbDLoUpTMqwEaXTtcHL2w5scE7vTSM6CYguwzC7zFaGYFWRxxFv7Pp3P46VQw==
X-Received: by 2002:a05:620a:a111:b0:7d9:cc83:7476 with SMTP id af79cd13be357-7e66ef7f8a4mr647822585a.11.1753925748013;
        Wed, 30 Jul 2025 18:35:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.45.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5947dbsm28014985a.12.2025.07.30.18.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 18:35:47 -0700 (PDT)
Message-ID: <688ac873.050a0220.2adf0a.0d47@mx.google.com>
Date: Wed, 30 Jul 2025 18:35:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1512877443901241421=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, salah.triki@gmail.com
Subject: RE: [V2] Bluetooth: bfusb: Fix use-after-free and memory leak in device lifecycle
In-Reply-To: <aIq23OWDy87D5qNv@pc>
References: <aIq23OWDy87D5qNv@pc>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1512877443901241421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=987200

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.06 seconds
CheckAllWarning               PASS      27.79 seconds
CheckSparse                   PASS      31.32 seconds
BuildKernel32                 PASS      24.63 seconds
TestRunnerSetup               PASS      477.73 seconds
TestRunner_l2cap-tester       PASS      24.70 seconds
TestRunner_iso-tester         PASS      36.19 seconds
TestRunner_bnep-tester        PASS      5.92 seconds
TestRunner_mgmt-tester        PASS      127.69 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         PASS      14.68 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        FAIL      12.06 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.27 seconds
IncrementalBuild              PENDING   0.60 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.133 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1512877443901241421==--
