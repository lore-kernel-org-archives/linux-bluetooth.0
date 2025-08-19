Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D5224B06
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613053; cv=none; b=ohwtdEXJ+ZxwIoxIu+g0tHq6uGA9tX/hCoyziAys6giokhp2hfN/O3wgo3iq6g0mj316olG6guuV7ujjowYATsODaeNLn1kg9Xf2rA7gyydjemRAZ7cshSh4yIocsI+A+03JSXrEvmUFltYDVSGdHezdNIUtw7RFPsiI9DvJWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613053; c=relaxed/simple;
	bh=bRByoutSMqvK4eAGHgzPOhkuMsuIptuCX3C+WCH2oyQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=papJOuOT8VGMi1sZ4cOFZwwqJm3L4LGqZG5lF3qtBp4q6lu25yxbPtqaq5m8qPZKWIdvlkN7wJUNCpLZ8yYAPlgHRYvBLUU1oTUJ2fYi0Q/zrL/+aV4N9vDgkDdC56XUwUbuqdC3oaL95kxv6OgH8C3D3r8viNLHR975TpoGqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJmsAjxE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJmsAjxE"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-244581caca6so41077405ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755613051; x=1756217851; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bRByoutSMqvK4eAGHgzPOhkuMsuIptuCX3C+WCH2oyQ=;
        b=QJmsAjxE52Tuyco0O6yKhcFrfx4TQob2THpXzRrpjViblaGunEFe91QluqzcXwUUL6
         HqmCxz1cWfn9Mz7Hfjvy7yQXPftbmQzLXMlhZNdsVgzSEg9aSCGI1a/mcl06w5nD+w42
         r3Gw31LHA0Gf22ptTN9aiXQqdWKHQ0jOsxHMHxCNnIc8RUQLflqG2NNfy0xEYbPvc0IR
         W5hIdXVwIV1lTDOkMpTH1AyWWkyE9zU7ebOa4gRdH9glfCOQkt4nVpi4iNbzWxBUNSyK
         KpZOmrEVyZaamkIQtPeTm39fRZnTj5nw3I85/jZ9CLkhWAKYigbhsGfaXqY8m8R0IGCR
         p5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613051; x=1756217851;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRByoutSMqvK4eAGHgzPOhkuMsuIptuCX3C+WCH2oyQ=;
        b=ajgCIcYpB8oaP5NL8Iocy69HS/BJfKFibwlS4N1kCHDg6VbYSVh3+hefHkHyFb6C2j
         leYMbW3bMo7mlJ3oEOr7Lha8qrmZDCV0iLuq2ZUJaoRQUQaKUu/rp1Z8T6BGRnN0hupb
         WbAN30/r/2c/4+xkRfkr9q4kgOH45qY75SaN0Hh3AVA6BbaEghHU58g1hvR4lU47KY8U
         h2nyK0EA332rN/i0rqrrW91qOnSgOf3MqKM0CauZro+0VQW4UYJEuO8jdbtwCTB2TsZT
         WuXQNUl6jPnohk6zL44hz7+KjskWvzenBmXZzB5zW3g82sykTiS0lrR9X0bZlcGQCRhr
         pWZA==
X-Gm-Message-State: AOJu0YwMmyv/nX3v/eGpX8+oEFFxEng5h3mygc/5gR9uQdoV9SgRp8uH
	Lf9sYPY3Ak72cyD0A2OxTQS7JQ9FI8ip7/Qgf76eFCDKhNUjoWjtF/npouEvlA==
X-Gm-Gg: ASbGnctwT9jNDe7IcuA3P91p7HCvyv4nokDmXsbUMZjOCNHxcOH+mKU+SUJuZ3wdMFR
	pWXpFPBl95NcyHNBMXixRk+l0Ody3Hob2b1uY/tlfWMtID/oAKQeI/m7kJnGhArm/+gQ3CQonYn
	k10+FOJs3wlpZWnKPqzBH9g3oUJDn715Ai0L/eisIQR4eGBcfTBRf8z7BIkg2TXJ/1Q5mqFk+y6
	7yvAqRSCNlIIC+O97GlcyLl7zNTnK+IDGCn0+QpddNgoqxPJMC6zvu1YrstY8rmNcqEqxeBVLMt
	b9XZbVGM5qdRWkIWzcpoWM6XIP2u9FDRmNNLVKsbTeMgSGuHPONESGATZAbaAA836WrPKrh9n3S
	GsJSCNU13jDCW12HZdm+JV0MmH4Uw6iVo9VjhNw==
X-Google-Smtp-Source: AGHT+IE5j0PpOIH7TL7xhpdfS/PViqEhP+I8h6iBdnwEBRKrZKd2/yN4iR2y5KV/f0RDujFFqqJVNQ==
X-Received: by 2002:a17:902:f603:b0:235:15f5:cc30 with SMTP id d9443c01a7336-245e030ce46mr28262965ad.16.1755613050991;
        Tue, 19 Aug 2025 07:17:30 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.56.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f01csm110980675ad.103.2025.08.19.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:17:30 -0700 (PDT)
Message-ID: <68a4877a.170a0220.30b4f.97dd@mx.google.com>
Date: Tue, 19 Aug 2025 07:17:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7181484619289402241=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xu.xin16@zte.com.cn
Subject: RE: [linux-stable,6.6] Bluetooth: hci_conn: avoid queue when deleting hci connection
In-Reply-To: <20250819221353357gfKAFq93zfeYcRSTpGtBB@zte.com.cn>
References: <20250819221353357gfKAFq93zfeYcRSTpGtBB@zte.com.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7181484619289402241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_core.h:954
error: include/net/bluetooth/hci_core.h: patch does not apply
error: patch failed: net/bluetooth/hci_conn.c:1112
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7181484619289402241==--
