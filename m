Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3A15530C
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517630; cv=none; b=KUOm4SQjxdXZgbnP/GTUQ9PhjYogkmfqmNOCr+UxNVEczauFlkwPHmQIGhC7Csj905d3+BTPHbNQRemfbos38P0wr4XsM7w3ouW/5g6eHLyxNBBeCrgOQXp9daGWhSKOHJL+TEbGNOM8CYewDiPzp2ccQwpxBDAXkGMvDxJQT6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517630; c=relaxed/simple;
	bh=SYL0b0eX0JdYSkm+iDXFIwxe3jXc7XO9lpCzc0NHCNA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WcAJQCWOKq42To2d33mMA3NZ/vuV3R+aVGdz3MmOsnoc4oN+gwuOMKksxbQJLan7crV8D+e7PpOd6/j7SRWaYvKV2apeNDXLYnEfjgyNc74A0I+qp7skJ8RexOjg1sTK6pnM5MuwM+/NtoyKCMal/ftXPJpxG0xv7+o0TU0srZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=deh3tr1x; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="deh3tr1x"
Received: from github.com (hubbernetes-node-2c38f8d.ash1-iad.github.net [10.56.201.52])
	by smtp.github.com (Postfix) with ESMTPA id 99BC56002D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 14:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768517628;
	bh=ciC5MvTQv5XUTigmu/HxlSjKcEAiZbcGllOqMMcSSeU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=deh3tr1xfkcP7f9h7n4AUZascRb8CsT6VLblWkC4w295Y9tgEp/P2rzjeFjECt8sA
	 bO9nJzyOrE5gUrmSyderJEmV0/Wdrj7FaZwYEUeXdmEUQDVQx/kVFaCtt8YF6WCB75
	 QMUoeUZUJwsBWan1U4vIE8p4YqEQucWkWzamk1Tw=
Date: Thu, 15 Jan 2026 14:53:48 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1043005/e1a4fa-000000@github.com>
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

  Branch: refs/heads/1043005
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
