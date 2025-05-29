Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5263647
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748547372; cv=none; b=ikZUJcRZwHzJn2pQ1eUJN/tg7xlD3dR/1B1gdIyZd4hRfGwV5sdyUBh7KDwWYw+BchQ9HiP4EDMmd7aq0N55DSN07ugDC9c6K5G0qIyDecjyew1G/NQ2sodVfcOCz6dLMJ6Al9XBzOlvcX2eI2lCqmCwYwiw9BeyOe/V8pK2LBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748547372; c=relaxed/simple;
	bh=Cl5f7+V6/TptMj3zlz5KHebtZm9NyJonx8JvpBWvZlc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qa+1o3kjV1+xEBaz8sqBYMTWfqCb2Wim2dZCRLDi1/pTsbTwxssWXT6L8NY57ejVqY+8STIqwIXrrZ+iEiMS5yceD6GLwD+NLf2k5vlwipnKZNTBWGnP4nRGeq9ccVijGsc7DpcBNQT2lrrG/08kk7k7FMBDo0i3vcx/SkO1e/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=b8uWt2VM; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="b8uWt2VM"
Received: from github.com (hubbernetes-node-e8a60f3.ac4-iad.github.net [10.52.158.15])
	by smtp.github.com (Postfix) with ESMTPA id D967B20834
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748547368;
	bh=wFDO0rP4lG6ot3yD0dOzRKW1zevFcV3bB83ybHGJz1M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=b8uWt2VM8LssDxWz/L7pW+xHBmKT/G710UgLUDyOEVzdgjq63QQvNUITsjPo/XGV5
	 JZR+ftBMt9tnNleZrFYnx+fXFsigWZYazOJEkNCfb/Ufj67HyWxJ0xooxwjgIq0zp6
	 zwVPyZ/zFZvZ09wtlsAyGa0fAAL8SFf2B1ZgeP1Y=
Date: Thu, 29 May 2025 12:36:08 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/760c6c-aed494@github.com>
Subject: [bluez/bluez] 5ad6ec: bass: Fix not using SID from BT_BASS_ADD_SRC
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
  Commit: 5ad6ec151c61d3a573362cd33414ba4d6ffa9695
      https://github.com/bluez/bluez/commit/5ad6ec151c61d3a573362cd33414ba4d6ffa9695
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-29 (Thu, 29 May 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix not using SID from BT_BASS_ADD_SRC

BT_BASS_ADD_SRC command does actually have the SID of the broadcast
source which must be set otherwise the kernel would assume it to be
0x00 which may not always be the case.

Fixes: https://github.com/bluez/bluez/issues/1282


  Commit: a805bae3dbc2ad62292780f3f11c32d77e5210e7
      https://github.com/bluez/bluez/commit/a805bae3dbc2ad62292780f3f11c32d77e5210e7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-29 (Thu, 29 May 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix not setting SID for assistant objects

The assistant objects shall contain the SID so it can properly be sent
with MediaAssistant.Push/BT_BASS_ADD_SRC.


  Commit: aed4948cd3c072fb2f8dada49c41f59882ad3a06
      https://github.com/bluez/bluez/commit/aed4948cd3c072fb2f8dada49c41f59882ad3a06
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-29 (Thu, 29 May 2025)

  Changed paths:
    M doc/org.bluez.MediaAssistant.rst
    M profiles/audio/bass.c

  Log Message:
  -----------
  MediaAssistant: Refactor object path

This includes the SID as part of the object path, also rework the order
of order of the terms to first show the device object path and later the
broadcast source address so device_get_path can be used instead of doing
another conversion.


Compare: https://github.com/bluez/bluez/compare/760c6c2ec14a...aed4948cd3c0

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
