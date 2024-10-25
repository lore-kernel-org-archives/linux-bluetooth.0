Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F01925AB
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885019; cv=none; b=LL+3tWjGhGUupCRRFIh8CJ+2Ek/PEdIaGuWz6tgCPAZp8bcXKuPHwVSlJDk5jeEXXkLhQxbfGS02hRyEE92JdJoxfEMd5EcEbyv4Jl93oVxr0jS9snx1Jk1Y0XSDFMO3Df8KQ4xfdOuTiepxe6hzeVlMY7WOLpNICRICpkQ0dPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885019; c=relaxed/simple;
	bh=Mb6Y7V4QRQEyqAE7HiKnF+KCl/HpUuxrkNLy7pkmcmU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HqEqqUwhO8THfdImyh9r9X0FrqnkAaIiY8WB5HyTvTgeCM9hEPk0Z/nwH6m+10rFBAunbJy+oRhgomNyGaQArX8j9OqRGzOgL38i/7m15ADMv/0rQVlT9RZC90txcWDGuosO0MB9nmBvwYcM/1Vcv0TwmyfLqc9a9+Mtrcv5K7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fb48jNmF; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fb48jNmF"
Received: from github.com (hubbernetes-node-0978f51.ac4-iad.github.net [10.52.152.31])
	by smtp.github.com (Postfix) with ESMTPA id 858D65E036B
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1729885016;
	bh=D7W0j8VPkrw+io3jO1BPsMDSn5HFfl7W7wDs/QyoNmY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fb48jNmFxl59TiSKZtCLw3dAlsHAiw15pwbJmM3m8j3p4ZKlCDE0nFFgJ3hazc/vG
	 8IVRo6JpNOM820qbZBHGS+T8kcYnYYTrIjJK01R3P3/+ejbmvHviy7o/mSWegnkhyO
	 XCZk5wsKyOu0F3XkOiMQP++Lvo3WqbCSw8dt4zN0=
Date: Fri, 25 Oct 2024 12:36:56 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/06c94f-8c8ca7@github.com>
Subject: [bluez/bluez] 36b262: transport: Send reply to select/unselect
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
  Commit: 36b26283cee31af9509ee372f9787f94830a85b7
      https://github.com/bluez/bluez/commit/36b26283cee31af9509ee372f9787f94830a85b7
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Send reply to select/unselect

When a transport is selected from bluetoothctl, a reply is expected.
Currently, if the method call is successful, no reply is sent, causing
the following error message in bluetoothctl:

transport.Failed to select: org.freedesktop.DBus.Error.NoReply

The same error can be reproduced for the unselect method.

This commit updates the select and unselect methods to send reply
messages.


  Commit: 8c8ca715e05fe8b8105a2646d87440e1271e6237
      https://github.com/bluez/bluez/commit/8c8ca715e05fe8b8105a2646d87440e1271e6237
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-25 (Fri, 25 Oct 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix select/unselect reply prints

This updates the shell print messages for the transport select/unselect
method replies. The bluetoothctl log below shows the fixed result:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
Capabilities:
  03 01 ff 00 02 02 03 05 04 1a 00 f0 00 02 03 01
Metadata:
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 17:7A:80:64:A7:93 17-7A-80-64-A7-93
[17-7A-80-64-A7-93]# [NEW] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# transport.select
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: broadcasting
[17-7A-80-64-A7-93]# Select successful
[17-7A-80-64-A7-93]# transport.unselect
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: idle
[17-7A-80-64-A7-93]# Unselect successful


Compare: https://github.com/bluez/bluez/compare/06c94f0ac055...8c8ca715e05f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
