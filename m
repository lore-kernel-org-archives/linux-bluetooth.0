Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DDC40BCC0
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023123; cv=none; b=r/lBxpYuEjvek/AT1HcrMeweMexcbxG8085bxbOPr7JC49WyrerVbZzbygd1/79oNzLmqWNoGZkcSbt5e1xzH9umY7hQtbFBhpWF9uhw481Iig32jGJsVu3JH5BIxGfmEXSPEWnnc+ofG24RwwixrTRpaBvQO4i/vdvit1PXpio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023123; c=relaxed/simple;
	bh=VinDKw45KO1jSD1RpuxD6mhuZXE6F/LPLnuUwU35WWA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=knm5Pv6w5FlpRvU056pcF8NInJKWtZwsDyc+gqclUci1fvpAAOGG+U5ytcZtU6iTOXfJ2HovXMuxogL5/oQvHcZOxfSuH1VGuSk8ivFhtESAHVcZgLAQJA0qMWhO1z2/ESlet3E5hn+S2hp9khPa5BLd7wqKrklzj2s+m4mwYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YEp8OeRh; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YEp8OeRh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781023121;
	bh=s9eedG8Fs6O6gUQwSMWla0mzGzblOhzBTEWLZwJIuH4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YEp8OeRhVnQDntTNpWkAdBaTlsdbwRkfKF2jdjizzTWs8kw/723aCnLdKQwtns9P9
	 VIUoUtk3u2PpCyuTIiK2ATOV3ikm/tCIMwRy75JVy/EKB2uaa8fz4ae75y/x82ijqK
	 uLan6+YTEr7XN52YGz1nixDOhGYJ2yUObCZu3Wzs=
Received: from github.com (hubbernetes-node-d447cbb.ac4-iad.github.net [10.52.223.73])
	by smtp.github.com (Postfix) with ESMTPA id 4E3FF740FF4
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 09:38:41 -0700 (PDT)
Date: Tue, 09 Jun 2026 09:38:41 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108483/29bfab-000000@github.com>
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

  Branch: refs/heads/1108483
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
