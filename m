Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF043556B87
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957407; cv=none; b=th3DLPML2frgdEUawhltaJGbErIa3X8IGi/kyJrEW0Kr4NAc5yZFimeKyHqfxXmziugj1WcQDl8YQ+VEw0j88mCpRWDHME87Y+N5liMN6OUGQbAaTkM8dx8+ZTGp1g4xZf5k17x9mRcCN/xPh5ok15/feOgonx+ljx2/JVaVbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957407; c=relaxed/simple;
	bh=Uktwc6ruBLtHaQE8R06Gv9YIPa0RVKo5lLUeLul8UkI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ewPuredV3Vk9Fo8x80zNea2P6KFOdT6kIjH9qYuHIAwyG0hsZLxYZdFfZdv0dPdmCSiNitnpNt4rHwQx2RD26Zl3T8115Sld0GmVMsAY+LBLmvUha35RAfJBQLjX/QYlEz12miMPBrQY/KK/NqhBmelntN5tCtz2Vv08cFMrgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CgI6YYBh; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CgI6YYBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788957403; x=1789216603;
	bh=hW4Vzv3EPTbCs/VWGsf9OEjlGypFawhbi4DSk4mkHoE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CgI6YYBhwYzLSCqDCXmcsIki2ShtlUydpsYe0MF8f6swPyNmCAp9eB8FMajrdeDjb
	 V7qy41aEVX/Y0Zmgcm+byZpUVt5bG2s5PSvJQ1I/1UQaYvxfd7Ndnz955GvwuMVgUk
	 hmak0paIHTD0tReGjlov+dqhe7zdh1Jc37TO/E2UireCYKZZsKQy2aDDaFLVzLbgpu
	 B9NpNAX0+A0XD0Ze8VEert+o7fwlrpMm6y3slHi/HlivJNQUdChtXwMYgSB74AVq5w
	 jgNguCxdthWjHGyvG+4OqP/nPihPwbOAnviyJ9rA/tm3CUWcMCDHlBZRCbCQir/Qqh
	 NZyvwEmCnH78A==
Date: Wed, 09 Sep 2026 12:36:39 +0000
To: Ravindra <ravindra@intel.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Kiran K <kiran.k@intel.com>, Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
Message-ID: <20260909123633.72077-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 0cbaac6b5cd63c6e9544c775233f07c35444726a
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

For anyone arriving here later: this patch is now 2/2 of a two-patch series=
,
posted today with Ravindra's agreement.

  https://lore.kernel.org/linux-bluetooth/20260909123416.71919-1-lsa.uz@pm.=
me/

It is rebased onto bluetooth-next on top of Vladimir Kondratyev's fix, as
agreed. The rebase touched context only: the header hunk removes u8
pm_sx_event, and bluetooth-next has since gained struct btintel_pcie_mdbgc
mdbgc between dbgc and dmp_hdr, so the three-line context no longer matched=
.
The resulting diffstat is identical to this posting - 44 insertions, 22
deletions - and no reference to pm_sx_event is left in drivers/bluetooth.

Authorship, the Fixes: tag and the Assisted-by are unchanged; my Signed-off=
-by
sits beneath Ravindra's as the person passing it on.

Please treat this posting as superseded by the series.

Sergey

