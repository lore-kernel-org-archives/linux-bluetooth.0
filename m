Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365ED34A306
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215941; cv=none; b=gOI0RiSVFRc078LlxKkq0cunRhF/tkyoM0fEnGhmuzvt11RjjAGZioJa8fcjSyrp4A1L1geKdq6CxNgqdnJ5DqZW8RHJ6ULJtZPDC6YJF1ZPkh2unG2Kmf5NjvtcamYhmdA8YC+L4UqfK3aZcOpF3CVVnh6lQxkJ2BkSpc92eVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215941; c=relaxed/simple;
	bh=ux9EJv+xj9sIOj3Eor6voY8HYWeGv9hEu/gwOunQ3jg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nl3FrP/UhJ0XMH5p+WjSnOSLH2wdQv+n82peEhL/yC+BNhqHJGskUvQAQNDD7baP5xQJKXzd5DaVP500Y3liLqsfuQZDEcN1DAyFgivBSsxnunK865bAL+BZkVujyotJPBeZr/3x9zPKTFxhoWaX6ErWxmZimd3V4NTW0jY6yvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=F9+U3SKS; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="F9+U3SKS"
Received: from github.com (hubbernetes-node-f60636d.va3-iad.github.net [10.48.173.24])
	by smtp.github.com (Postfix) with ESMTPA id 5FD01E1446
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756215939;
	bh=6wy9/Cy2dkdn5NFNwHGI75RbdY9tGm4N0GN01WbMtb8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=F9+U3SKSmOpdZxc77a21yauVWLXbKY0L20B1y+zxciFxCqaVh4r0vu1kpcH6EJdPX
	 TMfvu02gaqilqb0XuM6UVybTZXbMbH/aIRqSaR5QrSZAR2kKQBllUgknFJY0qcxL41
	 +/oteAButrKhqN0StdUNUnB1qEF415E7c9mF8M3w=
Date: Tue, 26 Aug 2025 06:45:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/995585/650f73-000000@github.com>
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

  Branch: refs/heads/995585
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
