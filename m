Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AFC155A4E
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364272; cv=none; b=LysNQF3vzEl3TCxGZwdX7Q+tIlzxGNi4Sb5I7beJ45I1jnlXLhFbuVsY++EYdjVJSM9Wr8EFCTlBK6UhbPKP+Lcg4QW7mW0qiysXnpodQzd5/BmcAHlNXSCpj9DD7IpEAXEQ0ALNHXH/7rNj4M8plBYou81IcUXP7zqXIy35mvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364272; c=relaxed/simple;
	bh=H5hbENVFy5Ch8/xgONfyuEKuXbFwuXEtR+z3y/wMrhg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iMj+29TCo/7uXaLhwmcu4QXKbQOvw1AFSefwd01Dr5U0ZjExe+z6OzSF2n4PB3KTNKBv8LU4gAYkN6ImccPMV3iZXYGPUrZ0FEii6N9gO7kdm3DB2QwzYk5rygS9xmRS9AxuS3yUIkrEhoM8FXp3QvLiQAE4USyYSV6yky/nkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAgMdh4g; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAgMdh4g"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0025ef1efso24569805ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711364270; x=1711969070; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=02+3Li9fbd/fWl50+vNHZR/csBnjxy1XU4VU6Ui+H/s=;
        b=SAgMdh4gfE6Ib1Y5JBS2oxlpuitlPwjFI/qjd+rnOlkytVG4j6OPLEdSYoyqJWiC7A
         emflLUyG/aZKzWgh2h+Zpw13Oe2O0onGm8AioF8MK6SV5Vs6wO0k6BksVFroBZHPr9Bb
         +wqNiVnU1vIx1D86od5RO3nG0PFwjiz+y/n1oTNsO/5ERqfpx1riq/wPtuhVE8KLD61q
         jE5dmx7pGXm3hwpslxn0jIwiwBJkIJ6sLqvibNtj6T0+/A3VGaO6J53pUaPXZGeSZ7x8
         Zl8IHx996JibdgXwGhrzXJyMrwcSghJrzVYeOc1mDNca7ccyNtGtvGYKiEpkBCL1gArN
         6hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364270; x=1711969070;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02+3Li9fbd/fWl50+vNHZR/csBnjxy1XU4VU6Ui+H/s=;
        b=dYnslhK3BdDUNCVvCA4pgFVU+J+sbvyY7LPlhsCRyQvLK1kLUplcF09+LIMDy4fHCu
         3LF2fl1k7+McC7RFfb1ggWPuTYFwKpG1htFuhIir3jT9UHDkDCGNKwYvvdxTWFH9KG25
         z2HreUbDeK7MkQqn7RMn4TzEAF+eXlEZX4LO8T7hb8+bcbCa03xqz018zMcDm09Lvfxq
         5uroEyl3dMVOtLLhGFkOz6NZrDa+5IvlhXgr6USyqpn5a8Zru1XTR9/Sf8GGRmco+XeK
         zt+jBzd1ZlycaeQb9PpUIsVD1PfjQuu/wYRdhxLOStQMDHBO4HyOyeHGmusUgxNSH/z6
         kuYg==
X-Gm-Message-State: AOJu0YzxLTbCOwUcPAWbs65khTIA5h2GBUuUHp+JV2Qv7L9idvzM5HZF
	PtNAmr1ndbvt53/CVxWN1qyg3pYu/TuOGKN1fiWfHHZI/qIljezRw0IPAoMu
X-Google-Smtp-Source: AGHT+IGLHiNekOs6l/l5LzDm5QyaAAn8JKF3p9ltx7GcGXtk+x+z8jYECeDheGw0tFKZO5kHUEtICQ==
X-Received: by 2002:a17:902:ef4f:b0:1e0:a731:ea4d with SMTP id e15-20020a170902ef4f00b001e0a731ea4dmr5921208plx.62.1711364270038;
        Mon, 25 Mar 2024 03:57:50 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.69.162])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001dd6958833esm4434294plk.242.2024.03.25.03.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:57:49 -0700 (PDT)
Message-ID: <660158ad.170a0220.fb33e.a4f4@mx.google.com>
Date: Mon, 25 Mar 2024 03:57:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9210060162679836990=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2,RESEND] Bluetooth: btusb: Fix triggering coredump implementation for QCA
In-Reply-To: <1711354309-27605-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1711354309-27605-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9210060162679836990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837786

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      28.98 seconds
CheckAllWarning               PASS      31.31 seconds
CheckSparse                   PASS      36.60 seconds
CheckSmatch                   PASS      100.76 seconds
BuildKernel32                 PASS      27.90 seconds
TestRunnerSetup               PASS      526.29 seconds
TestRunner_l2cap-tester       PASS      18.03 seconds
TestRunner_iso-tester         PASS      30.78 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      117.35 seconds
TestRunner_rfcomm-tester      PASS      7.38 seconds
TestRunner_sco-tester         PASS      15.03 seconds
TestRunner_ioctl-tester       PASS      8.02 seconds
TestRunner_mesh-tester        FAIL      6.13 seconds
TestRunner_smp-tester         PASS      7.42 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      27.28 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.643 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.108 seconds


---
Regards,
Linux Bluetooth


--===============9210060162679836990==--
