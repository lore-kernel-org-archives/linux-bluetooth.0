Received: from mail0.khirnov.net (red.khirnov.net [176.97.15.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7B143879
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.97.15.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626836; cv=none; b=WlKz4eDscd8vKJTeKBRgCqoAi5rjyvlsEbM/ULiZRYNlMBVbPxAyNe3CzaeFL3qzdhFUqWeXGJuB2Bh9KbTBOum9O2G0MMGDJ4G7jAyXlbQbOxdQa7bhA6iwiJ8W5im0ulMGH9NPdKFyp+Etycwo2regZ6+ld/zZtsCUbYMcNCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626836; c=relaxed/simple;
	bh=p21MIadoQT7q2TQoR1Z0N9/DF1W98X6YsJBuIH5OHXE=;
	h=Content-Type:From:To:Subject:Date:Message-ID:MIME-Version; b=Mm3Gx7cEhWooMfryWJNSZYOOXPVLvQ+jiRU3WwKZPGbLVZ869J7ojFWGaBzDgRqfCSvGNtt/IhzuaDHSoHkPzFtto42ctZQ6NKN4802l0CKw2XuorSJ70qissBoT9y0lVy99BkdTCUJ+OLRiaxexBBuyg7GBwV1D3rR7k0CKLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net; spf=pass smtp.mailfrom=khirnov.net; dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b=M/Nhus8w; arc=none smtp.client-ip=176.97.15.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khirnov.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b="M/Nhus8w"
Authentication-Results: mail0.khirnov.net;
	dkim=pass (2048-bit key; unprotected) header.d=khirnov.net header.i=@khirnov.net header.a=rsa-sha256 header.s=mail header.b=M/Nhus8w;
	dkim-atps=neutral
Received: from localhost (localhost [IPv6:::1])
	by mail0.khirnov.net (Postfix) with ESMTP id C47A1240DB7
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 11:06:58 +0200 (CEST)
Received: from mail0.khirnov.net ([IPv6:::1])
 by localhost (mail0.khirnov.net [IPv6:::1]) (amavis, port 10024) with ESMTP
 id Vgbh-LdadkKD for <linux-bluetooth@vger.kernel.org>;
 Wed, 14 Aug 2024 11:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=khirnov.net; s=mail;
	t=1723626417; bh=p21MIadoQT7q2TQoR1Z0N9/DF1W98X6YsJBuIH5OHXE=;
	h=From:To:Subject:Date:From;
	b=M/Nhus8wBIQ16etijai1unx0E5x4cE5ybeE5kW4De5v/tT8A6f4qVgDGQv6bNEay5
	 1fSANk5p84zskDbx16tcZAAPl/Qxkyfrz4QZec66fjo2in2arF3E0sObSAnVmHs7RZ
	 P9e1Jzqn+v/cCpbcKM7Ko2JO9lyUYPFhqb8QzdTL1iW85jGe6d5nijO7Dp9H1Usxc1
	 utFQdQjEHPL8JSWH8gWm3Vgv+dU/7FpmJ3BIhs3P56WckByf0mKYp/vEX0URsiD6j6
	 jM028SKGRRs1hsWREMO6ekgNMHdk0QCNRhU3450SVyTQoSc4AGLOeteYZ+urxSJH3Q
	 wbEUBovSyyGCw==
Received: from lain.khirnov.net (lain.khirnov.net [IPv6:2001:67c:1138:4306::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "lain.khirnov.net", Issuer "smtp.khirnov.net SMTP CA" (verified OK))
	by mail0.khirnov.net (Postfix) with ESMTPS id E4ACC240695
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 11:06:57 +0200 (CEST)
Received: by lain.khirnov.net (Postfix, from userid 1000)
	id B6FE71601B9; Wed, 14 Aug 2024 11:06:51 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:  Anton Khirnov <anton@khirnov.net>
To:  linux-bluetooth@vger.kernel.org
Subject:  monitoring advertisements from specific device(s)
Date: Wed, 14 Aug 2024 11:06:51 +0200
Message-ID: <172362641171.1463.1558884635182654862@lain.khirnov.net>
User-Agent: alot/0.8.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,
I'm developing a program that needs to monitor advertisements from
a known LE device (or several) and take action based on their contents.
From looking at the kernel code, there seem to be two relevant ways to
initiate passive scanning:
1) performing MGMT_OP_ADD_DEVICE with HCI_AUTO_CONN_REPORT;
2) using an advertisement monitor.

However, it seems that 1) always enables the duplicates filter, so only
one advertisement for a given device is ever reported; meanwhile 2) can
(after my recent patch) report all the advertisements, but disables
device filtering - so userspace receives reports from all devices, not
just those I care about, which seems inefficient.

My question then is this - should my use case be implemented by
a) extending HCI_AUTO_CONN_REPORT processing code to allow disabling the
   duplicates filter on request;
b) extending the advertisement monitor interface to allow monitoring
   only specific devices;
c) something else?

Cheers,
-- 
Anton Khirnov
