Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741621E868
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753319944; cv=none; b=oR1exy8h3DR/TTXeZcNbW1BId1wPJgKOfIgiSnok03NaBXpyVVDrQ4KTdyJZ6UvrKzS41ZiyLyVAjsTWu98qMF5QfHn1tfx5HrVFmsvZMBRwMth+pL/J4T85l2sSXrRVdZ8s3v+3+QylYWbdM+vhSqEKVKtnyk668TlIgP5VUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753319944; c=relaxed/simple;
	bh=3QoEuY+PaUP4eFe2Zbt0xutj6mQmpl3lsQnXBYLlChA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TsoS9glAS1x+5APc+9Ob0fV9OWxhnXaCllgO1+E9OGQFAshV/iHknEOK0HXp8chxZyhyRQUE86+4ianFcpHsEu2QBFu8p736YO0na/ZbvgUcdR0Mf1FLzB2Ms3USRG1bdAslSNWGeOe5gmGVY+r2SEhTpR7wHmrteLOpQbFTKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T/aPDaGA; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T/aPDaGA"
Received: from github.com (hubbernetes-node-f9059e3.va3-iad.github.net [10.48.178.35])
	by smtp.github.com (Postfix) with ESMTPA id 8229FE079D
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753319942;
	bh=W7OUkvBrvYUCIFUzIa1bW65xUuviwPXiyukfR8sfNm0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T/aPDaGASsz3T/2v+HbFkXL6Z0R3T6DNo0ySK1vgBbXYWl5ttG7Giafa11L7xLtcm
	 /93UcUDxRes7IY+WwQRF600u+/K//CrngG37n2A2xJ/weVfMjKermrJnKAFWOzswd5
	 L/3gYBiEBc0XSjqbjYmrUnoU5Vd8adKokCZjZp7A=
Date: Wed, 23 Jul 2025 18:19:02 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/975068/a00c4c-000000@github.com>
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

  Branch: refs/heads/975068
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
