Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902AD1A0BF1
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420836; cv=none; b=El6UMhfTqr5djpksZc+xyIDsAa5gtLB8I7UZivnj2TSxWiucGSZSTKKh6TQBQ+JHOaI1d8Aeveqw6+8c8qGDb05kvKb9ePInXqwL/E5u74CQkPX4DS4VIpiI+lGN+QTmUrX/bdI9A2sZjsgZozcmTn4YtKrA99gC1/Ph4ULkVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420836; c=relaxed/simple;
	bh=Sw2hW75AGVid0kWO3J8E54DedVYzScQI8x1oxmgBfcw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aLfZZRwznmYA3hPubcoTUI5H+vwHvGEzt5Ob6Pb0qJV5uQAnUEFlNraS/aKt5/9SnDNgYZA76BSwxr7MYLwpwT1bRkVi1Q1rpKEVjIKALyD7Hcy+WlI/AS5FtJYS7LEmenBLbwJwIU0MjcsSBxw68NaZqw936XUEOGK60Ic7cjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z2dcwEH4; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z2dcwEH4"
Received: from github.com (hubbernetes-node-3780ffb.ash1-iad.github.net [10.56.15.56])
	by smtp.github.com (Postfix) with ESMTPA id 9DC3260137A
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747420834;
	bh=OvIxKO/SCBsuYmumyBivSibt+8/Y0tIudqc+adhlvz8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z2dcwEH4tDmU8TfLvmh67incEyOSDcgdBSPaAzzaggHSkDTxPNNGO50tKeCg1dbL5
	 qa774vCh2Rg60z0OxeUiSRbQXSwwEhk2Sjc+Olnl9EApxsT/dYXRm3P/0lV4tc0wzB
	 tYnDl1DL4n6W53b82z+wjevI4Hp3OptclCeHtnHA=
Date: Fri, 16 May 2025 11:40:34 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/963725/000000-a851eb@github.com>
Subject: [bluez/bluez] 800b67: org.bluez.Device: Add last-used option to
 Preferre...
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

  Branch: refs/heads/963725
  Home:   https://github.com/bluez/bluez
  Commit: 800b67f21c0b86bad6048d1524c3bf7d342821e4
      https://github.com/bluez/bluez/commit/800b67f21c0b86bad6048d1524c3bf7d342821e4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-16 (Fri, 16 May 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M doc/settings-storage.txt

  Log Message:
  -----------
  org.bluez.Device: Add last-used option to PreferredBearer

This adds last-used option to PreferredBearer which when set would
make Connect to use the last used bearer first.


  Commit: a851ebf39c6737f0b71e2ae18739c20f2aedca64
      https://github.com/bluez/bluez/commit/a851ebf39c6737f0b71e2ae18739c20f2aedca64
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-16 (Fri, 16 May 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Implement PreferredBearer=last-used

This implementas PreferredBearer=last-use which enables Device.Connect
to use last used bearer first.

Fixes: https://github.com/bluez/bluez/issues/986


Compare: https://github.com/bluez/bluez/compare/800b67f21c0b%5E...a851ebf39c67

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
