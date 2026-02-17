Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A729339866
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356909; cv=none; b=ETwjZ7r4hPj5AKRaxeKZnBYcgI/zXyQp+qWVbJPS9t3xeDUFqWl6iUC9jowoRQI5on3ei6Zo1iUfxWM6dQbw+wfBXI9e5yfyV6bqE6ElaU3rXxy6wi7PPNuL02xdi1qglpup2itd2GwuRyiH+qGBqNWQHRelzr87F6szC16EImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356909; c=relaxed/simple;
	bh=/TCWAKAvBgYHSLhtkH3EqiLn5pqYd2Vc0fms73FpvG0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZJDIBJbZNCUNEyKXnmkwGKFrzxGRRgZ9bCwyyMjwlt5WXFmRzoBEVI2ZrUv+RZNNpxfUVYnF/K/VNj3kHBGRlLBscUg8yiY5GcFhvRT7cUnsnZFl/wH279ZPvdpOZRrpu8F2r48P+ai5qW1RLJH+IRe/fsyek8EdBHfz9oEa+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h6nHqFdh; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h6nHqFdh"
Received: from github.com (hubbernetes-node-fc37bb1.ash1-iad.github.net [10.56.147.23])
	by smtp.github.com (Postfix) with ESMTPA id 9A4DC60133F
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 11:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771356907;
	bh=m+gmGvALvlDkA0mkrU5pRStQf+F+QD/23akqwByMsl8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h6nHqFdhz/FJjLVhHgHJyAY4IxDrtDsrXNGi8uKeUcBOTavRHSunOo7PiCc1kbs68
	 wEfg6+aFt1De/eef8j5d+LYE1bD0PmOttp8CX5nbclU40hQGTEVt96z1ZNWxtDBjbQ
	 /m/c1R4xcG9MXeDkQc3M4tYxQrVUUXOER0P+xLxQ=
Date: Tue, 17 Feb 2026 11:35:07 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1051861/5b1c5b-000000@github.com>
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

  Branch: refs/heads/1051861
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
