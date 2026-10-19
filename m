Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC03DD84C
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420621; cv=none; b=VSBBi2lmsuskS+gbk//TzFSQuZYSiXnzrt7DSSn970F2q+DzaST0Ie6hhgU+jLvwpiiJvc9O9nTUm3MIIKwtaSGyzJz1yrFPQf/kFEDR/6DtI9Yk2S7ueU2a+MfTz+HKPxQR5UQuT5MfoDpngTOE3y6R94jY8yAuqcctev9HJcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420621; c=relaxed/simple;
	bh=WBhXcRfXRxsawIdNZcbn9fvnrurti2ieuA6LvgSTPGU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nk7aYJkq4hxE9fW4QpNkBcVqL+ggMNtaS2ayRwYjjirQZ4A7uXmVegpHPIyFxO+8UyTnGAG3jEHbenx8H0s0fxAya0XfJwy3rBu8LgnS8WSy+2lIgyUjFqhhmiV8OEQNyGEXbrLlyfHb3wbkTJVVXfLYa545VVAU1apb4EAXz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECQ5qKQS; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECQ5qKQS"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-16079d54c17so4895454c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792420619; x=1793025419; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u6IV4zfQQaNXeBEsrPDKdro3NO6oSpS5D7dMRMrsXGw=;
        b=ECQ5qKQSt9jBV0NySCSkaNuGj9XzPWau6+ucntRrruQPvLt/piCjDnY69xGD15kxWe
         cLo9JWRSPlwFGxX2vQJ8mktc8Ur5BfwT2N8NCVSVBCB5BOwSeSvPHs3B1iYAqXya+7Yz
         8v75+4IJiXeTQVUIhl5L7ZJm1Z1GYJgHpXhxCLHGmXdt77xh5o0SWEHU3KM0RYkzkKIT
         ZQSmJw1Vo4n4SuzExR5p/cCwYdRCHOxAoW8seo+V/oZbkZtv+BYtMHkNcFe/qmNEOXTy
         IS9hjwWM8y0bw4IvJ0FnM9l+VJ/TC/pn4k8UdgEpfKylSQTu1g1NZdkZeSSafk49Y09Q
         75zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420619; x=1793025419;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u6IV4zfQQaNXeBEsrPDKdro3NO6oSpS5D7dMRMrsXGw=;
        b=NaBETi5ohZ++kCdv8pkqUFPvz23ya152vDVOZm3Z15JBAGgj3P2iyvn3ePwQ5HFSNN
         FYt5UwWvKuOMw7vlQWVh+57tj0jF2Do14ry/g8AjV4A4mxTUl9RmXd03Ofeyx4o0+zE9
         EJ2Lfsfr0SvaI5zt3MfIRE8iGuGeDb8DK9Vdp+C0glADSkyjdGsgym9IdpxWpKTeOGrK
         E8pm62tWuo0FLxax9gS8OxVWddXnISC/TBMfwH2Grmsb9CU1gpDwcIRDXIqkkdlsz0OD
         UVyIuLpIyE2j4+9h2o4ZqewqY7Q2hUELtlZei2HfiNqUxRCuVlvJKu9qx2grMC59KtB4
         QIwQ==
X-Gm-Message-State: AFq9FYIcE64u1TYVQ2hu0hmpwmfIb5MNH/C4behObCSHKCJJxY5KG0d2
	kcOdahamM9naXFw58c67hijb1FQQiIhFtxKrID6YRsPqlpUVfq7bK9kUyaF/AA==
X-Gm-Gg: AYBFou36ZsVPdPCK2vY206Ek4g1auXa4Rhw8Zsy7VqIiVqfx3CLGaiFTEtE71XrQznH
	tobUZzBIlHPb6zxsQcdI3Pe44Mi7B3KhvhIpGK/OJ28blXsadBJTKGD5ixM4hprwD2LFPaqUE6p
	FBB5AB/ZoTpcYOPy9hViCTF1U2HhvfmxLRd/GjkqYZroUTxSEuJceWJQvc/ZilEo5UFF4CjAxxK
	d0xN2SqgZV38z6gL7BfSvFPJ2IyO0HiwA5YQ++hf3OsMh8OcWlqMwdicpscwqZcn9lAOfLXCbmm
	WJzX5xHEn3s9oy9l4o3Zjbpm7bvNFk5JM+dSbx1UtESSsoZS359eP7T2O0UDelMY0k5VSsETKeK
	qPpLU3N4BDLCDWJNqnVGyJxnY48NtgtHz3It+ThFtka/fQn0tyWbGJTI/QRIh4ggK3Wh6muEvk1
	31dr09yqGHrfKy7k+NY9IkN74CqUZCd1UCe4E8b4LjfGM4reUdBp7MPpjgFXWxAGX0OyQjxzQ4w
	JIpnw==
X-Received: by 2002:a05:701b:4544:10b0:144:c12b:4e35 with SMTP id a92af1059eb24-18514729b48mr10301499c88.42.1792420618506;
        Mon, 19 Oct 2026 07:36:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.100.245])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314ef8ed8sm28004066c88.3.2026.10.19.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:36:57 -0700 (PDT)
Message-ID: <6ad62b09.0a7c1997.23ecb5.5f4d@mx.google.com>
Date: Mon, 19 Oct 2026 07:36:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8141164056759553263=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 18983559317@163.com
Subject: RE: [v1] Bluetooth: hci_core: Initialize IRK before publication
In-Reply-To: <20261019111611.491779-1-18983559317@163.com>
References: <20261019111611.491779-1-18983559317@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8141164056759553263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1188835/

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      23.86 seconds
CheckAllWarning               PASS      27.65 seconds
CheckSparse                   PASS      30.46 seconds
BuildKernel32                 PASS      23.89 seconds
CheckKernelLLVM               PASS      28.25 seconds
TestRunnerSetup               PASS      537.30 seconds
TestRunner_l2cap-tester       PASS      13.43 seconds
TestRunner_iso-tester         PASS      9.48 seconds
TestRunner_bnep-tester        PASS      2.81 seconds
TestRunner_mgmt-tester        PASS      88.49 seconds
TestRunner_rfcomm-tester      PASS      4.94 seconds
TestRunner_sco-tester         PASS      5.18 seconds
TestRunner_ioctl-tester       PASS      4.25 seconds
TestRunner_mesh-tester        PASS      5.56 seconds
TestRunner_smp-tester         PASS      4.00 seconds
TestRunner_userchan-tester    PASS      2.87 seconds
TestRunner_6lowpan-tester     PASS      3.98 seconds
IncrementalBuild              PASS      22.41 seconds



https://github.com/bluez/bluetooth-next/pull/965

---
Regards,
Linux Bluetooth


--===============8141164056759553263==--
