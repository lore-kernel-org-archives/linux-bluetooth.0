Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE10518137
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066116; cv=none; b=LrpE9x7P2eqex9mSMB2ZqQ7l18ByMkUFX/o8sYzcwhekNp5FhFQYDGN/7iDRpCzlRF6ODzs9zGLfI4ktzMpQ/rUz34eS0c91IFu9o7aPce9SL3xFI0t5cjcFhubESogw2KXMeqmiG2g+DJTLK4e6n2rw7ms8eghku1MT9+ujVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066116; c=relaxed/simple;
	bh=97lNoWjjceEVOKNlGwdKOWlUpuLbKe2ENFnMd4eLGao=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XHdCLS1mfbDcfl3I9MdxRjCGUennKrH2E0QXkPqMv67/MxzyWR2pZbE+UTcZEkkqov1JEqcnrKQ8tqDtbkYutKiJGRiVuNCf2O14XgkvRt3tIjgOO49QsIZ9C/rgBMi2EnU+o3dG3be3mDnG8BpJhU2p3RwfjFsauEisU51y4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=iQvna94o; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="iQvna94o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1792066114;
	bh=f9ZDYCCCyWhnnaZjdcWkZbACXAZUNqmSIwHGr8/8ALU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iQvna94oFQDr0nY9xk1SItB18ZujQWYkzKpi5b0QwSN9ukEE3GsdXRqwQ1a8RMMjv
	 iL9nGpdm2RIyK6+5Xz2LR6JfOL3iILo2Bmxjo10e44OmFRSbJJG5+DqXxxrs7/kGA+
	 n3PnEY3NERBGJgeOiTF23egy7eGmI8+fQhqFEpLYXJtvxb3I5xse0DdpA+3CE8LRa0
	 MttsCGA6zr/ON/cQf6yCZvJjNYfzctgLzELDcQ9Y1jacgBhQjEDLeCib1MGgC6mQNF
	 wmMOyimV7GueCsQAlj0Rv1I0cxrZYiCYEWdRhzN1Y6IG/0IlzkuSALiB/U79Ex6jDU
	 0BVK881HYZslA==
Received: from github.com (hubbernetes-node-4165f34.ac4-iad.github.net [10.52.81.30])
	by smtp.github.com (Postfix) with ESMTPA id 4534574085D
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:08:34 -0700 (PDT)
Date: Thu, 15 Oct 2026 05:08:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1185477/362660-000000@github.com>
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

  Branch: refs/heads/1185477
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
