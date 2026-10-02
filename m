Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5A1A6829
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790899870; cv=none; b=cgF5u1ZGPR4dicxZt3h+UumQked2dBd1qekRkj3n0zepmksPinJD/RsxrbMJG91FvPGXS2eAg+X16KHH0EGs1eOJEy3lDkXAWkII41UDPLLKsMcesQ4sv+xvLx8xYetl/VodNuHhAYz2K/Sxcj5k5N+RoAavo0BM0009AvH3fSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790899870; c=relaxed/simple;
	bh=shxwhLb0rX/bFUL6AGUY22SW+yWkWdP7kRZjFjwx70Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EhXJVp5jjOinFCLwDOMSCc1+41kZZyMMLVk4/4a/Y6+/tuhNoWE65MKJTRn8Xlk8vffQIOeA0RBPesxTWPCXAYbiG7nG6DLIwobzJyk4uyXGQ3gS/aMW1r1YzGq44Sj3z92Dnpvwo+cGOJKXPh3ZwBNB2dsxf5Q85ifpo/uNhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=IVu45fIJ; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="IVu45fIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790899868;
	bh=nNCxbStqqV9dzeqOs+SGa1WHuSlYK5x+LysEj78m9u8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IVu45fIJS66EJ8n56U4F1JRoOQ9MCwc0t0H4PtQlidpv5QokgTH1CIqBuEMG/aKcb
	 m5XjJUk5KBeHvkO8cUa0EKL8BGHcB7B6xqw67o7dAlo/4TJ4vTfAL4xPBY2olmXJv+
	 QFikLNc4nfycL9jqi5nJ0oARcg7AdaBr+ZuGuv30S6WIJosvBVSWfxE3/I/wQ4wYKD
	 o+cJiz6f4RsB98PoT8U48wE9yoB5E/sbieJdSh2NHoelDPzP6vkauMsWU6CVFBgkDH
	 kJTdVbWMJm/RBG2drRx3jKNu4lHFInvJZOOhWrlPz8KpIBBu8GxXY3r2f4m+1APy6t
	 P1MsulhxedT8g==
Received: from github.com (hubbernetes-node-5d8da8a.ash1-iad.github.net [10.56.196.49])
	by smtp.github.com (Postfix) with ESMTPA id 232A65208B1
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 17:11:08 -0700 (PDT)
Date: Thu, 01 Oct 2026 17:11:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173777/d0e147-000000@github.com>
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

  Branch: refs/heads/1173777
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
