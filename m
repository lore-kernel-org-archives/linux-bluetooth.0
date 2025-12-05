Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987113570B2
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947869; cv=none; b=ayFDhooDaZbTNrHtpaVGOLzO0H1O+BwIN2GTYw4rg9UvGtg98HcOlOjMBM8UX+J925INjEyGfEHkoM7c+MDqm2Qo3VcppIzJMUA4yMwuttE5RsSlbZOLTOJDy9JJ3Apsm0gXX6tDWxUa3F9dnuLuqgWLPGlvquQkYKKyEVk+wt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947869; c=relaxed/simple;
	bh=bZWgw6+6HBMj9r0s+caPN4OA1P4+zMxkOXRzgnIoXcA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Oq6jdR9usbu1x8DxjSlOnrlDTWnB+PGMk1MnIptI4U2AGU3fBRpN6Xg6OtO8EnLZ9Ixc3ch1+B17jM6Hp5uBhKC8tu9kPNa08oGva5xefEHhXJej/t6sa2UT0k7WSOgEYB6kDk5bQf4klPCnr8OQnxogHxyTQskFZljJomjHjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z3Qr5vKE; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z3Qr5vKE"
Received: from github.com (hubbernetes-node-563cb2f.ac4-iad.github.net [10.52.147.36])
	by smtp.github.com (Postfix) with ESMTPA id EA38440106F
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 07:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764947865;
	bh=EsfekSkuV38wVNHBch86kER1N9OIoGU77TrEOI9MptU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z3Qr5vKENsnOQjVSJHwqGh/3Cz9v/ynwTJ60AyasjH3oWkWAz4ElJT08o5CLm2Yl9
	 7f7MMaxasDRdcUBDvFe1xUEVdjvodQ2ZPQsu9QLSmUkXXDHIvEsszX+UBb5J4BvwIq
	 B8IzPWLgky1IOHBYmYkvJK2CFpR5AbPZFV9xRk88=
Date: Fri, 05 Dec 2025 07:17:44 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1030592/d5afae-000000@github.com>
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

  Branch: refs/heads/1030592
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
