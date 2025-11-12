Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A22FC873
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937120; cv=none; b=Zh4CN3seQFGCk/CLm+lN6YarRREYCLuJhbuqqYqd5iM9GLua2juWDV3akKVkWUf6z3pm1eV3rqHoV5PfhxMGPkN0ebv5HSevZt2UJzngXPSk6vQiAyS++6bZ5COcF98wqMgG+UhAuBj/tRdmXY4J7YC0zDxxCajewKff+Zy6PEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937120; c=relaxed/simple;
	bh=JNYRPaP1YmGUiUQptWhcK6PfoiUPzWu0Uwkvwf1sGsM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fw0rVu/Ec/xlp5JZ3dX5iBE1+T7+SItL8RM5pT/E2Bs0+TVRwOC0PQDpYJ6Vitczyi0E0BVRP1kZm96jAMMXL+xqMxX3J6urpkGvPBG5AlR6frDEP5JkGTu5kqOweMJBiqteSRt1I6wDmEhrvFWRtYanxU1Yf5CUeJApq62tdLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bNAfioDL; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bNAfioDL"
Received: from github.com (hubbernetes-node-402c158.va3-iad.github.net [10.48.12.54])
	by smtp.github.com (Postfix) with ESMTPA id 71A53E0BB2
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 00:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762937118;
	bh=6P/Q/cmsUkUxg7LXxSKOeTlc97JqIwWAbCdsb1hMrEE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bNAfioDLnuoQq9I0L/eyyYlBN0JcT199oWjiYn9otFMzDNRghKFbx77lL+noyEnsi
	 TJyFmXAFfzhUWbbNgjFkoPDjQuyXTjhgIIYdjasZuGBLHiFAxcU0fWnjD+pdln6Lna
	 u0ZvGtpl/ZYajIfnIPufySlEq6bZ2VzXjaI3ws6A=
Date: Wed, 12 Nov 2025 00:45:18 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1022376/000000-500893@github.com>
Subject: [bluez/bluez] 4128b8: shared/hfp: Add simple 3way calls support
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

  Branch: refs/heads/1022376
  Home:   https://github.com/bluez/bluez
  Commit: 4128b8743c4bdb85af0fbaf7aa8e1b478ae3f4df
      https://github.com/bluez/bluez/commit/4128b8743c4bdb85af0fbaf7aa8e1=
b478ae3f4df
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-12 (Wed, 12 Nov 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add simple 3way calls support

This adds support for the AT+CHLD=3D0 (Releases all held calls or set
User Determined User Busy for a waiting call), =3D1 (Releases all active
calls and accept the other call, held or waiting) and =3D2 (Places all
active calls on hold and accept the other call, held or waiting)
commands and the +CCWA (Call waiting notification) event.


  Commit: 50089370c8cc0cebb9f9ca6ebca80e872369e745
      https://github.com/bluez/bluez/commit/50089370c8cc0cebb9f9ca6ebca80=
e872369e745
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-12 (Wed, 12 Nov 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add tests for simple 3way support

This add the following tests:
- /HFP/HF/TWC/BV-01-C
  Verify that the AG indicates to the HF the presence of an incoming
  call waiting and that the HF sends the User Determined User Busy
  (UDUB) indication to the AG (AT+CHLD=3D0).
- /HFP/HF/TWC/BV-02-C
  Verify that the AG indicates to the HF the presence of an incoming
  call waiting, and the HF can end an active call and accept the other
  (held or waiting) call (AT+CHLD=3D1).
- /HFP/HF/TWC/BV-03-C
  Verify that the AG indicates to the HF the presence of an incoming
  call waiting, and the HF can place an active call on hold and accept
  a call waiting (AT+CHLD=3D2).


Compare: https://github.com/bluez/bluez/compare/4128b8743c4b%5E...5008937=
0c8cc

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
