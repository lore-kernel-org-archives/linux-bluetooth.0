Received: from out-38.smtp.github.com (out-38.smtp.github.com [192.30.252.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FBF3E1D15
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373975; cv=none; b=T5Za5spK8+Uj1CCNjjUr74txnezj51L2dMceEhPpAXyFj1nLLvJNoqtgYVBHkhPj4/A4ksZeyr1wl6MXaIxPrHopKzU0WKMjzq7sUl31wqmNGhhf7MvOzITatWPLwoLWjkbDoGI4/n0OnmwOyYQi2lEFNMw8zyY6t81SAlmMMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373975; c=relaxed/simple;
	bh=TAbSjCDbpf0Y/2Ge9SPJAdW0b3ZsLlRa2p7GU59s0LQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VmLr8VktXZLJRdvuJv7Z8vsxTPIdJPw9fGab/VulN+fY6pjDTL8OOmqEHZo/NkzNjDsYx9yX5xlQzWrqW83Jm9/HUNgav9XfBArl7cLRWWM9O58xW8gpFpjUWZth5TnDF1GUvqr22IrlHeSrL0y8BfyNI4ReNiaTQHDPaNO1arQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RaaAn6Ae; arc=none smtp.client-ip=192.30.252.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RaaAn6Ae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779373973;
	bh=HpK0T9G1Fa6PkP2ZmOYSVj9iq6fi0jJbssA3Om0D0os=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RaaAn6AeJ1PJk909+MLsa5UkRjQr9VTC+Slp9syDOkh2SwVkhNlABgFg+mztOSkDG
	 5WPokIYZnWeixwYsZ/yBt4JR06u8Ofzza1V8P73c0/aWBv6VCJA6P+xSq27TOCYp/c
	 5Kyjmkj5WOrLIBr1vwxGYHMgfx/P2xre2o/9MLTQ=
Received: from github.com (hubbernetes-node-41f2782.ash1-iad.github.net [10.56.15.41])
	by smtp.github.com (Postfix) with ESMTPA id 69F23920C85
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 07:32:53 -0700 (PDT)
Date: Thu, 21 May 2026 07:32:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1097304/e6f7d0-000000@github.com>
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

  Branch: refs/heads/1097304
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
