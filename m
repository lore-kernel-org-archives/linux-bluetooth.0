Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45176291C19
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736652; cv=none; b=tQDBRAMpeePy0B3/uS7YKsJq1UQ9Me2cHzKiVp6JM+oYD4B8wp8qfFdqFdPDPnKNUFM+hspnC4LOzn8hxc4YtWbuL2vYDcRawP+7L2zxIq709d/XLvb5bYHW4whPX6ItdPArLQt9PEO9CPwrKekhVKxp+nrczCav3/3N2K4PknQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736652; c=relaxed/simple;
	bh=ooHIYbRA4zr/9NHzsXzxl/RBRmr35Wm3TO0Sfy8RTC8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RYpKqr/KRGbhasPzMgzBtHzHMrxJeuIu9fRGfpvyvGJzDV7RhUMgfwH6OPOkttFwU7ck6LubTaXhZYD849MbPYVg0ZSGYotR6+2EWSyj8yGsJ2zeIY+NTPwAyzRBsNa8PyuXmvGLgMbc6WiKN3187gkZ2+BUTYimJBXdxMk/sQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QuOm1aJ/; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QuOm1aJ/"
Received: from github.com (hubbernetes-node-3495d80.ac4-iad.github.net [10.52.181.49])
	by smtp.github.com (Postfix) with ESMTPA id 84AEF4011E6
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 06:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763736649;
	bh=3apZ6AnXyrVMVwVAuBnSC9dUxigOQHjd8RDkR18cXVI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QuOm1aJ/LnURuaAtrNAspF2ylfi8fcnkbJ5Pe3KfFzQoTNETCscgJpbMHR+4gDWNd
	 /IrmESGyZoxBhCnsLSzQeSnRIGZtWROziKSrV9qeLGxvAwHmNi2ypX9PWxIK6go0wO
	 yaJYwO8R3crEw/GdobTEbzUd2kucAPajoatlIVks=
Date: Fri, 21 Nov 2025 06:50:49 -0800
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ae5473-f6f6ab@github.com>
Subject: [bluez/bluez] b528ac: build: Add 6lowpan-tester binary to ignore list
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
  Commit: b528acaa45abf3681127c8dacb31fc57e9c2a57f
      https://github.com/bluez/bluez/commit/b528acaa45abf3681127c8dacb31fc57e9c2a57f
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2025-11-21 (Fri, 21 Nov 2025)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  build: Add 6lowpan-tester binary to ignore list


  Commit: f6f6abf8d5ccf3c4bc42cf578c4ef7ab6c2ec9d9
      https://github.com/bluez/bluez/commit/f6f6abf8d5ccf3c4bc42cf578c4ef7ab6c2ec9d9
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2025-11-21 (Fri, 21 Nov 2025)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.85


Compare: https://github.com/bluez/bluez/compare/ae54731047cd...f6f6abf8d5cc

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
