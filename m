Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E617A2E8
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757237; cv=none; b=WmBt9ONB8PecJgOvoU9XJcgH4yV7auAJZPZMkmbxLMeJeZ8jk576u66XWsvoHixSXLr1JDXqfOkTGkNAvB3tsf8PigCKwTN556SV+7K64pIS+WrLQ/dv3pIKmoh3XDPSYauwEqRfVnEQXY4xRRyYtEO27b/I4Hyfja4/QspiKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757237; c=relaxed/simple;
	bh=8GTz1rabJx8tpX9SBybABOnj11yNsDM+8tQV+GVoSbk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IwHi8M2vNTnDkypweitI6sPn3j3/3bGA3IF0f05j5e4HbS/FSREMdBZ/dZSsv+KT9+5oajAl0iZNjD8QRG9Ci4epH/T9HgWFuZdtrqfrn3jul35E2pFJrRsmZmpp7q4W+m6eotlb34oo5t/vaGXSdkIbsKf6sKxNmGhTuQy9L9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAGhTJgh; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAGhTJgh"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8955479c9so18899676d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 07:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740757235; x=1741362035; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8GTz1rabJx8tpX9SBybABOnj11yNsDM+8tQV+GVoSbk=;
        b=bAGhTJghryjua/ox33OpGiLf4H/1YRT6g8A+oj5ZEWrjdpPbbtY9Ag65oQ+syifwj/
         OHO8wLjLXRwIzZ9FGePAsZuWegF/ZFwyGKB5+DVXbIg655xKPmjXvJoXjm9zsAAJ+nlR
         JNCLfCpPhivn7yu9HCobhi2kb9l/iWV7rSLvTsIPITmTB22cJR5kZ7oM5pz6bYqItV2l
         5T1UFt/uJb1LRopYMoWYXkJ8i3SziaQW5SK3AaqMv2dTkMo07GNszCpbfwHqp2FhZd5g
         pxEo83+039d5wsNciXbf7gbzznTZhK6/xy8sQiltoXUnZl1dynUkkV6YA4gj3rz8KZLL
         XscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757235; x=1741362035;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GTz1rabJx8tpX9SBybABOnj11yNsDM+8tQV+GVoSbk=;
        b=ejJSZeomkHPXgfxhc3JRvrywxIikKrxcFspU+2aX1lFWSrNV+y3ipVvyHr6LTzQ+TW
         A2d83Nb0tfQoKZTOx1MXS2R3Hv+SnyoABs/I+KhhlWyfOyLLT4Z7gmgXsdxwMm2zMZyt
         aTkg4PqU6VIHBPCYaHH6taHyLxWpxoqISDpwqtRe7O0tv165LArDtKz88NfYvBRX2Npk
         ZqXnaBCgKnS999IcX+kLDjI4RPTm8wemmNsUxCLKj+hFv2soAu8Lt/3VV+3NeOUdiRSq
         SVAY7jb9W42C2EWJyGJvKnWXV7cNyT4cbYopcIETi94UFWNA4zXIX9JwpRhX3hjjbTzO
         NwAw==
X-Gm-Message-State: AOJu0YxOhrJB3bFmvKwaTrxP/QwfSnwqBGRQiLxv6Ygyaa17zP4GYaHc
	kAI2JnJFLSd8f2mcWHzv505ORk5brGLHHlTwSkCK3NusomITYuoziQxFrA==
X-Gm-Gg: ASbGncvqDEu7r1UL0TGJZXJZWkf0j/7BDvOcgb5naFgAULFSaRNxUlIUtsTmTyc69E5
	wDQoCCsyk78sw/ADF72LfYb7FxLMC5CyBq8eDWvqIUN3eCXTAyGvb3/n2QIftyWnc3zXY98EJq9
	EOSPmc1kcll32aB6ptTpAJ4ru/xveWsqB8lPixePhOE2S4bEPPWED0bbETFTsN7EV3L00k5Xs5G
	IfmqhBRLoRPb4c2WISn2IzYnLQTDBdch0Z5hX2wshM6Pdqw/JdOoApEfyJ2kpkbdpdMVjHZGbno
	mj1WODBmziAtU7ryK4uzNWHMd3Y7D65o84s=
X-Google-Smtp-Source: AGHT+IHTcxGBj0LMJhv6ClP1riQNwo2E7dhnUrG6NK/LS0+mWsTTcrPmqageWeA7lAqjMLiGpBjx8g==
X-Received: by 2002:a05:6214:20aa:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6e8a0d95f32mr62725156d6.38.1740757235126;
        Fri, 28 Feb 2025 07:40:35 -0800 (PST)
Received: from [172.17.0.2] ([172.200.181.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee995bsm261748685a.11.2025.02.28.07.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 07:40:34 -0800 (PST)
Message-ID: <67c1d8f2.e90a0220.743e4.a0d5@mx.google.com>
Date: Fri, 28 Feb 2025 07:40:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0748745687952045299=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v6,1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
In-Reply-To: <20250228152917.5432-1-neeraj.sanjaykale@nxp.com>
References: <20250228152917.5432-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0748745687952045299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml:54
error: Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0748745687952045299==--
