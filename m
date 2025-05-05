Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D021D63E6
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477220; cv=none; b=Gm+1vvBHJTXwgX7RCOeqkuQK4lcPsFfLFetmaA3MOT/YCjc9XMqUaQFiHfpAYqhl/1MDFZsMZYGPum2UNvECPxpDcjQrW+cgiG507gbRyRzCafDBN9HWrXfJFHPMZ6Sv2MlSLPiJEXDDWloPK5MgY06vPOw7bfHuiz3RbDjUYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477220; c=relaxed/simple;
	bh=UVKsqyHtO6m2ps/qPTovsRyuhh0HD+sgwMqiv0LQSPA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aeuyVVODefaq0GOkLs3MoYRpHbnQHQsBx1szvwTqIWPsoodZpxQfgT9349EtQg1xI8kxMYlp42ZyGLWCwa9pKzK3G9dbH9xM1BRE5DtQYJWjP5BVhLDwuMp+GD9ZUycMFXC4ttQN8mHhbVkTNTO6j4KQt2pT9Sq24RFUHDTTjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MJfITr5O; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MJfITr5O"
Received: from github.com (hubbernetes-node-9fae080.va3-iad.github.net [10.48.157.15])
	by smtp.github.com (Postfix) with ESMTPA id F212A8C1171
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746477218;
	bh=nE8O2caQe8Lr83gtLv6AFV1X1aI6RLARlOvdiQgLs50=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MJfITr5OpwXOycFvxVVXNgQiN+uvA55fn2uGRJ7zt03JjzbmZWIy3TYZUxGM9Kd0v
	 6mRx8Ht54DKLgwi9VJRJSpXg3/u7VzUUIMlC6QiIsOiMhbQRF2RFJ8uGzfTbACFvJh
	 5iKW2FFYpPgQbOIykUJiqR/Cr4wzJ0WMHiA6XOAo=
Date: Mon, 05 May 2025 13:33:37 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959339/3faa27-000000@github.com>
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

  Branch: refs/heads/959339
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
