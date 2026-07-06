Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31753F0774
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362115; cv=none; b=fAd7HawSD2XvUOoLZChwRDEqalweHBHcbbxrtB7BJsc3jcbQCdo8LuL73Gn3fobngMLmUOGTzJ+qgLdpFmhmqKqiZ2iYaT/gYdMmHJHL1DEd6TAyqrEMfZUxeHtV79fuwTdmZ3bQQBa4eVLOX5V+noF2x49ZUaZMJNCnrZaiFl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362115; c=relaxed/simple;
	bh=nhJpGrmncRd3ffi5WYFE++wBX8/00CryudPcgriKnv0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jEBtbwSHME+oDits8NQD0TPB2fJxjV50gsoSuMCxLxY8nnTWan2mxKjW8f0rJmsBi63JwJrrvW8i8TUTTLJxwN0IlCq0WpJe1skMjrUPxB7b7tRhAogEmOkTfAevdlRXt9+nYN7YP2/yPSjNuS5XQE/qiqkbYW79hp09o0FNiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2nHXHPY; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2nHXHPY"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c16ac21acso16147531cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 11:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783362113; x=1783966913; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nhJpGrmncRd3ffi5WYFE++wBX8/00CryudPcgriKnv0=;
        b=F2nHXHPYfU1Vv6ceMI2Y2VQOD+63LNNJi/3Hm+jL3px/BNHdJkyjFdZzlJoF2p14K+
         qoKIeFtA5kJ4m1BKGrqhIU8AQ4IceF8JHfo9UKfyATBN5F0X6PiHxi3mYd4eyMOMYv7U
         BST+4rs6sxO5E7DZMHg4AqkFdNcix318fexCnaG9uBhIlhHQG3PnsoYylhYweNAqJQwB
         xS1BmFtER0Vqv63J3/Ag8Mm2wziCTAphC8jP9QSemNpfMyJzlhVexm+yVrfLaUV39rXE
         XELGnqY7N/axNeImUf7uuFSlgHZ4BUKdfpNVj39tYiPV4Y9DY3RTQVdJ45j+B3T5E/nt
         F2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362113; x=1783966913;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nhJpGrmncRd3ffi5WYFE++wBX8/00CryudPcgriKnv0=;
        b=ObUYxDeETuZ+IxPmCEqeNzIBfNXDI6PsMwfylzcyhWGSiEDiBMbShOXUMRZvO/CR8s
         AvkOJ/wNZfqhEN0vgUy6PrIPymchrn35OaWi4RNcQzcCu2QfmSd1kz+yzrtVf6Y4sSz5
         vrejePHnUOpAfmLqLxXAXXmyBrJ7Uon/SWSC+de9QKW3w7+FwkrKcklsCJr2hvYrxYR5
         rDT46lomcvW565q/ruOumqFNpVIEegr203YlDHlWauUxV/xM8o+1YauAtF//Cz/LdeRI
         8Ju3YGKFF3HXKrwr2DsIfqLxHc77mukNF+T51niF7oB65qMgH2PX8P10fdDWamYTGS97
         tj9g==
X-Gm-Message-State: AOJu0YzOsbre9pKO5iuOKZRnjT55XeQqxc5AiTPDuJHHV9Xmk4ElS4Hs
	tqYmK4WrWilxWiR3PGpIO50v8j1UIApfKECNynQpo/ts1Yy1MHm9SX6UY9qOJA==
X-Gm-Gg: AfdE7cn/fdr2Ls65kyoNwahNAOetAViDQB6bQAOtIQchecz5xOvZtO1vuGLzYZk7Fni
	Pz+VpwAbiNic50KCQ8FtEatKNjqQfMlxxTRMPAzA/d6yFGw+rKlLKToKhJoHnKmxVUEY0f6AcqT
	Bt/FphjjEEBQ0qEwu80H497yGz9eL7odPNMK4y6PXHL3MzNwP7Ulz+72FWxETGwPcIaKZ1D8mXE
	gdM8OjGuJxGwGNdP3iIxnbIq7Wa2vbX5+3Jvzsa+Ad8JbYlGG1kXbRKurd/89TOoBidr+8iXx9Q
	M8HOhcvDVxdA8qBS+AouHJA9RCjTcTUqLjV+f07UVvDUtM+KUcjEVOgsBufjkgJheg6SbSLTjjT
	eaaWhu3TjKaiLQo6R62qO8Elp0Fm0Q2zmy65WSXtc+CeoAXLQzx0dma0IZ/G6NOi3PW2Z6CEIas
	73Ibf0HnucPwwy/FhZZBlk1Q==
X-Received: by 2002:ac8:7d88:0:b0:516:df59:32cf with SMTP id d75a77b69052e-51c7479f5b5mr21473061cf.7.1783362112897;
        Mon, 06 Jul 2026 11:21:52 -0700 (PDT)
Received: from [172.17.0.2] ([135.237.130.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4726b3201sm143232656d6.46.2026.07.06.11.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:21:52 -0700 (PDT)
Message-ID: <6a4bf240.50eb26ae.3261b2.81e9@mx.google.com>
Date: Mon, 06 Jul 2026 11:21:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1954849190832953644=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, george.moussalem@outlook.com
Subject: RE: Add support for IPQ5018 Bluetooth
In-Reply-To: <20260706-ipq5018-bluetooth-v4-1-350262a30959@outlook.com>
References: <20260706-ipq5018-bluetooth-v4-1-350262a30959@outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1954849190832953644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btqca.c:997
error: drivers/bluetooth/btqca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1954849190832953644==--
