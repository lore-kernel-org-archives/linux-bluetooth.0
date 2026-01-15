Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01BA34D90F
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488666; cv=none; b=tfJK+bGa+sXyBjy+2Pvd28S9y7RGNbahH2biJXfw020BXvR3Y7QIqGoLWmRMnbSXhrDyKbagK983/00/84Tz0JwO3w5VR143vbvurZD0TPxSZ029A+uPNxgCiF0ZcBC20CxGzzNAP/WjJUg3eLwQ3DL+sLh+GT4Ug4WzJuf5wqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488666; c=relaxed/simple;
	bh=xSa/s3OJmnzkJ3lr9QiC8Mebv5Cz+IQxKPFn/mR1ipE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eRAcRvkR6N1WMe6heYKeoMv5cnUkJxKjeKxHE8hIW7lUNltqEoXlJmYlUuXpSfC+NHJi97v4hEbBE+HBuI7Kg1/fM/bXj4IIHfrp45rcS8B3e1KGJbr6Wla7KQrfnfMVQcGtC9hogY1tko1kqDg2C4sGeMSkrwl6Gep6EaE4qxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iG+cODnv; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iG+cODnv"
Received: from github.com (hubbernetes-node-04a2db5.va3-iad.github.net [10.48.210.47])
	by smtp.github.com (Postfix) with ESMTPA id C5813E0A70
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 06:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768488664;
	bh=WZQuKv1R0SWu/vJQc4Lr6QHuZIMJmx4ggtDTMgaGWHk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iG+cODnvi0L3AKB6B1sICz1m6/kDOeI885+vynh1oPVc9t71YraIcT1uz4r1gCAJc
	 yV9I+W5+6zhufhXejRzOXGhZ8Ul6yyUvDnDnRKfm2mzz//Sv7ItKE5GE9cuPVZj3L1
	 Tyo9qlwhR/EhAY4orXS+MwoqqM6lONFEd1MXqBQs=
Date: Thu, 15 Jan 2026 06:51:04 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042858/000000-2af9c7@github.com>
Subject: [bluez/bluez] 2af9c7: tools/btpclient: Fix name advertising
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

  Branch: refs/heads/1042858
  Home:   https://github.com/bluez/bluez
  Commit: 2af9c774dad1702783a811ac7a7aaef50e4c8bff
      https://github.com/bluez/bluez/commit/2af9c774dad1702783a811ac7a7aa=
ef50e4c8bff
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M tools/btpclient.c

  Log Message:
  -----------
  tools/btpclient: Fix name advertising

This allows to pass GAP/BROB/BCST/BV-03-C and GAP/BROB/OBSV/BV-06-C
tests with auto-pts.

Those tests request privacy to be on to share IRK.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
