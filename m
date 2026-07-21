Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F94390CBF
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632797; cv=none; b=d3fGw/E62sDDnCEDBrFMRESsir27pjIl9cGPnwRPVTevB0fXbabrIIutm/qj2NeYVKwuATj7Xi4or/W9QKdmjpVFzeh6qrJuyDI34juHoMQrTMoOhCXiL1A7pU4MWwlCWbLWjYb/XKDMcKRn3HsxKbsTuDZkfJ7p6bh9vutkGGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632797; c=relaxed/simple;
	bh=atGcT/dPT5v4d6Sh5zaUh4bL4FTy9GM4irZjbs+GsOA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=u7PeNy7MieThoy6qMctdOcZHyWg3COAIfyzSb0r3UFGxfv6mNpkJqfCdxO797EbwPRVgLEz9bf6mrfzKmGLczqtQq2kwbq/e9hs+o/oLZhL6DFksbQrH8pq3uqqP9kjvEwsVrsngQ1Tu9lYUtQzP5reAB14b9Fga2PrbtJrjZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLYu6jkX; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLYu6jkX"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-451fd21113cso3684659fac.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 04:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784632795; x=1785237595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=atGcT/dPT5v4d6Sh5zaUh4bL4FTy9GM4irZjbs+GsOA=;
        b=pLYu6jkXdqVlPJKYYHnbYpFNGLj3mtBLtlJUglnB+uU0+z4Yk6VXFhtTK/vYWaoCSM
         nGhvpDNpnXyUYslHDZ4x0Myo3LlUt6dstvvXdaReg4RNOC/qiC22RJ235qXAK9oqlswV
         yMBM3JTc936fgrhZWxmLqI2DIxdytiSuN2fGL8DBWX73onuxi5DnzSENv2DH6TzFA8CM
         I8oTyYLH0qrrYa81bCiJ9s2FqnTQszVfRnW+behJM8QbeSWjr6cm0UJgwV3Io5zhbP8Y
         ovJgVQ+IH0MPwfp4+9qtIsA3fmi0Jpmc8RAVhUIpqMkYhuvDCva3wpZAXmNTSygORyTn
         c+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632795; x=1785237595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=atGcT/dPT5v4d6Sh5zaUh4bL4FTy9GM4irZjbs+GsOA=;
        b=Rdqs0jp9DtmjTo6pJ9QavcoU5MWhAnKaYnxvnpWSuVy4ejmjPuSLG93tQoGwU/kwG8
         35zV71VP04kcQtZZqR2aAsw1UFpu4c2pMZhEO9CfSp2UQoR5+Xql7J/XPEq9V1ZP4R7T
         91e25YTuJJ8fpeM7BdT8bdplKoOYQNHvnMkYpGFkbIgPW2ruq50iSm5bKDIwQ3HKg6ZF
         u8C+OwSGEj3GP5KfuNoupCYHG/Y1SUW9omlmSVIP3YdcyUPSpRr/8v278YWVCLyH0xwi
         Xbk82AbGInqZjT7Gk/bTJhL67IO4yrFCORWMRrm8ljg7Z9K/s6qlEkUZT4Yxmv2mFnB8
         7PlQ==
X-Gm-Message-State: AOJu0YxJUrkruyezUNue6B/+0tPLDM0dvY7736vQk5xftEmyHhCoAvSw
	L3xHWUU5V+SleHxX9ELqB8f8ZNa20Dom0d+ylo7oPrIq8vO7ZVaINO4SYBdq/Q==
X-Gm-Gg: AR+sD11cHO7OnC+9F62JbRmJ0l4HtUHLst8GAEBFS80ooUoBr8d6Kdi2ewGCvIYcAAk
	LArEIqPvo+bnmTFreo5lVHwzn+MDVCEgzQ6bWaZcamqBp6WQg4GLsAuyxKWYTlAXRtpHBgGG9ZL
	md1vRk2IM7PDNaq5SF6z8afoUlwpwG5z2OA5X1JgXlDs4RziSqpHjFGYEq8tHrwtBOclHOKAm6O
	Qwp5U2X6ku1MnNVk+dnndL+fhg91TfPKzolWxvKEVnVyEyS1lJDa0zsJCh2PwC3+qgBV5tyEeLf
	B+JFeyv4W6z10td2fdIBzcLU1fzj7aF4QOQ54BdYXBtl6gMFYForz4veQt5vDAGIB2MwS+ekhSG
	PyYWLEYoP4bGqqYBTXU3RDBq5zpDJzwMrmT6FNg8s+SkOpqlPH2knagYpP6NYaJWzu1MDJnoGKV
	vgzQJ61HT+UbjHl7lWi2o=
X-Received: by 2002:a05:6870:41cd:b0:424:801:49fe with SMTP id 586e51a60fabf-4568c81eb65mr8373084fac.8.1784632795364;
        Tue, 21 Jul 2026 04:19:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.238.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4568e141783sm11790906fac.6.2026.07.21.04.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:19:54 -0700 (PDT)
Message-ID: <6a5f55da.fbcacea0.dd55d.5add@mx.google.com>
Date: Tue, 21 Jul 2026 04:19:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1071304029171269563=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: Replace HCI_VENDOR_PKT usages with HCI_EV_VENDOR
In-Reply-To: <20260721-fix_vendor-v2-1-1977a8c39708@oss.qualcomm.com>
References: <20260721-fix_vendor-v2-1-1977a8c39708@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1071304029171269563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:2800
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1071304029171269563==--
