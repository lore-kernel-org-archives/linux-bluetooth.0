Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542082580F2
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329376; cv=none; b=UhoIx80nr/+KNVZsKcbAEhnCpYky1EKx/jflG8Hb0dXJgG8awOkgEJPu5z2hxwJoNturBFSuJdAGzkxDm0ytQgVSsmWWTB/HAwOb8S3fj2pdWHotSvgEXa4Osc9/u2okkeHsLXEPBQfBuQ3iSOh1Csnxm/scOZgtF9Zh+SQ1AdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329376; c=relaxed/simple;
	bh=ETEHjY10t+k5WpVverVgSCK470oBhq4dnBWRVZG0E90=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=O1SFXLLpBYdj4+Cu0IsdPuz/ZMfO9u0285Mz7w7wcJmtkipOVXZSlk1WpjBa7ihUErOiYJhX7kOgvu4zCwlrT2HhED11DiyDZMPyF5abJN0THxcKeCHPHR3HZ54Nq8ZJBbdwBquiuztEQuzCf1PeXeb7fsoqPnyTPjy4tfmmDvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K0UT2fHZ; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K0UT2fHZ"
Received: from github.com (hubbernetes-node-2101ae3.ash1-iad.github.net [10.56.203.97])
	by smtp.github.com (Postfix) with ESMTPA id 148D26013F1
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759329374;
	bh=qqHdAVpgFg2UC35plJxeX62nE3ogWclhvAkB9TiN2s8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K0UT2fHZ+tbzqtut1K9laWvBgOfDp2pS4pQnLdkU7fPVeJEDfsIR8DyLO5jQU5Ciu
	 R2YgNOBeCNAiEJmYEPXNuw4pCLGIYjQAAx3FEsE6ZrvprEKvaj80GLvWBaFCuZFSMs
	 fxTUbANtogcQTSIRRNPgx60nLgnaoQMZmZi0bmB0=
Date: Wed, 01 Oct 2025 07:36:14 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1007714/000000-0166cf@github.com>
Subject: [bluez/bluez] b8773f: device: Fix privacy
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

  Branch: refs/heads/1007714
  Home:   https://github.com/bluez/bluez
  Commit: b8773f54572fda61a982b430329db5457487aa3f
      https://github.com/bluez/bluez/commit/b8773f54572fda61a982b430329db5457487aa3f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-01 (Wed, 01 Oct 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Fix privacy

In order for devices to properly be programmed into the adapter
resolving list they need to set the flag DEVICE_FLAG_ADDRESS_RESOLUTION
but that is only done if device_address_is_private return true but
currently it doesn't check the rpa flag which indicates that the address
has been updated to its identity.

While at it this also update the rpa flag to privacy to better indicate
the feature rather than just the address type and then introduces
device_set_privacy/device_get_privacy and replaces the usage of
device_address_is_private with device_get_privacy whenever the features
itself needs to be checked, rather than the current address type in use.

Fixes: https://github.com/bluez/bluez/issues/1079


  Commit: 0166cf546ce875525f695d179c29427dac131e95
      https://github.com/bluez/bluez/commit/0166cf546ce875525f695d179c29427dac131e95
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-01 (Wed, 01 Oct 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  core: Fix not resolving addresses

When using the likes of btd_adapter_get_device the address can sometimes
be the so called RPA which needs to be resolved in order to avoid
creating duplicated objects of the same device.

Note that normally the RPA are resolved in the kernel but there are
instances like BASS Add Source that may attempt to add a device direcly,
bypassing the GAP layer.


Compare: https://github.com/bluez/bluez/compare/b8773f54572f%5E...0166cf546ce8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
