Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72433148B4
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820874; cv=none; b=MLW+mZkmkIKZSxNxVRJ0sluYra2OuGrgf5zchIoFcFc646w268SUcGck7SL+iWo0K+dCgh9lxwF39uenk9bZVaI8veD3sEYK52zhrLCf2P8DR7q3sqwemsdDpJT9Zz/Cl7bxAPD8op9I3M5xRc7JowgQ5OwVoCC0aiMCXnOLpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820874; c=relaxed/simple;
	bh=FqSmInhBdq2HlyQfJRg0WrINCIjdJQvfbkBlT+rOdaM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XUW7B+czv1szhhoko/+WyuoHb+xOHuZhMMDcmFQx8aL3CWcdscmOsDOp+fzb/oWh4oc4HqdsF/fvmROUS9bV1noW7Yxpl4guilM+la1h+aXJu6nR6ywR6XyhmVKzV9l8sJfojOqLSJ73q51QGdnnzQQifmR5OTFWojI9IylB73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eBT5Q0ae; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eBT5Q0ae"
Received: from github.com (hubbernetes-node-c4df752.ash1-iad.github.net [10.56.15.74])
	by smtp.github.com (Postfix) with ESMTPA id 13002920958
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 13:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767820871;
	bh=rIfZUQSFTqHPGD9f1K4tl3aSIjACL0Dmd4jjfWSKt8M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eBT5Q0aeKB3/hla+jzZVTe/iPAnI63acaib7v8pQPRunu9/h2h/83F+ll8vXAWhyU
	 dCyG6QXaAoQ1q1iqe8VK/BIJUhVNUiHe6J4/TcE65pHkUG+zIwsAUR4Z9Qgg0KOgOi
	 pL1pCk3L1upYgJXm6g/wFmZi6zy/NpA9kR5755dY=
Date: Wed, 07 Jan 2026 13:21:11 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1039131/e00b1c-000000@github.com>
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

  Branch: refs/heads/1039131
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
