Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF212F3614
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 05:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005862; cv=none; b=Na0z6IQcYdfcoU7uzmFWFZG3f+aaDTFIwbieG4lJstGOwThod6eudtTozuDuVYACrciW7MSyIzB1CYJqd0W/V04xjk2VSJmpG7RCyIqGeZfaq1Fz9ECPI8+HVEB+9uoBuEJFECm+PHzEKRbkaRZpxLtmILS/jIZGI1H0aWfVMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005862; c=relaxed/simple;
	bh=Xz7X8711h/1Ae8kR/p3Xa//fGTnSLLQ29GHD42NZZYI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aSVk7Z9r2KIuzK1cVsSSjuF0k41PoKs4px798ShUVfTtTfwYTqQBlyAA5i00FIAVKnlqnR+s/U+cz4NnU89tkROMVb+m17D+xuAmKE6WMa5v5CLdyvUkFnO6Km326HzMls9ez5+yb2b9EaL4clwPXy2/2YH5m7sIqTahz0+nRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eIDbfLQu; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eIDbfLQu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784005857;
	bh=zenjLYA6F3kjHMRBi199vyNtC4jQ1rlr8HwKOQNTd0o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eIDbfLQuDTbp2sC46fDotRM3Rb3PaNlirFLZuhWLyY06+O07hDAT9SrkxS0s6vGGw
	 bDrfETAqUwVzgRlGIIvzkIc/4X2nVsOqcLxYZDe2RQUgVz+3DCV3xhXhnN74NqjA9f
	 QDMDwF4qrSXBtKxAFO2fSlMoBXV588bvQacEir6g=
Received: from github.com (hubbernetes-node-edd395b.ash1-iad.github.net [10.56.80.32])
	by smtp.github.com (Postfix) with ESMTPA id C821C520C7F
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 22:10:57 -0700 (PDT)
Date: Mon, 13 Jul 2026 22:10:57 -0700
From: caitao123456789 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1127021/000000-a894f3@github.com>
Subject: [bluez/bluez] a894f3: src/device: Add ConnectedUUIDs property
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

  Branch: refs/heads/1127021
  Home:   https://github.com/bluez/bluez
  Commit: a894f3be27a14a32c3b846242d196be5808e83c4
      https://github.com/bluez/bluez/commit/a894f3be27a14a32c3b846242d196be5808e83c4
  Author: caitao <caitao@kylinos.cn>
  Date:   2026-07-14 (Tue, 14 Jul 2026)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c

  Log Message:
  -----------
  src/device: Add ConnectedUUIDs property

Add a new D-Bus property "ConnectedUUIDs" (array of strings, read-only)
to the org.bluez.Device interface. This property tracks the UUIDs of
profiles that are currently connected on the device.

The property is updated dynamically when a service state changes to
CONNECTED or DISCONNECTED.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
