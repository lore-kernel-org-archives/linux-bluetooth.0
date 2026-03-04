Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C83CE480
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650524; cv=none; b=cgo9jssf5ynTtWCNa08gwIUm3wDO8ncfgvuYXGwzFSzQcQFZQPaguOXFEuPbmSLglNYJIf6+OQTYZgBiQyXSQQ/gWVeKqg7fpMkjV3Qj/RxEpmizt4ahhnhjCKAbm2rI0DQbH+yfLRZRKk3JcF9aMbLqm4sxyQU1oLAkrehk0Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650524; c=relaxed/simple;
	bh=aSfNn/p8UFfd+7AWs4r2c0flZbXUr7Vlo6xsZyJIhrs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VysFSOnCWPY10rv124SyDdi6Bg/OwVXf/ELEiljld67d5oNh4lvZ6w8y6iAb3mmGDwm7vpIOGFCz2W/lWtOnP3NaiDe+oA5xxWbf0K0wttV1QwRn7rm4QLfqHuUDgqf2DDtQMQqL1F2AqrczyEXLfrm88QCXKO67rNS380e9x3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyjF5227; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyjF5227"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d596a5be31so6183612a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2026 10:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772650522; x=1773255322; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o4ut8gBjBuEtufMMe6tCsPFz8gBMJPSjPY0u95+bFoA=;
        b=FyjF52270TubHlkwf9JQ/cAzr/WO1SUm7tRA1JRgnsz8wdiOavOjzTe4UxK05oYcGk
         JgKE4Naa9hC55zgJrzabzvpk4krGttcbvcfDpoP9D2viZIiDgbqGoGqIF2aV71xsXaoU
         DlRo6e6iWGlqv9KOJjicZb41e+yHNL6asEN2zN7hWwNYrq2hy7jiR/nis0GlCZ0MaOPQ
         vaVL8DjYNLWnugYunZ4RUzqQaCgbbGiqacNOQtqvUJFnwg6uss4de+VdAZk28jrqqNv7
         2EolbOu/JHYkGb3IfqXasrEjm699RZ+GBn47NlnwTMDA8RNVNTGWSLwhnsx7FQTXJeFm
         8jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772650522; x=1773255322;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4ut8gBjBuEtufMMe6tCsPFz8gBMJPSjPY0u95+bFoA=;
        b=R7sQTuvblRRp3dm5HDjiuJMRHmJUbAeRuczxvlR9uS2FIVMs3BdnWAPJ/dcSBK+MPp
         jWJTXtluLv3tufOIkhodo/Jv4E9iNdOPyZp4ILolLl+z4VDoRiB13e0WQ8981MaCdIqK
         SWl5oJ5mqUX+jF86sT0MVQiz+Px1McTRCtcNEgUxZ8Y0jJ0eD1nuYP1gk2OpByO7k+ul
         uyB5xKinjoaY5PFZscXS1BxuroL94+1KgfRPVqAEc2YesKpEE2rlaivj15I8wXV6GlF+
         sXt/c/rRx+m781pgChUFL3CU3H+hEtxiYCP2XxJFmTI3vO4MDaSMpWDqhWflHz7slItM
         4K8g==
X-Gm-Message-State: AOJu0YyXxKNlHMJ5RWjZKfgBG12G6SAAUqBy93ChMLhQSxCOI2GGZWLy
	O+nV9lxjM18TXdYKTc/kq/x3atDmQpxRbAeBxzfXBVV3472WhX2tSUIIk/ynWw==
X-Gm-Gg: ATEYQzx/gEl2e7kRyAY4UmWL9cqq1ap746Y4tzhNFeQ+2HKmSnXxMs8E+28Y4ZMHN0h
	0sOqUGt/Cjmnwd85ETOSkezGsLPkARVaU4dThKmiTIsHfqR+frSfDwPDqbVxSJsB5zSkbtZDknr
	WxUc0xI65nnBYwBPme52wVfN/v+i5pIQcmxO6WsVA2BNraoQNBtoPKqLbv2Bazxi12V/VhuMNTM
	FjWzHg6bSVWs+XjtNO3ulTot1JkedD8KTxOb+kgB+Hcii9bpw0cdt8lIdoP7guj6j7qrOKY31hi
	BxejGPkh3wb4R3xJIS+/+TsrWI6+YzoeV2UyF2wTYkspjhabZxgk3YYGTEgtFK0gMdxz+6l0xoG
	UQH8FB8hIbcc+/2AHxU8VOrl9sG2OI7GmYKx7smln/3Iyru2koPNaAmVPQls1OH1w4oxxY60GIH
	TFL9B3UIZeG6c/BMslZn3ArA/+UU+H
X-Received: by 2002:a05:6870:3e08:b0:414:e37a:9b96 with SMTP id 586e51a60fabf-416abb66dc4mr1965493fac.32.1772650521765;
        Wed, 04 Mar 2026 10:55:21 -0800 (PST)
Received: from [172.17.0.2] ([132.196.19.19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b24dsm18705739fac.7.2026.03.04.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:55:21 -0800 (PST)
Message-ID: <69a88019.050a0220.378bd3.6dc5@mx.google.com>
Date: Wed, 04 Mar 2026 10:55:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3352402923658691618=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] l2test: Attempt to update BT_SNDMTU/omtu when using -D
In-Reply-To: <20260304175932.255741-1-luiz.dentz@gmail.com>
References: <20260304175932.255741-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3352402923658691618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1061476

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      21.28 seconds
BluezMake                     PASS      664.88 seconds
MakeCheck                     PASS      18.40 seconds
MakeDistcheck                 PASS      248.60 seconds
CheckValgrind                 PASS      299.32 seconds
CheckSmatch                   PASS      365.57 seconds
bluezmakeextell               PASS      186.43 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      1043.14 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3352402923658691618==--
