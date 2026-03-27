Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F8373BE6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631354; cv=none; b=PchEY/wBekrox+qHksWGT5eGMewnOYTtFyjof4e7DUUtqJYcuHck6Qd81LB2LeBFGuMx/zfET19uW2tVNh7OWz+ouPwzpMzU3K0sM02RhCBO6Mz+i/8wysCKXrMbb7+uJvYU/PpU01WlTPloO1HVVMv3980jRi+nG5EvaE0uy4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631354; c=relaxed/simple;
	bh=qMPc6dNloWJ28KsRkNqNRE/RaM4MeFhfd9PautQv1FY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FxrFq6VOD9jOXxjtLI06Zn3ALEx9OsBo73qZ82Omh7vyLjGZ3Y8YXzOrL4+7sMZjfMZvejqNUV5sH79kqrUJbqp78ISa4MBEz/UPwwevaVtUS3w/BkzkTyTkxjMRTd6w+sGuUmdjpVnayBOn8KkXzNFVxPAPbmJ/emJnVsZ4F4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IRhPlPS+; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IRhPlPS+"
Received: from github.com (hubbernetes-node-d22f526.ash1-iad.github.net [10.56.80.28])
	by smtp.github.com (Postfix) with ESMTPA id 8070D92078B
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774631352;
	bh=Ud2YwJh/okBSb2ZY1aij8PmJMFTYHjoc6M0wFgg7aUk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IRhPlPS+ruP506ASCUgR9nK9y+9VnL07jYo4gWRC0FWCQoaTpki1ImYyDmiHp+iiW
	 JsDIf9M2DyqiKcJhC5VX3qwbO2sNhL9oP4aUmkeax/BPWvUjrcK+LPZGpvMBqCFKl8
	 vS+hywAoC785l8TT1jfPvMpuRZfelw1X21x0+lF4=
Date: Fri, 27 Mar 2026 10:09:12 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1057897/22a0cb-000000@github.com>
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

  Branch: refs/heads/1057897
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
