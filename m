Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B9374E5A
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922950; cv=none; b=IkvJE36OK2jTsxYV9BWUaZvw0WTNfnSYDA/i0AeVrLwLy8IHIe8L68+D0ZQyc9qPLlDdY+32uw3OUxiRBNfZeJ+tryUdNhpCz2SI9FwWoHZBFzjCa1VK+DPMD8YVvBhNH5rfpyaJyhz6Xl+T/M7KESVCOVm+Wpwuh1yVlJ6mTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922950; c=relaxed/simple;
	bh=MD4FLcbqpPP3wc9K64UqR1qFEvLBZw63V1CTQQyg5EA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AjoqgbMNQEceATEvz5xdtkDnkV/uTRdHJQ+I3PALF6vamqm1RdDEsgbZ0Ff9XQJhdTA8jXU4kfFw2vJhDy0sOANi4RyRjuHt7jMSoMyM1o868PaAVCJQON1XinkUtkBig9ed/svVhiSl0dwClQrwv0A8W/FuFh9af8nkZYPFoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNCzp/FU; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNCzp/FU"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1692971eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 13:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922948; x=1792527748; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bzBMocOh/+dc6/9GCxknvzVK8tFu4NRL0Cd2J5tUi1g=;
        b=QNCzp/FUe6RVUe4K9C9LRhfGfnOvWeeicBeiAYD2THhBsIma5szpv8feeZhdzpkgLT
         30u6HIuRQiS0LqWs1fA4dX1jd0kW0Sug0CxXyn4IqygQzz098VgKb3bwTm06VMb69XVL
         QEcShHJVYX/avqV57nKwQe2g996mKw7ZNGLqpYrKzR291iI2ivZldQ57jhA+lHXLMPEy
         04IQL8kXRltskG1HBVpL7k4dgoZmIL79r0s6BwbkOgOZQzQlnwSHMgbOffn1DwsvZpoB
         Y0zSDMKp8GrahPeNETPT8udxQ/Oa8W16fjO0BqftooG+nvqQgP2S8LzNVXkluTw6L5sd
         Oo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922948; x=1792527748;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bzBMocOh/+dc6/9GCxknvzVK8tFu4NRL0Cd2J5tUi1g=;
        b=x57jV760Xp4TOCT7+5P/2oGF2s5EfG+ig4A6jjPbLZabi4e3noqkCYrTd+ixcT1EMn
         AAd9Rzs2I3qf2EUMfyVUGfxV+klm0aAJRM8+b4ExiGhnHrwZ6F/eMfYbxk14XBR8Aomm
         0eXHFE9AzwpzTS+BaOeCwKlu+HzLEi40lrDGl/kczgaROfIyRgdwhgBcpbMYHE1ZT2hI
         MjG8Dpo9rIZ32dLNVhijKGKS0qiVSDN6MTCLKXgmF4E31lIl8UIdk76Y93pOrZbY8N+6
         gPpLF6idZshL+ttdQqqWy0UEkMHXDo3NNLDTLOH0B1LSf5EBjnTAMC0mx6AUWk6gAKxF
         o7uA==
X-Gm-Message-State: AFq9FYIXD3KlEVjjVxVL5rdWtq73K1T8JbVCkjVoAFxJw9uI8MTia9ae
	/BoyqTgDYZRkaC69YW3qOIovDN52+KWo70RRYzXWkD5PE8KYsNotcg/znSMaeA==
X-Gm-Gg: AYBFou1X2ncR31WlQmTkGdAiZq8AUOoyVHuzFf4HuLqAn2Bov7kpWm+eVHkOBbkmZaS
	cqZrLLSsJ7xCwK+bv3qDmJgmfj2B7dFDndSE6qFvJRllFI/3/hWagdzy7LQuy8JgnqiQ7H+WVuu
	8yiOiIAiGVXD4dJJsaMv1E0ZrC7LLVSDP+Y4jmjPTJuI9EzbQMI6LiuxhE+PlV+2ATfgtDtnAhQ
	xCFaYnLg50Dq87MuVza4Pg86xWhxxrud5HzqS5qcDPyxppsZhMgbrMrqLVM7/cROJ0x0GCVl9Z7
	49QlGLIYOKBEvm+iMovj0kLujjTzLdYl98cCNVW1PjzXSQFvDvUvLrgBS2QRgKk0/oh6mjwFtJk
	0GIB0sPUl3H4AR6xmFV5TC5GY256D4rHUaWeeu3Yl1eMx9NR81wSIw2EPk46g/dbcpknrFnTRJL
	rrWCA018rAzEiRtGVC9xDntEyoaGpsfv8e9v9V6rS8SHtxRBgTFWJo1/+dvEOdnOdhn77Ddwa8O
	EQ=
X-Received: by 2002:a05:7301:1709:b0:35d:bd18:58a8 with SMTP id 5a478bee46e88-35dbd27a1e8mr130979eec.37.1791922948311;
        Tue, 13 Oct 2026 13:22:28 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.42.67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm51609141eec.3.2026.10.13.13.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:22:27 -0700 (PDT)
Message-ID: <6ace9303.a5690e37.2bee02.1f3c@mx.google.com>
Date: Tue, 13 Oct 2026 13:22:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6936841705421797379=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_sync: Protect accept list membership lookups
In-Reply-To: <pm-bluetooth-objects-candidate-0118-v7-e6b713327ef914d6d02a@gmail.com>
References: <pm-bluetooth-objects-candidate-0118-v7-e6b713327ef914d6d02a@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6936841705421797379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184930/

---Test result---

Test Summary:
CheckPatch                    PASS      0.85 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      31.43 seconds
CheckAllWarning               PASS      36.44 seconds
CheckSparse                   PASS      39.92 seconds
BuildKernel32                 PASS      32.05 seconds
CheckKernelLLVM               PASS      43.42 seconds
TestRunnerSetup               PASS      734.16 seconds
TestRunner_l2cap-tester       PASS      12.74 seconds
TestRunner_iso-tester         PASS      10.65 seconds
TestRunner_bnep-tester        PASS      3.08 seconds
TestRunner_mgmt-tester        PASS      87.53 seconds
TestRunner_rfcomm-tester      PASS      4.75 seconds
TestRunner_sco-tester         PASS      5.73 seconds
TestRunner_ioctl-tester       PASS      4.62 seconds
TestRunner_mesh-tester        PASS      5.45 seconds
TestRunner_smp-tester         PASS      4.28 seconds
TestRunner_userchan-tester    PASS      3.12 seconds
TestRunner_6lowpan-tester     PASS      4.38 seconds
IncrementalBuild              PASS      28.87 seconds



https://github.com/bluez/bluetooth-next/pull/921

---
Regards,
Linux Bluetooth


--===============6936841705421797379==--
