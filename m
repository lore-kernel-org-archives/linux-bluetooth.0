Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7E318ED2
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188489; cv=none; b=lBO1fiSVGiGjiXhpq6bc4QUgzg6RfC3jOWaesbNdA4WcvABldbe/Yi9ELYAcusato8qjfc/+YTH6IbF5HH4yuDLqo1XVfgClZm7iXNXMc2D2BESR92tLIFQXU4wNj9VhA78RMyz2B/KfcQ2lYM2X+GzUtuKpx1RmZ3NT4mmK5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188489; c=relaxed/simple;
	bh=Xo0egXZiP3Sn1YVzSASNfx0bZv186Io9CTDSD7Z447U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cNVOiOPgy/D3jb8Lqa0ge6sWTUHZ+Yd3stPhgskk+wUqkb4y+tCfMf9VyhYiOPV2+YniF6o0u6YgBfEWA1iJwgxMlTZz7ir2h/YJyozubCqhxQRmOVfTCn6ONFgBpWv+ACXRDamzBokG4pkDR020SIITaQ5yiETH0WS8ofoiq5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YEZYyqi9; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YEZYyqi9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781188483;
	bh=F2lisIbPOGw4iQWpUKxJUswfksEwuywgTVo3votDgrU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YEZYyqi9sS35KmMqojO0xkaxkSC9A6yuysAjsonsZ1OI6Ggvgwt6SsLwk1PFhJKzZ
	 +ve/yrpoBiOj8Qk+8PbBLSd1eZrd6s/i+j9I3gpASBDKjolEhL4KL+21wxynPM8BVN
	 uzzNim4+bIjABZSnvz9NKwmMyvxAFrU++pMYVRS4=
Received: from github.com (hubbernetes-node-418dfcb.ash1-iad.github.net [10.56.202.61])
	by smtp.github.com (Postfix) with ESMTPA id AB71C9230F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 07:34:43 -0700 (PDT)
Date: Thu, 11 Jun 2026 07:34:43 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1109997/000000-cccd99@github.com>
Subject: [bluez/bluez] bff7ad: shared: rap: Check role before sending CS Sec
 Enab...
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

  Branch: refs/heads/1109997
  Home:   https://github.com/bluez/bluez
  Commit: bff7ad1e29b4d1e5e84861d6333264b75964144e
      https://github.com/bluez/bluez/commit/bff7ad1e29b4d1e5e84861d6333264b75964144e
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-11 (Thu, 11 Jun 2026)

  Changed paths:
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: Check role before sending CS Sec Enable cmd

Add the is_central parameter to verify whether
the local role is central before sending
the HCI CS Security Enable command.


  Commit: b9336fa7b1d580b5ac18464fb6710de8117bcffe
      https://github.com/bluez/bluez/commit/b9336fa7b1d580b5ac18464fb6710de8117bcffe
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-11 (Thu, 11 Jun 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: ranging: Add CS Initiator cmd and evt handling

Introduce support for LE Channel Sounding (CS)
ranging procedures in the Initiator role by enabling
required HCI command sequencing and event handling.

Add handling of core HCI LE CS commands and events
This enables cs capability discovery, cs configuration
management and execution of CS ranging procedures
in the Initiator role.


  Commit: cccd993d1349ae9973ff03ea2fc9b21a70f0bd8a
      https://github.com/bluez/bluez/commit/cccd993d1349ae9973ff03ea2fc9b21a70f0bd8a
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-11 (Thu, 11 Jun 2026)

  Changed paths:
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: remove the old wrapper API

Replace API bt_rap_set_conn_handle with
bt_rap_set_conn_hndl which has extra parameter
to avoid compilation error for individual patches


Compare: https://github.com/bluez/bluez/compare/bff7ad1e29b4%5E...cccd993d1349

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
