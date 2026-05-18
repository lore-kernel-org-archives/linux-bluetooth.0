Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551DC2F8EAB
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145012; cv=none; b=caLixQ00B/cm8vK/OKlbx99ez1OPqSccTzZKPCaivI6AlnfIdwBRPL9MNbQPn/Gy7YTOM7Cc6MX3SmphhNybVX87hfhQuPdlr5rTnhRvb8nFiaDtlXgiHerrEp+0eYVEvv9cAE5QvlDq5vUJeczOB8D/8PaBYuyE3H/gT0kmihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145012; c=relaxed/simple;
	bh=hzxC77w6im6f1ZrV6gZU93xb7xcv+gYilQOnAS7Lhtw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uT15DYtLZs5r+4e94QsireOADhNZ7ybHMGWkNoBneBhf6/S8PZQycglU+sn2xUVjuqB28fdcyuIK+fKFXk3iZK8/S2VDjPZdh0Y2doUt2lroeiCQH+p/OVFttpzcfVSY93mq3DTwQuv38JQKdAmD5KQVJ7nEA5Mezk/pd85o1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JRqCIVtb; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JRqCIVtb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779145010;
	bh=9CpmeH9daRrIiu1q+Ks0wxCAdCMfvDRv78hL5dK9xpI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JRqCIVtbg3+Cl4VXLYZOAuMBiRnti4OpmXeyNLUf2sAhSURomHy4vrB8uz9i0CLmT
	 rrs9s6KQNya+M1X0ZBAxKN3uVGDw8K5JjF9NVGjDJm/5YczEzjPAJZgZ5V+lB1u2ay
	 wr9YK6ea5kvAGr4Kq9ODs5pL+QkbwJkg+tn3LT0w=
Received: from github.com (hubbernetes-node-b51b2d2.va3-iad.github.net [10.48.173.31])
	by smtp.github.com (Postfix) with ESMTPA id A31518003BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 15:56:50 -0700 (PDT)
Date: Mon, 18 May 2026 15:56:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1096012/a02319-000000@github.com>
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

  Branch: refs/heads/1096012
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
