Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40184149E07
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716419164; cv=none; b=uXG3x4A/cwCN64GaxRDR8+s4N14G5OxqWxyzXV3uPu3LeKBqsBcdXqCDK2tKz/yOZKyoYXep44GrqS0HuNS1Il8T1L3bsjbVwOVvUbZg+wogPG9DuKrOPEGdH56R6lzhjlHcgD410sJwysN8UemeyUkgbfrR8S2DEeZ/PTjOOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716419164; c=relaxed/simple;
	bh=ETJ8aSSB1i2I+QvktWRTCZkvjp/iYKjrK71epEdT5M4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sRbGLY5nO+9CVJP0bPjdI+s6kQkX+FdE7cosAjYiEiks1gqdvkPEnd4DWhuQmu0/G9hz+AHnLTBjxnts0+dd/pUETcyBh4+CcdPxM65lXFXvLPqXaeJMWOTxqpSe2Br+70Xpb/MZaZWzHHkb0xe8U4qJS4zu44nyZj/W3N0KFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPGWZU/k; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPGWZU/k"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c999556297so3586427b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716419162; x=1717023962; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k3PdYInZE2OfAwiWoE5bbKE9PzAt72h/hZBSMwI7AWw=;
        b=aPGWZU/kls1yoGxgGRiY1AY9L3WcBqJ5dOaC1PHQJVg3NmwO5iglFrb+nbzVflO0K1
         VwFazvOD4I6SBEbifLqxsGfpQ5cxvnxZdcXDoqDs0MaB/l20FolJ5i1mElWOtDHR1q0U
         IG6Y83RV7Jc7THb6XEdIzc0AfESZZnt5Xl/y72Qvlp9ScwGdjEj1pmLRTsXKOv5pLRTc
         mrIR380KxuHbOvFdI2pFYcLzr/PDltyfRpHW3dqngwUTaVWCWchht0kaGhEJyaMD9bJ5
         m7nMZpK+O2CciPIqseJRdlNNLcoUaASTgAHcrAdjJ1vzv8ycx022nxpxU/6rB/usLAuE
         k/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716419162; x=1717023962;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3PdYInZE2OfAwiWoE5bbKE9PzAt72h/hZBSMwI7AWw=;
        b=BwFM3NscU7yEuFcrwUeYF73tEWyuHya8j/4rmqgyqEnw040p03WPIYNV227+WqD4v8
         XZbUSAH1sgJvvtp6Nd/j3TKkbSyPqUheG2GW1N6GyRkBjms2xvJt36P30bbKyzZHpkPT
         vPLhdycZEFjHn5vE+UV/mYu2dQDsT47JFXiH4om6tx0GdZxg3jU1CIFfKuPGw/iQSF1f
         F2ololyZZTj0vepOlE0rp5VHClXS2RHzQ6vFOSmqr4DuYh5p/rCFiLWEMiXIe6TP1o2D
         79cu+ok429w00Cwak448SdpE+BJSJeE5ZM5OLtXofRkUh3dK9JFR87oJ+V7vJXmZ80Mx
         jXmw==
X-Gm-Message-State: AOJu0YzILyS0qzxOGFH+C6idwfNmNoay9bmhyJ2OdoEJgBBuZdO1LQxR
	OaLjOjuyGU/Hq4rTQ99r4uJyYYtXyVxDaQdYjrI3pm/46VF1O+wHE572WA==
X-Google-Smtp-Source: AGHT+IEZDHwi0xnxPuzOVMZiPlsg+g7Tj60pFLxjckkWMhHBXWn+gkoKjjgFILdn11R1F9ZJ5VpTGA==
X-Received: by 2002:a05:6870:b28a:b0:220:6edc:1fd7 with SMTP id 586e51a60fabf-24c689be593mr3904842fac.1.1716419161993;
        Wed, 22 May 2024 16:06:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.47.58])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54b58b5sm177217961cf.7.2024.05.22.16.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:06:01 -0700 (PDT)
Message-ID: <664e7a59.050a0220.73e01.ae1e@mx.google.com>
Date: Wed, 22 May 2024 16:06:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5846326199200384626=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] doc: Add initial L2CAP(7) documentation
In-Reply-To: <20240522204252.1891896-1-luiz.dentz@gmail.com>
References: <20240522204252.1891896-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5846326199200384626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=855126

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       PASS      0.64 seconds
BuildEll                      PASS      24.87 seconds
BluezMake                     PASS      1671.90 seconds
MakeCheck                     PASS      12.99 seconds
MakeDistcheck                 PASS      177.40 seconds
CheckValgrind                 PASS      250.42 seconds
CheckSmatch                   PASS      352.80 seconds
bluezmakeextell               PASS      119.49 seconds
IncrementalBuild              PASS      2982.95 seconds
ScanBuild                     PASS      986.99 seconds



---
Regards,
Linux Bluetooth


--===============5846326199200384626==--
