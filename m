Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D453A1B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751417; cv=none; b=c3iBf+dRKEru7f5TfXzlE7HjL8OZ0kVufRXvWug8b44d9HQp2YBkbhC6jrZUhmblf8AGuux9uBrY+E/f2pVay+SGADDU/blcDa5lgfZX1ZBjqD1IX5CfXJ7Y2Rm/gzgh0hceVURqi2EBgmYFlBq172MJq5vXvkY1waDPJY0em4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751417; c=relaxed/simple;
	bh=b+JEn8wTm13ZBmu/kWfyUYTk6xGkoTmxULh648ffYdM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GK4+hvxD81tPeSvenUdHOv2H1kLCqxYn+4w5kO2mhaufA5Uns9i7VGLanAajLSGPnYh/5zbngGEqikzvGLqQHn2jVdikuK0jad1i58oEWm3KwgAVIaySMZ2z5VnoEsk6iZcW8meYTPPFC9pF9E1GdTueYB5fVL9Pnv0Faa5heU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmQ6oQp3; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmQ6oQp3"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6a077a861e7so46144866d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 22:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715751415; x=1716356215; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b+JEn8wTm13ZBmu/kWfyUYTk6xGkoTmxULh648ffYdM=;
        b=WmQ6oQp3v9hTAjLAL2bapmu7sY1de0K3NzMZFkFNc8FxjSaADletHB/xYP5CHpJyoJ
         FMqTn5+DNREbZQAuy+cNglGbUZqRfpuZMSWTM27y/vUIdqg5oLPYc97ndVODdWXoHK/o
         TNQGO7xTC9/mMsMJdwBvDke1+U/tHZME/2oyBOWLZOBEoBCqvYHR+9/upcVOPUUvUj27
         ylRhL501XUpx98IZolNVMTAYl5yK5gmByyMhM6WqqyLD01mNtF5zYEcfRSSfiwe2/UTx
         VNTZb7ei0erMMlyX4ORDXG1NRMVBfjmgHlt3pQbA0myWu67VNZHgONs9+eefNY8+4LPd
         HIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715751415; x=1716356215;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+JEn8wTm13ZBmu/kWfyUYTk6xGkoTmxULh648ffYdM=;
        b=QBQc3K8gvhAJ/UOX9i9kBQpduhyHBTbPxSAYxoW5knfoOYJS4CFR7Lp3G0BCuwSKKQ
         owYkhxN1pPgzZhI5Hgwx7CJG1aOsDcV7YO1Y3NC0e/9+rkFrJFaGVehcV3Xk4ep3VId1
         4xrZASH9FELm1dmumE71KVZPzcijX1GR6BR2bU0PK+8ufX8YokrsGqMQcZ/HkFRDAk0a
         Z7zFrro1/LSW5cX2lEHPxlfhBfITzbzglF1vONYIKBPRWPlUROyvUr9oDpZgdwNIYEUC
         ccCAdw3wmysZKFjRQCjeQOcULJgPJJPNwl/EXjU/pgyh4aKCXh22rvQ4rUIHVEiAYWmh
         UH4g==
X-Gm-Message-State: AOJu0Yx8sRCZwH2Z71BaHPcvXQ4jMvgR/fTNwVudObmhV0KX4yPzCk06
	f3+E7bQzgatvLoo4sdm4a2d9LEl/J8DR/iZQ+wAOHskRMT7ZnSc4N4nkKg==
X-Google-Smtp-Source: AGHT+IFw67jugbiHFD/nskVFiBbcEaBqB3Scm6rjoeWHJXkDTKTRZ/OhUtB8ZyI74iDMRxknTtzj9A==
X-Received: by 2002:a05:6214:3a09:b0:6a0:84f8:6b85 with SMTP id 6a1803df08f44-6a16823d998mr191681736d6.53.1715751414589;
        Tue, 14 May 2024 22:36:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.121.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194871sm60858126d6.59.2024.05.14.22.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 22:36:54 -0700 (PDT)
Message-ID: <664449f6.d40a0220.2bd62.459e@mx.google.com>
Date: Tue, 14 May 2024 22:36:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3291789421194402635=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, SoloSaravanan@proton.me
Subject: RE: Bluetooth: btusb: Add device 13d3:3606 as MT7921 device
In-Reply-To: <hSVMHbHDWyp2u1NE5NY-bayU-w0Kxcqxyv2eIsJWYWNWB8jl3rHPMe1EWS0scP7hqKIZ7e2Eqvyl9LFzHdJdkZp5iSSmnNmSAHg_TL95DJ8=@proton.me>
References: <hSVMHbHDWyp2u1NE5NY-bayU-w0Kxcqxyv2eIsJWYWNWB8jl3rHPMe1EWS0scP7hqKIZ7e2Eqvyl9LFzHdJdkZp5iSSmnNmSAHg_TL95DJ8=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3291789421194402635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:615
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3291789421194402635==--
