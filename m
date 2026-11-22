Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795373736;
	b=27oajNpCw8WHJZ3tYHS23Z3wKSiJBJJmNUsNsh0lX9we3VunIKeO7TawpVmeiJEnsNSO
	 1SPUesTlIH3hCzcifwn0Gnm1yj8tMY7vHCB/8v6Qe+rditZNM+Pi557FOSG3VYazcQ24a
	 hj5its6khg96fo3R5h8vJCtAMqSaS1jUNeywusNGSIyCzSs/tmal0fCjuZSegql4gq5Lp
	 /X1Qqxo8Rztw15LKlcQS/0ZDD4Cxmjq1cIIiXzFYepMt1PW6ECLI6cgJwMvy68MorydRw
	 tN+0qildw99+3IFa68jZ6/w85vBXzpUbNlZ9CWjsLvzSwC5/tJjHy6YUdEotRT3WM3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=R/rSHXpev1mdu39vdoLpooxay65/1LxVP5NSI1BJens=;
	b=xaOc2rQ+7xkcuajsQP9/nh+zImmaS3I9bc79guzpbg38fETBrMhKZZn+uUkfKtLYPCjQ
	 cXoSZKgHIo41EpMzN92Id4GN2MJt0+nOwKbwjlSPh22gvKnoW1wWBOvuCvCtqwMG/Dr21
	 /A8iHSxoP6wK5Ew54PyHB1aZZgsVLbGoreIKSRBsqmrh+wqt0c/y6wfk0q6+eIQuZHoQG
	 DjYkGCvIn5M8ssMCc3QvtNGP+oKm4TPnd+wBJ3Vs/8b019IhTW/nw2J43uXd6yKYQ0GzD
	 sWacqpyi+2RKhLAAiogJgkiCAkNBIHuDpLnE5IgwA3aL2T/s56pQzLupaStmAbb8QYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KghmbetC;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D7606A33E
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 18:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E70D7606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KghmbetC
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-862df509d48so2122211a34.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795373735; x=1795978535; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R/rSHXpev1mdu39vdoLpooxay65/1LxVP5NSI1BJens=;
        b=KghmbetC/ejozlUUVJ4AgU4HK+SZUT7CeVBEQIK8G+r2kcFlXkQ31o122QKZ+giAhX
         m61EcFlfhclyFuCXAmXb3CYVG3riwy7s4MUYph+WUnm/7h8HbiYbTsoACIsRusTaxzEb
         brDpjRklBW5BJPrfTE3m0uYDJBEqfJYFy4FFQ0p9Ehmo/Gj6UBfMxlp5oSmcp0KapkXy
         +vY6Jtkq0JSvMJYkfxDMN5QYqds68Y7AO0ACZUunLWEx1/G60t45i/k68FQtb91OHbr2
         cSppWWzSRk4QVgnRQLubECHEBM53jfd58MtL9U4A9tWJUy6aPT+BRa31H3LSB0NkhQXy
         dk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795373735; x=1795978535;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R/rSHXpev1mdu39vdoLpooxay65/1LxVP5NSI1BJens=;
        b=wwDqCK5pmmpaA1lkKUBzD687D0W2dwlkhXVhgSSmrEWJUWIvxqOQ8XDVGqJgBCvyD0
         5Mlgdzz2ctBOW2kahdtsb6QjIaIgLx6oj6YIw6heWQsHwtHE+LdLE9f+blpuVWKucaSo
         BOKz2q7gjs/Qp27d7Nfgmr3wffj8qNZSudM3R1mLb3xMXE6xBxBlO4KjxwFf78+37G+k
         UR237dzfi2KDD2uBeaKboluJBUpaRsVQGBerScAqbaVdqJ5tYhaSP+tWsFnt11hOvZmB
         tFfnAxpH+3suAPcst1ngg6YldA/gI5oJQ4PrBTOYshUuOvUF5AamaZJMiJyzfaTkEaxU
         9BuQ==
X-Gm-Message-State: APuU4Z+zDSpRKmAxlyc/K3twjzh/NT+aMhnQSApo+cKvQ7owzPfvfe+8
	KfThczXufIlwy6wxQ2DcC0CB2v58Zjt9SViylRE2vjew+Pzmuqb0lfz/GqnfMr+4
X-Gm-Gg: AZFdTZcmohcgQBYqKsiDG3DZGz9Xlroqd2nTOp/oUrhGxTFLUjc5GWOsQcFqXGVaXxi
	fGM12I1PZfMtkZLL+b3QWC/vny9khzKh10I51bXFHIZ9FUfIJP5uLtqa/25OpqA+tvkn+DBpeF/
	w16HRzkBDSuDykCGFvmArmJ/hmErJLhJzVtBGm9FZZBTbtE9zwJ+zbcIXxVY3OF3M4UcNxGI55y
	EsbIhVDpzzTDxylXYlgLF8OuaSxVWzK4sSU+6osAS/+iDywqAQT2NY17s4atZFiX3PU7Fn6KNzl
	EfXxm22u2K4GvKbkiv2MzEu2oL26mfgZHHdyk2xuVWlwFKBDn1DFa+Ph17p37J41gLkpCDqkX3D
	BuQ2FgyIS3LBMTo0/qFYGQ0+RhOOg0isxl6ZKmY2cRTPs5g/AAxYemiO9ZdgZ8XEazbTjUTeLY6
	qt/E0m3CUjgcLGapOuygMzHFawW39fmbeWxWVNYSgFirEUOH3zYGt7YkSfBPv2Z36jDU967Keen
	qsGFhruXegNNzcG/ZpYRZfwJ36T1IvpcU/PoW5d5JBVUldXnPxvZCGneMbcvg==
X-Received: by 2002:a05:6830:310c:b0:862:8871:5bd3 with SMTP id 46e09a7af769-86309309ab8mr8727102a34.37.1795373734794;
        Sun, 22 Nov 2026 10:55:34 -0800 (PST)
Received: from [172.17.0.2] ([52.248.45.83])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168bdba0sm7445686a34.7.2026.11.22.10.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:55:34 -0800 (PST)
Message-ID: <6b033aa6.bf4204ed.14b1c1.8d93@mx.google.com>
Date: Sun, 22 Nov 2026 10:55:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8017527270955765917=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] bap: Sync to the BISes of a broadcast in ascending order
In-Reply-To: <20261122114918.1063391-1-simon.mikuda@streamunlimited.com>
References: <20261122114918.1063391-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8017527270955765917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218592/

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      20.85 seconds
BluezMake                     PASS      315.44 seconds
MakeCheck                     PASS      3.01 seconds
MakeDistcheck                 PASS      148.93 seconds
CheckValgrind                 PASS      161.60 seconds
CheckSmatch                   PASS      323.34 seconds
bluezmakeextell               PASS      103.40 seconds
TestFunctional                PASS      1259.73 seconds
IncrementalBuild              PASS      324.01 seconds
ScanBuild                     PASS      1223.73 seconds



https://github.com/bluez/bluez/pull/2873

---
Regards,
Linux Bluetooth


--===============8017527270955765917==--
