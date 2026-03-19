Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E038D685
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945560; cv=none; b=ZZEgxWPonsQrcRDVKYLBxF8uG5mr9lv9fxUB43vfaD3sHOmODEcRIdoW9BkPApwDtTmLaeorOmgwCOQsALJ40htqxC3ktr56/1nEwyf9O5OPNgJHm3G2J028yNEL9bX/zYN5/HSNnSNDZk3unZHKUFCVV3GfapN3IOaTWDUzvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945560; c=relaxed/simple;
	bh=7uNWuLsACEZqwSOgr1x75dcU8mPUXYgQJZKcJLDZeE0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=B4n4PjmOp5X2rg2qu6t6MHQjWv5WcYXxUJJStipxfgJx4NOzNzRNjU3Fvhg/NAHGsQQfMVVwohUNbRG6jnBa0Q0yt4o0V5AWcrFIq/k6vQxz4g9zs+iYYIJWShoYc4Bf8EpS4uPDXw/FjCgmrfY9ZENdOdSYAcYzwg952x7/L50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T7cPAK2S; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T7cPAK2S"
Received: from github.com (hubbernetes-node-bee1b51.va3-iad.github.net [10.48.130.45])
	by smtp.github.com (Postfix) with ESMTPA id DF67892007E
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773945557;
	bh=inGaZbbgVhL/n8V/OPJcdcI0nq42Lk3ZRKR0o7/zYtE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T7cPAK2SllyE4PKq6ieGV9yOwmr3CHbjEH4GG84Ls6O79XEtJ0qV5231/7MPMQnBa
	 IhhQZCb8R6WPjCpEkCalJEK1g+QYs5WGjv3N2haaOXKdd11g37npA1kupJDtf0Uida
	 l5op1v6x9QYjxcH8E+2KAQszN3yWLPgxkurxbNiE=
Date: Thu, 19 Mar 2026 11:39:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1069297/5c3408-000000@github.com>
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

  Branch: refs/heads/1069297
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
