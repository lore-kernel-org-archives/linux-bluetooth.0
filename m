Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16D8248C
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183504; cv=none; b=LGXQr60sMUWwrkzDkgrTHGvKYkqE75P7Muc9BCtzRIROupMfV1iwLcFRtSF2COZn+qYdOBkLeN6kSkjVYI3KLZb1AAppnzJ/EQ3GgqbQiRXOBV4FoRym44JuhFs+ox7RoVWhuSTAKZwkKolgMKhBlCOBJI/+aDMbBN9VQW77YsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183504; c=relaxed/simple;
	bh=80W7HckHjk9JPL7YdHAKlUrwhhR0y4SUdetHraQbI3A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JhiG/UCuixKB9AmN/XCLwuCznUsukiY+mcJrTdJKpm+tNl+t5ewDDBHrxU15CHFzV8wLBhMS2TMVMcehQJTrrHj1g8oOMrPv5R9jWcF4XJu54K7lPQkbSy926AtApbi3NEo0nIcgG70m8wdKVK5eQ/ufwHRjhY52H5ancJtl4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dhtevLKG; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dhtevLKG"
Received: from github.com (hubbernetes-node-dbc1788.ash1-iad.github.net [10.56.166.39])
	by smtp.github.com (Postfix) with ESMTPA id 8AF56920B86
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1743183501;
	bh=PPjrxozc0PT9FWo1J2Od35puWuf7kLfqq5nqJJQ9MkY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dhtevLKG8M40DNfuGOgnOAhZ9LcdmFqyoyq3QrB47hNWgAQu1nbhe3gvq/KUsRrVo
	 fts1ONHeAfLk4SD0iVVdC9ak85pFpZesgIvZ/6nojpBAuvY6Lix9pzfn/PSA9WXV9o
	 82/QegwM82JUlrd8KfeRs6CIVbdAiXPY4L/9jlKM=
Date: Fri, 28 Mar 2025 10:38:21 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5df952-78aabd@github.com>
Subject: [bluez/bluez] 8ebb0f: doc: Add initial SCO(7) documentation
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 8ebb0ff1178591e49b1a6f340c8b1f846824fa54
      https://github.com/bluez/bluez/commit/8ebb0ff1178591e49b1a6f340c8b1f846824fa54
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-27 (Thu, 27 Mar 2025)

  Changed paths:
    M Makefile.am
    A doc/sco.rst

  Log Message:
  -----------
  doc: Add initial SCO(7) documentation

This adds initial documentation for SCO sockets.


  Commit: 5bbefdcc9d2254b5a193c9361a44257d69e11246
      https://github.com/bluez/bluez/commit/5bbefdcc9d2254b5a193c9361a44257d69e11246
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-28 (Fri, 28 Mar 2025)

  Changed paths:
    M src/shared/att.c

  Log Message:
  -----------
  shared/att: Fix not always setting security for BT_ATT_LOCAL

Channels created with BT_ATT_LOCAL (socket pair) shall not be restricted
from downgrading the security level since its default security level is
BT_ATT_SECURITY_LOW and it may need to be switched to BT_ATT_SECURITY_AUTO.


  Commit: 78aabd896dbe3e23faaebbc97b8ecd711b2502fc
      https://github.com/bluez/bluez/commit/78aabd896dbe3e23faaebbc97b8ecd711b2502fc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-28 (Fri, 28 Mar 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M src/device.c

  Log Message:
  -----------
  a2dp: Fix removing local cache on restart

Endpoint cache shall only be removed when the device is being removed
not when just because the service is being removed since that is also
done when bluetoothd is being restarted.

Fixes: https://github.com/bluez/bluez/issues/1146


Compare: https://github.com/bluez/bluez/compare/5df9521ce4d5...78aabd896dbe

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
