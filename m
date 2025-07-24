Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539072737EF
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389620; cv=none; b=W1scZbeh7yozo0nYexP7H7RlwKQc1+SKFaBuFYpbjr2wif+VOfZUfw2tm6uS1nEB4ba6HvYSq+Iry68VDAnE3RAz4aMql7zQMiJRuw7cGLGwxGczZF2DpzQlr5TqpB4wOeQ2ziSNYx0oyXXwW4EWJsuyRhpxz6CDNr5lTyd2eho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389620; c=relaxed/simple;
	bh=Vh3oVX6FrY+yupc+OMJbFeV5zTeZyvtR4kgrB0Kb0LE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i6HBAx1bUvqbOy62XLEDIv4CMgq2Tg02lQ2hBKvKniockbCNDQHKjt9wC/UUYWQi573QogfC57VTqkvu/DFKa1XrCn8MgzZWtQ15t3YuxrHqcMmdns88NhLV7IvCUXs+HU/ahl83+Es4WmT8dQE6g4yaASEUvI3dZmGZ0I66Hr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HU/KNnLV; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HU/KNnLV"
Received: from github.com (hubbernetes-node-e6a734c.ash1-iad.github.net [10.56.188.43])
	by smtp.github.com (Postfix) with ESMTPA id 40A9D9212A2
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753389617;
	bh=QMwc+RtkJeu4ZcO7R3x24x7DHXQK2oLAQi/yWu9ukIM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HU/KNnLV9rmE5r3psRD5UbNpHGJXCPDCpyBFPLEmpgyb4fn7ddA+bFIbUMKqwzuLd
	 Yqa/1BWifOBd48qE2vrwvKguoZ2xGpobGgb86K2m/9/2gmpp59SS0j1jkZeos+MqZQ
	 GsA/4kwqFMEHA/kcukkF93tnc7o4R0XuVDneQX1U=
Date: Thu, 24 Jul 2025 13:40:17 -0700
From: Yao Zi <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/cd1314-da772d@github.com>
Subject: [bluez/bluez] da772d: client/mgmt: Print UUID and flags when showing
 exp...
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
  Commit: da772d62b295acbca12823c7e6e45534220f9c87
      https://github.com/bluez/bluez/commit/da772d62b295acbca12823c7e6e45534220f9c87
  Author: Yao Zi <ziyao@disroot.org>
  Date:   2025-07-24 (Thu, 24 Jul 2025)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Print UUID and flags when showing experimental features

Command expinfo in mgmt menu queries experimental features from kernel
with MGMT_OP_READ_EXP_FEATURES_INFO. However, currently only the number
of experimental features are shown,

	> expinfo
	Global
	        Number of experimental features: 1
	Primary controller (hci0)
	        Number of experimental features: 4

and lacking of details makes the command less useful. To ease debug,
this patch introduces extra output for the expinfo command, showing UUID
and flags of experimental features as well. A typical output will look
like,

	> expinfo
	Global
	        Number of experimental features: 1
	        6fbaf188-05e0-496a-9885-d6ddfdb4e03e (flags 0x0000)
	Primary controller (hci0)
	        Number of experimental features: 4
	        671b10b5-42c0-4696-9227-eb28d1b049d6 (flags 0x0000)
	        330859bc-7506-492d-9370-9a6f0614037f (flags 0x0000)
	        6fbaf188-05e0-496a-9885-d6ddfdb4e03e (flags 0x0000)
	        2ce463d7-7a03-4d8d-bf05-5f24e8f36e76 (flags 0x0000)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
