Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40C1DB546
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746476459; cv=none; b=UasS3PDbobbOAOPrcn5okaiDIEXLTariFQF+T7j5+XD3qUgqMlZLrQNW7OLKA6n8/Kkj3Li5iUQR4SFFzLQJhkC4ve4XJLA4cVIsdPDZTxkW2Qpz9Vrn9xic/G3Mj87fi+jeHBAQZCvBWBDGlxHwmnJDo4BCWlNyWBNh2ALMHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746476459; c=relaxed/simple;
	bh=fGUNthi6Aq6zP5wlLouQ5M3ZKV1BoAINTbUE55OY9jw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cba1WRhuQgS6BaJEgXETguyLHhbLZ5uvtoqpY86JQA+1an1JEV4if2GH5w0xVxoLDMZgkgs3KV3PxQPFdtAD/xNmbA71Lj7hHYYD4nSuRBZQ/hJb3aR/qfsA/JQRKs3HM1+9XhfFfEK7gYiRvTWd8uAV2GuIG8PsIoC2oDQTdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=litt5oFL; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="litt5oFL"
Received: from github.com (hubbernetes-node-c1fc992.ash1-iad.github.net [10.56.173.14])
	by smtp.github.com (Postfix) with ESMTPA id 24036600511
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746476457;
	bh=gi6tiBQ9PHRneInyJlrMSxrA3FxtRzG/ZvimjHtlkwo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=litt5oFLF3IvRaXXV/D6JWgNgLRUIzNqGK/WGmlR3+0Uo9m7W0nCpjBETIwAUvaEM
	 c1DilGazn7sJJzqI9zzpCKPOmE7hHck/sJ/8SaM/pjOCZnMlZp8TRnh6XWefzZ1F5v
	 iDxnEzQYdvSNHaJ90dttrSn0IF1gUqRQgKFp+228=
Date: Mon, 05 May 2025 13:20:57 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0831bd-4bbfd9@github.com>
Subject: [bluez/bluez] 6b9dff: shared/vcp: use iov_pull in input parsing
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
  Commit: 6b9dff8fe39671037cafcc8b7f76ee3383355115
      https://github.com/bluez/bluez/commit/6b9dff8fe39671037cafcc8b7f76ee3383355115
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: use iov_pull in input parsing

Check input is right size by using iov_pull* when parsing.

Also replace custom iov_pull_mem by equivalent util_iov_pull_mem, and
add iov_pull_string.

Fixes handling of zero-length string-valued descriptors, !value is not
error.

Fixes crashes like:

ERROR: AddressSanitizer: stack-buffer-overflow
WRITE of size 3 at 0x7b878bb77161 thread T0
    #0 0x7f878eee4821 in memcpy
    #1 0x0000009544d4 in read_aics_aud_ip_type src/shared/vcp.c:2713
    #2 0x000000950cec in vcp_pending_complete src/shared/vcp.c:2394
    #3 0x00000088b2ce in read_cb src/shared/gatt-client.c:2717


  Commit: 4bbfd9712857d4983593df23b82eb599907e6a69
      https://github.com/bluez/bluez/commit/4bbfd9712857d4983593df23b82eb599907e6a69
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix handling of ASCS_Codec_Config

The codec under bt_ascs_config is in little endian which may differ
from the native endianness when it comes to vendor specific field that
are multibyte causing the following error:

BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS] - setup complete
BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS] - run
...
 bt_gatt_server:src/shared/gatt-server.c:write_cb() Write Cmd - handle: 0x0022
 bt_bap:src/shared/bap.c:ascs_ase_cp_write() Codec Config
 bt_bap:src/shared/bap.c:ascs_config() codec 0xff phy 0x02 latency 2
 bt_bap:src/shared/bap.c:ep_config() ep 0x21d6600 id 0x01 dir 0x01
 handle 0x0022 len 5
 test-bap: > 1b 22 00 01 01 01 09 01             ."......
 test-bap: ! 1b 22 00 01 01 01 00 00             ."......


Compare: https://github.com/bluez/bluez/compare/0831bd39a0bd...4bbfd9712857

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
