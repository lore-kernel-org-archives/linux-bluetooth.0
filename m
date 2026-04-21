Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0C4359A90
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776806800; cv=none; b=XbG9Bssi9nUd05LH3sPYzp2pgkvvOVGUauGbWYTXkUyoUikWa2787Ck9PMraZIz0xWaMVlplRtRtCXbsx/QZ37BdtemSyHQ8wvhONdpz/hxQdKIx641dkNrgwSEP67xvFhxkpl415PoGxE0+v+8wC3oxyov/Q2o4rQntT8mPdaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776806800; c=relaxed/simple;
	bh=cQ5GjCtJ+D+cQPZoAVDCeJEd2UsxAAtHqLyZx/xrgr8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VUlfPKwfb+SGLcZPNCQSkvJLxdGwnuYsMB25BSamLY80HcA2+yVGvxlvMRAoHrl+Bvv4OohbmAwAx+ulx9TY1E9NhMSgjVDv3HsxmJOly9epd0ABEJ4CFRQM6xruKG4k5hs5FEV8Ec1kjUQMd28iEGjecl9B7D5ZGwGg+klpQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyAXHoIg; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyAXHoIg"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ee7ffd738dso111897885a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776806798; x=1777411598; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hkiFSlatGXkkG6rFRw1RRKR9vWW2/mgGKoiPSlVOsKs=;
        b=eyAXHoIggVzVecpRd3STeQmDMuor8AXRxqycH08b+Sc1K+I01U9mNgLAUuy7ymWCJ4
         ucKXoHUEjz5L/Yo/osgcZqnDjvhfwiY4mcWXdwkywMrefpo4NaUDXUQujEu6/Zjjb1ba
         3w/jdw0uIlr0HxVDA4/OhgnNCqhySeEoUoSiiwFErVRKXoME9xiisVm73ElJ3zljCqzO
         KZ/HLSfc9Ax17JXigmQjSa+g/IJ1JbLj/SHKovSZoocVul8hfYpbkPfSFJdJjJy38BkC
         ku8vq7nb3k36/iMkzrLbBK6QEE3r64oa+3pBRFBfwcl0+0C5z9QvJIdwkE+D8zMrCurg
         Gogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776806798; x=1777411598;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkiFSlatGXkkG6rFRw1RRKR9vWW2/mgGKoiPSlVOsKs=;
        b=I8rM6uc3UQc3z6vkxM2NVutEKPQxGW/WV823kU24n9j0m/hoocaNxQjKY7x2/ltsVL
         6WfO5HYkOPbxfn9wTm2QQBv+4kxa4z0BGHWDV2xnyGDSE4/xmOQYbawjscRcWyqPjNp7
         QKVbNEUq4CHLvAKQUCMFkLODsiWeOzHurYx/bQ4u0+/QQArLBG/3VNShrBYkNMqr0Xpm
         HKm6YY1ThRfYoKN3W5kCCi0JSInmMt2pBMItH8sA5cJlfxZn9VqyV2DC/H3MQNsnzV9+
         9G0ACPoKzrq0aNMAjKaudpXkkqo+kqtncZT6o4AAiwrMXpSX49tQtlu5XD/vOD9j77LE
         lxrw==
X-Gm-Message-State: AOJu0Yx3yNAq3/LBTdWL6CGlvj2tlOyrUis2zCkpjNuSeCm0r/PErGCp
	jKTqg9ipytrHGW35RW2nrCln3TvkbfACrvoUKzMqpL2k4hflVE+1AbBSUrnAeQ==
X-Gm-Gg: AeBDieuxB/axEkskkupzk2QaJUhNgxAkEKGPnA2FI9x3rkBCFxGvW8tbOD1+eEAGLUd
	09liO0/35t22xQYCEJFUq82R/ZZF8H8QxTp/6aPZFyS6NB8NtBpvVipdDmrUnijIK1YRj799Vsx
	mFLO2p800oLxpaDR7ylfMtJbDn/PtBb0efxzuC6NuoEnyZRoORdAaXk9RzOHkAXemDc3iOcN8dn
	QAD2YIYtlx3kqr0ogX/kO2MqMju3zwimeCHfPttsqwPiCquh412PMkYK+MMd8j5dYr2jJ/ZRHSk
	0DL1Oc0xENYHUOcLlTvCTgw4TgJG28lisKrhTRU+ycoktzJwuI/LzfRu098BcHkbG6bnqDAMfSm
	i+u94dOMKP2tVxaFGoxmKwyFVMX2mnMeJV0a3X4ouzJpKPFkG+SPDoaWISUazNgif9dedbW2m2j
	TZQO9w2aJqGRZYn9q1iOhHkbPTsyxjIz7LqGf7XKxTFg==
X-Received: by 2002:a05:620a:40c1:b0:8cd:9281:6be9 with SMTP id af79cd13be357-8e78c5c256amr2219403885a.31.1776806798433;
        Tue, 21 Apr 2026 14:26:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.246.214])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b031f65a27sm104985586d6.16.2026.04.21.14.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 14:26:38 -0700 (PDT)
Message-ID: <69e7eb8e.d40a0220.2b89.8aff@mx.google.com>
Date: Tue, 21 Apr 2026 14:26:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8304353133710664699=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] input: Fix checking LE bonding on HIDP
In-Reply-To: <20260421202253.1957689-1-luiz.dentz@gmail.com>
References: <20260421202253.1957689-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8304353133710664699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084033

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      20.23 seconds
BluezMake                     PASS      591.70 seconds
MakeCheck                     PASS      1.01 seconds
MakeDistcheck                 PASS      235.32 seconds
CheckValgrind                 PASS      201.19 seconds
CheckSmatch                   PASS      321.82 seconds
bluezmakeextell               PASS      165.86 seconds
IncrementalBuild              PASS      590.54 seconds
ScanBuild                     PASS      913.84 seconds



https://github.com/bluez/bluez/pull/2061

---
Regards,
Linux Bluetooth


--===============8304353133710664699==--
