Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27343E487
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433997; cv=none; b=iQsEGztUcXJH9bCBSPrtTT1qxWtPzIWyCaMhNnhBJefOER9YQxLcsrPE18Vq2Cu6hhfgj/pmvHTROhrTmjJ5E5mNKyJZPzatvGReP70VJNTF8nhGQsYLkiccDaupHlprKQKO1GR3CIO+TtkfSJoJ8XiqfHK+t7J7J9g6kEqStHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433997; c=relaxed/simple;
	bh=NpNr3R4j9ld+AhZYo46Mbess49k0Aotlc5zr4QKrzIs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uSbfe83QfpJ0PDVDm1jgE6gE/wkoIlTGBSbhVurLVNOAJLp3vf1TVRN9IDw4nFxyQZNmDttXTpLSGUDCGRxK7xCqSx1kdJ5uiG1Vx0+65M/TBW+7xaBkQVY6syHlaUiz0xgI2sYP/9WNQqkmJe/umJCo92QLD403J7lKmLG9Vts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XfoYgskz; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XfoYgskz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788433993;
	bh=MrSpHix8nVkLA7I4Mu9ZTT9Y9s8P6Yy1j9mbcyrU9vM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XfoYgskzEiWes8QrftMxs9RH3rnbfQ0s8Ri7Lr6iYQo8HQ68cAEjHJZVCEns/gTVB
	 vTkpT/tlfxT+XZb7l5DGSUqTtL5bLCiFVQXfrC2z+JkeP7cOG2qjejF9yQJPSku0F6
	 CGlrzJAjEGoKYyIRuS49iOAf0SkMi8z3mcpUmcRQ=
Received: from github.com (hubbernetes-node-f1e3c89.va3-iad.github.net [10.48.67.85])
	by smtp.github.com (Postfix) with ESMTPA id ECDB42813F1
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 04:13:13 -0700 (PDT)
Date: Thu, 03 Sep 2026 04:13:13 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1156754/000000-2d91fc@github.com>
Subject: [bluez/bluez] 7b6fda: doc/qualification: Add ASCS PICS file
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1156754
  Home:   https://github.com/bluez/bluez
  Commit: 7b6fda2d119c621ee6c18970c808be3c066c6f70
      https://github.com/bluez/bluez/commit/7b6fda2d119c621ee6c18970c808b=
e3c066c6f70
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    A doc/qualification/ascs-pics.rst

  Log Message:
  -----------
  doc/qualification: Add ASCS PICS file


  Commit: 2d91fce1871af858c2d93516b534cfde5410c5a5
      https://github.com/bluez/bluez/commit/2d91fce1871af858c2d93516b534c=
fde5410c5a5
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    A doc/qualification/ascs-pts.rst

  Log Message:
  -----------
  doc/qualification: add ASCS PTS tests documentation


Compare: https://github.com/bluez/bluez/compare/7b6fda2d119c%5E...2d91fce=
1871a

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
