Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1793BBA0B
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431062; cv=none; b=SGQRfoLq0ZVqsMDzO5e1AXGmlLDD0vNZPknMu0TOM+lAunnaHJqyiMtutP6+iCkYEc5JHUbbngCoZnQOYJRnZjrmFXP6bjUwjUCOnZSBHaNK58515RrVHmDg5L/Bg2ETtgpgUZxK+cOH8i9g3epp5lVXAG7bOxlNsa7fC2Hf9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431062; c=relaxed/simple;
	bh=zpa8TNKx5R/ROYxLcZTMkheJZGWnVAkKR/88xpslMsg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YiRHU1oLUWXHQXdIbzkZ5c01DdcBtUwBdvT+ZTgqEagNoaB8HTzR7UkRMhwTteSLACXjLA4ruDUWxiiLkmIPcJSgeVyevWKCuCvGlWrVMCVOd0FHSlxaiO4WuL661YSq+ydQTHyofvdEVYyDFNBf6KlkP21lEwzFAvfHxp45Fzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Veml7fa0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Veml7fa0"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso3307711a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 03:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788431060; x=1789035860; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zpa8TNKx5R/ROYxLcZTMkheJZGWnVAkKR/88xpslMsg=;
        b=Veml7fa0qfCOAIr7fQpR7MveqKFGkTVN/2bR8scVCPPkRuXaHsKxKzZOaNp6V2ohlY
         T8QFOZRFmTzLq4+3kKvpQbYpPUadcrpyGLQC+ZcamI4qfsXYwG2xEbxlXlzs/Xjrlnge
         ss5CcWMvpgCL/n40d28GC2cAra6L1FWnvwy9r3ZS+WUW4oKnn+yFhpybSIo/moNCj/+G
         GhSYsuurhAwdE9mkCFZW6jZJf78PBw5MXNeuxICWKiRLZr3woTc/+fiIRwxyQnj/rrRB
         jFx5K/OhMLX4TeJxpEl7JqxUFLx+oGSOW0twHilfcJCFujf1UrzGs2ijitrG3owMwu8A
         5DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788431060; x=1789035860;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zpa8TNKx5R/ROYxLcZTMkheJZGWnVAkKR/88xpslMsg=;
        b=hIaFjG01td8WpJ44HDmXP/0twgBiBl69eUrqy9PDBmpZ5q9XwUWE1a1eNQjeoN7y4z
         VApsemIum6bWPPiWVCefXEfH0uvdzJmuDuXIgDemozyHGWI89aEqYCo+uNOn1SqAAYIn
         QYzgWHHrTrhBQkv8iL3RoU4/edNrjlcl4+1cNGiLmhBSiOVmU+cTd9VtpnbEEKf14lug
         nPAOt89mjiXDoHx3fqn9Wvi3PJ/hRvp/VEQuri1Ac4z+upM9m3xIeBUaNNDaGSYH+baX
         IrPxKVC55edVcUxZW8ibXY01EWqFcDMALidD05TyZ7k26T68Pz+8+juNzdDBtLLFHX+3
         Lo4w==
X-Gm-Message-State: AFuF++nVAtqDmNidgKgzBljLeAcNRwMvkfcNq+ZYo/WRtZJBi01/fAjM
	x5ZZwSlz3DHK1HC0kT1TL9w5GS51sBu7LU6J4QpeDdMKOGvIksXv3nrdINPqurSd
X-Gm-Gg: AYBFou3ZJuT8pc77GPVrBRYH4PAqyiX4C/eQWbsJxNRKSlk6yQDvyv8NsFL4e4AYYlv
	orXt5WdVS0CFcMoexFQtLZSe3GpYkPX6/D2xgn38V33219g7/A9h18uPKF/bdu6+wSGw2ldDlz9
	teck+/+vfBUD0yYs2IO3erYjTHB1zpkVssd93w0noCCoEIHKvBFHZyY45WgvXaOPP7SxGWTV8YF
	bI8nVWIbWN3vEgPIXj02T/6QM2+9YeWQevvgK11Ub+OElcCLVMTIQC3iE+wS/hzFMve1FzK+hq9
	LRFkJgFyatsm/h8zw+JWlP6jD+REWavH+jLNVSJ4Wd8nxSqJzBwQBH+Pixhm5fPwsPoyYx2UJgl
	Y+9SzeEh1aJrzH/WOrnb6/Bhrkd4I/P3z6/PRwnGoejOCQlVkD3plJIabUAUGs1HqRfdyrdKuoW
	gkL89nKyUf9VlAbMujYTcWkiEP2XRsMHIAemZkBJWvT2d76m3syyWOe8IpkgKBUnBG
X-Received: by 2002:a17:90b:54c3:b0:399:ecd:d68d with SMTP id 98e67ed59e1d1-39aee26286emr19303448a91.22.1788431059689;
        Thu, 03 Sep 2026 03:24:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.98.45])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325631eed2sm6157291eec.22.2026.09.03.03.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:24:18 -0700 (PDT)
Message-ID: <6a994ad2.d63de05c.1e9c25.d86c@mx.google.com>
Date: Thu, 03 Sep 2026 03:24:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2080035905326801547=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, samuel.alhovuori@pm.me
Subject: RE: Bluetooth: btusb: Add device ID for MediaTek MT7925 (13d3:3631)
In-Reply-To: <7Lm0MbvHvV4KTuQVikJfyHTljM3ozGSBICPx7mcV3jvMSuZw8zx_jHkWn2wuhpZnaUhJgEpgHG22crnJMxLVX_1TRzBT4ME5WPZVtcDpBJg=@pm.me>
References: <7Lm0MbvHvV4KTuQVikJfyHTljM3ozGSBICPx7mcV3jvMSuZw8zx_jHkWn2wuhpZnaUhJgEpgHG22crnJMxLVX_1TRzBT4ME5WPZVtcDpBJg=@pm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2080035905326801547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2080035905326801547==--
