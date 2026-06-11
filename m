Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38C36A365
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175670; cv=none; b=CURSKpUwdLvkOC8I28r/mFbRu8B5yZYyld4AY50A9KygShjSMMMPcle0Hn/RWXd8ptytL2D7rO7fUDg2zIcisyZzlCXK3l1drMgWH5R00knGbDGThQZmQS4jneufH9UVR4v6bJxJMTEhWRZSUapaxb7r85HGsWq5UcBF7nrjXYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175670; c=relaxed/simple;
	bh=pBVUH1ahdDe+qUKd5tWnMkwh9SQ4KTb8Sv+cvgxLxgE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kESI2GOnq+338+JcQ/J8Qjq5FCnxbxvpfQj6ZvrKail014lFlvlxds+QIvkg3Zde8ys5OlgskkZDXjRm4tuWYfMLqAcQRivsyrTZnqd6sAH2TPzOAA3algwIhqPkAo+QzoxhpgLlaZ03W9lq8lhTWWLoRQgq0p1zrvDydVxfhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Vx/LkgOk; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Vx/LkgOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781175669;
	bh=leBr4c+KGBvs+jxjYCY2I69bTNuv+vhM4N53s66yB/k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Vx/LkgOk/vGNXUmUB9buy/PgoUTyQAxPgOOBHUSHOUBLfYpc1dHCTrPgMRcZxOzuj
	 w2WEApFAeNNXF8NJJXgRnaV21oA3Sb5qD4soJzDXwQBKcCnzQBFX573lDhGeOyGVPF
	 irnAinupod+iyBjVOgPWXhbODbirmr127KSXK8wY=
Received: from github.com (hubbernetes-node-81d50e5.va3-iad.github.net [10.48.175.26])
	by smtp.github.com (Postfix) with ESMTPA id 17BA6800867
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 04:01:09 -0700 (PDT)
Date: Thu, 11 Jun 2026 04:01:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1093445/c915f8-000000@github.com>
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

  Branch: refs/heads/1093445
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
