Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D81DA60F
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069778; cv=none; b=JdjEIKlG8WZ8FyXEg//amRcmepFx8cZV/Y7Oz33TvW/sx2sc2tvlQPkHFoKya7987c2gEXkg8lIB2JHULe5P49L9ddhOP9Je/29vyLw64JNXnTczkfFZHRDGsTeRN/l9N2Nad0C4eyHnXot05g407sK9+SVQDaIUspWvqH1S/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069778; c=relaxed/simple;
	bh=6+t5hzzX9M4QJj4mXylT+5ZtorGZnOpqwT3/5CZw7LE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gX5II26AGXWpM8vmBA6PqBAQlMK6icZAhUcJJNbcgtPcteRwtLKR65BLTrzvjIjw5yENhLXO08epTBCt9w/ILoRbuybt/Xu5SY6eUIGrzNdQgVPwB+RDA3uG7Jx1Qvf577/bdfWdAPijQIi2ZL8LRL6FWQr3sGicmopMDGpzdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KmkYXv/E; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KmkYXv/E"
Received: from github.com (hubbernetes-node-4c2b199.ash1-iad.github.net [10.56.154.40])
	by smtp.github.com (Postfix) with ESMTPA id 735D0921263
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 06:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766069776;
	bh=IizF86ZYtlawOzPbBtmz2x87v15YN/eQ9urDaxO0FO8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KmkYXv/EO8YIGkp3Tx+v2JRpdtI0s8IABgeDTewG1nPEXSB16G5uOuRi9k4u55GPN
	 ecvFvwXMe+/aNu96qOtXs79KhDKIufV6HzNI4SiJPj6W+dnF+gu+DMPxjqlZYZPG0q
	 JUkZbrYqLZ8Yr6Os/Ssf6Kigm4zuT9WVSX1/pN8s=
Date: Thu, 18 Dec 2025 06:56:16 -0800
From: ssorensenroku <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ba4978-2edcad@github.com>
Subject: [bluez/bluez] 063db0: doc: Sync default system parameter list with
 kernel
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 063db049ba2941606c647acb0928bc35b4d86230
      https://github.com/bluez/bluez/commit/063db049ba2941606c647acb0928b=
c35b4d86230
  Author: Stefan S=C3=B8rensen <ssorensen@roku.com>
  Date:   2025-12-18 (Thu, 18 Dec 2025)

  Changed paths:
    M doc/mgmt.rst

  Log Message:
  -----------
  doc: Sync default system parameter list with kernel

Add the LE interleave scan default system parameters that were never
added to the documentation.


  Commit: 5e5b46c5c0ccec25034e56c730e4d8ec719d60f0
      https://github.com/bluez/bluez/commit/5e5b46c5c0ccec25034e56c730e4d=
8ec719d60f0
  Author: Stefan S=C3=B8rensen <ssorensen@roku.com>
  Date:   2025-12-18 (Thu, 18 Dec 2025)

  Changed paths:
    M src/adapter.c
    M src/shared/mgmt.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  adapter: Do not send empty default system parameter list

If we have no default system parameters to set, bail out without
sending the empty list to the kernel just to get an error back.


  Commit: 111b6ca368d118c228e06118493c6bada5c734a4
      https://github.com/bluez/bluez/commit/111b6ca368d118c228e06118493c6=
bada5c734a4
  Author: Stefan S=C3=B8rensen <ssorensen@roku.com>
  Date:   2025-12-18 (Thu, 18 Dec 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Decode MGMT read/set default system parameters

Add decoding of the payload of the Read Default System Configuration
and Set Default System Configuration MGMT commands and replies:

@ MGMT Command: Set Default System Configuration (0x004c) plen 15
        BR/EDR Page Timeout: 200
        BR/EDR Min Sniff Interval: 50
        BR/EDR Max Sniff Interval: 200


  Commit: 2edcad4c4312166ca2aab0566c1bd1f442b109a4
      https://github.com/bluez/bluez/commit/2edcad4c4312166ca2aab0566c1bd=
1f442b109a4
  Author: Stefan S=C3=B8rensen <ssorensen@roku.com>
  Date:   2025-12-18 (Thu, 18 Dec 2025)

  Changed paths:
    M doc/mgmt.rst
    M monitor/packet.c
    M src/adapter.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main: Add BR.IdleTimeout option

This option sets the idle timeout for BR/EDR connections, allowing
them to switch into SNIFF mode after a period with no data traffic.


Compare: https://github.com/bluez/bluez/compare/ba4978255c3c...2edcad4c43=
12

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
