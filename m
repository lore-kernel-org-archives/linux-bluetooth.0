Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD621E08B
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Aug 2025 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754730374; cv=none; b=fkOpMUxGKr2kQrHEv7ItzFbrJSUkjDn3LYuk1iHXdfBoTtzvvGbn7IIL+VkwRw2aF4DbiNURaSx2FDI/XNQwVqymi2IS9OCnzV+EiDg1/zNYBlHQL71MQjxHFuTzzpk6LcNHZEIsQi5k29msoJcUiCk231y5Xs3NrGzoCMYHd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754730374; c=relaxed/simple;
	bh=q0ftes1YKyRMk1znFimJd7/hJZPbLkXD2tEvSQ3RJPc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lTfithkzDFjky+Yxj5vw+j9Lto27nk/JILbu+2otvPjJpFlnnHYfzJ/+YZkrGkK+ZytuZ6w7qOEMbC8gyj+cz3OCk0Ipsn4urfCwUOaYTE+0j0i6/q7h1H1FkWJyiQtblfdHEMhs4guNQ+4bQ0PtVeNC4QlpCgHgDZC6TmBhal8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNbjhzXy; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNbjhzXy"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e40212e6ceso12071775ab.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Aug 2025 02:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754730372; x=1755335172; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qcD4UUx9viEszIqAM3JDn7JlmMK/liouXQOK2szS+2Q=;
        b=XNbjhzXy8U1QG0aUFR70gxmZ/47WzDY8uhiI5yizMqt1h5XcOWkOhJkYe4OoPi8hBR
         AIohOMMEMZA431X26TzuaQ+zHYQe0tXskKsD8eqxQ8RCGnVtUNJe6HLAeYSlAnFD8BfY
         HN8MGRQq79Vk8SUTeGkcz5uB5/kMzc1C7adceawIdqQ3uJaSWv1liQGn+5IT0qvo3T9w
         zZKtSl5WM3wO2g97WGa7aWJFL7fiwlfWbk6o63skhZQowCKAre41YMDsjXSh3+Vbx1/5
         dKVOzJ+Smjp5z56L/VG0KRPGSW0/OckTk6UFh+xNXav8DgTAA8LLM+Hs9bFeO/qIfECc
         Ax4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754730372; x=1755335172;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcD4UUx9viEszIqAM3JDn7JlmMK/liouXQOK2szS+2Q=;
        b=uGe9cxlOrIzW+1kH7eHdJXJAnqiKt6jEzeoxeNSMr5DVUpm64fg03tIQY+SGGHU/G7
         jWudFENGkhE7D5LnmGVH40dvvtCskaMjBe6yJEFoXDgIgiaOLGenFXs16ueO4ppZfRn1
         HIgqkCAXh5xb5IUC1BZHH7YAJlau0dKhbLtVDx302as815fQJhC6XmjhcGZSQU+wR/X1
         2TD6NW9gU4yRJhOaMZM3vpY/J3+VFS5HYVZEBI/RJlc77B00LifZBlQiT17p8i9EZusS
         ycVl1rUyW/DzHrqAId8YdQ/ijqTnmXLehqo0eVAjH9L8RucpMuFETIHNQTJCCh1M7B0+
         0zEQ==
X-Gm-Message-State: AOJu0Yw5eNNivgiE06W93YN/evcXP/BTDGqTqLWeY9+o6a3xKmklgcZH
	O2NECg7yeJ0ZrtPTukpdgE3VAg+8YuH0dOAuaAaFe2BfOHb9f6jWeLcn5et83w==
X-Gm-Gg: ASbGncuqimUC2xWJnSH5lTdNBMOxzAMicOMl69RcbhtcV7qpAtkh2iY5CVkC4GMe3xm
	MQPWytV8eWCcCkY5UgeZQfmAduFWtyf+OMHDbmptrqu1kyOoPLacMGE6PnQqu+ng1KgEvoiO9TG
	J2dpLIcozvKY1+wrhh17OZFoAjt7dpUZW4mnzW4cH1LRtoFFrsf7kZ9BJCbV1xhqcLZWcvGAc/G
	twqKMmVNZycgk8+7Cvz/9A/Yl8vYdX4o1uwb4FcBZmCbfS9jQ8WwoJ7AYQv9X7kE4yGQjmpHSww
	BkaOCMdZ14VKeq1GydtKfZkNZwZqtWIrWgQ9iEN/1STWSnLk09piT4ibaRWDtAcBoSDT+JVVhiG
	KrqwJXYDZ2H8dQv2N7/1vD3QqowwD
X-Google-Smtp-Source: AGHT+IFXwm37hZ177sMbO4+Ue5TeWzJy3+ueGf1cDr7lK2wFAISwAj/vDtD4ApEqfl027fSFednXiQ==
X-Received: by 2002:a05:6e02:1789:b0:3e3:d7e9:f305 with SMTP id e9e14a558f8ab-3e5331e7a5amr121010005ab.21.1754730371653;
        Sat, 09 Aug 2025 02:06:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.139.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae97103e5sm949135173.0.2025.08.09.02.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 02:06:11 -0700 (PDT)
Message-ID: <68970f83.050a0220.13d023.1ad4@mx.google.com>
Date: Sat, 09 Aug 2025 02:06:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2333934563391527718=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_event: fix MTU for BN == 0 in CIS Established
In-Reply-To: <cc0cd5d3cd7ed9b081b60f34f97ed9c39a820935.1754728503.git.pav@iki.fi>
References: <cc0cd5d3cd7ed9b081b60f34f97ed9c39a820935.1754728503.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2333934563391527718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989586

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.38 seconds
CheckAllWarning               PASS      26.47 seconds
CheckSparse                   WARNING   30.78 seconds
BuildKernel32                 PASS      24.03 seconds
TestRunnerSetup               PASS      475.61 seconds
TestRunner_l2cap-tester       PASS      24.82 seconds
TestRunner_iso-tester         PASS      37.71 seconds
TestRunner_bnep-tester        PASS      5.95 seconds
TestRunner_mgmt-tester        FAIL      127.36 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         PASS      14.81 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        FAIL      11.31 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.23 seconds
IncrementalBuild              PENDING   0.52 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.137 seconds
Set Device ID - Power off and Power on               Failed       0.126 seconds
Set Device ID - SSP off and Power on                 Failed       0.126 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.943 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2333934563391527718==--
