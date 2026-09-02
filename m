Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA747420477
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341472; cv=none; b=tfomnOMeoW5RHvLuvfR8kxdSc3oUGkkgyWg06UYRxi/gtmZGEN+A/FwBQq9zmoSmtmoQNCE6OjDp9y41goZNF6SXnhAEmRz3RbkAPwvYRzH3qAcowK4DX+Eli6I27D1dJzPSksRV0uVNuL8exRXzROLgs+EGIJru4w1e2iYhvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341472; c=relaxed/simple;
	bh=XhwvZho44DKRPrvA4WHo7bTDSDVDjqux91LUa0WErR4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rupsfdfs4StJGaQyoYgwufp7r/0H8Nr9sc2JVgOndz0Z3BJTEWe2+8AieXV0tSCqRV0UGZUODpwC4bfY22otfaFUBesK8wRuNXbN/Jp1mC61F7fXn2o0gnaAcOD4IBmo0Y9Nf6cHsfvI+bHmRtgBlB2/IGkOWN1UKRO0ciDxVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=TKLM11vY; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="TKLM11vY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788341463; x=1788600663;
	bh=0pAmZqGVXy4gUZk76iF6kCQFynnQQuqdi+35+w0zZwU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TKLM11vYpEE/kVaEwXXb6ehraBNffzfo/FvGMhlYQ/aXFp5gNqsoq71LHrbDobwxU
	 +g7QId/gDwm+ox1xIR0rWVdTewOSLhfqrt7Yv794IvhLKghlBhatEoCSZbY5DWDsyN
	 7inUCRRf4YYY5pOUUVxbK/noh4DTtC1oc/ySP0KebXPYrvNAhG0Sk7g0v4WdL0S6CP
	 t05aMTbKt7ywyQ6KRJm057qYYnnO6ch2aqOzz37d3gU4NwAh7JFPyG+GfEpotH1cei
	 c60hfH/CrXxvoO0WluwqEY/N0NBF682o9N5wGaHWxK1kW/u8YrYQ8TGU5XJqw8OoiZ
	 vErz9KhZIjIBg==
Date: Wed, 02 Sep 2026 09:30:58 +0000
To: Paul Menzel <pmenzel@molgen.mpg.de>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Ravindra <ravindra@intel.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Message-ID: <20260902093052.66719-1-lsa.uz@pm.me>
In-Reply-To: <d633b7ee-0afa-4fa1-8340-3d7616f429d2@molgen.mpg.de>
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com> <20260901203818.112189-2-vladimirkondratyev2@gmail.com> <d633b7ee-0afa-4fa1-8340-3d7616f429d2@molgen.mpg.de>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: c39829796aa564f08d04ecf089c890a50a3af3d6
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul,

Thank you for the pointer =E2=80=94 it was the useful part of your mail.

Ravindra's patch changes the same function, and the two turn out to fix
different halves of one failure: his makes a *late* alive interrupt count
by moving the flag out of the retry loop, while Vladimir's makes a
*missing* one survivable, because the fallback check still reads the
stale boot_stage_cache. The hunks also sit on adjacent lines, so whichever
lands second will need a rebase.

I have followed that up in Ravindra's thread rather than here, since it
concerns his patch:

  Message-ID <20260902091021.20160-1-lsa.uz@pm.me>

There I report what our test fixture does under each patch, and offer to
assemble the two as a series if both authors would rather have it that way.

Your other two points =E2=80=94 the Link: tag with a fuller commit message,=
 and a
comment above the macro definition =E2=80=94 are Vladimir's to act on, and =
I have
no opinion to add beyond agreeing they would help.

Thanks,
Sergey

