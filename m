Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1C3A1D05
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788086667; cv=none; b=ovmGLI7bs8EodXb4tAlNXciGn9roZyNHtPItvjZ/LpkbMsGgyFLme9aQs+uHJKG7IYjauLtt+0sK/O7TNXo+CHzE0U/TtZgCb9PX+I6ZeWdPzZugDjA9k870l9Dd/+B6RyjFDnPzBMYIc7Qr33ABtx3wMgo0lndoK2TcrRozR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788086667; c=relaxed/simple;
	bh=399nQH0D1NWbmHL453CFG8QGHfSHmyu+ZBiNJyqg8/4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lQkz8KRAXpSBHBP510tqT/e1oRG1FW1xeCYnwlfD7RcDiNx2INXfYE6B2O6wiJYVh19mK3lZJXguN/Y24bOxiZCrRLT4ix6KfUGOeaX8e0DWarSNODXO+EZ8xqi6a7RpLHl/qUUmElp99ExtqGfHZXqsU4kC5mmtD4OqDfiaY3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VpayhFgX; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VpayhFgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788086665;
	bh=meRzjs7nMtWpE2HbziRuQx0OXdULP/mNs63aJe5O81A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VpayhFgXcWO3TwKXoIiRzZaKEesiUTULLjtg/n+3iFcP2XiHhMbE64eU+GjJPWi4N
	 JHzKLXaysATew3d8WR5EOFo9DGx6Bdhz63f92rCtIY0zKQgcVdvSIVIprhyki4E7fW
	 Vnftlq2QKQh+wI1HgZ60nwNg2WrCYFJGzLCZAz5w=
Received: from github.com (hubbernetes-node-35aa425.ash1-iad.github.net [10.56.200.81])
	by smtp.github.com (Postfix) with ESMTPA id 9AB3D9208B1
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 03:44:25 -0700 (PDT)
Date: Sun, 30 Aug 2026 03:44:25 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1137931/e38a41-000000@github.com>
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

  Branch: refs/heads/1137931
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
