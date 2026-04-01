Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF5224D6
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775073484; cv=none; b=fQ4y5H5t0Hm2PB0EZRheokW7zIjS51/ZyHRpzrwkOR62UjphBNz93P9BSdza3Pct4ejufCoipqeqrPj1yENNXwa883A68t1gS6etgeOBVWLYiDJeB6BemEpqZtMgtN4K0NJNA+munp/ogA53954U/QpdDRtuLmeetWV6ix84wwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775073484; c=relaxed/simple;
	bh=7+Gebn64lelFvTN+Xf7CJU9m43+k/Bx+0Gm1S12kGRY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qCIyjerOCJ3AETo14DfgY6PtA9qUSCV+OVICztoaInS+OEPFC6raYB6a0tZCpyfGYiqTLKBQysWbyxtH9Rb3j8fB3eWzWhQcJJRbFV2HdeexM18HtN49H6h70dORYq5ThtZWo+HgHAgOyIx/teOIrpAjzQaj6GFP5eod5Bnw8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EoS1QMUk; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EoS1QMUk"
Received: from github.com (hubbernetes-node-b0c5c78.ac4-iad.github.net [10.52.223.29])
	by smtp.github.com (Postfix) with ESMTPA id 6BDE5300C65
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775073482;
	bh=UBub+OV+th5dU61EEYe91bBY82/C1hU2igAdOy8MPTw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EoS1QMUkNZiv+uNXqEOHD2ygM4edzsqmgtH6HEIitVHbxf3agLDr25Qa+hJoQDW6f
	 8ISiVKsJu0nQZ7DBCLq67+6Xbiwm7/ddjtqOB4Vt70QpjcF95eUjzk87rSpuPmZKsi
	 mMHYDKHwHusJt5cl+CSq+xsvBRcgYRtl8dPpqU4A=
Date: Wed, 01 Apr 2026 12:58:02 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076017/000000-17e787@github.com>
Subject: [bluez/bluez] 17e787: doc/btmon: Add Channel Sounding protocol flow
 docu...
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

  Branch: refs/heads/1076017
  Home:   https://github.com/bluez/bluez
  Commit: 17e787538712cddfa378a4fe6a3eb6fa40c3cfd2
      https://github.com/bluez/bluez/commit/17e787538712cddfa378a4fe6a3eb6fa40c3cfd2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-01 (Wed, 01 Apr 2026)

  Changed paths:
    A doc/btmon-cs.rst

  Log Message:
  -----------
  doc/btmon: Add Channel Sounding protocol flow documentation

Add btmon-cs.rst documenting the complete CS protocol flow as seen
in btmon traces.  Covers capability exchange, security enable,
configuration, procedure parameters, enable/disable, subevent
results with all four step modes (Mode 0-3), result status fields,
FAE table exchange, channel classification, CS test mode, the
typical setup sequence, and common issues.

This provides LLM context so automated trace analysis can correctly
interpret CS distance measurement sessions.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
