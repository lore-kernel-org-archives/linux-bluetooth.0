Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9931A724C
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044305; cv=none; b=MYnwzC17NadPt8Ae+kL/Yn5QmlfAaaWqv1ksBIvwJqyOMG0amOm4lxV7ZqrCUb9wydgEeE+R0P587UmLvp/EGEjsjBM64dK0Q6pEzCMnm67vjYWNUhupLXpHYB+kF8oaZlmFYQdjIXbGtNdvkvkqeiPH4kyfXHG3tqyIWADB/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044305; c=relaxed/simple;
	bh=W6peptFeaqI5K7AemM989CuwrVXvmJmi3AtrfsnHFag=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Oh+XejTGbdT8n9iuZt73kHJSavfKOUQpe4Hn/hiVV9IlpE3DPFjJbQgj6ObcNHVfxnz0K6LFkQvbvjjBC/iDIXNNUlioZwwKoxboWZ0tLVvcZIhtrS3SODIjpykSO52oKucDJXFbaWK74DphkNnhpf3sM2a8KL9TYSc5EqNOMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+sNPRgG; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+sNPRgG"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4c79fso1559626a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 19:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790044303; x=1790649103; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+32iDjxZMJY9yUI6YF3GaFA7ia9+i4rHsgYs0mtAjB8=;
        b=N+sNPRgGAtr+wZBJiir1qRbeOCamPOtLysj1IY0iU9I+NyklpUWvdTMRhUV7QrzEBM
         BKMBm4ogXEZb+q4HVcBJ8R9Tbzq/RQ/ywvl4Mf2XYsCT/Fv3XIMXzKEy2dxH94c9jD4z
         Lxst7PIAaifQ8Mcp09eJEtOM4pDI6ukk/DaXQQaXtVnat/QXnfCYNdfjoy4wUxH1qvnE
         sa9zwu1VpKgaMsujoYJ74RsvuEuXPzyAxOFInWvK8JGSyVYnLIYMxswNXfsLPlCWR9k8
         8qWdf2OOjh6hNh3Frlpbfl0pALQrEoSUMVz/qGhwi8y+adm8yvC4BHoil8LcFiWFGh2Z
         d1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044303; x=1790649103;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+32iDjxZMJY9yUI6YF3GaFA7ia9+i4rHsgYs0mtAjB8=;
        b=unTIPvMrBN3zumG8Z3MOcP2xatYECUAdSgmvz4uy3i/fd746WQuopIMXP1e+31+nHf
         z4sMcemin7gik+4/bGt2tlZ+iT+/P5H5ndZQBsHIgkpeCaza2vIUMEa5ndo+jJmweNJj
         mTR2ccnmLP0Z1+lgQ8pxFy3Y1QoqkzfKUbVrEw3AATrW+wgdKOIxrut+JE+l+VfHGdg4
         uSMn2Hk/2i0GsTrxvEmHqdCcaiQ/bnQDwvKIllME5JfVmRAUYQiB9CfZGtvk4uI23YqI
         ft1dNTOEzbfnrvVFFaif3/yPHtHoEnME1+AWS29c2Bi7iYjXJ1gX/SBYIAEqF7K72+lT
         5jzQ==
X-Gm-Message-State: AFuF++nqKC/KtbvYWV4h8PHJ3eJl7H8uETfUJQ+Jty+kG0GnRXi199iT
	YAkiCTxYBb/skbDPnMDjz/SoeX73JNZ9741skbD4mpxObALHQj3B19AaJE41YA==
X-Gm-Gg: AYBFou3y3MrE251lxVW6GkY9XPZZsp6yL10eqm1SdQUvnX76AGGv4zcdsSYx0V326XJ
	OGO12/TLOtVzPAPclIwFowdSYGmQdKT3CzMJZCwMVwl2HcNwZzsWkFR/AxkQRzklCQZZQZwaGtP
	t4weXkA8UMyoPInIHVjnWt79o5VrCn0EqxkxZFYDSzylN98rjZp5Eq7+9KLqc2TLsWsKVDN1FgL
	KBIB3x+4otcpnQvqbf43ZmCnUJMPyvYYE+C8VMzc02RG71w5ZLOoZqPlNKvntMm/LLem9GaWLXA
	c7qdUL3QaO04PSO5RWDy6ioHbGKbHqCbOxcgfCDqalcxHBP9UwyOmLZ6mCrQcuhOT29IKaW1rpA
	/4uQoJg0ZYHcDudj5F79JSEDE5doWvnLgZg8XATsdPd4LSSoh0ss2YKUniXPW+8uC8gaR1YkV30
	Chs39pDqQw1FKIzCJFoGYJHCVTLmSEsEO018jdDq6Cpn8Y7LNDEad+ugJEY1+YCWxtJUfRT8qWs
	Tzd
X-Received: by 2002:a05:6a21:6282:b0:3dd:a197:7362 with SMTP id adf61e73a8af0-3dda1977457mr14237393637.59.1790044303487;
        Mon, 21 Sep 2026 19:31:43 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.68.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e61271695sm1064668eec.8.2026.09.21.19.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:31:43 -0700 (PDT)
Message-ID: <6ab1e88f.3efc6ce7.2c1da4.018f@mx.google.com>
Date: Mon, 21 Sep 2026 19:31:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7466788648166593760=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lilinmao@kylinos.cn
Subject: RE: Bluetooth: hci_core: Fix inquiry cache timestamps on 64-bit systems
In-Reply-To: <20260922020141.389269-1-lilinmao@kylinos.cn>
References: <20260922020141.389269-1-lilinmao@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7466788648166593760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1170901/

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.16 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.92 seconds
BuildKernel                   PASS      18.39 seconds
CheckAllWarning               PASS      23.54 seconds
CheckSparse                   PASS      26.65 seconds
BuildKernel32                 PASS      22.17 seconds
CheckKernelLLVM               PASS      21.37 seconds
TestRunnerSetup               PASS      477.87 seconds
TestRunner_l2cap-tester       PASS      17.38 seconds
TestRunner_iso-tester         PASS      24.92 seconds
TestRunner_bnep-tester        PASS      3.23 seconds
TestRunner_mgmt-tester        PASS      53.59 seconds
TestRunner_rfcomm-tester      PASS      3.92 seconds
TestRunner_sco-tester         PASS      6.86 seconds
TestRunner_ioctl-tester       PASS      4.01 seconds
TestRunner_mesh-tester        FAIL      6.66 seconds
TestRunner_smp-tester         PASS      3.88 seconds
TestRunner_userchan-tester    PASS      3.04 seconds
TestRunner_6lowpan-tester     PASS      3.94 seconds
IncrementalBuild              PASS      18.33 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.758 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/810

---
Regards,
Linux Bluetooth


--===============7466788648166593760==--
