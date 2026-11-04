Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811360;
	b=OsC6xNttB0YNKA5MYfB9B8OkXuhHJIgx5UPQzOGfVTbaSeFYScmvRD6GqDgwu8NhBbCI
	 wzcZ3xO8zUn4aWQtYzRWlXLF9Bf1ilU+/pKplLsURqAZ76v6M/xMQ+z/eORdRW4Q+eAjt
	 2LCpleE62x4Z4nGuiBE5iQgvtPWuxMyneSIO7nGXaBMi7j66DT8BdVmg9ISKvhc3UJ0pp
	 Sdb67ztwhT6j+1EVuydGd680X9r5K23YWbAokcX/2IMbVlI+X8yba3AAVw2HqpfDDBvRs
	 UbVJ3ZRVN4+KAfbyh2DpgXMra0U6aq+wgpC2Ow0LXdsIN8/KOCQ3bSdGRDGAkrHMLtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=DHDz29tSp7VOS7rwo34iVNBckabPmRyRA5EzypxLx4M=;
	b=OSjhDZmZYECvz2oey228sGqtBiT+bWMAN72a+gQyGcauKbtrUKHumysr5acIJ4/dvmST
	 RLiI1PYE+PV/JGTB4adr2ygJg+GNRfAwVj4tj01MSxWnVOVLLWH5YTXZQk1WoDOnfiEUC
	 gQoEnsZwmI3QBCJC5IS3jTlYl2aA6cnjK/z00urQ8FcEAoMHqb4yQTw4uUYoZHnWicwkS
	 Ba6NZ0ZRVM4wbFmXrxH7O85+XrOTJh361GRU0GN7MGlbneZ5/RvWS78m7H7HhJQ0XeWHg
	 MLX5V+DjvUoC3IO3SqE7EuMCC1lNmuSRY9INKAiyGmMXz5kA5R0SLUqe3Rn7oMa8wuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qV9XAwFS;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DA606A331
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 16:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 956DA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qV9XAwFS
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6f5a0893610so634980eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811359; x=1794416159; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DHDz29tSp7VOS7rwo34iVNBckabPmRyRA5EzypxLx4M=;
        b=qV9XAwFSIASrrYPgEpjus+TUWu/G5EauVVTyNz6VF/CPJsTZ0pXJeArck7TEPpr2dR
         T4wdd4PyuyY0KB0XH7NiTkP1MQE+nf7vR6o83ZQT6b1fmn5bWJrzChE4/npIs5HPi0iy
         StPCATj4nCUrN1o5nZ+KbQ8IJSoEesGApgTp7YGK0JrwY2C2LCqyxR9qw9LrIpVsIGs4
         KJRNDP+nWUaYFU1mhfDsZv9N7T/ezmED8FcZwE+oBxAXkc5JTLU7UYQYVWyofsATogd3
         SZdTF6w160BMjs/jdiNl2D6XICxrN23TxZMnXES1bb7/bP9QYR7JUSV/fWGOUZ06ikBu
         +FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811359; x=1794416159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DHDz29tSp7VOS7rwo34iVNBckabPmRyRA5EzypxLx4M=;
        b=wNjorCERSFPRM2XXOVWleiYeCo83ypnw9wtRvP62GU08Z/Gygpe4gOUg2MULv0TPD5
         6LY8yyppmtSG1NuRIf0NQjdiV9N+rBRjk+6AXEb22jQiEWSTNjGtk1rSgbyuo7pIXiPU
         bCwWpw37PuGDOV00Vtlq2Pa9jO9gWjpBenK2gk4/L5eG8JhZ223hWYNPDmnyNDH6beBb
         jseESuVC/uS2gf0ja7trty3L9YfnBs48ZyLk8ui0cxWFyGchRdZJgF32AgPrpNFGtx2I
         RWR3mX6eBjq4s8mm4QcxT9p5G10ycMPqZbBWv+J+XqSpUmKFAq0BzwvL/sVRTFIBVAuz
         ZW/Q==
X-Gm-Message-State: APuU4Z81/4jxELHmxaI/ND6Jh0ZvX237Vynt5AH7x8OL74vULbszaFGB
	uguk33DBKWnYce1h5HRYf370FneiJA/nTxVJ/egwfF7TdjRAl7NTWuAKbWIRpg==
X-Gm-Gg: AYBFou1nPltBynWwB0Sr6+25eq+a66MPdaBTan3Jm5gvk0WZzbHCevbgYK9oRMksj5h
	EF4EZlxy42KlY9c8QhHf5zv7eofuU5d0g53anXiIs0ggojBLxv1UEwYE5Gacj3p5MVOAjZdVqtU
	gP0vASoViZOcFDc9YxqOGWiaEk8pj5mgenlVIWpmSht8SFnevN26V21K8N+B6mxWJHwJ8Oy4jnB
	Qh3mLXudrRsRzkIktJzrknj7qGd5Wqt0zQi47EvZN/qDKy5sjzHNGSY4chX8C6tit4Ojr9zn7m2
	l5S7/ulggZ2IFhXbd+wz9/cv/2g2zQYNEaglHa5IxNmEJ+C/wh8tNTqWzTYkAkCDzqwCTcCiYeV
	OUgH5ahHfVSmT6uTgL5Uf6259+6DCMMEjEF5KAmI2FgRtgqqjX63Z5i63jg9DkxxCPI7EGjfQmy
	2aztKshbfKeTQOcJgleeXS5WoxX+zluBpShcqmIVejmHUN1PfvgOdXSTgFr2cX1BO94Kw7AsvUD
	5f2GY5qNk5p6LwEhr83N+7RW1lfNdoRCa+3p8sGL/AAR3gWnBehxfJMwWPRjsUoMw==
X-Received: by 2002:a05:6820:1ca5:b0:6fd:e28f:ad38 with SMTP id 006d021491bc7-714f29bce0emr8874066eaf.32.1793811359237;
        Wed, 04 Nov 2026 08:55:59 -0800 (PST)
Received: from [172.17.0.2] ([130.131.247.118])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c1308c96sm2087450eaf.11.2026.11.04.08.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:55:58 -0800 (PST)
Message-ID: <6aeb639e.87c3a088.228e9e.5ddb@mx.google.com>
Date: Wed, 04 Nov 2026 08:55:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2035084066461213939=="
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
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: obexd/pbap: Update PSE support from PBAP 1.1 to 1.2
In-Reply-To: <20261104083429.4111632-2-jinwang.li@oss.qualcomm.com>
References: <20261104083429.4111632-2-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2035084066461213939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1201470/

---Test result---

Test Summary:
CheckPatch                    PASS      8.55 seconds
GitLint                       PASS      4.70 seconds
BuildEll                      PASS      23.33 seconds
BluezMake                     PASS      197.66 seconds
MakeCheck                     PASS      13.22 seconds
MakeDistcheck                 PASS      105.32 seconds
CheckValgrind                 PASS      164.16 seconds
CheckSmatch                   PASS      173.53 seconds
bluezmakeextell               PASS      69.20 seconds
TestFunctional                PASS      885.71 seconds
IncrementalBuild              PASS      250.73 seconds
ScanBuild                     PASS      687.43 seconds



https://github.com/bluez/bluez/pull/2760

---
Regards,
Linux Bluetooth


--===============2035084066461213939==--
