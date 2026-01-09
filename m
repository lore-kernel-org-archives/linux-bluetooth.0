Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D0341674
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998953; cv=none; b=W6GVviDPgO5ZCDdpiTzqug0dJysYEYwY1E7MdRhTuDYWpLaT1CsuQUvCKL4KSa5fUd0uTHxInuDxyOHBg5BZ4F2tawBmcbGTmTq1towunRlw+2OHBvS4pMJxKobm6rWeQkleLWMFwEtS9WIcPLzz7f9s6uNc9fakiSfEBS5i1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998953; c=relaxed/simple;
	bh=RtdHHPjnIoEdsiwU5aX29JXpwZ5RRRsViFAx5jGCcYY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UF/B8oCj2XPPE452j8+H0yPUmj609ZGIUzeajE32m6aY1gaIQFqcfNbs7TlNkqwy0wE8y90O9WWtMGS327mycbFGhYXBy7JdHwYtOHywDDlJGUEcP/sAXSfZ8HodxcQkT7TkbNNjsihJtSf82V5LB3fCuufjpDRL76Njt+D+d+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Fv9qEtV8; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Fv9qEtV8"
Received: from github.com (hubbernetes-node-1fba64e.ac4-iad.github.net [10.52.220.39])
	by smtp.github.com (Postfix) with ESMTPA id 6D19C205C7
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 14:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767998951;
	bh=V50dLYFMiIi7+sNPrpedBmabgZjhDMa/cO8iF0AQX4c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Fv9qEtV8GUekSyerd3bSffQUTqlAhLa+o8HiyLzWtj04vnU/AUI+WW6WK6D3GGeKr
	 m9+w7MZaDIf7qbmgZjPvFhYfd/b2aaAieE7WeHTZw6UubIq+h8xCGsTlPnbsJX8pkJ
	 UZq22PPDXeM47hoCnKww9x6FbXKxQgiXJaPV/1rI=
Date: Fri, 09 Jan 2026 14:49:11 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1040617/3361c4-000000@github.com>
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

  Branch: refs/heads/1040617
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
