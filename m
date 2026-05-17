Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D33CAE72
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041336; cv=none; b=TJVs25okp4ZZdprEF2jHJzunZLTy1Qt+rT6ptgIbNgKfDuW3aeMUNhKyYfJF6GqWa7Zy4hWHFG/BUr50NULdLpriFTxs9eANaRPozxKZ/kd5vQMwYiHvP9aShaUd9pLH2X1ElrHIC4NRNqgh64jypzlROzZ6rMkD/tBGE69qCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041336; c=relaxed/simple;
	bh=rOgPvVJ9luMy3zvxNUEgiV+7mlyNFSeV5ChMY+xLhFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFRSDO8SoCRx/JvQp98Xkj5MkVg+WDOm5L8xXsX0XqHrLPRtMZliV5BtARgt9vLkjpghid+z/W7eGzAFoyf79xbGJ5uVY7LupxA8YTFEWRNWiG9npXc2FTMiMP6PYq5CtSInT1c70rc5Ih+m0fryADyz1H0EAA4N7C2Te+GIlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsZ3jaqK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsZ3jaqK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso9863045e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779041334; x=1779646134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOgPvVJ9luMy3zvxNUEgiV+7mlyNFSeV5ChMY+xLhFg=;
        b=ZsZ3jaqKiaMrA38mhvlb8vku3Jq0uuBD+gtuBnO/f+J+d91trvIlRHRXVYDN7NQWKR
         PUTDQ/IrWbIK76x68eNQ/dozGSFVCwkHhoJnvwjAA59XVEXIQh1u6lxCF5BJtR445wfp
         c1z6z38STj/er0/mx7/S4bioyJn8gFWGRn8ED+6yC9ZWF2ANigMbTeOHBdCSMjeYwJ7S
         xcMxVBXDYDPQJBsKHzea18sQcJFqacJXn2od1od9Gb1bEymFt6jTLoRiW09jTkBMgKYI
         PVd9vDc3R9/XLDpEmTjLcEBUwiAIxEtS3GiufDwdnhZAnCwpr9l6K6ml8MJbCXCt/ISX
         g72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041334; x=1779646134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOgPvVJ9luMy3zvxNUEgiV+7mlyNFSeV5ChMY+xLhFg=;
        b=iNjFHJquO2Tgk/8qIDef2HQ9P6TOBszJFCIwmgN1JqbVsKga2Xg40V/O1odpsBuMel
         ai7x4K2pOdCacwTkDra+QcTWJMV2olo/JENK3/lzXEswPbGZXlfRHxne/IEMC0UXDbt3
         yD0sFpUUmgCwi3Aou2pvBO0hDfMTZWWirxuq8X71yWImzk7V3HKO/cvZU7oEvNqTCNVP
         4GM8ZtVuT8NQo/vFsn2Nn07NvbAaTOFjOtRaZGHWcTdtZRuu8/bpkPIKmr5OI3kFcYDD
         bF+/OOJTuq8VPh33UmZS2E6+1YjF7Z5EHM6wDUmNzf6LnA/XreoFmR2Vr9yGG3mZxGPH
         fxKw==
X-Gm-Message-State: AOJu0YzFGVK49GlWAycGlqHJ8ny1Fp4rTsC9Ac31QbB83fvvb4VrV/+2
	xh+aSuwi5u3rj/VIuulSCNad4C5RXvSHDzaBfgv4mXIqp7Gq3lDHbBAd
X-Gm-Gg: Acq92OFfbTQWmsEbVqCl+aR4wz8sbie501r8Ehp5ct+Cyfh6rSgKXMN+0NRO/eSJVqI
	x11l2e4Y4R+sg8B5mfBR3aOuJ1N8+cOr7rIhKIjyFdboA2O4yXKQuwVJKPtqu5MUdTlKg3MYk22
	maJ/OPsLiveho16ZNroHKr2xiQLwNKpJI38ZsbdMey455tRZfjdeecqtBwWsvB8KyYy5f9pQnk3
	enXsIAxd+MKZBOHSEWzb+/e7pQSc9LYLf7ZvNICGbfVOYhfB5ckIz8QVPCQQe0PChGVXGR4snBi
	HMImVQQz/TCOOTYVeBfZAy9lGDuCjP61g3F8LbxZuoQdvHPv1EGA9RozElxRBY28zWdW35aUhC2
	hoiujD/2j/7Qmj44aOmpwtzvuh49RTAq4xrkDnVFqNfci4L4VEltxh47vcgPb6EtfLnU0IHKqy0
	hj42p0rjWxcqSBSCRxWr/ecLhaLUaw4zDgbT6AbzE0OLLzdBfSwlnUMAFPKnAtReXrVHq/KbxpD
	w==
X-Received: by 2002:a05:600c:3b12:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-48fe61ed2cfmr169618865e9.22.1779041333535;
        Sun, 17 May 2026 11:08:53 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe585absm65005075e9.19.2026.05.17.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:08:52 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: pmenzel@molgen.mpg.de
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
Date: Sun, 17 May 2026 14:08:32 -0400
Message-ID: <20260517180832.52329-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <3a7eaf6e-6e4e-42b1-a136-3ed2befa90e2@molgen.mpg.de>
References: <20260517145417.31910-1-meatuni001@gmail.com> <3a7eaf6e-6e4e-42b1-a136-3ed2befa90e2@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paul,

Thanks for the review.

Moving the check after bt_dev_dbg() would not be safe since the debug
statement reads kp->value, which is exactly what the length check is guarding.

On a truncated SMP_CMD_KEYPRESS_NOTIFY packet, skb->len may be smaller
than sizeof(*kp) when entering the handler, so evaluating kp->value in
the debug log would already access out-of-bounds memory before the
guard is reached.

Therefore the length check needs to remain before any access to
kp->value.

Regards,
Muhammad Bilal
