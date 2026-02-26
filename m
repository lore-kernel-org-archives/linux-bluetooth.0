Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E26428828
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137268; cv=none; b=XavORkMC7Z8H9qRYuPvom6curke//YY3lm4IB4eAbvUgEV6/2xCuEeo2ThqIMNysc8+GrHu1puC3Q1M6DXH/Wo2O4Fo1dRb8cUjkBYKY/ahvJCW5UlwRjfr6GoWSCD7Xh3wv6CyKrgBuy9LHC7XCVUhe1/IiLo0OvwVctu6b2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137268; c=relaxed/simple;
	bh=xRtJt0f6m38Flqut26v7rEJ8KqHDNYvNr4siFaACC/E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iTT4ubynnIhYQax/lsMqod2d9JPNL2tBIrx1mCr4WszGQlUkJz+aMy1YPI1RBZy92m1gf0E/cGWI0uZa0EvzSc+i5TobF3b1KsIbJU5t3+PQfQnT064zo3FRVOD5F5Ccz0BWDD0ab9Kz7hlJM2OPmvXGZwdlFcCd7a8oYgJe5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FcOin9G2; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FcOin9G2"
Received: from github.com (hubbernetes-node-ed29395.ash1-iad.github.net [10.56.183.32])
	by smtp.github.com (Postfix) with ESMTPA id 666D01404F8
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 12:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772137266;
	bh=ajOyNvKMcrbEhPukPrlI36Qx1/jIVZKe+Qtg/7ZOYCQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FcOin9G2JLytVXfZJKGW1wkQq0XWbKHmYQ72d1iXTIVpik4Xk1p0q/Duu/Zv0JGtF
	 DaECZ1VddjcT6faUAgCK8jLSXS2/HTbRi8RkkUYzlmc6erDZP+pLqhU7wb+aEi/tX3
	 PBnopEI6vaYggMvuv+8KmtOKJVopxUTKdj40lvIo=
Date: Thu, 26 Feb 2026 12:21:06 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1056469/928fa9-000000@github.com>
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

  Branch: refs/heads/1056469
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
