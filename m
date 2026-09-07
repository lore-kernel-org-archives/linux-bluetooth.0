Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37144F55A4
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789563; cv=none; b=Oq9qPk3jSatnply8JGjr2UeN7WImTKw4V2s43p4/zFGJyKp9gErJbQJJ51+eMipsJYKY7ZJWFGIh8HPpzbsYvEtMG2cAtGfuwTlpYnZJa8zU8+eR/ECm/lPOV+6qc+Eeo8/J9VFR95CdQeQPs+pwGniQ0KMAZIAnEH4VDmV27Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789563; c=relaxed/simple;
	bh=DK6aN7w5gbXKUCuIG3RENmmkBIn0jsG8CgWWubCEwig=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pCDrogQ4Lti+DrNzXlDLebUw0YmhEoZIfVVqOUHyUm84dT99/npj8x2EQquU/IBqA0y/JF5F0Nc8P45Un/aFcg+w3Y18b8RuUjaACsqlMJCtLK6KIHc8Rs5+5j3OdV9fVdrzAm8dO+qNWfjgpIwMvdwwa74THpzVWXMzAL/Yk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efs4Y3tx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efs4Y3tx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d6efd73032so38704165ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788789561; x=1789394361; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DK6aN7w5gbXKUCuIG3RENmmkBIn0jsG8CgWWubCEwig=;
        b=efs4Y3txkYrgHJzEg/Dy5hRsO/xVHujVOtZOh/IDTp3wjyjePGA/3mz7PvtopWGaKj
         tVFM+yrhXyfK+Dvmx7wZTHanEOkvYsaTdHwlWetVlLEg0w7YlqSxLYZOPP0Knhqs8w/O
         9NLaIpuV65uMFeA4UomyQS8FR/+gx+2OuVJkR/60+b9gTLMkm51T/EcHteSCbLECqBb5
         O/vSASsdLikIIaTKOMapfY/sMOSV2mKg+oViTSZ2Mo7wVrbydE8Mcuam6ntMvu6tun1C
         ZXm25A3y+Lzja6aOit9/uC9eZuhIqjTbN+mWHE2Q05VIOrtrSZIzav++5DhcPcWZ2Cc4
         DC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788789561; x=1789394361;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DK6aN7w5gbXKUCuIG3RENmmkBIn0jsG8CgWWubCEwig=;
        b=Pp/5TCCfmqYUTYdm9XyKOiH1Df7E6V/MpCdz2M1TrBZLNp4DsfeoRj+3Cz8b3tiMA2
         Iv9nrx7FlIf7pkZtjjMbCkNDcV1UAaZ8LEoYoGNe7ZQgi/iMCR72scBKtqXF8UQkPhWv
         mKuPZSr5Gx/jxNNUb263Gq49YJeQoSDbMwAfTEuBUI3kpojaq2lstWBEG4I8PRdEHMdx
         bLztzhqf0q+6FW/3PaIuhsyLVTHCAoCUde5xgE+oJjbC1Hd0nUQ4H83UOjBwymImGuwd
         xlN4iVW52SrqIvZ7IgntjtMSGqYZzTUV37yXrYZoY7aTj93xG6qdWlOPfWqJkvTLNvq3
         /Kfg==
X-Gm-Message-State: AFuF++mSHH9tJLGEqZ1I0aoGtNtLfciWUgs2oWMGhOceTj+xH+QbDt/J
	kCUG/v8i195am9P5f35040iBOM75aPHcsGpBK5TiE+x7u4ATU7h5lFerhn8pew==
X-Gm-Gg: AYBFou2fxWbri3KvDEAN8jBinodRv8GN5SLfZczBUr8tGPT2ZKvFqvsAHZK75DvKeso
	kDf6isBl7wpPnnaqwfVqrswt//Dkfj+3kCn3lOYzXUTFNZfvbC/Y7ObeDqVKbzhkB/PcZWKJovQ
	i/QnPMYSkvzi1FIxKOE8ae4Msq2DlmUO//04jcqFYWRFoTQubLdZ4nLhAb5Nhcz/pv5FGU/PUDO
	ikyWv/JX5r3RGYK4J6Lqmbe40vRC8MPuyEiw0KOB765y9ZClVeyti2b7kevktfQ1pvpsWpB2CUM
	TogoQN7kiU5gbRWUSWdwolPNKCOXzJA4IanOCmUTIagim3VniXtzAKyjtovwK3uKNAV3dS2a8wm
	BOH7KZeBDUEfgV127iOXBVvfVQ8bxGxbkdzOypYx7Yvsm03bgY1J30diVwkHai+H/a47KjeoaDf
	3fzBhsWbZxDDeqOAfBsyIem5EgRnpL3d3d0wavT9Ve+2wi0mjlBgeDoCwXJpUtopduyFaL
X-Received: by 2002:a17:902:c951:b0:2d9:2b1b:878a with SMTP id d9443c01a7336-2dafaf60ec2mr273740425ad.10.1788789560703;
        Mon, 07 Sep 2026 06:59:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.226.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm28703685eec.19.2026.09.07.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:59:20 -0700 (PDT)
Message-ID: <6a9ec338.de43c058.24771f.7437@mx.google.com>
Date: Mon, 07 Sep 2026 06:59:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8200937935417186389=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btusb: Support Qualcomm multi-subsystem QCC2072
In-Reply-To: <20260907-btusb_qcc2072-v3-1-1f65350b03b8@oss.qualcomm.com>
References: <20260907-btusb_qcc2072-v3-1-1f65350b03b8@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8200937935417186389==
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


--===============8200937935417186389==--
