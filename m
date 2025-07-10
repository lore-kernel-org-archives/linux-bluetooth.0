Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E3821C190
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160743; cv=none; b=dZLGzn1qtcjs6QGqilhKraGx3H0Vq68TbHhidjrxGdeLo4bAua11ZAvh0kTZSgo4I2HyNFYA7k0UWjIPeabU08BuKVCHuiykJrNVMAKyl1CEbEYeVJGui9RIozjGiNpMsnYaq3xf3SfUi/lgCbxWABpHKXyQ8ohoBueKGlmXBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160743; c=relaxed/simple;
	bh=s+C/s7/X9Ncvw5BQlZrGIz9uCjJZBAKssc/t4RwjDRs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uRnwv0SaZ3jxoN21iEvjPFrFkCzdGdlUgJPY+F2hBoucVjw/vm2NJug+sWn7kxpKpAz/Lju5fOOyVePUXetEZi1LETM9RV+oFY4Z0WP3zu2jOFz+1/IzrMeyEUiDoKj92hbv5Cfux6Ga/Ajvavw1BoMiv5L8VqKaOho62LjAV3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H3dDCR8u; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H3dDCR8u"
Received: from github.com (hubbernetes-node-74a33c8.va3-iad.github.net [10.48.146.26])
	by smtp.github.com (Postfix) with ESMTPA id E3DBCE11EE
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752160737;
	bh=ujdygogY3/cdcOcwr9eJIDp1k9JRRO0FK1Y7Ww3+aSk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H3dDCR8uMtAhVD2SYjWjpxeJZ+qPkAPqwiYm+Zc1+iun2/YsETEj9gGY/37s/p5GT
	 0HhPe252tSK4T3tm3EQJutcuqCw4R2jv5rM1d1RfZDmuyPfDP29h+5Xa9cxYCHTFur
	 DIYibPxIJ8EyCtyzXfNr58MryBW/iX4fka3G71yk=
Date: Thu, 10 Jul 2025 08:18:57 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980566/886bc2-000000@github.com>
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

  Branch: refs/heads/980566
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
