Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B84F6482
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456045; cv=none; b=fRjDzYyJK/R4uSqlhRUNUtzZvBvbNFRO3wS325JjypdGXIrdNF/mUB1DNLsR9uPc/Jw6BbOIh4uN6qKcLrwvgV22O6aK8YHJLzDYmIsU9B5MfS09DvrQ4EtZWZmeFf0jpAg+oWHOmJTE45JrurBG8+N33tL15DPfPdY7gNJCjpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456045; c=relaxed/simple;
	bh=6QBoq/pfbjK8hNJHvcynYsRCEv5M/wG0+h6tSZ9YVa4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1HAqryl8O0uSOhbRbESs0tbul9iR6G3ug+ahTjJ1+LQ1paKhvC9XTvRWxOH8Vl/aqGgPeh60sfyItUqZIXWyrP0PYsddthsryxikP5YDeLDUDkL+71+qhyLKptUocSyvZdqveahC16jVgx0OhdoW6m/UfXMxeVLX0lmV7N/IlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=IxAtYKL3; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="IxAtYKL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788456038; x=1788715238;
	bh=6QBoq/pfbjK8hNJHvcynYsRCEv5M/wG0+h6tSZ9YVa4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IxAtYKL3ZoeM13GMOnzw4+soq7pJ0g8OpCcENLgE85TAlyInNpaXE+WpkSJyZD9XT
	 K2qIGNBrgrP53eV9fg1AnYUwWQnLdvNrXcmlUN6Z6gpYZP0jd4QT6uaSxd32PzNp5r
	 5Ig0n4BnLLtzNB7y/5VMUD/q8N/WeK//CGZra5vnRuhvddWu4go4btqRTQMVJT69mI
	 PoCIiTJW3LgiRitoA+QA4pZqLn2MOuEIs+03T7jC3YHaw5zJLOMniheihASDP4nXFE
	 DGVDsHW2ttamNWoc/RLE/q+3L9H+aj2JbmTH0itkgbpP/+sVX85P7loMtAhMxmBAiX
	 H6Loz2XpvZejA==
Date: Thu, 03 Sep 2026 17:20:31 +0000
To: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Kiran K <kiran.k@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Message-ID: <20260903172021.98799-1-lsa.uz@pm.me>
In-Reply-To: <20260903153521.130258-2-vladimirkondratyev2@gmail.com>
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com> <20260903153521.130258-2-vladimirkondratyev2@gmail.com>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: f6ba5ccdc55df8cb7517f421eca9736a0b22bf9f
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Vladimir, Paul,

Thank you for the quick turnaround, and for putting the D-state note in the
header =E2=80=94 it says in one line what took me a paragraph.

Two things about v3, since my Tested-by rides on it.

The tag still holds for this revision, and not only by inspection. Between
the revision I tested and v3, the only changes are the comment wording in
btintel_pcie.c and the new comment in btintel_pcie.h. Built out of tree
from the same 7.0.0 driver, both revisions produce a .text section of
21048 bytes with the same MD5, and btintel_pcie_set_dxstate disassembles
to the same 116 instructions; only debug sections differ, by 8 bytes, from
the shifted line numbers. So the object code I exercised on the hardware
is the object code v3 produces.

The CI failure in this thread is against the 14:29 posting, whose header
hunk was cut at line 53. The 15:35 resend applies cleanly to
bluetooth-next at 6696072ffe07 =E2=80=94 checked with git apply, and it pro=
duces
the diffstat the patch declares. As of 17:15 UTC the resend has had no CI
reply, where the earlier posting had one within eighteen minutes, so it
may be worth confirming it was picked up as a new revision.

Sergey

