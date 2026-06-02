Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5137475E
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424664; cv=none; b=A40memrtexm3vU/pas/D7mnJLpv/I+Jr2d5pcpAbtk6V/pRAXe0tI4HLVsiFxlWZ8js35HTbRMF03XGlI+6Df9vD6YCmCfETjQhBjw+Bm4tj8R87Ce45iomNKpciYHbEteEHbBoB3S4PcpNn+u+3pUVC/yUA/anOU8v0J3YTI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424664; c=relaxed/simple;
	bh=bOna7p8LOE0zl3PGZTNPNwCceS4PGb2QW3MXF/hRmPI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SQkvQ4oJl1L1h9jsAwMxtyW2yyRTh4zoBT9q380K54UyzYEnPwSGmTQ4KMsb+XX4wLAIURWaI9aQpiLtbp9h00P99He2pknS+wSkhSM/EIui3jjCAAGlvsvBRGAsugZTV6+rujqR8qSYa94tUTMQQ0W5/2xkd3DS/KltimMThgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lVtIIPPq; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lVtIIPPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780424662;
	bh=ZQxRV9Zz5yAJFath+vhqFAZ7bAOu2PEbidjUomuizFs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lVtIIPPql5QgWTNmCB2EhsBPugPuIctiEnJcJS8qU4ai7T/wKbWLEa54QY6Gt+ohp
	 2IRL/IORD5PM+Gg1CLihDySJgSXdZybFDkvRGosGkcXMQgcvIMrd19gRuDPxJdRbp5
	 0aKJH5AsVVvM8O8w14tt7rbuz2lF8HDk27elVLLk=
Received: from github.com (hubbernetes-node-c24ec1a.ac4-iad.github.net [10.55.96.36])
	by smtp.github.com (Postfix) with ESMTPA id 8D30032014C
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 11:24:22 -0700 (PDT)
Date: Tue, 02 Jun 2026 11:24:22 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1097183/05e977-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1097183
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
