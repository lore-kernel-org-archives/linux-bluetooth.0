Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096133121F
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401310; cv=none; b=kSMhIGaK+Br4VhlRjmr8IUfcDLT425a0lyaVkdJ0BVtqH42iCcQDOy6vlM5RJ9WcF/aVN0mbAQNRY59Je8pCRvn58gOgUuShXsa5YJ+hYRt9mX9/xp+vun579chfWHT5ZiuyfsIrkpOcWx5CGccC2x7lvSXkvXbAeWpI5qlTHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401310; c=relaxed/simple;
	bh=3Hcb4V0iLCWzB3M4n1W5qah/gEblZV8kwh6R9mmf86w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OBAzn987UnQpZ8VtVXWlD0HlJuweD/HWBQeaBsTpYXgbSKreG32jbc22PHoJlcApWK6k1oKUSF6kpJw3bDEykDpNNg1dQtb21Q+uSqFXMDyeeCff7UvPjkGcd2nQwnz23TMxJHXaBHnOh9TVM0MkRzkesZDivODYVpG96+NrIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=S1Y1MAx6; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="S1Y1MAx6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785401308;
	bh=zONAFVB+t3D5vNQ2StGgl5UXCkTA+HiAYiuepzi/cGI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=S1Y1MAx6LUmB08WiXTWHmFoYcyFtGcMqE9wSvqjM+ilS1WNOQsE3D6JM9r+JJ10Dp
	 86yegFB8D/MZ6pTJ+TTANuRpxRz+7ayc8Kq0+JaiPWBT9J0mQj30p9GfjaWXajfG8Y
	 F2Zd84EuX0GQwyPauw19jhakhamy9QCflAzUId4Y=
Received: from github.com (hubbernetes-node-34fe1f3.va3-iad.github.net [10.48.74.46])
	by smtp.github.com (Postfix) with ESMTPA id 2BB0134117C
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 01:48:28 -0700 (PDT)
Date: Thu, 30 Jul 2026 01:48:28 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1136563/417b3d-000000@github.com>
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

  Branch: refs/heads/1136563
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
