Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128232857CB
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722803; cv=none; b=Wp0uRySGTJ33lK1qxZ+X1uUv4qFnlepjOCwQUOAVqcD6zFZLj8FGLBx0IgUXxomNPFHw4ivb51ENy8/G3Ea9fqihTXJadJQLmog0BarT0Cv+1MMwZGGHYwUgRzcgQ9iSKlm00hVbqrhV0zGnvGXSy8YC4SCy0w1dKLb12+homyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722803; c=relaxed/simple;
	bh=sfrBCOPHk2U0EOPptpHPKnE/G5s5O4Flx9kQVR667wA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ayAdCQQz/dwn990Vm+cmlfRQg9T6c5CM0+gruAwbhUbfxVb2qIb4uZzCjYlR/ot0uHUzseZb3F62eNp+YG04qsRUbJBBhUrQgBe3am/WahZhmwGLjIADGunLYPQccorhT0gcncak+MU/wmK2Uq53inUWdUQKnTEQO9eJ8C/g3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZjxHAaNN; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZjxHAaNN"
Received: from github.com (hubbernetes-node-fcf6980.ash1-iad.github.net [10.56.128.52])
	by smtp.github.com (Postfix) with ESMTPA id 1A5456003CC
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755722801;
	bh=psPWZZY5iE/wrvUsEOS9N/11nJuzC9Qo9mPgb1Wn2Mc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZjxHAaNNQQrsdA3dYhbluOMbEFe9Ss6khoeAeaxK9JDou3mWBlwwoGHCWDc1jcDFw
	 E7//Gh4UZ9/k17EMtK5iri+0kHz8h9mAJwvPAqHgf9U+UBBysXu6zqMh7XDyhFWARW
	 GkDH5JO81BsL1wg1I4tB9Pz+nvzF531jBiua/fTo=
Date: Wed, 20 Aug 2025 13:46:41 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/993679/000000-ce1974@github.com>
Subject: [bluez/bluez] ce1974: monitor: Add support for -K/--kernel
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

  Branch: refs/heads/993679
  Home:   https://github.com/bluez/bluez
  Commit: ce19740c376f95c7670ea2f7df519a49c74624af
      https://github.com/bluez/bluez/commit/ce19740c376f95c7670ea2f7df519a49c74624af
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M monitor/btmon.rst
    M monitor/control.c
    M monitor/main.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add support for -K/--kernel

This adds support for -K/--kernel that open /proc/kmsg and attempts
to print messages starting with 'Bluetooth:':

> monitor/btmon -K
= Note: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
= Note: Bluetooth: BNEP filters: protocol multicast
= Note: Bluetooth: BNEP socket layer initialized
= Note: Bluetooth: MGMT ver 1.23
= Note: Bluetooth: RFCOMM TTY layer initialized
= Note: Bluetooth: RFCOMM socket layer initialized
= Note: Bluetooth: RFCOMM ver 1.11



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
