Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9CE13C82E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126390; cv=none; b=tA+toHprU1+7Cr7GvJryl37gHN45NMUXVovrS26o/ol1z6Z6e6PqDtrSKg9b5j0asSWrc15jC08NajwZ2zM2MqJYPHF234AyXQd5OMjfp3fydJn4kg/AL2gZPFtBOVBrPjOgoPoZjgn3TMB+Wm/Po1mrUsji0A+m+csiSv2fCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126390; c=relaxed/simple;
	bh=BlLiWWs/98H0QbCrmF8E4uU2RXCuwIJ4i1x7Koa5gpI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZksTviqa1SZxoNAIcQsjBez7wmiISy13h/za6vM8YpIe0vxJ3X5PkridJVJ9e9AYFaTV9Sc1C1ljXjNMRnS4bmuvFvIwvWRsOO7kd+5BhR4nokWnxh77SMJXyg5I+zUPug/nqfgjx/8L3s30U/FPxpNS8PqI4cu26k/qWKZeBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVe+Kzsy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVe+Kzsy"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163b0c09afso44226985ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 07:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737126387; x=1737731187; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GFovGVn+z8/m51o1Yw+2F2ZWicyVRL45gF4Ya1Gz2zw=;
        b=VVe+KzsyRNfmyEqiaBhDBcTh8pGAypAnJSP3WXb2k8sQA5zcUivqGBsE3WEa6sd8V4
         zfuUcfd/4m0FXy48nSvav4YmBkiXWjJQqshL4YoM91fmTfBdpv04GN1dKGB5KIflhsaZ
         1vFyDn+Sx6Ff7Nz+H5tdXZT1s8auJjuQ+8zYpxntPODm1EwVIFkQ+csCgrRedPdcA4NK
         CY7BassH4iD+sr4GpEyV8/kE0RMc7lC3vUT7k930ALn4SJDstdKVaP1+5QY6PUgTvnlC
         LBv+JggQDiaiVlNarq9HdBRERbR3QD4QrrQ6/nY7fBl5f1/zIOTAOCDtsdNoLu0aWLO2
         Jk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737126387; x=1737731187;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFovGVn+z8/m51o1Yw+2F2ZWicyVRL45gF4Ya1Gz2zw=;
        b=S9UDHlUkGF3hMFqb7n3KIUqUIwN4TVvRrwdRw1dYds3xftBs+Mk7i30ULfp61/IiXg
         LMQGE7fot5GwCnPlm/CSuUOXIDMp6bxSL0gLASxjouwObR+PCxs2QTNEsCmZo3VRTQBv
         nrrs4doBC57TTKSGxVgBlgcUH0Y7aTHx9AlSnLLlzxxyvh8CvqKbPMXG8QxXLd15vK8R
         p0G/8UEoQzzJG6V72jiDdrAlGlfQzXnzdDT+730XnDhCdctEdicUemyUg9M8oHV59oXo
         lQsF2RVNIfP63xImlF3jO9DYke/jyfpq2hFhNoUUt503zV39lUqwMUNSNrtnizcxz9UP
         FgsA==
X-Gm-Message-State: AOJu0YxvjBlOA4uhJ6P1caFvuHg94m222YbMT3GOOwDFX4sj1+szbYff
	Kx39KUSdGkVFElio2oGIUvjtaWgttIYIgl1c1gHoWlgSgfmnPou+Lr02rg==
X-Gm-Gg: ASbGncsdymgw6OBSMKiS6cT7hVB5/4+eveTIlDM5hKfwoux+Up6HqLOreC3uA+PJpgr
	2hRPwjAwN0zhvRZzjSsUuSW7a0OQd5Q8Z+K30FPwMGuBJ2JiduoVCp75javNt4yzkFP0pxoC3dT
	Ve1lRwOD3WysUBxCBCTbL09C7imjPKDd6CJk0Ytas4nMiMIqX/qsXnT0aC0oyA1DysAeWpJSqu7
	NYBntmbuGtPrCM8GzHoUk576+KM1cbLFhRjlwLGsPL3m6RqmUiiKW/hGBGHBA==
X-Google-Smtp-Source: AGHT+IF87ouldQw3b3nB5EqxqbmGgbPSWgAUAPj9Ilxiyudp+DnDvx/kdouxQMZkd+5qJqPSdMibXA==
X-Received: by 2002:a17:902:c950:b0:215:7dbf:f3de with SMTP id d9443c01a7336-21c35558d37mr46054605ad.28.1737126387285;
        Fri, 17 Jan 2025 07:06:27 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceba740sm17193715ad.79.2025.01.17.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:06:26 -0800 (PST)
Message-ID: <678a71f2.170a0220.171e5c.2d81@mx.google.com>
Date: Fri, 17 Jan 2025 07:06:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5858115506627069503=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: shared/bap: Fix BASE parsing
In-Reply-To: <20250117140632.120501-2-iulia.tanasescu@nxp.com>
References: <20250117140632.120501-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5858115506627069503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=926463

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      1456.82 seconds
MakeCheck                     PASS      13.06 seconds
MakeDistcheck                 PASS      157.07 seconds
CheckValgrind                 PASS      213.06 seconds
CheckSmatch                   WARNING   269.09 seconds
bluezmakeextell               PASS      97.96 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      851.68 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:296:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5858115506627069503==--
