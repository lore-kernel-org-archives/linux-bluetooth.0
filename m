Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF92222D6
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183289; cv=none; b=dRZ4WjjzBN+XRjiyqChetAGUbfVWj+IUB28h3aHftlBWNFeROl87gwW0V2rR3eqszBLWagTjwHHJzME80wj8az25Ns6sy9rpoTA2B04Csjtw7WYtk3Q1U7ahnI2p0AW9llKiQNIu8Jyl1s+UyUyl5d/6B8icwhBgghz8P5hkvRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183289; c=relaxed/simple;
	bh=9qT5wv8s51iH76Hj0Bhl7c34K6bYkIcemEWEeZu0tNE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OfC/W2eubwQsPFpk5EWgRIuDdcpF89PtWw9Ylq6lt3dQbjRzo/Xi+7pfrurjwj3zSEx+sMXJR0DotSGJdv991/OP4UNedWZLfX+XJRdHiKHIzfk3oszQrwZjgg1P0n+t0OulB3Q1hpR2U5tWeIIACE83sV3lZ+C4L6mlx5bdG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=anKioakU; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="anKioakU"
Received: from github.com (hubbernetes-node-0b6599d.va3-iad.github.net [10.48.164.55])
	by smtp.github.com (Postfix) with ESMTPA id 03D384E06AF
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752183287;
	bh=xZBZImdc1ln8WiibfVkzH2OLrshXfGi+05iusg5kvLk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=anKioakUEBFLRRoBBvGRhPOVO3uiDIfBMDfVHoYZFD2QQXWmjZ5CVNGpmuUuUtYjD
	 Q+PYZNIpzFhQkj926Pdpk7OUYDyjXtmPnq40c1RY6UuCRKpUJrh8aEsNED3Rcy9RrD
	 FJxViY2DzXt/R6zNHN7TEGNNCKMgNO1NiT0U1+S4=
Date: Thu, 10 Jul 2025 14:34:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980136/c60f55-000000@github.com>
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

  Branch: refs/heads/980136
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
