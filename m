Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46103002DD
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782279556; cv=none; b=qKNpdZl1S89FV6lc2xvlkeOZBk4Dv6lY5fj3BcGGlpMZVbytFQlYDNhgTzOc26u0/Q0gtvL55TSu3fU7I6YyuqYa46ICnMZAzGkxfwXT+eZ41FA9HR5sFJ8NE1hLhx5PgFYUPv5wsrz7UYjYegqf2NruiA4vMDF/uYrPzviv5tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782279556; c=relaxed/simple;
	bh=QsavvQ3wtVwv+aBaA7WM4avCt/75Ac3hfm3PkKCFt0A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ENBHrmPf/qvm79lRwe+aIaX+hC3yrbm5ZFdlZhDz/Mqbds9LEK4PNz5N5wbXlJriYdLJ0J1e/YsuHo0O52l/5nHeUazxdGZdddDNI7YzEInyKHYNVFDj2dwdZgBIOhY7HFEHC+Q0oH3Gs53Bm0V+uienxatl8i3xzPt+CJAODkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TpR46wmB; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TpR46wmB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782279555;
	bh=wSHZrrH6CtvCgMVwm/A4IGm9tX5U6eZC29+kt4EK9CA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TpR46wmBZ+96SGiEm5jgPYt0wOa5rpUy+hIxO/FMWFHKmhxioEmxhhBA7CN2YNadl
	 z27jHI0Oju78FsrPhY3mhcbaefjC5mu8bc5Zk8PrKTzoEOnnvJtKyb64KxZyv8keyS
	 8imsomUECmX5fXxs3FME60ssPxl93fuNocU44AdY=
Received: from github.com (hubbernetes-node-4f22ad2.ac4-iad.github.net [10.55.98.34])
	by smtp.github.com (Postfix) with ESMTPA id E7C1B741029
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 22:39:14 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:39:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1100171/c2977f-000000@github.com>
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

  Branch: refs/heads/1100171
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
