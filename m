Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8F42C513
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343290; cv=none; b=E5VkIaRZrsFHxV758i79Q/Fdk1Ab9taNcma3EYU/x4mKsddVDBHBhjvfa0MFEXdFKxjdhH2tTMflJlmIwE9jMK3SHEdpCLCXi/DwgGLUr+AVWu6ruAus34ovQBzX3qo+KviCSvZ43XscWgIjHl6gzPZrIWUZVKpGqGg1x1roGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343290; c=relaxed/simple;
	bh=/jXF1yGDhOQIdUUCmnHlJpueuEfsxFWEDW+2OzKAVa0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q8Rk+4mi/23471sS2N046LOZVcwjJL0k+oWiPk/9tVXFkvP42mnupa8psAXJAS82gLS+GBO9wWSB/Wdw30GaKXJLDE9a0GO44L4/VqI0dwHgPpV/Fs8GPbna3a+od9kBtKJSrxK7CN8PZUGPB8vi9Jdi3V1RRqYCSygsBfwJM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NockcNhm; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NockcNhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785343288;
	bh=NJbYmKgIqb1N7QspwjO9sZLEv1ZworjQG0h8tDEKqGk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NockcNhmnDb5ekM+etxLK8R0GHEx2v1jI9oZtq8kiwRwoQ6JRn7DNwAsN1YygMsXF
	 xC0d4owtH0zYPar7tskePGoYKl6dQiLCvoAWWWREfc887Nrwef2RNmPqkGIfbj0jcE
	 27ViETrDhooH6uOJIebFT6qdFtPeMpyZw8UzuyF0=
Received: from github.com (hubbernetes-node-efbab3a.ash1-iad.github.net [10.56.85.35])
	by smtp.github.com (Postfix) with ESMTPA id A16FA84114F
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 09:41:28 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:41:28 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1136408/102aa8-000000@github.com>
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

  Branch: refs/heads/1136408
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
