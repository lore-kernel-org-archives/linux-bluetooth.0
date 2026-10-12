Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B303CB2DC
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 23:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849127; cv=none; b=tMdizjMG5Xo9bmi6UtN3wv/t2km5sg1fafeRJ8vSwmU7JgdkYGYjeuXRc2LtzkVStJ4u612iaEhZhtOV/OX0DfXWD6hkzsZvJVmAnZN21cFxKwZoecT4023ZQhTMvi0SAID0aIaERDiTteA8xX0//05ecIY6EInayVs1MakLP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849127; c=relaxed/simple;
	bh=B1McQTk8n1xSFuWH/BAy6lInfWlrJl8TBg3emk6AkoY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ghsnDAqTn5bQfx797sfVOON66KM5cFql6WeKuaXaEmYGTCWtdhm4maNoR6VPNg7duLCzju3ToSCJ/6mSe8w9byyJIC03pD8PZSZmYhZIambhzDQKZQoI4KaBn4VEMmQV52Mu751fr7zsXSv/f+3PUB66Rh05XpAmQ1ftWjD8x8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=H8n7lnm7; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="H8n7lnm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791849125;
	bh=C2u6u+Acj6Mv7iRmtBjZjT2STUORhtob5uwDlUIh2Os=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H8n7lnm7NT0b8jWdXc1WN2PcA9CSUtjmlqRtyl+9F/Dx0BnNJdVVaTSgklxKy7/i3
	 vbBU69eFt3eWXJtwb6Cy7a3XNst19kq/rfT3qdcLYEa7E/pvnwAxB14FoGqTCWxaqv
	 mEGCPGuoRXrTC+5gwdAOaSkW2KNfIYLViYKJIvoj2mFvil5+zOI4PAHsUUMsEYZIp1
	 k3E0NvgXZMTbLtGTYwCPxJ1QsYEa+zKwO7CcTUbf5N99xiikN2cN10/K6kQQEYDJrN
	 TC07njujJyWCZmySeUdLncoZeR7KKIlEZU5h8bBYmune2F1GuSgDHO/7nad2koEX0B
	 6YEzLgeQeZuZw==
Received: from github.com (hubbernetes-node-1b7fdd9.ash1-iad.github.net [10.56.208.73])
	by smtp.github.com (Postfix) with ESMTPA id E6ACE18023C
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 16:52:05 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:52:05 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182593/bd47bb-000000@github.com>
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

  Branch: refs/heads/1182593
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
