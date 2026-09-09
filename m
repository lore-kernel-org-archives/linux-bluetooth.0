Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D3E54CF7D;
	Wed,  9 Sep 2026 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957406; cv=none; b=BuocMPB1L7I0IuQnB5WU5WyQg/2baKqqDey83YZY03MZjwB0wIhsZLEJo08iwifK49UwRcyWtub6Faj4r8W7+e4bZqyfOr1AMeLmbR/OTmi5i4iRc8guy3CIhFoCAGZrtG9Vn6+bp0aicwR0OLSupgZV8dGKRT/9hM5nI8fubjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957406; c=relaxed/simple;
	bh=l46CKViQp3zW5HRKchxZ3QEpRItrYTg7NYq3J/AMCOQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACHgQokisftgORfRqNzmZlgkXymButad37NYc6C81bOuZyiiPXfb8/hGr8x0TLhYUAVzyxZjllohT+gZf+tEuqqYvlUAy3GrLPqewUFX2BLhM+m3hLdo1BxcHik7OUr4S8Jy03llsxvmLpY3PymbHa7/HjgwG120OqkiaC38yc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=lbj2PIgU; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="lbj2PIgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788957396; x=1789216596;
	bh=UfMgxI5ECUBneggy/3p96uqfpXXz+eCuwUnoSjzcPgs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lbj2PIgU+CKQD/IPeor+F95N0TG0rhF69E7CTIrAS5rA0WQ4JesX0iN4lME0Z36SZ
	 j5YdOC8mBCq4rJ7EMl1EdKqZhVK/GjgLOcKuewnhWRa8TH+j4vE7LsvguoNQwoLBFV
	 9F3bi5eGXPuj6mCfylKVP6TTQ4FWRbwx0rVnLy2/R/ETVBH5ACLMDI6ja/hn3yFaAf
	 0YZ4D9pV5UwvaKDqNflXNTSOmK60XSlOfoSndtJfnxGhQWQqk8FePpbeYslJknI5NF
	 oDv2r7RRqYdp53VyTlxex1ZurquxnaDyKnBKbm+I93f/hCzcrYcyjTmNkdUXM9sGsk
	 4JZWJ0XpEBK9g==
Date: Wed, 09 Sep 2026 12:36:31 +0000
To: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Kiran K <kiran.k@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Message-ID: <20260909123625.72055-1-lsa.uz@pm.me>
In-Reply-To: <20260903192245.135310-2-vladimirkondratyev2@gmail.com>
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com> <20260903192245.135310-2-vladimirkondratyev2@gmail.com>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 112975b915fecf03c95a6dd87eb0d6eb75a25e11
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

For anyone arriving here later: this patch is now 1/2 of a two-patch series=
,
posted today.

  https://lore.kernel.org/linux-bluetooth/20260909123416.71919-1-lsa.uz@pm.=
me/

The code is untouched. The only change is my Signed-off-by beneath Vladimir=
's,
as the person passing it on. 2/2 is Ravindra's PM-flow patch rebased on top=
,
with his agreement, and the cover letter explains why the two belong togeth=
er:
each of them leaves a real failure behind when applied alone, and that is n=
ow
shown on two machines and two controller generations.

Vladimir, I have not heard from you since I said this would go out unless y=
ou
objected, and I am not reading that as agreement. It is your patch. If you
would rather post the series yourself, or not at all, say so and I will
withdraw it.

I am deliberately not marking this posting superseded in patchwork - that i=
s
yours or the maintainer's call, not mine.

Sergey

