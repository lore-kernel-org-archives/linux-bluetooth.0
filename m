Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF43168E8
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706365; cv=none; b=LtDCVhg6IeIVjyoooMG/fVzf20ofM2Da/tNZGiiLDZuXss8svMel8t8ei4TuLkYM6aTx0p4VTYsnDKkAZi1xXVOGGhZatAEtx2FVdlgGudGn8bYa/kK2aPhZOBO9YO16waGd5J3s5BQrE0+NAFaZ8z9D7x7EsF42vNbmfKp8iR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706365; c=relaxed/simple;
	bh=KpSKaKke/9IlLtDFxFykVjZ+BzxCnSVPaluJk2CGRkg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gOXtdjx9gg2TSISlfXpetMNFJ686RlouGeah428gBrUCAnfTcTgQJwmWLnRJflpLQn8YD98sn+3Upw5doiAyok/ibkwC1N7rTv0ZXbjj87CoCxW/O/2PAlIzJr/HHFUAS/ehlHtWVjxfCqrpMUQtAG2S2ViWUZJk5045hNULRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FZb9rXUZ; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FZb9rXUZ"
Received: from github.com (hubbernetes-node-9ef5c2d.ash1-iad.github.net [10.56.207.67])
	by smtp.github.com (Postfix) with ESMTPA id 9B012141387
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 09:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769706363;
	bh=eJh3/Dkf/LqQSox8mxtgaG0A9u2drUPf+ySDkZl9G3Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FZb9rXUZQQC9R8p5EoeF9iXcJ1nwRuChMr+P+x6sPqRTwESZoarRryEDrR76g05f2
	 /Mj1WoEkhGLwyKa8iReDor1AL3UClY6aN3vcgzsUEPCDangPei8BGFHTmgvt76Pfxn
	 NOjg1U6suur9sPPF9pjGCaW2/KH9z9CzTZurbWJI=
Date: Thu, 29 Jan 2026 09:06:03 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1048044/615102-000000@github.com>
Subject: [bluez/bluez]
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1048044
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
