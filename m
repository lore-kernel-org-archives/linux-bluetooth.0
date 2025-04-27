Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283F2C9D
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745753377; cv=none; b=V3QPCULlr1VYTOp8d5fvM4Lotm2M91Vg2/9HkbDEzFGyeRBBCu8xgElL3I0PaRGSp8hhL+P9pv2AXqzi8i3gbuNnGntQrkr5OQZMdlPBJFQerDeKZPYfUwNa3+XImYX5tNbx17BRseG0EC1Ck0VLu0AG1wW+lievKFtXMVxaXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745753377; c=relaxed/simple;
	bh=iAQRlfCvW8boSfxOXxH39mdKXTaBjzMmXz8PMzn6nM4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MMLpubD1I8YoUrZ2lJiNvQrgmFHauTeRrJb78u1mxbPeAViZfBED5kfjk3FyQOekhoJSs5HasrcPwyEUIh8rloDd5B/3K3Ki2GSWBEm/yHqu5Y7OuVcQbxehDwFRPUg7LUzppuMRr+o1atxXWtGuDtuj6osY4kM2O+e8qd9G0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VEfnE4Hx; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VEfnE4Hx"
Received: from github.com (hubbernetes-node-ec6cc48.va3-iad.github.net [10.48.14.74])
	by smtp.github.com (Postfix) with ESMTPA id 993574E05E9
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 04:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745753375;
	bh=3mb0ojvDpp6DTjPl9cTmt47X8y2P0ZctcdL9OgEL3R0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VEfnE4HxUmQrEaP2Tk/lbQkA9IIp/OGAuLLizz/1/PQRjRfop5/o6y0RZ0sRUAm1v
	 HaYUiRSFzeRkoxEAEvppeB3b4S+b6CZTKwbzzJiEchzvnHwmzwJsJt/q9NgnKHVzK3
	 jD9YgZPkd/OHaa/fXGbl0bU/1HDCDsZcpW2CmaN0=
Date: Sun, 27 Apr 2025 04:29:35 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957489/000000-a4923e@github.com>
Subject: [bluez/bluez] a4923e: tools: add tests for SIOCETHTOOL
 ETHTOOL_GET_TS_INFO
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

  Branch: refs/heads/957489
  Home:   https://github.com/bluez/bluez
  Commit: a4923e8b08a6f5be892d866e32144204eaeb6cee
      https://github.com/bluez/bluez/commit/a4923e8b08a6f5be892d866e32144204eaeb6cee
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-27 (Sun, 27 Apr 2025)

  Changed paths:
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/sco-tester.c
    M tools/tester.h

  Log Message:
  -----------
  tools: add tests for SIOCETHTOOL ETHTOOL_GET_TS_INFO

Add tests for obtaining timestamping capabilities via ethtool ioctl:

L2CAP BR/EDR Ethtool Get Ts Info - Success
L2CAP LE Ethtool Get Ts Info - Success
SCO Ethtool Get Ts Info - Success
SCO Ethtool Get Ts Info No Flowctl - Success
ISO Ethtool Get Ts Info - Success



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
