Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42AB49B5B6
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095247; cv=none; b=T6av+Wr/gBARStXaPEIjxVIntyDRD7vmc+TuQI5K8yxBWzHWDg4qUkpDV36FW5jqqO/I80mjCUrxOtpw1WukPZ7ZcLUQetkBAXrGRJdoUH1JjrXF+0Sl8aSSB49l+kbSM+Tt0NiH2K2+3yH77NdQC9s0WnqAKS+tWCUwXuhDpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095247; c=relaxed/simple;
	bh=3x+tZdyINNtuMiE0BjMBXihjurM959m7plqdiXHjxIQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RuzQ4kg3ZYsY3vBUiyHtzxKXa9rWpUW3CItRBTEL05zFKp9VMY3anebBoxV6qyoAEtID5mtFVWnpvRQrQSR5Z0AcHoeSrWIPTlem2MjIPzV0Udp9SvbGv/PNDGGcMIZebVkMzKegq9Ppjwi+HPjkNvVQHpk1sa+FacS6NP1JV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oR733VYR; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR733VYR"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-141395927feso10994524c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792095246; x=1792700046; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HvFafl3exe7TbmUxRmjmu5xCwOFIuPnK6Gr2dY44UeA=;
        b=oR733VYRVwyYaDey2RwswsLNiFj272lTcfbGBoMulid+oowoYlmK0mZIvk1ghX+kv3
         HK6p/zFATDcV1T8pPDEPAAMU3y3SLsNld7kpRPiu0wnU2CmHo06SrVQqqbJ9od4tanLp
         2G0Pq1GzbCI30zQRPm0NakXOf292oF2FgGsIqW/g000CJuMVlsr2N+/VCDrq6yZDnKHL
         /B3rf07tGWQdi2GzvisJfUogevpxuL+6F27DdXezlMmsdEXPe+dBMoHnF40dbhEHJyWg
         rSgPxsoolA5o04zltZ+ZeQaAjbdDAG/yM5N2lyAG12AKDFaSGiwjvh+5sfoV8+1zMJRO
         fpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095246; x=1792700046;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HvFafl3exe7TbmUxRmjmu5xCwOFIuPnK6Gr2dY44UeA=;
        b=dT1QCLyCz62gqF+oo15GxNBRTd8H6Rplg+M5UZEmQztcwaassxgMG7zywQvKrpqXSB
         u+PF95y3+RZpjCFT4yRncUvC+QC2wJwoYHk2Rz00JTe+ZNNTODi14rfj4BYBTiAzysft
         ltqz3Kd97tG5Kbm+KsyGrvHYpi9bkvjPuedECxsN3ueTOLVAeqFUM7CYBeXbKX6Z5Zoy
         O95eXMrBQnLR9v8szc0TgAcfaRJZ3UBo9gx5qHx02ILnav7VPCwiXjPd1IydNk5C88mq
         HcvJ8xfTkO4RdoiG49peYJz6U+UaEUgREp4lSPOYEndJBANgCIpsP7Fx17jNuHcZfC5h
         uxeA==
X-Gm-Message-State: AFq9FYKoe9FzVjy8SPnq9tuXkxt8NXE5KKsiBZ9hmcfFXlGYD+RP1ETi
	i9AywH10yurbL4r/Et9p/Tb+hie68DFTc6v7EUh+GdwiPkqeVpcwSSn/TjGccQ==
X-Gm-Gg: AYBFou0iiOV1hNL7jrxPa7KkUSwZWo9e6tkN9v9hvu9YASr3NZjpruzysKzIqz+sAEX
	MXzoTXqQCX+EWF8UUUqsWxVkjmKu/C8mMQj3TtmJjyGWGna2ekI7fyC3FD02Yz6+vpomLlIoFJL
	3NbkjsChwsMfgHNjtKmztSaRgdGQoTyz4CSFgVlaH5+KRqc6gnybZZows2zZXZm2239IIKTcQVk
	hqKw0OPtXgFTpPSStYf98wrHPBrreieWAawQqamdnbqxu1oRvwmDFNc3QaoFQwrZ5gakD32a7FF
	tPXg4EOar2RgLfx69sN2LLMwYPMtWNmKD8iI6WV1vN+8jvz2rNhczRrDPkiT/zTxhO3GPjkw+RD
	NQMqimGYYqJJz00nURaf4RK+pQ45XH2fa+iAd0xYcuGPc7Yu4HOA57rtdsh54yhNlDHopZhsuoF
	CS5r/DcDMJ3NoC0FiPT0J6o6piv/6N2O0+qAYlVGixoBswRN6i/OBXT8iuxDNuy6cBW+Rn2vJl0
	ueZ
X-Received: by 2002:a05:7022:1713:b0:14d:3c0c:79ec with SMTP id a92af1059eb24-16a5dbfddf2mr21048557c88.9.1792095245607;
        Thu, 15 Oct 2026 13:14:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.39.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-182a6e62b17sm1211837c88.13.2026.10.15.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:14:05 -0700 (PDT)
Message-ID: <6ad1340d.77c88264.eb9c6.d6b6@mx.google.com>
Date: Thu, 15 Oct 2026 13:14:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6712168667441113253=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [v2] Bluetooth: MGMT: Serialize power-on with power-off completion
In-Reply-To: <pm-bluetooth-objects-candidate-0063-v11-a70581b6877e5fe118a3@gmail.com>
References: <pm-bluetooth-objects-candidate-0063-v11-a70581b6877e5fe118a3@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6712168667441113253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186652/

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      23.35 seconds
CheckAllWarning               PASS      27.23 seconds
CheckSparse                   PASS      29.93 seconds
BuildKernel32                 PASS      25.12 seconds
CheckKernelLLVM               PASS      28.52 seconds
TestRunnerSetup               PASS      530.21 seconds
TestRunner_mgmt-tester        PASS      83.49 seconds
TestRunner_mesh-tester        PASS      5.15 seconds
IncrementalBuild              PASS      22.36 seconds



https://github.com/bluez/bluetooth-next/pull/950

---
Regards,
Linux Bluetooth


--===============6712168667441113253==--
