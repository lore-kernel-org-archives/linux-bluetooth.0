Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E9375AAB
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982266; cv=none; b=gd3on7mXiHeRAnO3sPdbU487a5Bxsj1qgOmNt/oV6EcZbPljz710fZL3CDlmmUVVoH7JGPRxZprXRqi8Bz17redALPonDDj7OAABWvaMUYMS77YLR4qjbVGnzJbRXnIlHCVnGEm0QUMj3LZQ2U9UMcmelEsXYhhH7hCxCkTMaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982266; c=relaxed/simple;
	bh=+czFXgwEilSP7BTNNphnaVzoAjiui7DMsHbHPOqwiLs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Q/F2/qUAfJXRVvrdpYyYjJyi8lJmBCp2qQkuBgslMQ55SzT0Gnhh/B9q/bxkrwW4xTi8yK7xMNMEk8CWKty/hQjI0sci9Ea56c/W15CKNHi2nER69571ir1+41cCL5RWy3bTHsRbtJ+nPpJ+pVuelbScojqhBOjxXcpBAt64E5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jysuD+47; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jysuD+47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788982263;
	bh=PNHZarTu0jlPqKdjvmydpjAEOiCJr2f1lMqtSUZCz+8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jysuD+47SaFaf6JsWJOq+hZd+2en1IUTmkmcrWaELlOdVJPm0poqu26daeQihKdUh
	 X3VaAcALq+A0bkVGRt4DV1pHjIgqW2GJ3SXWcU5UJLfvmEdAGEsCrZy0A6wSHYZSyu
	 il/UpLitjYRCWsZa5h9XE7Iq6LYNnUnFkEyg7qfI=
Received: from github.com (hubbernetes-node-3762a99.ac4-iad.github.net [10.52.220.43])
	by smtp.github.com (Postfix) with ESMTPA id A9C5B4022A
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 12:31:03 -0700 (PDT)
Date: Wed, 09 Sep 2026 12:31:03 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/293eb9-19ebd6@github.com>
Subject: [bluez/bluez] 43c33b: monitor: Fix the LE event mask decoding to
 include...
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
  Commit: 43c33b9a411f072550ed0c34e205933b273ebbc6
      https://github.com/bluez/bluez/commit/43c33b9a411f072550ed0c34e205933b273ebbc6
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-09-09 (Wed, 09 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix the LE event mask decoding to include Bluetooth 6.3


  Commit: 2ef7a4b547eb2eebff836cecf254cc4483709875
      https://github.com/bluez/bluez/commit/2ef7a4b547eb2eebff836cecf254cc4483709875
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-09-09 (Wed, 09 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Show bit value when decoding LE supported states


  Commit: 19ebd6a2124de54fff5906d84e26cd5370937c54
      https://github.com/bluez/bluez/commit/19ebd6a2124de54fff5906d84e26cd5370937c54
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-09-09 (Wed, 09 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix the supported commands decoding of Bluetooth 6.3


Compare: https://github.com/bluez/bluez/compare/293eb98b4403...19ebd6a2124d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
