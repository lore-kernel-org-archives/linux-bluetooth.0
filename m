Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443876;
	b=ueZkGrEpujVgkc0seygC18aDB7kl7HAl9mieyvy7AkilfDEAO6xsqeRkDAXNLPycOIhH
	 ieA/U9WYItzR2HOPlE+LOaMz7rypMVwgG2uL4pi46btDrewm2pkACA3hchqgPcM+KrSYr
	 W4zxk46029bNdHBFB+tcF8xfCcFY/lgMKjQ+TJWAFlZSyi8p6Xnz446RBFBMxXZ0Fl51J
	 thartojVU2UZVBI0H8d9mkMSF9a1cd/b8KjL1kkSij8pafaD3QLNx8KClU25IZ6oXBxPA
	 d0Y5PsCZIXubRXnBW6wkabNqn8t/gbEOd1GzbHFCzWa9seDfTVEpvC+fAgxp0dHFwmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=cqhLm2H6+TM2o+f2/OpzYav7i2NlFYN/YUnrQy2qSwk=;
	b=Cw2efJ11QwQr3ul9j+hKSGYHTsDiqaVBdcC5gcJlBLL7jf58Ed/inhzSmGBOzWUgN8X2
	 Yw4toAFMQ1FraXTTFBybhXEgHilCGbatEaQwQX1R6BOapRM6POjE52H6Runjq9O4TpPjY
	 ZAfQf4Ewi8ZD318M9+df/m9fKf2KN8Ecswd3Z3ddV4xGnsLRjmYGl2cRa2tEOW8t7Y633
	 a0aOg9LqMSG39vdZxXqr1cvj58yUVi3hhgD4HtHFxeoJrn4+wQ9pqHHyqsXDhF2ajv6Wh
	 hV0Sxz3j5qo2ljIZmyKzVttq+lKMvUnyZftsH5n35mMWslt/Cm3IpYAahuofnGAuXSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qILx1JNb;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D9606A32A
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 00:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 815D9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qILx1JNb
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso1833652a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443876; x=1795048676; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cqhLm2H6+TM2o+f2/OpzYav7i2NlFYN/YUnrQy2qSwk=;
        b=qILx1JNb0tswHN4buAuW/EQNiNfrILbHLCCwRiUH+DH3gDzsfOeuN6Ug9K4KIJICsq
         ViztsNiGsm5K849WT48RuFQ84F7kVPyWvAVq/OvodNeLoKaFhFuaWQlIBNmxVbjUKV8I
         aj63oXY9O6PhSu1tDlZ9rcTQQWAkBYK5heoiwR97G6wvIBcHxPDbt7bBmCPSynEUxCP0
         ZF7UNNKc+N8xc+y9gztQgfUYO/IldO4kHcmmgp9praQJjktKLEfkDRvKoSNnbEFn4T5b
         t6tc7ma7CeYt1dJFiBGe6EQOsXqRE/Dio8XaZLbfO+TrRDwpB/iywV1j/QCZn/NpW23G
         ffNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443876; x=1795048676;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cqhLm2H6+TM2o+f2/OpzYav7i2NlFYN/YUnrQy2qSwk=;
        b=fRCR5ZTtvKG8jPgmNmXwP603j7ma23hbZKWO54Bi/aXJCBI4kEYboTR6dAuXs0R5lf
         CnZwB7Tph1pJyYJQYEJNFiUUb5579UwHIMth2/0mPEMP1e5jdlZ84lhbEEm+EO5YMrTM
         MB3fqEy3OkUsIdIdc8+rkQdfezDmsLKs5niJyYMg1zOM70s8fwRmk7o2VKJDzXz24zZW
         GHWc4XH2nISGXFSWF9qaMK9KB5J5F4gv0OeQ+H0w8Jzx92SS/TvA38NWCd7pgtdE+Tbj
         ymiflL/vLSrJMxTs3sUiVKXq0kDLnkZVJ+nvkzlbbV9leeteh/6M+HAW6RTHRqcFYyd4
         +PjQ==
X-Gm-Message-State: APuU4Z9st5Y1mjDornaHtW6xYbKQdURrScGZL3RnpXEvg7dbCjadr9fR
	rReHNu9lzCGIK9jWN2uSvFKts6k1fhjnKLLHr3LQt1lUthCVOgaKnbOaYZ6YZw==
X-Gm-Gg: AYBFou2Rrh6+wkK2two7kUzYxEWnDh2ELWRPniTta1qpj/Up6l3JuPKzYztCVM+5aq5
	Fq+U+33J6tFmPHdxfZb/DcRjF8LDeWXedVM811jQGqYidQ4SaFyWd3LUme1Qc0wMy7t+jbUtb/M
	gKT+AMXtibOgD494vqwkG6PZao6eOvGnPqu/b26tO0fqVCluCCcMObdfYiGnRXzeQhI1HSzxlyj
	ie3P528Hq+e31l7yTN3+YaOPMswe2zXk45LNdTXIyPLobKT7UdjdidpnQpr0wAvY6f6LqpKjZwW
	QUc4bmE76jTfcZw2zkUgE+SdN+KIbmFwEaNEgBkyvMDwXXiMfVxvKnFavikIElisAACw0tes08e
	NzLcYlrJBSSYCDkp6DRVJpxCi+MBPWWwz2mtGiMWw2Zfk634doampiJEtnjTeOTrnS3F8KUMFfu
	MRuEsWprWhw4nlyiqQvTAN7C92fA23Dq0UZC4CU7krToMh3MF8jYsfUU+HGoDJuOH00anyxW4JJ
	kY7iadHfIeElq7aO47bTk3S6YeIZH+4bKqRHelEPvZgZK68OPihrV+4NuNf0Ynwt24p+DtWApv4
	I1XubovC
X-Received: by 2002:a17:90b:4b05:b0:3ab:3675:8ed with SMTP id 98e67ed59e1d1-3b182efad65mr3989153a91.22.1794443875818;
        Wed, 11 Nov 2026 16:37:55 -0800 (PST)
Received: from [172.17.0.2] ([20.64.175.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197b603d9sm1580964a91.0.2026.11.11.16.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:37:55 -0800 (PST)
Message-ID: <6af50a63.3cb833c2.3d9137.a084@mx.google.com>
Date: Wed, 11 Nov 2026 16:37:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5034202091010906619=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,6/8] test: functional: Cover disabling one ASE of a shared owner
In-Reply-To: <40720115137c05aad4cdcb4c596c66516a97b963.1794428234.git.luiz.von.dentz@intel.com>
References: <40720115137c05aad4cdcb4c596c66516a97b963.1794428234.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5034202091010906619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: test/functional/test_bap.py:819
error: test/functional/test_bap.py: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5034202091010906619==--
