Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D92726F2AF
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767646398; cv=none; b=cUAdMCxFAV1dUy1q43GhDisgbeJ8RCaAVAwtL3Gbod6XGd2RT8j+XG9wC7xaNyT4N1TuqwnqA/xtRPxiSrTv/v7OWrkYE4k1YrAuOP/78p4PPj4RPwacg6rJFCVb/XQ9DoKT11qpdWMVmDkceMZIiblNSV81zOTVChH4ltnwk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767646398; c=relaxed/simple;
	bh=quaxSjmbNP9IbOO7IFvyP+zvfXSdo0qQI+OPJ5N9kFg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Qs1/ybDuIK0Dv1ka8BxwzKdZaYjsqBc3ZevmdONGsbmjOKscnzdag8uDYTEFMF0x4IF7kSIz9wkECgiKWbNwfAmKxzRdfCmlUfVcLES4XDdaCP609FGgghcDjroeCv/GaZK0RWkMuh1MpG73IwLOtSojSdSbNxELyZHoc/NEmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IlmXT5pg; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IlmXT5pg"
Received: from github.com (hubbernetes-node-48d6f9b.va3-iad.github.net [10.48.14.47])
	by smtp.github.com (Postfix) with ESMTPA id 43957E0906
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 12:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767646396;
	bh=aNUI+N2gy+HkR34e9Y2n06wyiO/7C1xgShsRnElMB4g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IlmXT5pghKsqfx3qJeeSyoMVyKHM1JwbTUM9yeMA1Pb/kfWYDqVBkz3u4GpQdIbwm
	 Fdz9EutbOSIQ6VvehQebl0QQNGMvhLaO+Qg8+X/mdBFR24YqAGpakFswu769Ia+o6O
	 b1I3dIqrXg2uW17bqDb57TLIuwRjzmCIoX5Mpdl0=
Date: Mon, 05 Jan 2026 12:53:16 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c8fb53-b35b6b@github.com>
Subject: [bluez/bluez] 11b8db: monitor: Fix parsing of
 BT_HCI_CMD_LE_SET_CIG_PARAMS
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
  Commit: 11b8db231e52998b6c8467d28e4cb7a4ab1f53e0
      https://github.com/bluez/bluez/commit/11b8db231e52998b6c8467d28e4cb7a4ab1f53e0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-05 (Mon, 05 Jan 2026)

  Changed paths:
    M emulator/btdev.c
    M emulator/bthost.c
    M monitor/bt.h
    M monitor/ll.c
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix parsing of BT_HCI_CMD_LE_SET_CIG_PARAMS

The fields of BT_HCI_CMD_LE_SET_CIG_PARAMS are bitfields rather than
values, so this changes the fields to phy's' and fixes the parsing to
print it as bitfield rather than value.


  Commit: cfdda3b11ec2c9afa65341528b0207a47001dd1f
      https://github.com/bluez/bluez/commit/cfdda3b11ec2c9afa65341528b0207a47001dd1f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-05 (Mon, 05 Jan 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Fix using BT_HCI_CMD_LE_SET_CIG_PARAMS PHYs as values

BT_HCI_CMD_LE_SET_CIG_PARAMS PHYs are bitfield so they need to be
converted to values when emitting BT_HCI_EVT_LE_CIS_ESTABLISHED.


  Commit: b35b6befb12c91c1802d09208ea5a00f0b0bc614
      https://github.com/bluez/bluez/commit/b35b6befb12c91c1802d09208ea5a00f0b0bc614
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-05 (Mon, 05 Jan 2026)

  Changed paths:
    M emulator/btdev.c
    M emulator/bthost.c
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix parsing of BT_HCI_BIT_LE_CREATE_BIG

The PHY field of BT_HCI_BIT_LE_CREATE_BIG are bitfields rather than
a value, so this changes the fields to phy's' and fixes the parsing to
print it as bitfield rather than value and also make the emulator to
use bits_to_phy to convert when emitting the likes of
BT_HCI_EVT_LE_BIG_COMPLETE.


Compare: https://github.com/bluez/bluez/compare/c8fb53f49cc6...b35b6befb12c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
