Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12638DD8
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739511447; cv=none; b=LmQi02eTFk9OqojLvjMsK3N/t6/8XEctgmjuQqcLG9ul2MCAhGGnK9FsJYMPO23obt/IdYwmejelRc2GIzBvbICPGPHGh8gr1bStkrSxAQrYMIO12lRqbsVOWPcHPXavjYWftgRA3dCHpUTBwYDclAGZCb8oK28VqqeX2hf2+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739511447; c=relaxed/simple;
	bh=qD7Cw1anvTno+pjsbcLVSIf64b8c0CLqvUolqxKysoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3Z0Xaj1u26uOciCBwAfwu9f75MLJb/rPuFCaNWDhS6oM5S/nKcYxwtQmNWXWjxMUs1hFe4sxlkEexa8vyXiAmmcyFmaafm2qF4U6wyhUUMdkYGQeMLfPFch/UeE/CmP64oInfIrjT6xBtEpqx4J18RN5ojq+mZ6S97kEr1g5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFIiC9/D; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFIiC9/D"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so11066276.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 21:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739511445; x=1740116245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qD7Cw1anvTno+pjsbcLVSIf64b8c0CLqvUolqxKysoI=;
        b=LFIiC9/Dol8JRv+tcuzbo7pHhdZc35GFsh3hZqQdn4qRlMOLDYZxLRqdYPU8cucb/D
         bnyQsMsh0dUpeZ2XnJ0C1Gt8S8jUDQqz0Xac9hKlFebaBgyI+yatyHB+mu/50ItaQbwy
         byTrdSsQdlpwHAsR/MINeLJxsuGSPZhcPZW/VNrgqnz1/0X/1OvvXlgxLtwg9iT/EMt+
         oGiJkmlH4DbMVP+5/uBYexnzCS0udEAvXRbinPlbwIK7KuWrFWp3Qelmi3hwD3D096Ol
         Gn06KQWsD2Rxt+OO/3+vBx2uv1cFQSES7jyzHiGfMra3IcXzEJMNTk6n68+UwAagA38c
         0YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739511445; x=1740116245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qD7Cw1anvTno+pjsbcLVSIf64b8c0CLqvUolqxKysoI=;
        b=Wp78Wf3qV1Ni7le0OHT799duSKB6lLhy14YRie1G0PsFlfoGeVJ/6Oh570oM2amDQv
         3zfpJE7FftYy80L16NrJROUs9Fuar/gsOmkELIzvlw0RnAr/wcqL8N1n+N5HEiwsZ3sh
         UenUuRzo4hPIjNPKfSaNg7f8SUHzRoa/GHxBCIYqTw8dcruOd1ZRCzmZit7B91Xs0/FT
         K2Yj1ette8hl2nNQdywGRbOfDb5Wn/hw1vLZpNmKL+5yPrW6cdIuHPiU2z3vdG70BMgF
         FEcw8swT4EvAgke+AXT323UL4GOc6WQyC04zw8IpHj3HWxPUw6WBnBp1pJGZtMDbGtbq
         R/cA==
X-Gm-Message-State: AOJu0Yz96WrogzjMJzD3QJH3D8506ZOgbDrh8yYlrHObiGY1yYieQfkW
	+Ti8o7m3sLs8qZxHbVSb2h0osfKlkqJo4C2/TzdrUlDjsiHuwxRPFJJJl7+CMgDdhen68xkIN7C
	ex1peMOaQhIBO59nJnv0a8HCz2Ys=
X-Gm-Gg: ASbGnctztLNfxlYHZVjl6kMBj5G6ET2alLBLd6/HzI4nl2DJ6+IhMSffBdPEBLM7OE/
	vDq8ZQCCo2BnIq+gwYs58I9F5Vs/pgWmFKnfxFHUB0FNNLfCPDSgEx1eLHIIfX77pxnwM3A012w
	==
X-Google-Smtp-Source: AGHT+IFq1RcMEargUHA/AwfACpp80mrLtfC7HpqSl1buskS4GScR2I63rgdjcKVMhKsW71uNeGgAozIeTmuwymQnunU=
X-Received: by 2002:a05:6902:dc9:b0:e5a:e7eb:2803 with SMTP id
 3f1490d57ef6-e5d9f0e93b7mr8719292276.18.1739511444936; Thu, 13 Feb 2025
 21:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123134908.805346-1-arnd@kernel.org> <67ae71e1.170a0220.69f3b.9ade@mx.google.com>
 <CABBYNZJz0yFAyphL-wRPWJHhqUBX_s5r1U91bZo+U7V46c7yMw@mail.gmail.com> <CAGFh0267CagMx0UFg9YQputn2EK=OHVgx+n_OTbZ7tZYMYU76Q@mail.gmail.com>
In-Reply-To: <CAGFh0267CagMx0UFg9YQputn2EK=OHVgx+n_OTbZ7tZYMYU76Q@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Fri, 14 Feb 2025 06:37:14 +0100
X-Gm-Features: AWEUYZlO05OACSVXkMNjDwr2bp2cHeVhl-ijT_j7fw-JpmgZN3_U_BGHD1kvzso
Message-ID: <CAGFh026t7RQJos=uCnUb4kg4Oc0U_GbwsNdGLzP2BaPofwu7tg@mail.gmail.com>
Subject: Re: hid: intel-thc: fix CONFIG_HID dependency
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, arnd@kernel.org
Content-Type: text/plain; charset="UTF-8"

Another idea is to add an option to the tools/test-runner which will
allow to enable "-cpu host" on demand, so for cases like mine (where
binaries built on host are not compatible with QEMU setup) it will be
an easy workaround. Unfortunately, I won't be able to submit such a
patch until Monday.

Regards,
Arek
