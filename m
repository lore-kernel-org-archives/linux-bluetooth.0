Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B41A3145
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274551; cv=none; b=exvoDBtHJvT4gTXkWgDfY3NyZbAccaM6ojNOkZnxD/ikJI14w9+VRr38tmuZPedcRyPjRED7GVZpyl8QgLvphImFBnsrqHqUxyzBPT+qBljYzs47PRhP4l/nZ3oxH4+styWqh3n3JlI9FRrqsvYqmlT9W7CQ+JnBUV3rKISXkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274551; c=relaxed/simple;
	bh=JCVEgp8BVYKwPLPO9exJOAV2zFLkHPni2GM2ZhKHZZ4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dI8TbOHztxZwRogsBLKfmQODPWBiZC/ch6UxsXVMfBvztHepw7kxmU4syzIli912/zRM63Hqe8bmaUpf/4A4B63ZWa83Anv7jDsFIEEsZwDT7z/H0aazxv2XXYyyYe89UHUWSBhf73LQqoC6cg27oczu0HjME5kO2d2wNDiQIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bxr4xcnu; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bxr4xcnu"
Received: from github.com (hubbernetes-node-b41c27b.ash1-iad.github.net [10.56.186.35])
	by smtp.github.com (Postfix) with ESMTPA id CC8EC6008D2
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 15:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752274548;
	bh=Isy1nNZGjd/PxtMG/+0ppFP/iecvczLwF6Yfl/C7W0k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bxr4xcnu743+OzDMRksUwVnV/ofcN5HhlJ8AS2QrBx8dj90cItWzzaQ+PH8G1RN72
	 q1nBHTLaoL2pe9DkfT242WVrQYpYhVd+eOXhLSslnFQrLLSjo5p39nC+BjfiqyOYpY
	 tmFvBdzFijB7aJFuXR1AzbloWXQ8wDlXuFgfKQFY=
Date: Fri, 11 Jul 2025 15:55:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981618/321f4e-000000@github.com>
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

  Branch: refs/heads/981618
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
