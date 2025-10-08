Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130182E7BDC
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920654; cv=none; b=rpB4MbyIXL4esWmrqHSjpdIpLbiWwVUj64kTeXpOVYJ+lzeqVNj+ZU/BU+cWL5YHzIcVo7VvsQxCf+GGD0UO4GUDg+AkRQML0gZHhheCTow1h3P0P5cLiSGXdB7wuBelB99sUCkAGImNocCXSizqoMwzWLK1nuAVKIadAVSkyEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920654; c=relaxed/simple;
	bh=yAU01cXq3UL7tkSmhYlp7vc643VYupXcThkqULAJ2zU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qHGZ6t2/Xiv9lHfA/+XXJ+xNck942DpTxmQXRsvddtvsjIGpZ02JsRAEpziVBOUrN6IXBUmnUqibhncWUoR82uLesmiMELEN5KR7Iu7LTKAPWFofI5CRQNB4V4riqBCmYfzjm/UZ5odOoB5dqTjVoq4DUOf5z24XdQWGelO9IR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djEw89C4; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djEw89C4"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7946137e7a2so80249936d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Oct 2025 03:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759920652; x=1760525452; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yAU01cXq3UL7tkSmhYlp7vc643VYupXcThkqULAJ2zU=;
        b=djEw89C41XDxK9gEW2pVvAq87qdfvO+5pAcD21415QzTIqhzD41TaHPad/xZ2X4GLd
         0odoeKeywmXo43G8UY4bld+IiQIMw4nENch6mEdUzU05plEPUGUdAyRE/tHQFOcKfHhJ
         MUR470wLvUMKpyiDAluNAaz1yoGDR+La08DCCDCdWYeTouHUWRwlrnRkzA09TD5nPeby
         5Gc235w+1TirKLy2gjv00qEaLB+Htje9uAage0TeOtI7wpW9WSCmogKdZk6ewAILcstp
         9tjF0u9U1djUGxPPM2p1aLM20dYVRn+3PkyYWonHTGzmIiGQXpIHE23ZL4PxTT2qtK93
         VxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920652; x=1760525452;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAU01cXq3UL7tkSmhYlp7vc643VYupXcThkqULAJ2zU=;
        b=YWkSml6c+UY3jtLDky0ST4vn7/Nh9TZDdLZAmXZsc9HoWwNPtLOhlWdpnBkCWr9TX1
         qvfy2B40+xN5b2WjGRMIbzTb0oFMgddmL2lmWGLg9SX163pUTqGLh3ThCu2C4LlOaq4p
         m+llKXcsc6pYcy11jQDiD/gS/lVc8zHzvBeYv/Yk8VWmpp57y+YVkHlsc+CFZqOOfjFa
         DJ9dW+9QtTeCILvFThZtoNUcV58VUkPXcdt4/mpE5uRBPnLZuesMxl/OKK5Ibz8FeMC5
         FHrO0CM1+++eI+TjTpG7JQJPIdvKE/N60gTBXUyTUxFYqob1JnXcgnnlPQbGleIO2NRP
         jtvQ==
X-Gm-Message-State: AOJu0YxAaJEocCniEjCgHshkitl7mECclcJaF9LCduyyirKXmmuIFqAo
	qs5Uzr2DncsO8Ow5UtZw0fFwJXhqntdVwxBCM1zxCD13DWrl7/be1wqGkkmWNw==
X-Gm-Gg: ASbGncue23zcEwKdowozfFE14TAUW3fgPrlSUaFs5g0yxosKKf0iAKvoIh09uPIcu6t
	+MKzqDsKqyGpS4xTzXy8zIegjld8/SD47VMZMzx/ynVu4Me5NvUvpkVBNMTk1SmXv/N1ugj0V34
	E1hWjbgf1emScgv7U7F8jG2RcLEC+kcb8F7wb4G/dmw6KdB0DLdvgFTq7R6Vta1U1NaR7jLNzzC
	Jhar0tVInoVJ2GV9WW/qp9GkIgbuZW0yxVyP0Ulu++A0Fy65C4Uew7BWjAMGRyfi4eh8pV4r6zt
	3aAKBmC027RxGsaE5NCBaMXRcDB+O6qu3pYe+i9mMZb0znRk2hToPiurVBQTLhVVKlkcwjuXaLc
	EcBIGKh5+dzY3ceID6Vmr/zAd9J2h8/VDH2AGW/Mo8eFY3QLpkLA=
X-Google-Smtp-Source: AGHT+IH2+Hrl64bs7qWjekVbQcJXh63A4XuHQpoYJPCfqjP+ntvDCoszdWbX78GIX1AjNYMpMgBwgw==
X-Received: by 2002:a05:6214:1946:b0:78d:304d:2cd with SMTP id 6a1803df08f44-87b2eff072amr34937506d6.49.1759920651824;
        Wed, 08 Oct 2025 03:50:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.87.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61fc21sm159028526d6.63.2025.10.08.03.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 03:50:51 -0700 (PDT)
Message-ID: <68e6420b.0c0a0220.6e177.4c81@mx.google.com>
Date: Wed, 08 Oct 2025 03:50:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0465308559194481323=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v3,10/10] build: Add License field to pkg-config file
In-Reply-To: <20251008104132.2206963-11-hadess@hadess.net>
References: <20251008104132.2206963-11-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0465308559194481323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: lib/meson.build: does not exist in index
error: meson.build: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0465308559194481323==--
