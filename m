Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7D329C7F
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459948; cv=none; b=oq/1r2WV2LyVJsfg58XVyjZvcpz5ib6mlfOaLBo6FO+LAKbwqe1FOXvwD8gGw0jiuXDihwexmk8ehArX7FQWlPLDP/0Z3hPj0KygIyJHae/FHn2WkbCRAUFtTOmmRjC0lQBBIN0IW17arRQV5HZEM1Ddnfpa9LdUSGS91q7zTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459948; c=relaxed/simple;
	bh=kxqSNVG4SmMAY2Yb4ZmQnLhUtPIzQ3Gl+qr1gEZN1Lk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tMdJ+qOljrTcHlsXwY6fwzhHVHfCLvdewyzhExNeXLovrbUQJJtOO4mXMCtdO3ySU5RhdQ45YWHyHnIsYHx17vtgdwVXVAB37Hj5UETATvJnTw+mw5OZ5V7bk3Zseoj+2yuVIgi1J0SB+zbO70fkZYysFndIufb/podqw8yqBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eHE7GKOr; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eHE7GKOr"
Received: from github.com (hubbernetes-node-74b4c53.ash1-iad.github.net [10.56.200.83])
	by smtp.github.com (Postfix) with ESMTPA id 3EDC1141342
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763459946;
	bh=xflrzmbUn4Cuy50jFD7twSnqUcZYGsL8XUhQEfScDCk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eHE7GKOrWvTJjyzCORUSpNaelmKSYlzi0wuoxBkG0KKXcVGflZlmfFEcTECyYpbH/
	 06KURdwDazceD2W5vgnbZ+R70wUZrxuIFwxNg8nh+YWQa+DnF+Lvj5iYiRgs7xukF3
	 sYbxoIELISm1XvyawRSSMpvU1559OhTDZ37iFmyM=
Date: Tue, 18 Nov 2025 01:59:06 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1022762/689cd4-000000@github.com>
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

  Branch: refs/heads/1022762
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
