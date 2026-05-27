Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812CA31A061
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889687; cv=none; b=AfY8NkFzIKXNQlYR0FCZjimk0teyM28yPcM7UY0wMOPptfhdd5ERbQWZ3M/evNLBBBO4Xflfmbjio52lgyY6IuhvRFB/bmCAjJ7e1g+n811j3FUHhbDb0R4DfWAAQ4Xe2pRzcIxXnJF68XDK19OtJsrSjUIpjGbdomL5nMT7298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889687; c=relaxed/simple;
	bh=vbkh53aYjRTtNptojG95EeTe1DOTzSGmwQS7NZ74IAE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=I2Ny5AH7TGLST0Uxpc1dDpv3HLVVuQrxuwzR7twCw6Msby/VAzzv8r5WxD+cg+Y9jjQF2k6UTvGSN42n2KZzHOX1RP+6bbhQDbUZqXF5O488eJLE0msa32o87QWP1+uiFN2IcJwX4rs+Gl8b3lDlJnejv+dB4RChYc1gnffpsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f2p2jSrq; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f2p2jSrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779889685;
	bh=VOoVAXpCiIFKF1sXa7K9SVe38x67g2h2g5O20Vu/LVA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f2p2jSrqqX6HgOuBISeTSFgtLrtD/1MFyl3CmkxQiCTlzX7BgiMx4rA4ITIG0v7bj
	 yGdK+Lq6acjfsws58ZnN1JY/XObeamgrMD2LbY7AH1xRi0qhwNs08GQUtObPTP/TJZ
	 Lvzpby/w/lyRCTF2mOuUNJn+Vu+N0f7ZCHmjb5ng=
Received: from github.com (hubbernetes-node-d20ef0d.va3-iad.github.net [10.48.83.30])
	by smtp.github.com (Postfix) with ESMTPA id A65892810B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 06:48:05 -0700 (PDT)
Date: Wed, 27 May 2026 06:48:05 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086088/dc62cb-000000@github.com>
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

  Branch: refs/heads/1086088
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
