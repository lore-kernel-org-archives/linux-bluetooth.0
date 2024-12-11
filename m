Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2641A0726
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955385; cv=none; b=uVAil9dpBCLv0o4jw1RqIc4ag8sfd3/6ycJi/RG6adb41qNzNcUMEMMxsp+6V00kWXqM4+JCFlq9ekVK2wYrjCxDoJDi8CNwCFrjQt4VSN4OugQ9i+/2Bwox7lwZIpdXmPHj/sc08TkX3vE7pxYGQG7u+M/WE6nW2yaipaRcNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955385; c=relaxed/simple;
	bh=zsEanvCIWnirVIQFtMpEK/LqdY3V34CB1mpxj98kS58=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OOVe7VNqbVhK8jBpaw0fyHCGXMoPGGKMeUHUJNqnCUiDtbVJW32W1ErZ0Sm/pwB7LzLnOEN9UjDGCDKNhsQboiV9iUuPAlQwAlFaRuz9akrXmpYQV2uK6JO8d8iuyfGy40BbNX3QsLRFThyC6jFIC4vECI8aYhVBQo4pZwdS+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBY+DPde; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBY+DPde"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8f65ef5abso36370906d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 14:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955383; x=1734560183; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zsEanvCIWnirVIQFtMpEK/LqdY3V34CB1mpxj98kS58=;
        b=gBY+DPdejF2nv023FLHx/cco3nK5xb9P00Mvlc2InmLQxMbQgYSzLnH/XXqH+5Fv+T
         jq8L+2EeihRp0lZjP0GMpcEBBa9XyXlzqQhaodmNO/5+62WMm66uKXqE+Xjk1gDIgis/
         VprV9mg54GzlnqGn8ciyK0W7dV83eW5NmqsvsKU0oCAyt1neU6vDf2nrjpq94V9Zc3WI
         XVKwZNE6xzyVxSTxwL6rsXz192Uoy1R/A+TDtbEcYQAxXFzH6ucpU5BHMnm2AkNC3dSV
         +8CytmxVPHnUNCZjcQwR4ghmik4562DSfQpK/fXTmWdx0IbMHHwfLvAFDJ2TdPY0OwHm
         QCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955383; x=1734560183;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsEanvCIWnirVIQFtMpEK/LqdY3V34CB1mpxj98kS58=;
        b=wEsxTaTSes9XiZQ4Zrg5tNPwk8EajGfBiYPk5e7PwNPIm0zbSzkkRa5blC9HKOnsmm
         TjZ92myCkVXtRTBy+f+zRQsLTag1N/e6T4yOsbd8hD9Q1WEWGTB+HLBQRftGWZlJhuXz
         r5w0r3bsUw0Yf1xEOiE7OUJh9l9Rc+lZ2RXNd0p/DhTh439EpMkba55DCrudzhNqjiE6
         ZwkKhQLbny+u7Wo72nGIEm8BLuyH0zWhX9yeNnT56ZIztZZaIkMcCjaxZi9Urdnq/0p+
         60iznYvcUyDZ2ftapPwiCZ2fWDd3LwnvA+/7jHbsMO24RDvl8x1ymLyMH2C6sC1IJ3LB
         MXhg==
X-Gm-Message-State: AOJu0Yzh6EUVekn/JAloIEd3aut8zwcTc9LvD9iAYgOPl2xXgxgAfPK9
	lrbp7fiBU6zfKRvfqm6ILyCGUNdLUEgHSVtOzWNIRhSefOMra1lKmka15A==
X-Gm-Gg: ASbGnct02QIzzKjY6MBiUIEB/KqBWca/gEbU7Zoq4jQUJiW4HsvGFXEPIkJrBtT9wwu
	p91ltsQb90LE/XgQ8IRLRJHif76HxqSROMXA7QUeLAHCzE1xvKDiFrYzKvH5ueXPFyFtKyElwkw
	NROaPAmVLjSJ2EoRZNpy0yRZ73PioD77SMOZDxm0OBEc5Mlkv8G6uG2KqW4qbJdps9/B1yXw8Ef
	MxPJM5G3KFKF0G+DOMzlmh9yWiZCw2imwCbYAxlPaEMXvvRTMLm6sh5Nw0=
X-Google-Smtp-Source: AGHT+IH94ipCVcYNSKlcfCNyEMpqXhnm0cVf9xfpcPPNTVBW4eOP2rZXgjWQO7t70RrfRmvB2Zoonw==
X-Received: by 2002:a05:6214:1249:b0:6d8:8f14:2f5b with SMTP id 6a1803df08f44-6dae391c144mr17232816d6.19.1733955382666;
        Wed, 11 Dec 2024 14:16:22 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9fdef9sm74782236d6.73.2024.12.11.14.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:16:22 -0800 (PST)
Message-ID: <675a0f36.d40a0220.35d39d.d172@mx.google.com>
Date: Wed, 11 Dec 2024 14:16:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6953378407602337895=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, git@doridian.net
Subject: RE: Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
In-Reply-To: <85c64500-b6e7-481f-94fe-5d8fa78b008c@app.fastmail.com>
References: <85c64500-b6e7-481f-94fe-5d8fa78b008c@app.fastmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6953378407602337895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 11
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6953378407602337895==--
