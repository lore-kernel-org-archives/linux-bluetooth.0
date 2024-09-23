Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F62114
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727060678; cv=none; b=A0CEEAtVgIEKCMR8mtYIeTv8MT6yDvVdjYF9vdZEPOsq0p8y8mqz2pmG/yh0x4hwhfXIHugojYixS9l8/dJtQ60xqx41Dt+Bwb7agZURkggMy0Kw5Fhiyz1ajSV5IgFkvbXx+IWvmgFIR/fCaZUxOREywt8yA/xXXYQkaBU6rMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727060678; c=relaxed/simple;
	bh=WZ/1VwI7w609GquzsBVlRVr7qMP0HRNRY1TOpntprjc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aipI3DTkGAwY/FV6WBjulfLsPc6bSb5Vux4pK7hauXmYe3ynpAmuAXv4D5xYq4bCZYX4NdED4m9Dk6+n1dUledgkiHrkiwf6Asb7OfBHYR118MNy7v7JCg/o2uil/N6qFohhSOavo399sHfg3J5J8ALA9nsSbzXV4zdyjNYZXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0mx4PV8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0mx4PV8"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71957eb256bso3389408b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Sep 2024 20:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727060676; x=1727665476; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WZ/1VwI7w609GquzsBVlRVr7qMP0HRNRY1TOpntprjc=;
        b=h0mx4PV87U2lY5W9IA3bbOgEvcV9xBIdDHGGkIYo/DFqe9CIcSoJqLDToFQt4HzenY
         ccwAP3EUvH4jdsqF+QTe5ObS64dbQ9DZugHBEQ0Ux0UuHE4yBqz/q/Ats5B+GbCn7/kF
         YvvibYIDTP727NKGZT/aRKH06tjydPYk2EeC6JaYvRALGUaD6l4+HTWSVj03yFaaPmv9
         LR0dVrocRZusplEYt7ePKajultZ/Fbv+zPsOjykGuhJxlIPldIA0oMlzUhHWBDystCsw
         NJ2m3Cp9EnnQxIIQL+mvcakpjxOqKRR6UeUOYpczYTpvYMDrxeQx2ZVRLvxveZBDkYw2
         TDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727060676; x=1727665476;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZ/1VwI7w609GquzsBVlRVr7qMP0HRNRY1TOpntprjc=;
        b=f2nc6JlbTUjms19QphuXDolDPwekk0K21pNstBGiUl79HHwrc8YSF/edN2AdXfpCmY
         JcBnMB4NzBp9IILHS2QDmi4dFmSIYJARW7rYzqgm6zgGZ2vSJDy6wvPfD+QXM463oktg
         UkvznQvss2fKGlp5pPRjkJb2ssAerkQP2C8U5oVuLSZE9qc2YVPTpAL0BwD4ppmNqv2g
         2uEWPw9hyKCbeQ8VO1oRzaqHzTIhA8GzgVHTiFK7aHjcN1qChTfIjiHt79M5HSN6zYhb
         Wi1UZRKt2i3WmVE7B5SnYM58Sw3dZE8S5UJXycC6DUBUHSaFRrnvKlmSBKwzl4CyGOz8
         pT4A==
X-Gm-Message-State: AOJu0YwMWtBis+sayjp/kfhNjZy6ae/xUC8+i/vaVse7lsIj9OuMHjft
	AeNZfaxhhJ/aQmkQLfvc66lnIi+XCbMVZkOg1IEGvxvvGR51MZgb3TWEUw==
X-Google-Smtp-Source: AGHT+IGjNVolbBBe4/e3BGUWeSH9Ps5/OPiOebVI7A8iNft3HjF0uxGgqZrYfNC9+ATBoEMXp7cblg==
X-Received: by 2002:a05:6a00:39aa:b0:718:d519:20de with SMTP id d2e1a72fcca58-7199c96be5dmr14632020b3a.13.1727060676017;
        Sun, 22 Sep 2024 20:04:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.136.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b97560sm13434217b3a.148.2024.09.22.20.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 20:04:35 -0700 (PDT)
Message-ID: <66f0dac3.a70a0220.115b39.4666@mx.google.com>
Date: Sun, 22 Sep 2024 20:04:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3104846412453756605=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangyuli@uniontech.com
Subject: RE: [v2] Bluetooth: btusb: Add MT7925 support for ID 0x13d3:0x3608
In-Reply-To: <423A85B62ADD708B+20240923025147.693748-1-wangyuli@uniontech.com>
References: <423A85B62ADD708B+20240923025147.693748-1-wangyuli@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3104846412453756605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:512
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3104846412453756605==--
