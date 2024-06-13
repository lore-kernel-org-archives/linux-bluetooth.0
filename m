Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC07E796
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314571; cv=none; b=nRKvTuOWGZXVxV0VZF3VCksk4iDGtPrNtjlMOcXTQQqwvTe86jTDkWROzJSJvWhMVcaYlY/Uqd/9mJ/drj1ixGXZFLg2HZw3PlttDcAcZk/Pv6ygGXZYAstTOc5VzPFcITKdJcRjIG5z7k8cIHmxesRmwmNn36P9Y+10uinN494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314571; c=relaxed/simple;
	bh=1KNPVMrYrpIK0Bh7GX9/7pZYgI0MM95TKTFSQM4JKuE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JmkvS+pZZb99lsYxiSElw4xwdDpUZL4yDfmQHcU1KzMfo7mL7ql5Wo7AYLCv+qq5Ze1dS5aSWg0F5qke/Zi0ZjiNntoViWeQa10LnP/6uY3469tpv4/iGJ8IP6G362XtPdlw08LLMNPZlRBXev/N6NiM9ACZOu/KtUkoMhWTJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CHmDXgjM; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CHmDXgjM"
Received: from github.com (hubbernetes-node-1ee83c3.ash1-iad.github.net [10.56.179.10])
	by smtp.github.com (Postfix) with ESMTPA id DD3C76C10F3
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1718314568;
	bh=tQHoODm7s77D+vEbJyzLu7EUDzhnfHD7nIb0jdOpBMg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CHmDXgjMjdeIV1aUyHMqLecom9MtHRoJ3IC4YLVKKicuYR8M+lgdRpgldF+OzkzWs
	 VfjM5rcRzgjqnNf2TokAfnbTJnqp2EE31MJQm9VMXnRDBD8LyagOT2dgbkX639R1Uw
	 cOLR+rbXVTL8SXT9d/+fynQGPv43a9tGSpLm7hxA=
Date: Thu, 13 Jun 2024 14:36:08 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/792cff-0b0237@github.com>
Subject: [bluez/bluez] 98676d: device: Fix storing conn parameters without
 first ...
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
  Commit: 98676d410bde71425e4d56cf7e29b4757fb0c97c
      https://github.com/bluez/bluez/commit/98676d410bde71425e4d56cf7e29b4757fb0c97c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-13 (Thu, 13 Jun 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix storing conn parameters without first attempting to use them

Some controller seems to have problems to use connections parameters
that comes from PPCP as seem bellow, so instead of storing the
parameters immediately this wait the MGMT_EV_NEW_CONN_PARAM to confirm
the connection parameters are save to be stored:

< HCI Command: LE Extended Create Connection (0x08|0x0043) plen 42
        Filter policy: Accept list is not used (0x00)
        Own address type: Public (0x00)
        Peer address type: Random (0x01)
        Peer address: FE:D5:D9:EC:AB:99 (Static)
        Initiating PHYs: 0x03
        Entry 0: LE 1M
          Scan interval: 60.000 msec (0x0060)
          Scan window: 60.000 msec (0x0060)
          Min connection interval: 7.50 msec (0x0006)
          Max connection interval: 4000.00 msec (0x0c80)
          Connection latency: 0 (0x0000)
          Supervision timeout: 5000 msec (0x01f4)
          Min connection length: 0.000 msec (0x0000)
          Max connection length: 0.000 msec (0x0000)
        Entry 1: LE 2M
          Scan interval: 60.000 msec (0x0060)
          Scan window: 60.000 msec (0x0060)
          Min connection interval: 7.50 msec (0x0006)
          Max connection interval: 4000.00 msec (0x0c80)
          Connection latency: 0 (0x0000)
          Supervision timeout: 5000 msec (0x01f4)
          Min connection length: 0.000 msec (0x0000)
          Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4
      LE Extended Create Connection (0x08|0x0043) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)

Fixes: https://github.com/bluez/bluez/issues/876


  Commit: 0b02371e2b15295d45bf2c8bf7faf39ce48d6953
      https://github.com/bluez/bluez/commit/0b02371e2b15295d45bf2c8bf7faf39ce48d6953
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-13 (Thu, 13 Jun 2024)

  Changed paths:
    M profiles/gap/gas.c

  Log Message:
  -----------
  gas: Fix default PPCP connection intervals

If the remove sets 0xffff switch to using 30-50ms as that is the
recommended values for GAP as 7.5ms-4s seems to be causing problems on
some controllers.


Compare: https://github.com/bluez/bluez/compare/792cffb4992d...0b02371e2b15

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
