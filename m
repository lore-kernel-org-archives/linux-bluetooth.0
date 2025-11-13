Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64335CBBD
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006440; cv=none; b=uH5Mq73M4LvTXOEFPTXl7cuXcVt2zGaFwdAHCgxBAcrbVPfLdw1wDWUvVt5lC3AlWoJ+t3RLdOR1NJdqXdIlvwgEnrObNG5D+HdQQuVXozo6D2vY2cuSZe9UwLd7cqsKTE9SAAMbDS9YD8Xisty5rOWsWOHVdKLdKhh7i4jTiF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006440; c=relaxed/simple;
	bh=eRGnjaNolNLjFBjw1VLo4NTwV0YzRd/2d1XV1h9Sv4I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iQqiMnRt1Xk9ZYRAtfwf57Ewr9Y4b80w1w4ch5bVOxp6+xKC2bcA9HDHL3MBUklHeC+UUILTOESeQGefkKgsMfYe0Zh9F2qnQavY7rnDFSqwx07XdwPL1WQOqGsxDlfhvClm8w7V3YnCimI6nuCtTyRpK/GFZ5d8q76ELQOwlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GmyOgSd5; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GmyOgSd5"
Received: from github.com (hubbernetes-node-88bf5fe.ash1-iad.github.net [10.56.154.28])
	by smtp.github.com (Postfix) with ESMTPA id 8D1E99211AF
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 20:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763006437;
	bh=BLcPNKwYdOyZ9gRXoZ7HQ3qZ3M8kYDZdjK71iUsX61A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GmyOgSd58hvGp2ap/DNdq+Zf2X3BcODSFhXu+npvA3vK4434XcY92ke3AYQLQ/obc
	 oTbzM+qk3h1ttcwuZee+w0+6BhL8Phzug2eqH+7QJ/lw6Bk2t/dalMr6zmk5n4QQtA
	 pjOBi99rAOxfhjEzlAmLv7CpXUphzOxIYvZfNivA=
Date: Wed, 12 Nov 2025 20:00:37 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021957/f1c880-000000@github.com>
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

  Branch: refs/heads/1021957
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
