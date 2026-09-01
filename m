Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D213B47D6
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788302086; cv=none; b=JhHITVPb9J+4Sjvk86WKunPGg9yHJm3p2mM64r6+jRhHV/orxwkE1TzJy12JSgW22CtaaP14OyytlrC2UoChiTVzgo+zlhvGmzk8srtHxfJU+lTiOPZgUq/cUuQJa0j6n+pWSFZHeUplklq/U1oggsNLzY1oKATvwTajyOlMYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788302086; c=relaxed/simple;
	bh=492wErgIZ27My5Y34cn7sDlRgu3fApEYjazhrN3TzCY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OqwwQk5p24y9TO46ZYh4OHFs/Awtlo73wpKuIOwrrZUNXtENj8JnHiXOwdHe3h/t115cpiTKaaa256cBa6yeyUBdPjnZDiSHsXQ2Kzq2dQUyHUDQBgJ/zCojCovYhqKZ/p+Hsf2hAITRu0/eSS85rMvgVXOJ2VBBEpX87Rc7lHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JsjZ3D0H; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JsjZ3D0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788302082;
	bh=sEvQRHFR0w5NaJv+B+y5HZkEDb4BEptEXCWtLrYVexI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JsjZ3D0Ha84GXgGXyUQI0iTca/Iv6u0i6Lg74lfOLPK0TiXt9rmHsic0C8izqUt0b
	 b/Db9zGBkOYTPRIl43GkRbtB2XFe/ZYUxQWNhzf8holxy/lHREpG41sjHBqD3PYyTj
	 JFRAlPLfAoLtVBYcVUr9efABZcoHPNQs8eqZDu5o=
Received: from github.com (hubbernetes-node-2339bad.ash1-iad.github.net [10.56.226.65])
	by smtp.github.com (Postfix) with ESMTPA id 84214180981
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 15:34:42 -0700 (PDT)
Date: Tue, 01 Sep 2026 15:34:42 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1155668/000000-73ef98@github.com>
Subject: [bluez/bluez] 73ef98: tools/l2cap-tester: test closing sockets with
 ECRE...
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

  Branch: refs/heads/1155668
  Home:   https://github.com/bluez/bluez
  Commit: 73ef98294af840743eb2fd98b6d1a380b4a9b94e
      https://github.com/bluez/bluez/commit/73ef98294af840743eb2fd98b6d1a380b4a9b94e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-01 (Tue, 01 Sep 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-tester: test closing sockets with ECRED defer

Add test that does defer accept with ECRED with 2 SCIDs, and
accepts + closes the first before accepting the second. This triggers
deadlock on some kernel versions.

L2CAP Ext-Flowctl Server - Accept 2 Close 1



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
