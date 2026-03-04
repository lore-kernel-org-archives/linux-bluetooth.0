Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4D272E56
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658078; cv=none; b=CO1ilbblzLKt1caKGwQYAZVd4DlSJ1KwVfsz3En95xiuvg8o8+AOZTfIKD905v2GQ5d38CqI+vWsyxVe8tohWJ4BKo42HsOuhQzL06i46Qr2iz4/eeK7wVUd/F2zTZc4Snd+RwtcbFe7txntjWFdmOL9f2aQYNfOjo4wDDbSJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658078; c=relaxed/simple;
	bh=E3p7R8OEmH7BmsoBDVWmXCDeDJKQ+VaE4kvh2Py7iuo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=p05T/arIx4u+zlXnTVPybp9rZpFbCvMlBv1pV/c9SFTPy/tqYeHsnIa1uUQI/mvYI8u3eZMjiEP+Btb6GQEX622ixpU46GJJe16ZqY58OcLEBLklUabJOQSW3YbqPrEUuALzHqMeZFOSChHXHSz2VHF0Bdg37XMQ2ZgOrIJ7B9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IQLxrGPo; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IQLxrGPo"
Received: from github.com (hubbernetes-node-3696467.ash1-iad.github.net [10.56.189.45])
	by smtp.github.com (Postfix) with ESMTPA id 6F244140B2C
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 13:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772658076;
	bh=h2jKKa6IgQtBMOumu5kj1+N0vXq+GRVoJOAEguw9CqQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IQLxrGPo11XkQkE46tzj2hvolw5qliP0Y3CiAJvMdNjadpq6KiwDRhfLpaVKMVzPP
	 5WxTEmHLzWbvdYHJbqCBYnsHwDUux23SDD4VSgYO3T2bHZAxjCLS8nx+H9+ExKNyQz
	 Uexu/blxktZRwLihAehoumyG6S0x5hFSbs1gizeg=
Date: Wed, 04 Mar 2026 13:01:16 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1061563/000000-5d88ec@github.com>
Subject: [bluez/bluez] 5d88ec: monitor: Fix -a/--analyze printing wrong
 connectio...
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

  Branch: refs/heads/1061563
  Home:   https://github.com/bluez/bluez
  Commit: 5d88ec3c5e25f29e16e9a2f96877587a15dacb79
      https://github.com/bluez/bluez/commit/5d88ec3c5e25f29e16e9a2f96877587a15dacb79
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-04 (Wed, 04 Mar 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: Fix -a/--analyze printing wrong connection type



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
