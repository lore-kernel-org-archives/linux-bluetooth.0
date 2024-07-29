Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD98C07
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 04:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722226595; cv=none; b=Kt/ffbQb+Oqr5pc5zymzZs+NJ/xmWYTdzlV8AWXrrRQ1WWINNwhnlBXqCWn3jQT2xho1m813UQUQ2msmxQqkFgoXBwiKKprDOwf84gDOeAGetFgcQgqbO2iXn41Rn59PRJtqrPvAt1pDXWBwpyZAkXdzg54lVp5qEKZ7TETOoYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722226595; c=relaxed/simple;
	bh=wtzFe7S8QaUfqtj7YPrTBirE+0Ob2RDYz0BtBqP9brQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GexbWm7dlsM0VYf5R/jU4XbwxcWdFjEystAWURNSqLg4vd+yKb6IKNGc8Y6s218fFZZXXRr44SisnQubTEKeYDZEm1Hddobz7nHiM+SuJp0N6/zycdUZyGDxnpfmJGftwPZ9W/mTexQvJzzTbqS7YyP/MOGrHa6l+BOthyTpx5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF7IrMnb; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF7IrMnb"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1df0a93eeso160848685a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jul 2024 21:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722226593; x=1722831393; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wtzFe7S8QaUfqtj7YPrTBirE+0Ob2RDYz0BtBqP9brQ=;
        b=CF7IrMnbSeXDv7FJANKbJen3UrzNjorARbVfafMjqLfUOdYtohTShWmK7rkGMIkPOO
         nn8Xy/wtEzPn01Ud8GE/AF8Nib38QUOflghsqimsjd9hunbKuQztqBfjBwXP+OgkCUB/
         ai635fTADuDvAHQ0tUXNWa9+rxRGAXNwWh1HW7d2XXONlJ2pb/sQl6zl5aGRu+U3hbWB
         Zdp6BWXSZ+NS1Vxp1tn6G1ly+nfxYGxUBG4RGCvgV13tBnjoKBI5RDEUKAMc5B0iT8Fy
         kbYPzdIo6zq4fjLGH8qQqhHN/5xbOMwzmatWFYJ1k1hZJk3uVXXmOgK9HCWT3RYppn0t
         Iu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722226593; x=1722831393;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtzFe7S8QaUfqtj7YPrTBirE+0Ob2RDYz0BtBqP9brQ=;
        b=mzJHHDkzuEbUsr+MouTiYotSSVJQT3lafckOMcFsWA5JI9BxJLjPzOjYDFvAv8Oypy
         95wz34yJJ72+8zuzg2qRVKW3C7UcTUK6WeBYg52GDsL2SeYIepiBTZiXk9lz+7Etd1w2
         7HWikIxzDQ8k18UZ5Ep6gBDD2Q4lKKlwDIi5N+hE7srvkCxPXPZcilXPytbP14mW4jLt
         cTspjmHvvIfF4buERzQaBDITut6qrGrq2gQYK7sL7Ex/646tAFr1BWdcM7lH9Pb7dX7u
         GXYs8sESPwAf8hqwVVth9wZbC1BJrbzUHZdJ5KwXlMSEFfMze4YC04wsMj9m3lCUBemo
         Lz8w==
X-Gm-Message-State: AOJu0YxfaiBEGf6FrvfcZirdAi/ymisfuGp2hHdWObWS4aHV4fcDuRWV
	ExWllT5pMtk1Z7SIv8QpgzJQbU6/4uMO+Chpr1c8DEof3Ojio4ArscZmvw==
X-Google-Smtp-Source: AGHT+IETBrMQRafztFAyKuf6fwSnCMGXSOXDcGN+bOGlx6DEDEu9E5Xw1RHlKdPmCeo7905eaRk4iQ==
X-Received: by 2002:a05:620a:4113:b0:7a1:d437:7a32 with SMTP id af79cd13be357-7a1e5301b2bmr585158185a.67.1722226592745;
        Sun, 28 Jul 2024 21:16:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.161.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1ddea0c2asm380935485a.27.2024.07.28.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 21:16:32 -0700 (PDT)
Message-ID: <66a717a0.050a0220.28416c.a2b5@mx.google.com>
Date: Sun, 28 Jul 2024 21:16:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4467014107438884259=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xuerpeng@uniontech.com
Subject: RE: [6.1,1/3] Bluetooth: Add device 13d3:3572 IMC Networks Bluetooth Radio
In-Reply-To: <0FAB34DF3E2E47AB+20240729034247.16448-1-xuerpeng@uniontech.com>
References: <0FAB34DF3E2E47AB+20240729034247.16448-1-xuerpeng@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4467014107438884259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:545
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4467014107438884259==--
