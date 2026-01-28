Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E52EDD6B
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769601585; cv=none; b=qRiJ9/lHFE69T3c91SVDTUwhP6yFhLH1xONeTGRO37aoMVa6VcdHxYuJ4tC2O6I/ANl/aGQTP/FtnJuNTjwrlIz+NuhE1mkT2v2eEzeqxHaAxYU7DV7nzslIYbmF6jcMk/wFpgHuDERA5oaG7lEeV3g3erH9EdOhVmcp+YCsSWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769601585; c=relaxed/simple;
	bh=gdDEFvN+Gy5l6mzTuSwqUG+D/GaOmN4yHQuKNhkste8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pwaLuiLs0n1O9tcvPJSuYLl7AAhktIg9gTov/Ljhy1+4mi2QTZ1oLWWlXNpe8rt98PqRnQrun+K2dL6J8KfQJwUuerWs7hHSd28iDoyJDj8I6ODQYQGkvZfTHcq2u57XiG8pJP2pHXjUarZIIR5IRyIRWDPtx11+f99+yO0li9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h2ElTfOD; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h2ElTfOD"
Received: from github.com (hubbernetes-node-8e8e964.va3-iad.github.net [10.48.178.31])
	by smtp.github.com (Postfix) with ESMTPA id 690004E1326
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 03:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769601583;
	bh=gK0Q4QYptWCg9Wc5oaurHT8AW7JZ1NNXAfzECXzuNaA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h2ElTfOD116rW/wH6vTh401RvyZRywmJi15zE2mhy8fl7z8+zuqtDbYvnUfvNwEEz
	 aKycpuVBdVjiqBwzaBBT9g5gcleA/9m+/gD6AWAfrGJRWSucY/X3idePPaQUiytOV8
	 rfTMsz/jaO1K79oCqZwyIwpT7u13wlEzklyfUgwU=
Date: Wed, 28 Jan 2026 03:59:43 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1048044/000000-615102@github.com>
Subject: [bluez/bluez] 615102: doc/qualification: Fix typos
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

  Branch: refs/heads/1048044
  Home:   https://github.com/bluez/bluez
  Commit: 61510247a4823dcf168d08e421c0199bcc30fa6e
      https://github.com/bluez/bluez/commit/61510247a4823dcf168d08e421c01=
99bcc30fa6e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-28 (Wed, 28 Jan 2026)

  Changed paths:
    M doc/qualification/avrcp-pics.rst
    M doc/qualification/gap-pics.rst

  Log Message:
  -----------
  doc/qualification: Fix typos

This fix the errors and warnings found during HTML generation.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
