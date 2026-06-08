Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BEC33F5A8
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918684; cv=none; b=qNxR1e+wV98Bz9ni69bvd9pbvUZ5E5PlUQbAnTAxiIWgGRfwAbkrMSmppxJe4Wl1wlqaEmM4R/52KlmVkL4SMUjaSBcYYlW6znOd7NG5NoCdjJsLFXcXxHExTMrMVlwmbdUAauW+EcwZtkOH4qeEMbMov2hXv7+UuSb9sB6AiEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918684; c=relaxed/simple;
	bh=r5MfQTKPgIYhU8z23cVUP0s/DTEW2AV3xN96Iar4h7U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DEVFXgl/Yx1iup0Asy6V9Yl9+vMea3We3UkCba0+1WSpvCskxBCoAfUsTj/jbzYv+UEcYurOEPTBVD175LUXm998vErwE/YG3J3FN7NAz2sq4PLz7D7ao4g+GchsVoJcMcuek4I+h7SAFAOryG158694e6k+Bex3zypH5vOSaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1lWPbjh; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1lWPbjh"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4854166e1efso4161823b6e.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780918682; x=1781523482; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r5MfQTKPgIYhU8z23cVUP0s/DTEW2AV3xN96Iar4h7U=;
        b=q1lWPbjhsZf6TPpz/AgqUczJRLxsHGhoSo4z1mmcvIC00EN+qeOnjC6qDYNxNf9Qpt
         zEDX00qsVkW0szysUObeQXmSzTJ+os82Mbs2p/Bb8bf+sx+r2d7r6rxlYql7t/36m0Ga
         gC70OnqO6UI7TKcIBoHeQ5ai4PQjMghKGNyTQUW8jwcahhAMJMjiOw7WhFkasKHZfUhS
         Tp8WGPBnENQ6nXy1xUqEwwZLStYhA+eDKCk6p+kEdj3neIuooLUmvZ0dpgCiwtgeYIKx
         yBqV32keiPlyKizxYk6tUqDL1EXsBKFUnjQRrejSbTIyAaRgk+LQYs93sQXcQiK55lTa
         XgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780918682; x=1781523482;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5MfQTKPgIYhU8z23cVUP0s/DTEW2AV3xN96Iar4h7U=;
        b=cHSAPUC2y7TIQnPsMfaAq2s/p9Fsz8C8yvXN1Eh5jz011FVCnKEnr1EUfLf4sFP5eU
         jzMRWpOC6ZntwCLZnu2MPzBhRJqjuG7Uheb1OAw2s/imGcyMGbRp8KPeEIoJrzueVjqp
         u5uBai+sxejPO0jZIKF4RdJjrwArqZCewVWSTE5vlTsCfeiznIFoZsy9tWHvZ/XxXTVN
         rCj+farwhhJUCstAvUSGytYE4+JxLlcl/ZA/B10jWEIDuqUAiE1hVHeGkmzc2fBLFtJS
         87g0pKr2ool3JlAKbDOedfriqy3FGmQvrcJGNQHxLMO3SJHsaQMXeXqToVXYx6f1alRq
         E/OA==
X-Gm-Message-State: AOJu0YxgNKUHVMPK6xKxDdLvs83VLzUc0EMuJPCYLVMSqKdq6KpEvsFO
	WQAzqlSyGHuBo3eXjqqy01c/MTh82eueRSxUAepCK0VtMSrug2hjRFmstta/Pw==
X-Gm-Gg: Acq92OG5khwXxtTR+nge4MUSFgr7knpZOneUF9RAt7syvtGxBXyOS7vglitLlCeDOKg
	ldM8HEHjfsyPFbsnWyeOnJUYO6Gl/bCr0iUjyIzz/b2/HODANY0fQGS286LPuTmQGk/l9vSY6kg
	xCs92SNjv3npcb9/y4NssXHSduMihY0MiDy2HajGbWI4joALhUNKaDX84S/piiSyQ/N2v7i1XjZ
	etAmoiEGbrh+FtMVs53n7ZsSch5iHnWyvaPQiphwipw73FJNzkC4Zd781EkFplRykrvXkp6tPoC
	IJxAG54LXs+fQGkxeMsHFEvXmUipXfL/O6tVEVzNOpqB0pbw/A2JCwkvD/mfnKOIVWbEJtI1aO/
	jqseQWVeGY7BrsTpYIwJeFxT2t+BtpNrM7OhF3+yhP59/grqzeJcgOyCGLaFVuOsJp7H89OhXzV
	C7McE2tMV91JrlfJT/AMhPL3XX9t2CCGdcN+uZzeqqQA==
X-Received: by 2002:a05:6808:d46:b0:485:46bf:9127 with SMTP id 5614622812f47-4868dce4233mr9371225b6e.12.1780918682184;
        Mon, 08 Jun 2026 04:38:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.219.149])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b745773sm14076924b6e.6.2026.06.08.04.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:38:01 -0700 (PDT)
Message-ID: <6a26a999.1170b354.aeb03.1bd0@mx.google.com>
Date: Mon, 08 Jun 2026 04:38:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3156461467333901524=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com
Subject: RE: arm64: dts: qcom: enable WiFi/BT on SM8350 HDK
In-Reply-To: <20260608-sm8350-wifi-v2-1-efb68f1ff04c@oss.qualcomm.com>
References: <20260608-sm8350-wifi-v2-1-efb68f1ff04c@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3156461467333901524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/pci/controller/dwc/pcie-qcom.c:1907
error: drivers/pci/controller/dwc/pcie-qcom.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3156461467333901524==--
