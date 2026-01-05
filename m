Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93432FA34
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615827; cv=none; b=N6PIe/3UW8ddBpXPoYJ1SkdnBa40FLAXPI8yx5NSDNqOgTQYKMN2rOTrCZ5yUWrL1Qx0XKltnVyUlM7Vgdy6J0+jKXPIeuGSkiXpsR0OISsZHaD3uFAQLzPqtHfhp+lQMwe118oIh6hOgC9Rs5FNQxz5MDvtJ9Shweemi4K6nnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615827; c=relaxed/simple;
	bh=yp6t0KEyiWwSkdw2IQG3bhwB+EOrlNN92XU2Jjvfi5g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hwdC4QhU2iVlSxw0f4vZ5nlhwa8cu9diOS3e4txhhWODobFpOCsT5YPZ3YaBtrwnrTcf7y4VPOPq4gWn0Att/ux4pdlV4X9GFusmS1aCj0/Mts4MUbqWZMtJrEQAnk1PhcKWE6qFfREyURNZzR7dm1GUUEQvJLIP+xqFvV9q9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YBE8re3+; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YBE8re3+"
Received: from github.com (hubbernetes-node-e390919.ac4-iad.github.net [10.52.147.32])
	by smtp.github.com (Postfix) with ESMTPA id DDF7B640B6B
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 04:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767615824;
	bh=rgVf0W+pHvpdADawEdVlc+7zOqDMifiFMeVZsDxncqY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YBE8re3+MwWJjIJJDEAuTkbT4ENqu1q6heeOMPdhmBsbuEJTx4+Ym3SdQxL7Qe3Ec
	 mqAOpn/8HmfxSkQaybn6Z+rEaKA6UsMzJqV+AwH57VKyvJMVbpNFwzgW9EpBEef76a
	 9kUpZBjmMaho4ILXO44J45gFZEJ8tDpT7yDOoc60=
Date: Mon, 05 Jan 2026 04:23:44 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031057/a22a38-000000@github.com>
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

  Branch: refs/heads/1031057
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
