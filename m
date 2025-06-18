Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716C28E7
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750217708; cv=none; b=PFTuhMdM8m1OWS49kvDLtkBLF2jn/s/XxiELfPxB3W8SIpoYCEq7iDe8MSgXioq1sjzDXwUwkQkzZ3ZkqI1fIOucZv1xuftJMb35wU1MUSSxoRGbkOuQ1VjvqO2Nfp/nxlIsDX+ckZqT1IDQeQvbnZ5acwJPtKojflIDWO1xVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750217708; c=relaxed/simple;
	bh=78ez0AmHA7vmkcLPb2i/VdJFqVBBQaLPqrkXqPlPWSU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qqsTIRQZ6p8x7Gbt5A7pzQ0Wv1uBDh1IgJtfTm7Hcjh+vS0+GRSSw3JwtBEg7CHoKZM/RSRFVWg4TaRad72M85r8OlsyOJ9SSLWtADs6e66VO7lsagy0CJKYWy0Es02mZiNr6ZhUw+QKBm4ZKScJbrxPXDFn4DTJz8b/wm2MQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I25BGcHg; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I25BGcHg"
Received: from github.com (hubbernetes-node-45e1b05.ac4-iad.github.net [10.52.202.113])
	by smtp.github.com (Postfix) with ESMTPA id DB19664082F
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 20:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750217705;
	bh=GBZH/XvsuF7g5brxRksbW+j+IlSyqHs5czS4ADnZlDw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I25BGcHgQ21c4oSefiPwA5v07UCB6MMI2/fpiZypUJr5E5LpXrRGkrzjawDj0gdSE
	 Us//v2D87tPEQs44fUnrUQBVh/gbpD6WYmoR0w7FFIswgns1XtUSxnm/zwcR/l0eSQ
	 sEIU0E9hBGD3EvuMl1BxtnZlBbw1yjTof8RhOYN0=
Date: Tue, 17 Jun 2025 20:35:05 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973184/000000-d8b0b4@github.com>
Subject: [bluez/bluez] d8b0b4: device: Add bearer info to
 Connected/Disconnected ...
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

  Branch: refs/heads/973184
  Home:   https://github.com/bluez/bluez
  Commit: d8b0b486b9130d257c21e7ffc0c6085df09e153e
      https://github.com/bluez/bluez/commit/d8b0b486b9130d257c21e7ffc0c6085df09e153e
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-06-18 (Wed, 18 Jun 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c

  Log Message:
  -----------
  device: Add bearer info to Connected/Disconnected signals

This patch add a new Connected(string bearer) signal to indicate which transport
(LE or BR/EDR) has connected. Also extend the Disconnected signal to include
a bearer argument.

This allows applications to distinguish transport-specific connection
events in dual-mode scenarios.

Fixes: https://github.com/bluez/bluez/issues/1350

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
