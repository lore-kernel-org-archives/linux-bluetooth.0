Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F982E9EDA
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534785; cv=none; b=KSNzcFRQEILN3FCO2hS4qUAx95inERMBdE5urwPzRCG9GudjZVD/baXhE7Y3eV2QxHP+f8aEQEKzySe3B4k6T6n1HlKDya/IwEere8w4uaG82UKXfisaX3hU0VTZo49Gby0JmLjhAsl6EBeedR1XW3j1F3c8JpV/iV/RAJpoy98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534785; c=relaxed/simple;
	bh=xND6+SoZI+av704C3qT3fc6ek4xOixyhu3azEMa/x2I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=A1Xoq90PeeRwX9hIm5TcJ5LTFDFynPcU8MEdY/N/7NzUMm9ajYCMwEPBJnIgkzmS/elWJkeST8W269axDGWkcDrcfNo6e+Jyld/7q9xLSMB6ATkfjY23owOiPvwRVH0zwa0TjzMJ2YJRjzUsc4Pz5mSOHXJjOPjtqvc9Dun5vso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UI6uMU7G; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UI6uMU7G"
Received: from github.com (hubbernetes-node-134ddbc.va3-iad.github.net [10.48.219.16])
	by smtp.github.com (Postfix) with ESMTPA id 91896E0446
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769534782;
	bh=PVTBd8C0m1oX2ag1NMZ0PPQeUBvNIeXNiUNmCgn7wQY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UI6uMU7GRswbCyDwuOIKOuVB5pqosBEvnLk02I0yUx2858hfQTCJsV5r4wKaGVjbL
	 6NijS29b5AozXr/Uz/PAlw5MbfxioMjFgcboXdOzCEg/5QlV0q7bBnfI/o2KtJNuq8
	 2pkky1EfiK5Xr1HfYOtDCbX3FqH93ozt/t+7aOmk=
Date: Tue, 27 Jan 2026 09:26:22 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047695/000000-0ba82d@github.com>
Subject: [bluez/bluez] 0ba82d: doc/qualification: Add PICS and howto for the
 HID ...
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

  Branch: refs/heads/1047695
  Home:   https://github.com/bluez/bluez
  Commit: 0ba82d4512d014286a10de25cdf54ac830fd8f01
      https://github.com/bluez/bluez/commit/0ba82d4512d014286a10de25cdf54=
ac830fd8f01
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/hid-pics.rst
    A doc/qualification/hid-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the HID qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
