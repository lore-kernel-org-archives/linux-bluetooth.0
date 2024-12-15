Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C0189905
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Dec 2024 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734297273; cv=none; b=jbwuVoK9ZC0+8EuKOLwp27Lvjblg8lbcRvIUaDnwtajSCUNSwphFTB1j+TGtKQd4X5fEaj2uur6jtmtYh7YEIFTFBYfcymbsiMr0TTsBkELNhI+pw/20evRkm1HCV/D9Op6Z4RxMNdpNuO/WhQ6quTW8z4Mgf8a6mmGrQ6RPYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734297273; c=relaxed/simple;
	bh=Vb/P415kXr2/l9j6T58UydhaYH/gpLCkvP8MwrSeCKs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SiNmll8VfUdMiy4NJmCZzbZ9qHzGFriNiel+zDx3+IOdd+8X/kyZdNXiAS+Vf5UXUrSbSQEvtq2qHf1JXbqad8hXaJZ86mmPFDLpKVvH4YJKnLYiVpCBSD5wDNM/oMBamPgkNK+4Dme2y+Et3VkX2VaxBsl9aH8iq5Jca+GFgno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1z0tG7X; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1z0tG7X"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so1925543a12.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Dec 2024 13:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734297271; x=1734902071; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb/P415kXr2/l9j6T58UydhaYH/gpLCkvP8MwrSeCKs=;
        b=R1z0tG7XOAuqOPog8ArJsOVRmMJK4k/fJ9EsA+kQE87HRWGBZ00O449wzZYswybWPe
         v7Hv18zm4IoM8P0C0q5yTYTrjhoGTaAOWiUvJFegvsi8MbkaYdtBN0xdPN5MqLZPpMWW
         H97EyxR2UauMKutrhp20AOUC/X2pqRzj2cf3W+6XpWwcr/Ib1vOBLr+oK3FyLZcQkg7V
         YQYIie0I6m0C6Wrg8Ku/ya6PgkrjDNXmaopwov7+12RHws12Lqo8Mll3yHN7zDTSJb8i
         AQDhEf3x0rrjD4EIexmq5mElrfzDkX3hb/6xL5l3U0K0h4Cgj82gM2XHsS2Hy6erGYF3
         sz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734297271; x=1734902071;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vb/P415kXr2/l9j6T58UydhaYH/gpLCkvP8MwrSeCKs=;
        b=AnmB+Id9P04N+zDfTmyaKNFz2GrZ6GWiUDEbCw3RBEdlKGt3kFdaJq6WTPRH3YI76K
         sMXXS11u0NjuEdGHCWrb00HGPbJReCZjkkw5FLbdblVX5UKvtWxF3ehUQ4vbq810OwO1
         GSz/dsdj8WVE349O785BSNALXqRjbR0vVk4N9IXWwMKEzHo9Hn2qVbwAHn8vpqHxsYjo
         Mdr1s/bfx8japUr/KSpI+HTm+K/izk2aDmUELgNbysY10+2UbqMK0KfcDoiFtszUW/6n
         BHp4JZsrTbCtQcpt3/ICOQx+yNIHSLT/pc/zESM2foP6K3LNEuCuL8KIi2Sn+8J+xVrr
         mvEg==
X-Gm-Message-State: AOJu0YySrY4ItR/BgxLQZabIkxlEtS6a+fAy/T2GuZD6x6+xMozRfi7p
	0EVFWKvwqRdu93Nc+Rs84+/o//8jEbRkiYgivZEzezBsqUe4I3V8lGhwRw==
X-Gm-Gg: ASbGncvEIdHkEMsrELqJPRjdlKHo52e1pcwQmZ4EILssY7gFTTzI4LhZB1QmsIJ+smk
	8xUot1bk0Rh+yDdDFcJJPJc5dkxTbDCxZsUvO1scUf+n2ed9Mk3+TjYcZsyJ5VkvpjgCE4p7gti
	H78+OrypMIEh2b/MA5PeosfhLdWWYsWVpQKRYClSYDhKV1j8wnX1LPoC+5AVPqYrbYNWJ+Nq+YI
	21/j1Ue8rzg9KHLL956WBHVPlAT1o70dAZ/BOqXYGtOdvk0dDqI7GAlDesaBw==
X-Google-Smtp-Source: AGHT+IHiLDyFQ6Kpz2zPEe5zKKbR4xk0+HaQvzm/yCY/Hf2AfxPKg7zyjGzxeVOHm3ukwtEn6r3dpQ==
X-Received: by 2002:a17:90a:c2c6:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-2f28f869282mr16746469a91.0.1734297271398;
        Sun, 15 Dec 2024 13:14:31 -0800 (PST)
Received: from [172.17.0.2] ([20.172.5.219])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142de475bsm6688017a91.31.2024.12.15.13.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 13:14:30 -0800 (PST)
Message-ID: <675f46b6.170a0220.2965d5.d8ad@mx.google.com>
Date: Sun, 15 Dec 2024 13:14:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5552516967082003075=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: RE: [Bug,219514] PC does not resume from suspend, bisect points to btusb/mediatek
In-Reply-To: <bug-219514-62941-ESnLv8F142@https.bugzilla.kernel.org/>
References: <bug-219514-62941-ESnLv8F142@https.bugzilla.kernel.org/>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5552516967082003075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtk.c:6
error: drivers/bluetooth/btmtk.c: patch does not apply
error: patch failed: drivers/bluetooth/btusb.c:17
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5552516967082003075==--
