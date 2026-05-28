Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3614BF97
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946735; cv=none; b=Uwm8zLM1lifxQIzjO6QcQOxW5NKAWwZZsi2dMI5+s+xhO8G/XB85oY7drpdCI3UXRQvO4uU6z2Mt0wMGLsm9P0y+ti/fIPlY7c917ftn+Ux+r2gcmm1qOr5gkFndBgqi9I8j1pYb5QkGwPP8I74Qyu8kJHmLocCDBVpbwHHUMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946735; c=relaxed/simple;
	bh=QUc7pzsYyCkdt1af+Ra61Q2LjlQUv0PQ/n4zasP9ddc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iixoahq/bA6VQmUi89joV4SogqnpF1hFlZvmChDB0P86gCw8oFMGiTpBuDEp5mvjcn0N9wfhnaKk670t+bVvc3ThgvxZJde2hXRmkeGXoi5LP9ha4gbzKFJ+fPy1Hvk8vechU9CwUFmCsl5pefFL3Wq7NIZFbqu7GGPtbXRQk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mL9czWA8; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mL9czWA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779946733;
	bh=kIvJq3gfm2r6kkgFudIgVuWOQ92evotE1uVAWZkk1vc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mL9czWA8DpXd+KXcn+l0YcE4vTcM+VvYD5QuTCuJyWs5WltB7PxW07CX8wfjDQfHY
	 yaKQnXTZ3xKHyECUsBMpn9uEbRIcgiYdZNCUoIXPj6NnbzHJnC7fF21tVHOGu/S9nX
	 lWxf/hcLJ6nxMWYhT79U+O/pC7MU0S0ey3JuMeP0=
Received: from github.com (hubbernetes-node-6d89ac6.ash1-iad.github.net [10.56.208.79])
	by smtp.github.com (Postfix) with ESMTPA id 7462284053A
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 22:38:53 -0700 (PDT)
Date: Wed, 27 May 2026 22:38:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086507/1c15a4-000000@github.com>
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

  Branch: refs/heads/1086507
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
