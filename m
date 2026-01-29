Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BDE33123C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706366; cv=none; b=D5Xrhou/h3Zg1qn8WEOenOSbY3mtFQbz4Cfw/YQYgF8WbHTPgaRBzU96PPyXTYNZbtfQ7SqmLDHCG5rTH4QozYRm9wkOzKQXZZa57UXlaoGs/gHwvDkYBLcNAgL9AiqFPS08A1ZqI/8wADPqj/6FxzbyiYLng9BvacVjgxfumgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706366; c=relaxed/simple;
	bh=a7WXVANtV2qoKZhSSXb42fYUz8BUfYp8SrZJGyDEeaY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=B2WEi35w8cE8OtMff2Yu9Ykjb6kpxMlHI9jga5AW2lIClxxfb2WlowzqOcWv7IP8BAAQ1LkKIg0zbThYNLm5r5JRLAjaWCPjZ/AIh3TXa9XyHi90C9Ug66O7eAxr0HxG4hnS7NEkHl0048SIWUhOywApWX2f/0qnHdWTLwJjn9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AgoHrNxP; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AgoHrNxP"
Received: from github.com (hubbernetes-node-9a41894.ash1-iad.github.net [10.56.182.41])
	by smtp.github.com (Postfix) with ESMTPA id E55FA14136D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 09:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769706364;
	bh=6TFBaglEkxkIpefObily5HwIJWJPWQ0lzpMYnZdPJxg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AgoHrNxP/xcozfAbA2qXJxqKg3ehPy3RLDc5jtRy5DD/q04ty4oBsC2GIM0nLiMab
	 ZZceDeZ4eT5gvyxHzwKIgHvhpiP7JNrhjK7usmLbAMVnFsVUOOvHmMmPwa3ndGWXWs
	 noW9g8C5xKPZGrGtjZ6sY6YTfGk1Zxy5glR0qKSI=
Date: Thu, 29 Jan 2026 09:06:04 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047987/0d2a4a-000000@github.com>
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

  Branch: refs/heads/1047987
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
