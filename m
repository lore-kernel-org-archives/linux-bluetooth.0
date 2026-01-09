Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994D2E413
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998957; cv=none; b=a8AL2U3Q6O5KuZ3t1LAlo1lPvl3TI0Ds3MO8Qa+T8uonBSf3lzRVSxRC+pF0+PofTLn1cTgi254RoT5ooz4SihZglVGGLZgLlgZZjopjoCxH0DN+4ytTnzh1UfHoxWpAsWVuj9xuy9l60pKK4bYsfiodcjodgyJTpwE2APvc8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998957; c=relaxed/simple;
	bh=zRz5T5BMlVIRBc5FbKVqv+/vouPK6uym09xU+cFjc2U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=e6SqrU5XzV7qqeSokw5/KV9r0TtPesB0ZkNea/3/Brd6RyHbcz8d1dWN4+pRROjgsmyGrkzUFUHnb13FTjHI+x1MGM70J7W29daVUpeJzAHdZVaLcYgOPgSkmo6HrD7HQ6FCNwp+jYG8b6sUVQBANLByddV0Xjivdmdvq0wB1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a9ARiUA6; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a9ARiUA6"
Received: from github.com (hubbernetes-node-025607c.ash1-iad.github.net [10.56.15.64])
	by smtp.github.com (Postfix) with ESMTPA id 0EBA2921238
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 14:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767998955;
	bh=peLMikpMuds0ai2KaQv4mQWdl5c3HYjXTyzo4GkkW98=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a9ARiUA6ZHx3Sr4M8LsMTtR8wKd/rOONUDfrfyWsAs8ZrtvFfO8P9V4wfjaDCi6ei
	 3LdA7/VZpaHjBmsMkEPqs/W6BLnckk+aLbYwOec9T7lZuH+fOsiBlWj6SAo6gRl9Iz
	 GS/+RAm2BhpIyf4E8Fqd+iuLHiK/0i/XIiPy4gZ0=
Date: Fri, 09 Jan 2026 14:49:15 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1039830/a16613-000000@github.com>
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

  Branch: refs/heads/1039830
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
