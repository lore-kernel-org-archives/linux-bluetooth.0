Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946AE49DB8E
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300625; cv=none; b=O/okRiOXtv40U1MgO17xHQRAyDrUeN2Q6w0A9sTSzEwb2o7fUb8MqNQZPN3ekyzUtxR1WjYrmZt3zVyrC/Bv7xU4FXlatqFEglxOvbVNG9M4yf6TVNPgzcTQX/BHEwOrLwt1lfxeKELpVf243mdS3GESpma9VAgdyRUiyPzX/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300625; c=relaxed/simple;
	bh=y34n+DNTehIpH9UapifZ0w1+qTQpQSfIex0YFkIAKFg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gA6Y4tgB2VIuMZlE+gLhJ4/65cpObJ6MkE5p6m/GBYrvJYD/dFjvYb1/8eMsX+7MM2OcabrWgg+CmLRQnTVO3Kp9aIJ6HxOTFrzNLvE/N1sogycBfUN4vkoLuPThcXXr5D0/Wp9JkI9LBGkejG+z3IFxVWXJghapq+aqACbN/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXEKnROm; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXEKnROm"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6df7f544919so504507eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791300605; x=1791905405; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O4Ms3BW5WBLYxnHZPTG+mpYQxyG76rLXIkLTHETKkPk=;
        b=mXEKnROmXuW0XAWZ0D4CmlQh7VF8dBCyQ8DKPZ6etleakYBIsuRQWqTeOOQER1/Pnb
         pUVWNp3IQnIWnLaAkt92hu/nbxzB827W1JudR7dP3ifrtb26hGOJV3LaxvWkAoAXLXFg
         gfCntFRMg1+55buVy4ekok5Ov4pxSnwuHCZYNexFKID66aJYqT5f7vDkMm8CY8EfKP7Q
         MT5BTPJftVd845sqYFktQz8BCdsMNBUSg35V0gmh1fjCwKRTwdzGdwkptlD7L+XppuMc
         JpPIBKVfXJhBhSp0VlHojIOXijqFXICi99X33wMdc4lfOoU5UMke2zKkmJY7ctjPBY8d
         ZxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791300605; x=1791905405;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O4Ms3BW5WBLYxnHZPTG+mpYQxyG76rLXIkLTHETKkPk=;
        b=y8TdT3iJr7FHLbWo22OXc6U5biyg2FZWPy+Bqs2FpOtapf+pXTUoduCknnPbzt1ctW
         5PSwRL3ovxYA8nuHINXQuzFcJ4XjdV8zbTa/dawsg/BGAzSXmyvavhOVFLyB+zlMdRVb
         BMm9y3DQu3j8TFbO9HDaNTQghWbED/kQzuoSsvBB3j2jIPXn35HyRa9UUJ5Q6g22UYNj
         DzQkXIISKVKzNK3MnCnX1nSWIg5Ro4WdQrwEpmZj945DgjdsL8QSkt65BtkaLNCLanGf
         neAk77CotIpIG8qQuzLa9uesGbBWQ+1A6VOfh6TA56aIkS4Cg1TGXRXKWqwQFlggzFPX
         zS3Q==
X-Gm-Message-State: AFuF++kSQD8uFIdbntjyko4ikSHeutOkQuxlHs860blzcHV64jed5uwz
	tdziNLALH48b8UUFKSxYJ/yyju12YyVVLYw7gOjfDy243dEaY5uL31jqdFZxYZwU
X-Gm-Gg: AYBFou33g3jpyzw61Amq0Y6xTy8DF1nROwRKB+cay1j6jyLy7qQ7nPN2tVAzyzbaUL7
	upPeK2eNM7zn7H9DDcmVoOl91Az6sLSYLirNB7odK2UzD6YY6nzeeW33nT4Nq5SNDLGMKlkUATE
	4PE15kaNddEL8bG8wDYdhGgKOcpQlkxxuKJLCF1G3bzVAHyrtm6cbpG7VweNxyGyhhNk5On88+c
	dGMQIhIRTKe4NPFkJHHsQEG+qm11hdJx7Y/ann+5TUnst96WVdrvpgwPhK71ii+o5gO2s+jpJCW
	kYolqVCW6iReKFe0YcAz+qrZ4IJYIgD7Lty9YRoPw9Br+VPnysanfQpUEeqDdD1vSHYWjAI0FH7
	YIH47Hu1925O4LgL2AKEXcVWkH3yyH5qXbJOVsbMdz4aRQVCRzzA9WwMXL2bQYvRfEOP+23nBu+
	mJ9bV7vUBS/ZD7gTsUV4ZVFfdp4C3sc+XTH/0Vt+KhrFMkRvHIh1zifMC7AxXRPY6j40e6a5UlB
	0GA5w==
X-Received: by 2002:a05:6820:200a:b0:6df:cd30:fe7a with SMTP id 006d021491bc7-6e555e579cfmr1320921eaf.79.1791300605373;
        Tue, 06 Oct 2026 08:30:05 -0700 (PDT)
Received: from [172.17.0.2] ([158.23.190.68])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6e77139780csm75221eaf.2.2026.10.06.08.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:30:04 -0700 (PDT)
Message-ID: <6ac513fc.bd18b5f5.392000.0e25@mx.google.com>
Date: Tue, 06 Oct 2026 08:30:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2508768687535452120=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_sync: Serialize devcoredump reset during device open
In-Reply-To: <pm-bluetooth-objects-candidate-0250-v3-f85e5bae9c76348c88b7@gmail.com>
References: <pm-bluetooth-objects-candidate-0250-v3-f85e5bae9c76348c88b7@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2508768687535452120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1180369/

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.24 seconds
CheckAllWarning               PASS      36.40 seconds
CheckSparse                   PASS      36.59 seconds
BuildKernel32                 PASS      29.93 seconds
CheckKernelLLVM               PASS      35.37 seconds
TestRunnerSetup               PASS      792.81 seconds
TestRunner_l2cap-tester       PASS      12.86 seconds
TestRunner_iso-tester         PASS      10.73 seconds
TestRunner_bnep-tester        PASS      3.14 seconds
TestRunner_mgmt-tester        FAIL      72.19 seconds
TestRunner_rfcomm-tester      PASS      4.53 seconds
TestRunner_sco-tester         PASS      5.63 seconds
TestRunner_ioctl-tester       PASS      4.89 seconds
TestRunner_mesh-tester        PASS      5.52 seconds
TestRunner_smp-tester         PASS      6.99 seconds
TestRunner_userchan-tester    PASS      3.20 seconds
TestRunner_6lowpan-tester     PASS      4.42 seconds
IncrementalBuild              PASS      28.76 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_sync: Serialize devcoredump reset during device open

40: B2 Line has trailing whitespace: "    "
41: B2 Line has trailing whitespace: "        CPU: 0 UID: 0 PID: 496 Comm: kworker/u17:0 Not tainted "
42: B2 Line has trailing whitespace: "    7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy) "
43: B2 Line has trailing whitespace: "        Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps "
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 503, Passed: 502 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 2                 Timed out    2.481 seconds


https://github.com/bluez/bluetooth-next/pull/870

---
Regards,
Linux Bluetooth


--===============2508768687535452120==--
