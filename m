Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CF1A6832
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 03:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774324762; cv=none; b=tVhCEShBKu0UtFJ05DOe8PIQBne5Sm6dTssk6Mp7n5MNsHWhthV80Yj2XO/1BmwuG+ucXM39TFea/80ABTDhUiAh7GdI9C+UGZOWktspLWnmMuvb4iLnxBpZvSCW4HplLKFwzHUMkGFYxahOMQT4oBolYVKcywUQdH/cpHY2Zzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774324762; c=relaxed/simple;
	bh=FHf7/H/yePH3vUqYsw+sLLqvOYec1VVOZNeRKp2pJe0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IFal7WAooUreaEEa3i6bKfTV+RnKh6uFRxJU1ZEvEC6wc7VputmPofIrpJi1PMHIE90BMXtoriB1Lpp6qVYeOA1S0ppWMOw4lbCUO/cFKj3LkiCGuU+yREB8tgMQnFx4RdK8kOaXT0R4PMgmK3K+/hvqVf8CqJ1Qq300Pc1AJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIQVanAj; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIQVanAj"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a6cf8242so38394821cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 20:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774324760; x=1774929560; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FHf7/H/yePH3vUqYsw+sLLqvOYec1VVOZNeRKp2pJe0=;
        b=aIQVanAjTSVHPJfNeW9TnM0D0wHWlc8YWTXRIOM6d/Aul0ZeyHwlzfzW4E7DXUpKKu
         7dCjLgsACarxokIKi/TIXPFiNjC/3836KYgowsOitRJaxipQwjBJu5Ohyv6uNm4Mthlf
         QvYT86A7+fBqkMLx4bMSNhJBoGLprZKPt6emX4HRHdGPV5VpBYeA9nQKEfUbw1LO25MH
         rfNJUue/9D0umH/gNEV3vdOJSjWT6U3bQEc/J+247/Xc5eWiNExhZRcifFv5LLAJ85sC
         mmMu1i5NcUDELRJZZpndzFrEoaWHwrCCcEki/GvioXz5emOySnUiGXU+hqrtFtb8eYDN
         TwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774324760; x=1774929560;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHf7/H/yePH3vUqYsw+sLLqvOYec1VVOZNeRKp2pJe0=;
        b=KkxmFb06j6Ea+4d6Gkny7gCc/d3PuIrqiqwlxqfVsw+w8lkiTjXVZVCb1Wlv3/5NVK
         CuU4unbI5k8QuAbywsctvzXBRdof4bM2flXhAJIqmTTs9/NwvL9DhEKbMUbKpDE/4zqG
         RsLQfhg9ATz6vuQ8aC/UtcBisWhm0Vn7DMEHFr+QLqIB98bdtPMfQs+qiMruLUtrvnjy
         DA/A8WQINWLxKrZZayriLvJN33zXHkuhckDsrziJcsMp6+nyeMJ12LkBcDC9BxpxwUrF
         8VRY1m/KEeyEakyXYwcb76UucCrieXrqTmSIruFJidPs7i7oNWoQd21xo3uZ9LMO5qko
         ge0w==
X-Gm-Message-State: AOJu0YwYmm0/ShEVRa10URlhHko9RKPN9wUOq6nAs+wRwy4xNHWuwllh
	r+px83tmyTZauSYl/kweg1PF9KkKgdWznAp6gs0ym2FYW4sYQ7aco3E/5/6HmA==
X-Gm-Gg: ATEYQzz+Kr97USRr3QoDwgmiqVRAria+OdLX8JyP1hYKLrapra6vSLQkFxPeBhAaSAT
	+J/Oy6Jp0VgqnwZXxfDG4iVHkJ6Yq4NVj8ghlVz6eCkwMjcJ991MVNzKqG5380EsSRraXMgoI92
	LGdiZ34y6yQrpxYw+rQNS9TiSLGjfWWWuJkKZOepPK8TpXEe9YvUPhZIDQptO0LgK/8BE3Nt4zb
	GEPiTXe36gwtbHhWtb2zWQqyNWFr2e0B5vJYPhOgkLfMmlwhhO14kfSA7shkFiziwRdFqB2+clr
	qh97rZcpuNIvC5GKvd+pLRWW76E4OoIcjKdEXF4/YoW3KwwM8LVC3jmEh1CKQc+ICYRTH8EluSz
	VreuPYvdprSYlCP67aM27S4WdDcj1mPrvp2aQa6HPvwJ2OzZ4mtZ1hFK6H4fiLk0zk+6zonEhaU
	XWZt2wFRFS7Fu4mzKitlze3XvyNSrQv6k=
X-Received: by 2002:a05:622a:180f:b0:509:2053:ab5a with SMTP id d75a77b69052e-50b3751c0f1mr207080611cf.57.1774324760352;
        Mon, 23 Mar 2026 20:59:20 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.177.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b709da0bbsm10163511cf.14.2026.03.23.20.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 20:59:19 -0700 (PDT)
Message-ID: <69c20c17.c80a0220.85476.bd61@mx.google.com>
Date: Mon, 23 Mar 2026 20:59:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1207235837866483043=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rob_garcia@163.com
Subject: RE: [6.1.y] Bluetooth: eir: Fix possible crashes on eir_create_adv_data
In-Reply-To: <20260324023402.2607704-1-rob_garcia@163.com>
References: <20260324023402.2607704-1-rob_garcia@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1207235837866483043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/eir.c:242
error: net/bluetooth/eir.c: patch does not apply
error: patch failed: net/bluetooth/eir.h:9
error: net/bluetooth/eir.h: patch does not apply
error: patch failed: net/bluetooth/hci_sync.c:1248
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1207235837866483043==--
