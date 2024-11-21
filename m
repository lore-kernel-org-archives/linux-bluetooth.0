Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525016130B
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209112; cv=none; b=is+CzbKDbLlLlMyT2x7OTmy4q8qTxrUUfwSPz30ZbmOn9XlhNr6Il0O6M81I49epk9PNfH5YGVGEw2OIb9EPxgM7fFeimZXHI/qgbkpWJpu8qehrM8EUfAp9IUh2HgIJEUTeRZfK76THY+yuN/2E6m4H1kfsBZP6zRvppK1JNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209112; c=relaxed/simple;
	bh=3aZI4KJEcnV2LeWKCrfUdNq0IZe9+ihClICcEGomLq4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h4lKIWtTPnmUCIs1k6dItM4rfvEi06y2HfPZEzwjdmhLNUP6trbq6stpav1FsgnmwnrBtouDg0/8o/B6ULUg1qzikwIRodW4PI5LXtyEe9B1FwMdebU3zOopRl3hvlvE6YVMb0Xhqv2TsJ8+G5tCK1OLFXnG5wCoScBFnaAo1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kkZnKdfW; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kkZnKdfW"
Received: from github.com (hubbernetes-node-8408469.ash1-iad.github.net [10.56.209.93])
	by smtp.github.com (Postfix) with ESMTPA id CA0DD6C00A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 09:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1732209109;
	bh=7QaAJacE5Rk0ogQHpEy4Rln0fMJki0KcOuidm3ILXY0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kkZnKdfWkP9E6pRqB9iCSMZjqI7wJcVTR6ys7jf65o5Y47hilbWnA2Vqt2O+gJn+I
	 BCLxa9vXyozneeX/uUo2lxVDfUhu+3zG0mSk3ueae8rzPGPDAeFHSGBR2NtaLTa3zN
	 CLsbBgp5aD27gC0WCAsXk4TuHPy/1CaczAY0xE/k=
Date: Thu, 21 Nov 2024 09:11:49 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e59a91-385f0f@github.com>
Subject: [bluez/bluez] 385f0f: advertising: Fix for broadcaster role
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 385f0f357d98ddc5a021c0951740571139169994
      https://github.com/bluez/bluez/commit/385f0f357d98ddc5a021c0951740571139169994
  Author: Prathibha Madugonde <quic_prathm@quicinc.com>
  Date:   2024-11-20 (Wed, 20 Nov 2024)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Fix for broadcaster role

src/advertising.c
Include check for broadcast mode:
AD flags shall never be set for broadcast

Test steps:
From DUT, bluetoothctl go to menu advertise
advertise.secondary 1M/2M
advertise.name on
advertise broadcast



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
