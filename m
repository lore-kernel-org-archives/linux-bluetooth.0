Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB653BB11C
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189172; cv=none; b=SDEWKFmYOCu+/KySlI7yW9dyh+x7pXY+TxbqDT6yXVtOCxNnA19iURXAjJqhmbTmfmCkW8MKac1dNQ49GtQ3EJdQ2YOEwehDNWscs47jvSWA+Y6Zp4O6RcoQgmuWzrYyiHuu6W7wFBUp9mZTEo/bbEa04Qkk382KuCwpNN9t3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189172; c=relaxed/simple;
	bh=QfiEkNHY/rR1asVm33sY5B5tZLBKfaqqdZeMpsyW1xI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XITpkTepcIHZNklT3cwiBnAzALu/mCKSXicuAQf/98tCBlVI3jkZenk2OjRBCNpd7ynd9hr6xdKNQJyULlYIfPnNqdMbEm0DbDcVAuL4MbAyft91dEJa9wJxzG5/CSQf4+8stLeVBoovMHAYroF64+6jzZunMytl9ASBkU13gH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Spt5VYHP; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Spt5VYHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784189170;
	bh=WV/CoIUNxENFDd9yZxHLipjprwOwVCogwipd6X72asA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Spt5VYHPP00iRZsu8t4A79jDEMoAR4QpbLTki6xSi5UAxF0bMHlysBTas/TmaH2x8
	 o/dYGlIq2pRiFcxvpJBXFEmI36ks5dG5ZY5SwxxNNEjjGlD5nKa9UJLscWq9gDYyZo
	 7eNsvMH2fQgE7R0bKHbHtihEIeshBdw31qntVb5Y=
Received: from github.com (hubbernetes-node-9895ccd.va3-iad.github.net [10.48.135.33])
	by smtp.github.com (Postfix) with ESMTPA id 323D5781325
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 01:06:10 -0700 (PDT)
Date: Thu, 16 Jul 2026 01:06:10 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128574/000000-eaf23a@github.com>
Subject: [bluez/bluez] eaf23a: client: Add scripts to start cs
 Initiator/reflector
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

  Branch: refs/heads/1128574
  Home:   https://github.com/bluez/bluez
  Commit: eaf23ada4f52f3747c0aa1a2bc918b0bfa81cdee
      https://github.com/bluez/bluez/commit/eaf23ada4f52f3747c0aa1a2bc918b0bfa81cdee
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-16 (Thu, 16 Jul 2026)

  Changed paths:
    A client/scripts/cs-initiator.bt
    A client/scripts/cs-reflector.bt

  Log Message:
  -----------
  client: Add scripts to start cs Initiator/reflector

This adds sample bluetoothctl scripts for cs initiator/
reflector.

cs-initiator.bt sets up and runs a CS measurement as an Initiator
cs-reflector.bt sets up the device to respond as a Reflector



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
