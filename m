Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793319637;
	b=OrG25bAzqsubyOgJLrNmK7k8wBb4gv1u7w/0Y0YSpdL15NMuZ56plnALbSAmnZ4TPIBy
	 jTRwcAwFFotFVnlfhWXyyqm3U7BHY8VQ6qFuUK2HGmcfxcfwpLNlbQ2q3y7Mvc2IqGsEB
	 9ok+sKpITcDp1DvVsWhAMjKJFUQmmrPUAmenEc6lRI/+ChHFAjHJ0fhX2TXESsoCpzGlE
	 6h4guaM5In/WRt0ra3zr0dwVWtckj9Kr2XknF2i/s+nptB7efap7krsFhr0PHNiKuXc7v
	 rWnsnY3hthpCwlgH8OsL7WPeZNWkQGh/XiGIRwMnAZ7AHFnzPO4AdsqXVct2nuvSbHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=s8ayBCFMQmHCBmCTudPYjc4cfR5SRhheNy/WIz5D/bo=;
	b=tCizGiryTaRmclzl0o0jJB7mBSQJAhbsHFbs7K6UZimHCSBa2pdDSLC92k9M5IG6pGeY
	 +1pUyk3LxT8PXZaK9IDzbL0loXv5jV1HmXsP96QQbxMd2pwktf68TiddobFtViFoIfhri
	 cOv46/Qx38fgApIxSyktBgCNl4t6icVXlWOgtv9lEeYzCfx/Py7Fusff2et6dajKd/kKi
	 pPq0jjZOuycxUztKj6VcZyx+6JiaFnuLtf4a1wZ+ngbWMvBD7kgAzCK5Q7uBKV+V2oo3Z
	 Bq0PjGdNK01XHbmSrGp7wV6l3hOf2aQi3oLauVnbRMVI9ySdKovYxBspVoQaMn8C91g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+o+4ulF;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF4606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 00:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DCF4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+o+4ulF
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso291115eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 17:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793319636; x=1793924436; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s8ayBCFMQmHCBmCTudPYjc4cfR5SRhheNy/WIz5D/bo=;
        b=i+o+4ulFs6CNsVOZxMjy3ImFpRkto9mH6h39beTgIPN7DSHUOEJ+GOVrqCRkM9udFR
         JXSu4YrJDDe/JpYDzVTbWN/GgTV9ZwUb51OxhPXtc6mom+1FPWV+m6frvZXhFNqR44jQ
         8gBZUUxP8cyAet3Tm/keKWk6tkJUkguCVh/PE1Cz1EOkN5RTVInNA+ondbHoiwNRxlBr
         QBlvQa9rt9xD0j9q9YbNs6r/cs+YmE/ZVB5ZVvlqUn490OErqF/FMzLgZ8szeB5JQX4W
         znKGGq6fgdn51F3tNTiyMyIfQN7LOet/Qa8K9DETf2D3c0f9h6sncr+C7rhLwPb5YDlo
         2i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793319636; x=1793924436;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s8ayBCFMQmHCBmCTudPYjc4cfR5SRhheNy/WIz5D/bo=;
        b=oJRMTGh5iZQkq01Kxznw5EbKleAc4cgMTGwWDq4vFo63JzRXo8begtTnqtZEjPGbIl
         IVST4RdCUnJ75pujhg8UhKRBTQ2ddT2SON3nKRwXN28yP+hsL9nJVygWBUYxsL4NJszR
         Z/Y7U9oxYEakLxtSqFq9LWFgvnzfyQRWEVgqPvOekfGFl6nJiET1E+3cgQbdN7sNGggt
         R5jBOxja76YKvPl8IGicfdiZ2zp6qvtmmAK3bK4IvS03LOeZeUeqDzBUnTKpHYldnh3z
         YUZP62uMdII2HJxYFv26CAn6fcdZzundCBd+TPFzRWqYkA1ZyeFOiToAh2GKUq4CFWF/
         iRXw==
X-Gm-Message-State: AFq9FYJzyRDHsPZkN4wcVpwaChIWNb7Co3bV8B5/LI1qbeFSRNyk1KKi
	Oux4uip6nkt2ia/ieIuO1P+aIj++4EUz94110w3pDvQ6TqEhEfrMh3XP8V+yCg==
X-Gm-Gg: AYBFou18xmjCCa/k23nb9C6xibiWKYSiVLkI0XT39j0jSYuMn1VcqeyHF2mchDuDYii
	CCL44qx0quFj+YE8KAmTmtBR/6iJdWvTV54Ovivtdcxsl50aQHUGBC9vLozijWASDpeRbbNV2NS
	29IuRrH9nFyaWtFJzgJJyiEGl+haQGeYCeOT8A5P1Q523qa0vHiFygafhDbF1jeD0JAqR6VGKjD
	w+iX3E2jxdyYKgrinX2vzOj/JdXvVmuejj/dAfn6bVCbxqzYRO5XwtZF2+Ybyt5eyYH+ndkQ4Q4
	EY4GuYVXbC/b9pNsCrUOvMWVxHcMV5KMg7Siu2bkn0syYwEaFhUjzdshywh11X2jh/HO06J4A5J
	U6VKW56gsYWjdAIhXr3hpMIXkUK8yuupwdSBm5gWegPVeCMVunxiPKWOZEMNbex2dCjgsowqXxs
	PUSrBC8e3yIrVunh0FP7QQ0qpCzd5j6ExiOtHXoJqkDQCtxEnUGgCrtLubPZnTUstJS6TBU+BxJ
	tOSIzjqzBkXmxhPkx+cePj8pJlBdoGp6D8nwbJV7mq/Ep1MbsQZ34R5F+Ij9A==
X-Received: by 2002:a05:7301:3aa1:b0:36a:3005:aa65 with SMTP id 5a478bee46e88-36a4236cf4emr1099058eec.15.1793319635980;
        Thu, 29 Oct 2026 17:20:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.83.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6eabbsm2031005eec.24.2026.10.29.17.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:20:35 -0700 (PDT)
Message-ID: <6ae3e2d3.78c6c619.15cd85.0285@mx.google.com>
Date: Thu, 29 Oct 2026 17:20:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8417999134635049925=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ismailtarim7@gmail.com
Subject: RE: Bluetooth: btmtk: fix error handling in btmtk_usb_isointf_init()
In-Reply-To: <20261029224022.1233751-1-ismailtarim7@gmail.com>
References: <20261029224022.1233751-1-ismailtarim7@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8417999134635049925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1196677/

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      32.74 seconds
CheckAllWarning               PASS      36.93 seconds
CheckSparse                   PASS      39.57 seconds
BuildKernel32                 PASS      32.49 seconds
CheckKernelLLVM               PASS      34.45 seconds
TestRunnerSetup               PASS      756.08 seconds
IncrementalBuild              PASS      30.87 seconds



https://github.com/bluez/bluetooth-next/pull/1026

---
Regards,
Linux Bluetooth


--===============8417999134635049925==--
