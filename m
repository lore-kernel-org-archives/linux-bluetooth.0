Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E52450F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Dec 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735208141; cv=none; b=CSMxMudst3dDfVw4FcmuFyg2EWc+P/YXj5jfcRiFNmYp3R6ABZnWRaN7xAKnbfn7hoFEuCtk0KdXTuhHgsiIAkGFqM/+wwxupM1rjfpL6Cz/7C2AgleRhB2Pu0vBepJ54G5yRsWP4/5xPHaQgMe3zCztrg92fPZDDmiE+49TnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735208141; c=relaxed/simple;
	bh=Ym18IppCEncEcVLphAV6XXXEJFK96mg3RynNp/Rg2w8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FNC7N97hX5rcYv1aRV+DL4vdN0HerVMCcXYRg+j9DyOrYdm0Y1jSEJhw1SaA/Pwh2XvzbNGwzPDaop3dOVnqRbs6a+YVk1HG4eb0kQOKV8NTOqK+o5KmDTGm6gqOUq+8BJrFlJROSECaeL39etO5ssMRGFoxter6BR8D9JETjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIM+pfSu; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIM+pfSu"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6f8524f23so677379285a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Dec 2024 02:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735208138; x=1735812938; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym18IppCEncEcVLphAV6XXXEJFK96mg3RynNp/Rg2w8=;
        b=EIM+pfSuu8lQwSdpNtyPQsMQ9XuClFNEcrT6xzviMWhz1XTgKsK2jMUFAZKk7QDZAk
         BtlBRZyR8N7/CX59f+JxUnVQhckeF+LnTcyFdIGNAxRhhkV63z/dZgFMdjaCamZIl+Dp
         kYwzDOwG0mxKcqr9TJyCbR9c5KLIecKk+JhakFePJjLbH/EJa/PnTFhSoED51GZDIwvK
         PRiP4gUPKW+kLPYgnp4EPJJeBVg/JyaX3o0NfY9fN+kZN0EcLXg5IOP9sybPKKBVhHmY
         oJaZlc15tS7Di/NDfs6N6ZzbZexOSjY5R/0WwkdpcoAENCnqw8nFEJvVGqYw0P6XGWB8
         UsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735208138; x=1735812938;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ym18IppCEncEcVLphAV6XXXEJFK96mg3RynNp/Rg2w8=;
        b=ETZZJ7x0e2wxwoGxS0MqQr4/pMOUg2sQXwNQ3jg5hu3EAOyUcsVE8Axri4njwMS20B
         4mY6zLeeOoWtl5aBUQcBE0jKiX53TMBXDyQ30HFLIexWUKSUIIa+TOyJ0sJGeA62tBPk
         joM3LEJifKvaWDCKaL4oQvdGm2eNRv1Nv32FCNW+QyNphOyeE8VPmEcFwbjQAoo0BlcW
         qfbjNnfWIwSWErlBY9h8+mFZryRvn06DrEfZ3NxYwn/nzHv/R43PA1Y0aiwQrW8xr8t5
         QJixmh6klW2GXakRZTMRy99eTQm3a5NfqUvWImS7TTNBCp9BdTOeepclJyHodPk4LuEZ
         8qAA==
X-Gm-Message-State: AOJu0YxFgz/hviqbkN6ez1DLuFuwPe2SMuJb8gLNx7Iq7kCCGvcDL/fM
	vrxTBj/ymo42hzXTFCG/JHiOh2ouzA1R/Z8GZDEmaijtCb+zFBVo4V+qXQ==
X-Gm-Gg: ASbGncsd4NV7Oui+wlaEstfCnoEeIUb5fm4DentsYokV0+4e+kYB5yHEDpBUnILfUzx
	AKdLG81ccsH/AUyNt0+f5WJehDJZaQgzoRPgDhpbHwNLrXbxQB6OZ/6tRwL26az9zAcGSDuIJ6C
	uWA7VDzvZwTTiWS2k1CZhNC2MUm4dCALXbQFunJC+OPRRvUQoKOL6J03pyJ0uWepblSRP6O9l0l
	mEcQRk28PKiPQDLX959J518NP81NMs6D8Q2pehZtpVvG3+MqKJhYOzqxnvJJ3k=
X-Google-Smtp-Source: AGHT+IEKu/+jnjpd08k8IDiQ/2tFko6mLL5cf/REDlmtZJhiW5siNo4ATr+IWiQL8jWaH38k1wiLoQ==
X-Received: by 2002:a05:620a:31a2:b0:7b7:142d:53d2 with SMTP id af79cd13be357-7b9ba83640cmr3348507185a.41.1735208138239;
        Thu, 26 Dec 2024 02:15:38 -0800 (PST)
Received: from [172.17.0.2] ([172.183.37.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4eef11sm609953885a.126.2024.12.26.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 02:15:37 -0800 (PST)
Message-ID: <676d2cc9.050a0220.15a4ff.377b@mx.google.com>
Date: Thu, 26 Dec 2024 02:15:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2677626877214991390=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, d.privalov@omp.ru
Subject: RE: [5.10,1/1] Bluetooth: L2CAP: Fix uaf in l2cap_connect
In-Reply-To: <20241226093539.44806-1-d.privalov@omp.ru>
References: <20241226093539.44806-1-d.privalov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2677626877214991390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:3245
error: net/bluetooth/hci_event.c: patch does not apply
error: patch failed: net/bluetooth/l2cap_core.c:4272
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2677626877214991390==--
