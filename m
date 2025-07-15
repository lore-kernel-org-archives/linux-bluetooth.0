Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8624677B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603970; cv=none; b=d80p656aWIvxOpvMjXDzS8exOUxr5tF4Xlg1jjPzxdDCTRi2iuPzVATq/6MYXJPMZAz7/AM9JmpZbxsgtKih6UBvuE/Vm1Of6dvJSvQhnyS4b402unHLHTzbPbwEZZEbyY3VJ9A+etaA5GusXKCdx61ramj6VGiLzBtcGvMJsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603970; c=relaxed/simple;
	bh=PLCZqSSzM2qrM96SAoIbw89RY45RI0XXFSemdGpMSyo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WIzeY492kjWtLgTw+QQIvHHnlk6sq6nNZ82E7dpF2DmGdaGiom88rxCVlMZ+iTINB7k4UmOEPHgZwy3viCQS4BGxVJEoIheiNk0UvoatG7byQrn1P4FDqHiEsvIk/ZlyX5LJOPxr//sKSAP0CLTFkkggH1hwyASVEqG/5Pr5nuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WV8wdWgs; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WV8wdWgs"
Received: from github.com (hubbernetes-node-66923d6.ac4-iad.github.net [10.52.147.35])
	by smtp.github.com (Postfix) with ESMTPA id 6758320B1B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752603968;
	bh=WM+PQXXbOqZbMmwQLjZ/4SQ1uNkQwv9rwTQKEf7kYRI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WV8wdWgshWHDNNw79pzgRpwKlqqqFqBtAEVWoR5lcecQJ4qTrE18owBB2rZx30Rwn
	 F57H5MiSwo3GkjWfDzTtgwtVEqxAEhHl9BMRz/8XdcLKQiSrsymGBIj1fFKQkrPohf
	 P4LP9cJFLV25vHUA8QeRhHoSpj1hho+pbxityefk=
Date: Tue, 15 Jul 2025 11:26:08 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6c3cc3-4c431e@github.com>
Subject: [bluez/bluez] f40602: device: Add btd_device_bdaddr_type_connected
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
  Commit: f406028b5d2e38e5510ffa8a28e875b72995a2b9
      https://github.com/bluez/bluez/commit/f406028b5d2e38e5510ffa8a28e875b72995a2b9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add btd_device_bdaddr_type_connected

This adds btd_device_bdaddr_type_connected which can return the
connected state based on the address type.


  Commit: 8c8b5ed25a88e33dc8a24ea73f95711cfbbfee0d
      https://github.com/bluez/bluez/commit/8c8b5ed25a88e33dc8a24ea73f95711cfbbfee0d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Bearer.BREDR.rst
    A doc/org.bluez.Bearer.LE.rst

  Log Message:
  -----------
  doc: Add org.bluez.Bearer.LE and org.bluez.Bearer.BREDR

This adds bearer specific interfaces so they can properly be operated
separately.

Fixes: https://github.com/bluez/bluez/issues/1350


  Commit: fdfaeddc9c71245228022de01b7e45cafaf8b8c1
      https://github.com/bluez/bluez/commit/fdfaeddc9c71245228022de01b7e45cafaf8b8c1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M Makefile.am
    A src/bearer.c
    A src/bearer.h
    M src/device.c

  Log Message:
  -----------
  bearer: Add initial implementation of org.bluez.Bearer.{BREDR, LE}

This adds initial implementation of org.bluez.Bearer{BREDR, LE}(5)
interfaces.


  Commit: f4f8fe3e4813170ab02762bd0951d6d9404dd0e5
      https://github.com/bluez/bluez/commit/f4f8fe3e4813170ab02762bd0951d6d9404dd0e5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Add support for org.bluez.Bearer.{BREDR, LE}1

This adds support for printing properties related to
org.bluez.Bearer.{BREDR, LE}1:

> info XX:XX:XX:XX:XX:XX
...
	BREDR.Paired: yes
	BREDR.Bonded: yes
	BREDR.Connected: no
	LE.Paired: yes
	LE.Bonded: yes
	LE.Connected: no
...
[CHG] BREDR XX:XX:XX:XX:XX:XX Connected: yes


  Commit: 4c431e5dae3e7cee4ce3d0720fefc530a2524e0b
      https://github.com/bluez/bluez/commit/4c431e5dae3e7cee4ce3d0720fefc530a2524e0b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Rework handling of Disconnected signal

Print with color the signal to indicate there is a change, also rework
the order of the parameters and use bearer specific suffix if the signal
comes from org.bluez.Bearer.*.


Compare: https://github.com/bluez/bluez/compare/6c3cc38da9dd...4c431e5dae3e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
