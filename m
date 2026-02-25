Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B5366060
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772060026; cv=none; b=CELllfr9jV3fTdky81qF7mdlaq+Oz91W2Y4fO6cgU4gvxfRdLzJCcF/0aHG75vEP8KniHYmtxZ5S2SsVF7rUVEDz0qOmtxKxi7LHWiMhelSqPVZgJDw5VBldYG+EfowmNJzChlO93qKIvKYFMTZhVA2f0D7AxuGodihjTB9h3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772060026; c=relaxed/simple;
	bh=s0PvCBu5xLwc7+JtRu0vYxLjHSK/fngcrBb8ycXdHfY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UUGWsChB6tySjmhIYo25LO88pTe2UojqRQmN83T7vwwlXVxB5ELsnQ5h+xtnLJEUXNWoKW+Rn5AgSNmHpPmFgq2rWqzWjV0WLReL1Muz6xyikEEglBnZhS1vwP01Uxvi7EP/rH0y5OJHmODPCBukM5kuQJjOPBH3Pzd5tu81H7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KaB+xB1t; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KaB+xB1t"
Received: from github.com (hubbernetes-node-af4b4d3.va3-iad.github.net [10.48.206.54])
	by smtp.github.com (Postfix) with ESMTPA id 73C5A4E0A2C
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 14:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772060024;
	bh=Wa/dirpFOmwBNeWKU/ELXfE+CvsOqdYK/wP19ltWxIU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KaB+xB1tQ8Kq+/BZvRWV0hc5xbpd1KKRVo11RpXpxdBeyHcstP3qIrab3tMtrqvsP
	 JoG8Egk6jnY8fnLgpP5LCghd2c+BstujkYS774PiEKHqQaUZjLP7H7KNldnpqREPLt
	 Ed5XfYGb+5TcW/1Vge2iamYwA0duh4lqb+kS+Ucw=
Date: Wed, 25 Feb 2026 14:53:44 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1058038/000000-eea7a6@github.com>
Subject: [bluez/bluez] eea7a6: bthost: Add segmentation support for L2CAP
 LE-(E)C...
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

  Branch: refs/heads/1058038
  Home:   https://github.com/bluez/bluez
  Commit: eea7a6da6e0f74b5101693652ea50c74ebe99a6e
      https://github.com/bluez/bluez/commit/eea7a6da6e0f74b5101693652ea50c74ebe99a6e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-25 (Wed, 25 Feb 2026)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  bthost: Add segmentation support for L2CAP LE-(E)CRED mode



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
