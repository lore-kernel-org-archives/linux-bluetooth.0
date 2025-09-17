Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CA275B1F
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Sep 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115759; cv=none; b=O4fky99gQpZllPxXHc7JEnwdxLmhY5/P5Y8B1b0qVS2KG8EVJ3QIl5VQqasfhWB881Ky38DaJeubpLKi9myRKtctVyB4srETYkk/ooa3+ci+u8umcdRq464qxPjNIalcZcqx/1pqxiodiNz0PzgD66rD5ifh0hHkF3D8DF51X0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115759; c=relaxed/simple;
	bh=Ni39+iuj54kuAzF+hvYxmVnOWdhGtwaj9PnWd76pGUE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OMWxJjaSm+VoK7/69whS+20eaGpkna6OJ75rZ0+sZM58zFYg0p7pZti1WZJgnjD0ShPD3uXTDCoTbaWK8o+vRGLNW0mT6TKxEsyaaXFglmpUjx3HylyOdpoTEPfcp1LVTKemp4y2fxHXNDzT7kD0DRmXr+c6dqpPc2lGDu6du1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hwaqAq3p; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hwaqAq3p"
Received: from github.com (unknown [10.55.88.32])
	by smtp.github.com (Postfix) with ESMTPA id E16EB20C12
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Sep 2025 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758115756;
	bh=xzZAkg5Cqwk60Xkb4k1led74ahpzIuvMy5NaXooHcco=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hwaqAq3pl7jFpkZBHJKX1o1w30u6iHQHMz0csKpujjmqBnxW7NayIsBxewfuQNb53
	 CN7vqwAdZ52sN04YRuUN9pWKEoT7unJEv1C0xoihs0wtzbh21EHko4d195JQd3r0ab
	 ASioIxW+knz4QPQfnxVn64fNgulrQEEGuwDJtiSg=
Date: Wed, 17 Sep 2025 06:29:16 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4d7d25-c6dcf6@github.com>
Subject: [bluez/bluez] b8d3e4: shared/hfp: Add Operator name support
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
  Commit: b8d3e4c510b81e152f70618f17698329ebe48335
      https://github.com/bluez/bluez/commit/b8d3e4c510b81e152f70618f17698=
329ebe48335
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-15 (Mon, 15 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add Operator name support

Send AT+COPS=3D3,0 at the end of the SLC creation to set the format of
the operator selection to long alphanumeric, then query the currently
selected operator name from the AG.

Register +COPS handler to call the update_operator callback on event.


  Commit: fb32f3a27fbddabfa678c19f82297d7e4509c73c
      https://github.com/bluez/bluez/commit/fb32f3a27fbddabfa678c19f82297=
d7e4509c73c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-15 (Mon, 15 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Operator name test for HF

This add the following test:
- HFP/HF/PSI/BV-04-C
  Verify that the HF can query the currently selected operator name.

Improve MINIMAL_SLC_SESSION macro to be able to set the service, call,
callsetup and callheld indicators at connection time.


  Commit: 889139e0a1af317d0964b8ef989e974709ccff0f
      https://github.com/bluez/bluez/commit/889139e0a1af317d0964b8ef989e9=
74709ccff0f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-15 (Mon, 15 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add Call Line Identification support

Send AT+CLIP=3D1 at the end of the SLC creation to enable CLIP event.
Register +CLIP handler to call the update_call_line_id callback on event.=


During incoming call notifications, i.e. after +CIEV:<callsetup>,1
event which creates a new call object, the reception of +CLIP event
will update the line_id and type of the call object.


  Commit: 430b8b1b024b4f452aa1f641137c9b132c812435
      https://github.com/bluez/bluez/commit/430b8b1b024b4f452aa1f641137c9=
b132c812435
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-15 (Mon, 15 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Call Line Identification test for HF

This add the following test:
- HFP/HF/CLI/BV-01-C
  Verify that the HF receives the caller ID.


  Commit: c6dcf6b714501768ab7ea293e75d945be0eec188
      https://github.com/bluez/bluez/commit/c6dcf6b714501768ab7ea293e75d9=
45be0eec188
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-09-17 (Wed, 17 Sep 2025)

  Changed paths:
    M configure.ac
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix build with VCP support disabled

$ $ ./bootstrap-configure --enable-a2dp --enable-avrcp --enable-experimen=
tal --enable-asha --disable-vcp && make
[...]
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transpor=
t_bap_set_volume':
profiles/audio/transport.c:2275:(.text.transport_bap_set_volume+0x11): un=
defined reference to `bt_audio_vcp_set_volume'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transpor=
t_bap_get_volume':
profiles/audio/transport.c:2266:(.text.transport_bap_get_volume+0x9): und=
efined reference to `bt_audio_vcp_get_volume'

Reported-by: Arun Raghavan <arun@accosted.net>
Fixes: af8266af13c8 ("audio: connect VCP profile client to MediaTransport=
")


Compare: https://github.com/bluez/bluez/compare/4d7d25b70245...c6dcf6b714=
50

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
