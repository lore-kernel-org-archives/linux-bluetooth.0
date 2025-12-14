Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30859258EC3
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Dec 2025 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765673691; cv=none; b=VYmIzOo/UhnDGnXFtGbpgmWFqRTO4TiAnv3d6B6Otsc0E5gIE0szwYmZgfBDz0bXIP+Rnjvdq8jZobtInMymGzSjn2169/oWcS8HcuDysS/mbJ2Z+wpaddrL2ycm5kZBZHvBkRstCVjSwzJk9olpkcBiVXCcJq0KlvU124LgJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765673691; c=relaxed/simple;
	bh=O3gbyV6zCP775Qjc8SkoK+bB74od96ovYczUD1KLOFo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jEdt7fkfwa9KEy1PST8/F/u7pniv/vCA3I68Sv62VlhT9WXQMo1N6K4deeaYUbVQOulgD369afZTO2W/QEpWNNQ/1vP1r4zJwbfkEUVZPuyRz3M7wV02lsVzmdyP3FBP76tMHP0gU1p27y6AzoKidj+eYBPWjemMadH+4Qb43p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WlLkDSC3; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WlLkDSC3"
Received: from github.com (hubbernetes-node-61be00e.ac4-iad.github.net [10.52.210.17])
	by smtp.github.com (Postfix) with ESMTPA id 4D57B6407A2
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Dec 2025 16:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765673689;
	bh=stkOCTDQqCAFb01ev8a4xCE+y9hn/tOPn54dKnRzDfg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WlLkDSC3c0o5fNLMvL0FQFJ1U8izFpH3kBXLdKhv/I6bP33ISCkXgmxkCif8GSy1E
	 r8+zQW+CmMfrtVvHViamccyH4wxbVkGuOdGjWurh5w4fJbu/Gv/oVFLad/B2fxlp0/
	 lq9EthPe8301/5i0rDMRKraj0kJQcF5ebJTOrGL0=
Date: Sat, 13 Dec 2025 16:54:49 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023205/f3a24c-000000@github.com>
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

  Branch: refs/heads/1023205
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
