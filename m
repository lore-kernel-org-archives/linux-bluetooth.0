Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B82C029D
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776724426; cv=none; b=BygtkZqCZZ1i/OyQnJ/T0t3vHH5xA0piqRUZGcH99D7M9J4gUn/3hXA6i1FrmPxyde5/3kb+/odSN6JXHK6Eil21sI03qAuBR/pMLsvewQ1T0PpX2JVAGyUsv8avgwHguGgZZAMjMVlOF2c6ADUb1v584QMOWC+PStLMamqtb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776724426; c=relaxed/simple;
	bh=ePN/ZtgJ/dLozAXefJxIyXl1AiWrAYSqotawWe8FHzA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WQhHwOHwKz5yaiG2h6noOsLu6CBdV3eO6SksCYFuSOwhqbl0kldi6JHC+YRwmDjWZcZ+8c6VvqhTROgzOF1FGLGZnLhL8Uz6NXUUO1dWURzvTe2eEuA8tAuBCH6g50+sT6TpCkNkBXgaMui/wCKzA6/jLrsxb8iyy5BEany7vHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LS9DKTW9; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LS9DKTW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776724424;
	bh=1ejoxiNvPsqMWshCj2ka20qIuTRxXDnb77X6paDxqTE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LS9DKTW9iqhlR82KksEsUiufWCcaKaiKs6QetegTNnFSGj9TqR7SOeM7SY0xlj5pw
	 izKHn4IbKFAXuy/vHWerz5b4NZI0+3DwsZhfpAABbxrLJaqzfSSF0RktrVQJIGYmyh
	 mzuzA5zQOyCiSz0wOOmoJeRKTUbFie9106tl7xMc=
Received: from github.com (hubbernetes-node-477bcd7.ac4-iad.github.net [10.52.84.32])
	by smtp.github.com (Postfix) with ESMTPA id 2A74B321104
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 15:33:44 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:33:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082170/3573e0-000000@github.com>
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

  Branch: refs/heads/1082170
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
