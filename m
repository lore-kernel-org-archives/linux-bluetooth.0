Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B6B3876A9
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605816; cv=none; b=Pa5SWcITMvt3tbDu6fs5+lC9ISs8x8WkTu3n052Haoy7ilNWJ0vj2qGRTZwsdaXoIWOk+Y+V3WKn/plRnkEsaPUe938OAk5j3IacAHMpp+jd+D8RxtSpATD6kitGx0PfDwRFnSIE5ZfxAuwuwoVkbt/lfmTQZu0R1kIX9KAFHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605816; c=relaxed/simple;
	bh=rRL1birAPEpp2uAEAHroVxxTdUKbsHvcddFSWZzOG8M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AcGnm58L/yd8mNrQcquv3/wBt5fFjN7QH6a4GMt6zJipPhywP+Cm4IQI7Xga1ONF4ndF3y9CS/0/2OUkxR0a7SDSm4jORQEjNQY++z0MP6wEnzFKOlNwoYEznmJL243hYaxM8FuTzZxc6qGPxm75x/RpFsdGTKT87hVTA6FfShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QUwaIp1P; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QUwaIp1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783605814;
	bh=qh1wOFWyj9xRAfWIglRceW9XsnGsujg0Nn+cuVLHh44=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QUwaIp1P8qLvrnSG92XW4/gJ6QtHEtAp6/CqnrecwCBNDfwF1CQXug6uVStUwToCQ
	 T3ii3Ho/Uh9NGR9ikxU2v9N4y6qH0f6rVOUlHFPUyfC8UPclsuaC3UQEd9rYRJqRam
	 jyCz9tjxDOm+dAKzRpHsOu4tmnSoAneGC2sTCyIA=
Received: from github.com (hubbernetes-node-bd2b122.va3-iad.github.net [10.48.148.41])
	by smtp.github.com (Postfix) with ESMTPA id C2EBA18A251
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 07:03:34 -0700 (PDT)
Date: Thu, 09 Jul 2026 07:03:34 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1124699/000000-e22caf@github.com>
Subject: [bluez/bluez] a5bfcf: doc/org.bluez.ChannelSounding1:Add Used by
 referen...
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

  Branch: refs/heads/1124699
  Home:   https://github.com/bluez/bluez
  Commit: a5bfcfe1bfadf87701efa2494be8fe2e1eb4e9b9
      https://github.com/bluez/bluez/commit/a5bfcfe1bfadf87701efa2494be8fe2e1eb4e9b9
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-09 (Thu, 09 Jul 2026)

  Changed paths:
    A doc/org.bluez.ChannelSounding1.rst

  Log Message:
  -----------
  doc/org.bluez.ChannelSounding1:Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing corresponding bluetoothctl cs commands
for D-Bus methods


  Commit: db0165c75f0a4745380ebce18f045c8ffc7bdc27
      https://github.com/bluez/bluez/commit/db0165c75f0a4745380ebce18f045c8ffc7bdc27
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-09 (Thu, 09 Jul 2026)

  Changed paths:
    A doc/org.bluez.ChannelSoundingRanging1.rst

  Log Message:
  -----------
  doc/org.bluez.ChannelSoundingRanging1:Add references and examples

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing the corresponding bluetoothctl output
for the RangeEstimate signal


  Commit: e22caf30e15aa1baef7bdf45347f61f12cf15da0
      https://github.com/bluez/bluez/commit/e22caf30e15aa1baef7bdf45347f61f12cf15da0
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-09 (Thu, 09 Jul 2026)

  Changed paths:
    M Makefile.am
    A doc/bluetoothctl-cs.rst

  Log Message:
  -----------
  doc/bluetoothctl-cs: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


Compare: https://github.com/bluez/bluez/compare/a5bfcfe1bfad%5E...e22caf30e15a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
