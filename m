Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD019C556
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749753712; cv=none; b=LCiNplHZ4/WdVpAnYuQBtKAf3LnfVfAB1JSX5iJ6qBoJFQqlwhfaaw8RIsRziAPKLKCyEAUxmG6Eu+Gh9Uebvc6SHLMkj8WxQHF5/0uUMNx5jCR+SuNv6ruWj4HhsjIny47DmaMoAal6FwdkZLqKTCCIWklroThPekoQ95DR3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749753712; c=relaxed/simple;
	bh=fgIqSoHMLNDKXitMj2HoV925QhnIeALjlOpSNUG7mvs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RAQtL8x5x0tWD7kYZBoGEEk2C9Swbwjko1nBXcCPZParkGQpKS5dQ1CkKUxW4NuHYnNSPGXu94qyVQJ/URAK3uLkAK06jdzUvwKs1jXrP3h3K6knSkNLB2fJa+KWF1swLFHq9ww8URXF8SuReacCTbGqnJP+ufa3dOhQRZYgic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KiEhRY1o; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KiEhRY1o"
Received: from github.com (hubbernetes-node-576f47a.ash1-iad.github.net [10.56.202.38])
	by smtp.github.com (Postfix) with ESMTPA id 4B638600838
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749753710;
	bh=urfgTE5hyzjbpNEJQWDRcdH1ZCRAAqvDfzahOXAuet8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KiEhRY1oCuC/1rTOAK0GIb32JsR7lRt1QJQQzz8Jx69pZQsq4C/ROx6c/WcZ2bhmC
	 Jq1ERhT1W8PFmj1Yt4h9bMJHj6eLQcmJGYGzgrxNbvpeNGolzqVcMwxBgvagVqKGYz
	 O3Ghu74tj5YNcigKekeppVJg/XPKqnF1c5jWuSqI=
Date: Thu, 12 Jun 2025 11:41:50 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/971489/000000-1464b4@github.com>
Subject: [bluez/bluez] 1464b4: shared/bap: Use read long procedure with PAC
 Sink/...
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

  Branch: refs/heads/971489
  Home:   https://github.com/bluez/bluez
  Commit: 1464b49457b3cbc969f87c0e817df86ca956785a
      https://github.com/bluez/bluez/commit/1464b49457b3cbc969f87c0e817df86ca956785a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-12 (Thu, 12 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Use read long procedure with PAC Sink/Source

Since the PAC records is not of a fixed size and can spam into more data
than it fits in a single MTU it shall be read with
bt_gatt_client_read_long_value otherwise the record maybe truncated.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
