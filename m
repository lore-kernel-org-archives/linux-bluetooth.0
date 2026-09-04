Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6523B71D4
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542485; cv=none; b=EXkSnT0sGXTpsXhBR58/CBEotuPR6j4rSot3Wv0U5soGA/GMNGofBzRmbybd8iJx+cyaojBLOo7B3BcsQID54aFpENrMXb7xG6BTfKXHm5PX+Hc0XLAoV++q8o/NAsNa+YXbYpBo5pouVNTuWVwBTur9EZr0llVCvkN+uaRC2Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542485; c=relaxed/simple;
	bh=Hf6I2EwPnH2riLXNnT67wEXYtwoAIPnDSwwOp5EJ2K8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kxc1BnmFJNR51WKsKL5juXnTa5VFn+iGPfPUGxTXdD6RrdYqZbt2+ARDQ+WJ9MCvFLpbDWgeVlbBdadqFX6DFHF3AvQMEWR1SfxHkOtY+DOm5iwUIj/al48+0lP9Ub5LsVJ+f3v/2fChS7ZKT/19lnsYLaOcFWPvflxJRKTT4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiIKwm/0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiIKwm/0"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5300bdf61d9so15055451cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 10:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788542482; x=1789147282; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hf6I2EwPnH2riLXNnT67wEXYtwoAIPnDSwwOp5EJ2K8=;
        b=MiIKwm/0x816ScRCIzKgJHuRz/2iC3O66dKWCy4woDGeZ4eKhNi0GqxNhkVBwNt3C7
         8HK2Yjj9XsmclcWmWMgFkLsZCVbw0EhOV2P3JfN/6KtXyXwZxnWDWF46U+KazC4om7bo
         9b//NIBmCJdnuxCSi+H5/dtIwiW5GOo6JJfzf6EyKwXpbFDgjcJ6GfSynFD3uL+HVMCF
         IY3MWHiEiIbLHmMDoniaTm03vcqjKBQpAAdQv8ni6xcyRs8BD0PbK6ksu54Lo2ZDsC7C
         LCfTvB/lVwKL3cbqtiJODhhqpiH+SgMXMXBoj4JoUntclYNEwK0JFTkYhJtddRoybWPn
         LhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542482; x=1789147282;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hf6I2EwPnH2riLXNnT67wEXYtwoAIPnDSwwOp5EJ2K8=;
        b=ZbIC2qa4iNt31IXeCfEVEZV0E7yRTPZil4Qz2LcjCM5QN2rpSN93CRgoup4eV8eeVs
         t0NKhzsQiAb0Vw8t85uOnEfKpl+tb4OJFoG7nujPmF12LowOIfQ3U82qwgqTqF3eeLE3
         H9VLXzf8hGVA2/5OTeVX1XooGIbIdOXSBHaNkTU6R35QnRJiwNX/Bperjvk6afAirxPH
         k54lN59mg6PRNYNVemtpDC1g7nZ1PyV05qaQZgivpGlj+6/tTCMI0GXivzB3+gBJe5jX
         6dtwePGs3zCP9w82o0IyuUFIdqmYnydtKp5dyf1DoPZ/bA/QcM2C+479VTwAabanSZUf
         a+6w==
X-Gm-Message-State: AFuF++nQVRbS4Q2Bz6AF+fS+ZNqXxIvLifnmjfV7xb1k8d1oZJSmFHa4
	oTNBxvu84f2yL87xsf+iJimC7XSAMagUA8HiK/2ALzLauCSGEqodWtG90sLmCA==
X-Gm-Gg: AYBFou2AH9gk7h2Z7GcUUWKzMsphGWL/s6b7YSuA8bjISPWxi5hba3+D3J2dMV0uN+C
	cJQJoMLf1y1sPPMXnSyjba/C9IAq1fS/5D//jgHfaWWBRCEEPiLfIRSVJz84YotK9DfZLzS3pei
	cvsWI8y1fEqXxseZb4mSWLRQtEHz9UZ5FthdjY8M1SNbSQjZB3ox6rlQq8/dS/78p4tMSvxFz5M
	J4Vfpt6CWd1wgzT2bG6yp3XCZVNr6+ijZYstVaKcy0PB8dAOexkA24n3nTUkx5LlIDDyc2FAHzh
	TFpOMrTeCmnqkwbwaVBu/LbTZ6YhNJkCUjowzmp9xrT5qcsEYn6Qvuplw2EZgzFMCwNVAGoV2WD
	miRnFL2xiPB2sKUER1mEBbWCyzajUb2M34SvPBGSAf6ZDKDe1lgzYOZ5CQIM0m0wAy+4qpEquI/
	dpL/VEghKWNoMdmtRurjFeSQB8Ay9i10PnGIeqI0LFgs3b0cZchfmgT2IK11pjTMkFvQ==
X-Received: by 2002:a05:622a:14e:b0:51c:805:1be3 with SMTP id d75a77b69052e-53054988345mr72807611cf.31.1788542481816;
        Fri, 04 Sep 2026 10:21:21 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.54.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305413de31sm25321911cf.13.2026.09.04.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 10:21:20 -0700 (PDT)
Message-ID: <6a9afe10.d1a89f1f.3c18af.9839@mx.google.com>
Date: Fri, 04 Sep 2026 10:21:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5996872010593058032=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: arm64: dts: monaco-arduino-monza: Add support for LGA WiFi/BT module
In-Reply-To: <20260904-monza-wireless-v6-1-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-1-d8c5042b3efd@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5996872010593058032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:2259
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5996872010593058032==--
