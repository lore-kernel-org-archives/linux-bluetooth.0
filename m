Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64AA2620DE
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356908; cv=none; b=F7+wz9S6benGYteF/+/PEloOg69Nk24XLgSeOihl21whyulXXMHXrbkkihwUz8G40iIpPKauctmzyfOh742g6kFyWz7QgSyvgmXBCmbTxhUiI+Gp+pIRIDx+dol9MisU4szCtyjfUUPm5PnY5Dgrk4mpMjBB6cAo92L7QtETQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356908; c=relaxed/simple;
	bh=WFOo5mdHmKi5PNrrRCRbu43xmbciDTUX/ZwebCeuylY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CeuMzoSjbwwmMyh57yJMS/AqEZQ4eDuLNh9mSLBZxmcLYmZfAvH/og3pypiQp+U0RlDTJEzJ978N+ZTqO8/jFzNh/tRif2uEt7wQueirIuABnFLJOLXNAs1ut8vzsMX+22hPGlxB5qGn75xsW2viFlO4tZ0mNkovWSQ3MWePUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TyUROy9C; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TyUROy9C"
Received: from github.com (hubbernetes-node-cb7a443.ac4-iad.github.net [10.52.141.21])
	by smtp.github.com (Postfix) with ESMTPA id CB150640C62
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 11:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771356906;
	bh=T4IYVuUKB9eVBgSbeehySB1SFdiaOgu/4kr1Hh+yVpQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TyUROy9Cwe4C4aGaYyYNz1y8DvoPxot2a3HakRmkhr6bnt26Z/2RmeVjbQ22AoLau
	 H9yWbUy29FxE2v4Ktb7/SCk9FhlBtYiB4wzKJwedGfpHQAI6q//JLqHgopYb7aEK+h
	 uJQQNLgFttQLP/iQCyKZN9KLyMLA5545ZMr5K+9Q=
Date: Tue, 17 Feb 2026 11:35:06 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1054909/1bad1c-000000@github.com>
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

  Branch: refs/heads/1054909
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
