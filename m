Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509448C41A
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631115; cv=none; b=FhR/tEr6K/xcHnHcMWhrnh4AH+GD2W6ybuRKSr/npQDwmb9yUhxcQN5rKNFJ70kBPlqOjRpYefzKASSYgBBFQqXDpZdTShqZOCsFVp0iEQgGjXeC37MhH4cyljX/FKEGZ10j9bYJ0i6geOg/F3qxyyM5m+T6zoU3cwpIwhj5Pd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631115; c=relaxed/simple;
	bh=huh6GN9aK8IWU/65w1ybCawqCKOXUDFfIIUl5tyqPrE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pgzkdurnrGpgxMacIitcOl5rvKmKtcl2vzdBuNhGDGNJ6pg38Ts9oomZT5hEBHSy7tZTmQn/G9kq1X63hJozIMKka8C2tuheM63HOZHsVY1l+1YTKOKhyFI6sjn35zGvf+iuo/h7m32BjzTn/V5JKU3W6PwznK6ki7YKua/T5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=N31ftTYB; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="N31ftTYB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790631110;
	bh=hoENF3p5DyI6d3mpgOCYX3iL6GbH9LGFgN2+jqQmUcA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N31ftTYBn973qcgqUzsOzL0rhS1Pz5/KPwn6dhxv3el0BUDdagFPMIGpH4KPk9u2h
	 NckIGqekcj5r9t4BGi9lpvn0XeToT4TqUfpmOjHsl8PhsL96+7mtzyrjNTQ7S/DIcA
	 IdjvvnSyFHtRtgPRifAHDoixh81uKG2uoCnIuh50rJNDpgRdAbOHsNxIcCNzWC3F8X
	 mK4Gjdqzvjqpu4ONmKKPHT4JHZYIBuQIerKb8FmVfQQor5RPKOfESGIOsE4aC7zBwZ
	 JL/0Ssz94COXe9/p3tWdwQs1rLNmnBnnwyIZKJHt9aYX23g4i/m/v3ht4cK4cIMUPE
	 PgI9t+uFlrmsw==
Received: from github.com (hubbernetes-node-cb5f337.ash1-iad.github.net [10.56.167.40])
	by smtp.github.com (Postfix) with ESMTPA id E5B5584107E
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:31:50 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:31:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1174578/8178da-000000@github.com>
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

  Branch: refs/heads/1174578
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
