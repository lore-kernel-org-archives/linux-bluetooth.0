Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7699190676
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jul 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753606580; cv=none; b=Rv6U3NAGw6rEeiETegb60/rW3ZTlj4m+Y8lXVxC0SIuRG0xIwOSoxB3wCbHWmd4HInqRp2cpRm+GSRqq8svAyDc0myy6kIbh8vrrNpg6+v5B6yLP9LbJ5YtC3TLJmwsB0UGFw1LpMpwA2fIfKLQdIA3zZZ2RHa9isSa9Adz0cDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753606580; c=relaxed/simple;
	bh=dL9a8bxh8LliYqYMZ7uoot17NegUoKpNTEVVY1xQuWc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LM1qC8f7qohpL3ktjDMh9CaILJ/vkdOVurgjsPU7BsG5UGivjZFFi6I+9DIEKXuaaKfK6AqvIS04Z5EdJjs0+T7VCldFF8VB8Ppd9Y1zEmc37MYArwAyQBLKX3ej25EdkbUjxAoEse/fN2PXL2BmUs7C64y5a1QXdi0r74fP60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WxTQ1pvl; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WxTQ1pvl"
Received: from github.com (hubbernetes-node-f291013.va3-iad.github.net [10.48.205.52])
	by smtp.github.com (Postfix) with ESMTPA id EE667E0410
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jul 2025 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753606575;
	bh=FRivkizVSdL9A9XDtv5zmMnx+9vootK0ky/G4vWrhVE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WxTQ1pvlPRmPCcBFWMG63ParhRLk1kVOeZ238Ju4GcarvkAAvJLyYmZqQOBoWo3l2
	 iTy2ZRWaW6S8mE02ml/eA/iVKpoPqJUVbfG+RcdmBFMTVD8OCyXkk0w3QRL05yKr10
	 2O8L6m0vw+oW10b0OEC4wAvyW2F8aL+ckiKf5YxE=
Date: Sun, 27 Jul 2025 01:56:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/976514/e51dfb-000000@github.com>
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

  Branch: refs/heads/976514
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
