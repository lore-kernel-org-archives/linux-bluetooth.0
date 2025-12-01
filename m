Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DDDDF72
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764613858; cv=none; b=kEjCZikKsoGcju17boZnTmLdICKQKa0dgi7Iye8g5aSniKR+c1JDsVgp/ICNIJifyXgjhiCYFjbnLyHokQ1j9Axv7V4oTChuN2e0ju8WuhoQM28mVEpZ5gxYd+GbWJJIS18AEGPM/Fyh4KBqMxs0+pJGNY2nsN0zAYEycbd47sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764613858; c=relaxed/simple;
	bh=sYnbTBkwa2nC/BoPFECkg4aknmHwM+NjHVnhh5l3BYA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=D86U+gKXgz7KaA8lmfAXTNXGJ81IAwmyqOLaQs9u6oaaqyOHoM6U/5NbfKqhCmWwCIHStCQ5IfNPRV9+DI3UXZa4gtnpVZedZAlXDR8/Odb8cXUY+4PHem0wLjDU7FnJQ00QnM0/kruIxzzfdIsi+oUIrOo0MdxsYslpwC7SDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jgPc4sww; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jgPc4sww"
Received: from github.com (hubbernetes-node-70edec2.ash1-iad.github.net [10.56.226.82])
	by smtp.github.com (Postfix) with ESMTPA id 625D1140B87
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764613856;
	bh=WvakoecbnY38nbp+jNkvaiatsKskzRD+Eh6GDbq5V9w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jgPc4swwhAhENKeKDq5HIiXMUgYUPS8oojxLalKHuw8aGc4qBUrg7LGmQm+LFvjWn
	 XRT2qSU3/QYjGY1FYV04CcCTG8OZPflRujKfLxufYQzX8A9yzjDfBft6cVbKEQM+rt
	 rLOfdNdurv6NxsW3jaq4nZJhzDc8bF394rs009cI=
Date: Mon, 01 Dec 2025 10:30:56 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1029386/000000-50b506@github.com>
Subject: [bluez/bluez] 50b506: client/player: Print
 MediaEndpoint.SupportedFeatures
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

  Branch: refs/heads/1029386
  Home:   https://github.com/bluez/bluez
  Commit: 50b506e8a7e9d5ac938579be5131315fd29e3213
      https://github.com/bluez/bluez/commit/50b506e8a7e9d5ac938579be5131315fd29e3213
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-01 (Mon, 01 Dec 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Print MediaEndpoint.SupportedFeatures

This makes command endpoint.show print the MediaEndpoint interface
property SupportedFeatures.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
