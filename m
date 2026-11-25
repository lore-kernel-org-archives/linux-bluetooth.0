Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641133;
	b=ahH/fjLyOCOItboC3Ln9ic+87wJhTYH8IfvPhLStV55cXq/w5C4u0r6vBrvGZ1a8mzJs
	 aqYNrVDF/uHjfjwhZvkSPPowcptkE4vHxGqu43orFIJnly4nXAHVIRjLbS/VdYoQlzvfE
	 g8tNBqjLuV3QD6Su5cKRDgOgoWOLxBnKkT0mPF2uFCJBodIprBZs87TtZbrOyCQYU55T1
	 ptkyxy7qrZAn7t2yvk/i/c8Ul41uULzVFWrVGMJ3oAUmIavxmWGV6+UVBeBW/IN90BeMJ
	 1U0/LCwNfGAsWz4sXYq9kmYm5dgLJXh0+L8V7hKFJ8TYvem37Odda8VAVJ5pZK6AI2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iPcUpTbAheyWu1PDmQsTPJ2jxhnUOGlZsVTSC1jFIuE=;
	b=uPSITnPDPHPwkMijDBuuE7URhwb0CrlEmlRzdR8Kg6r9sIXY7D+a/N5UXR2x9CsRrjre
	 +/tJ8k8HJj9xGujWy29E1Hb8XHBIsWvZxoEjhW488sO97Tn9+sIp5zAkNEIc8xabBBu+l
	 U5Z4AE6+ymrNfX6FNTvYQJkxu6FOmpccFBf7YrNZNTQScs3KEFC6EO9DrSlQTLc99XvLF
	 4oorkRtStpCqb71sMSIIU4pJyQS45bjY6C2HdJ5Nbwu2ADH3qig8pyubZD1+Nqi46UhrZ
	 xbKFnB6/waBD3b8dIH06IbeHpvRoKDjXl7ZoFn5Mf+aOg7Gy+KOBlqwUNbwmb79d5Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=igMTbLSG;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396A606A338
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2396A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=igMTbLSG
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ec690faf85so2217062e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641132; x=1796245932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPcUpTbAheyWu1PDmQsTPJ2jxhnUOGlZsVTSC1jFIuE=;
        b=igMTbLSGPFxK52MtP4ijeA+OixGUJAAqKG4/E1/7/klsYU6iEUxcAQ0d1SOmthmeH0
         ov7qtJ+hy99PhJNNKR3+WJLzIt/K+gQ+uO+HRh3oBhGm/mrDqPffGij0tyC5A/fKwULN
         yc//FYfexL3PJZadMReIzxy1ZGbUp55hUjmZ0AZzw6LsGQbndL06c5kkOpqZghsfVU+g
         +eD+ntI52QwRvuy4ZXUTDGxoQJqM1zNbH52LlX+FFqcbpZNq2L/RcDkaoE7IO2MRoTAn
         AkjJzaL5R66NJ63nChpHAEFaOEw6n5WD4ttVRb1eVCTzeANr7IlW2V2Z6aBPSs3XCjTN
         OSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641132; x=1796245932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iPcUpTbAheyWu1PDmQsTPJ2jxhnUOGlZsVTSC1jFIuE=;
        b=oezNZNM56/XEM+DKXECBY2VTjID59Vwhuo+mcqWWZH3VAD+5UQArLjL9y63+4dbuOp
         NyyPUA/gR+QQGHiaXKuMB+R5HEzHPvBtyCgxZXsizFe1zX8xW3LJvQW/Y2kx1Eh79N3x
         iUufi8q3QrcH+ppqIlIStBRr91TUsA00OJv6P3uufmU+g8H2dyjnmNu9tHlCXmTy38nt
         ykzUe1q0eudW4K7rJzAnNc+MLvL9Jb9J94K3sVY4O4WrWEdojhsNvwLf4S95y0jZ5x//
         fivwDH73CqEZqF32dI+i3Hq9sktpCvBUIqd7zviWIFWGkls+sIJiE7WJffsmrCY2e4Ci
         Dvhw==
X-Gm-Message-State: APuU4Z+gdqvVhodgZlsl/uDkXHdt2W8xfKXZYD/vSC+oyEIAh1X0NV15
	JDJWWomFhHl1f/dKByA14Plz7v+o9qAHckSk13Svjw4hs5vjjPvPOf51jr8pOA==
X-Gm-Gg: AZFdTZe4oEd0JfaIPuiHTJycIsuK6+5aaZDnyYOIX2rfHHf0CIoY6WgqvbT1vEftT8t
	zAWM2ex9uboXI3SXbzM0ANJDD0rL5JGMpc5Gul1mnqiHBveSfRrof0Yte9erceB4RK432cSWtce
	cJh0QoNmp72CyY1uOUqvXNernLp8PvXszKGk6S3Px+wmf140NeFD/4ddSGZ4XCnMNBJivNgBgex
	5zau7ppfoPTIGev0nFauYKbD5zydLSFnOX9zagKK1o2YrjOx6fpCLo9gIlDUPE6ZVFnqlBgT4Sz
	ELzijQ5pENDb8PYeGK9FmPH1yB51DS7S48phWRKVodBmgVO7EKeHnml4st6qwnkHVu9j6W8Nwq+
	LxNEsBdQU4b4EOiIt8FtcEoYjIkKoD/MU2Zks/tU+kKfrIb3kT14Lis3YMFMFxeh7UU2kQmDh/f
	6CPhb6mhIQ25xzeLH/FEtXcfdZnepe1CHXjza/hl9VHZtqin1Micqe/hHOXZBMawUbuTXg7j0uO
	kGjexsr7a1qs3p7tzPXyLdp1P9VC/Tu5t3gPVQUikUZYLhcTkDamcZyUkHPeO4OXeLNm0FCcCPL
	ts44Sbgv7/Ukam9sMjzdaYWbUUHfq7QNC81W4nOu1ndhObhZEmpq5HtexcUW7KJu3ro/9bgDS0O
	U8oHkm5F3WK43Rw/N3ZZeWDD0E7r2c0TaFf7psvl3Nj0cJdzYh8No8Og1YkiQq511JKrgLutKj1
	hHiVA=
X-Received: by 2002:a05:6122:338d:b0:5ec:1996:43e5 with SMTP id 71dfb90a1353d-5ee8af210b7mr10900222e0c.14.1795641131952;
        Wed, 25 Nov 2026 13:12:11 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b556db7sm18316369e0c.4.2026.11.25.13.12.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:12:11 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 0/4] L2CAP: Fix channels being established with insufficient security
Date: Wed, 25 Nov 2026 16:12:06 -0500
Message-ID: <20261125211210.1955598-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

l2cap_security_cfm() lowers the security level of a channel to the one
of the link when encryption completes, and accepts channels waiting for
the security to be met as long as the status is success, so a channel
can end up established, or be offered to a listener using
BT_DEFER_SETUP, over a link that doesn't meet the security level it
requires, e.g. if the peer disables encryption while the channel waits
for userspace to authorize it.

The first two patches fix the handling of Enhanced Credit Based requests
when only some of their channels are refused, e.g. when the listener
limits the number of channels: the response accepts the channels that
were authorized instead of rejecting all of them, and the socket of a
refused channel is no longer leaked. The refusal done by the third patch
relies on them.

The third patch makes l2cap_security_cfm() compare the security level
of the link with the one required by the channel, which is now kept
apart from the one of the link in min_sec_level: encryption completing
below it is a downgrade, so the channel is no longer lowered to match
it but disconnected, or refused if it was still pending, and the link is
disconnected if the channel is a fixed one since it can't be
disconnected at L2CAP. Channels waiting to be accepted or started only
proceed if the link is encrypted and meets their security level, and
deferred LE and Enhanced Credit Based channels are refused when
userspace authorizes them if it no longer does.

The fourth patch makes a BR/EDR channel visible to the listener only
once it is offered to it, after the security is met, instead of as soon
as the connection request is responded as pending, so a listener that
accepts without waiting to be notified can't authorize a connection
while authentication is still pending.

Tests for both are sent to the BlueZ mailing list as "[PATCH BlueZ v4
0/5] Add tests for security of deferred setup".

A channel requiring a security level that pairing can't provide, e.g.
BT_SECURITY_HIGH when the IO capability is NoInputNoOutput, is now
refused instead of being connected with the security level the link
ended up with.

v7:
 - Add a patch fixing the response to an Enhanced Credit Based request
   rejecting all of its channels, including the ones accepted, when only
   some of them are refused.
 - Add a patch fixing the socket of a refused Enhanced Credit Based
   channel being leaked when the others of the request are still pending.
 - Authentication completing before encryption is enabled is not
   considered encryption being disabled: channels in BT_CONNECT and
   BT_CONNECT2 wait for it, and fixed channels are not disconnected.
 - Also refuse outgoing channels in BT_CONNECT on a downgrade when the
   connection request was already sent.
 - Restore the security level requirement of a channel if setting it
   with BT_SECURITY fails.
v6:
 - Evaluate the requirement of the channel in l2cap_security_cfm() after
   taking chan->lock, since it can be changed by setsockopt() meanwhile.
 - Treat encryption being disabled as a downgrade for fixed channels,
   since l2cap_check_encryption() doesn't handle them, and don't resume
   channels the link doesn't meet the security level of.
 - Also refuse outgoing channels in BT_CONNECT on a downgrade.
 - Close a deferred channel refused when userspace authorizes it with the
   channel kept locked, so it can't be authorized by another thread
   meanwhile.
v5:
 - Require the link to be encrypted for channels above
   BT_SECURITY_LOW, since the security level of the link is updated when
   authentication completes, before encryption is enabled.
 - Disconnect the link if a fixed channel is downgraded no matter its
   state, so one still waiting for security doesn't bypass it.
 - Keep the security level required by a channel in min_sec_level
   instead of comparing with sec_level, which follows the one of the
   link, so channels that only asked for BT_SECURITY_LOW, like SMP, are
   not considered downgraded when the link is paired again with a lower
   security level.
 - Refuse deferred LE Credit Based and Enhanced Credit Based channels
   when userspace authorizes them if the link doesn't meet their
   security level, instead of closing them from l2cap_security_cfm(),
   since rejecting an Enhanced Credit Based channel deletes the others
   of the same request.
 - Refuse deferred LE Credit Based channels in l2cap_security_cfm() when
   the link doesn't meet their security level.
v4:
 - Disconnect the link instead of the channel if a fixed channel is
   downgraded, since it can't be disconnected at L2CAP.
 - Call chan->ops->close() when a channel was deleted by the downgrade,
   so its socket is not leaked, and also refuse deferred LE Credit
   Based channels in BT_CONNECT2.
 - Only start channels in BT_CONNECT if the link meets their security
   level.
v3:
 - Don't use l2cap_chan_check_security(), which may start
   authentication or encryption, compare the security levels instead.
 - Treat encryption completing below the security level of a channel as
   a downgrade and disconnect it instead of lowering its security
   level.
 - Only let accept() return children in BT_CONNECT2, as
   bt_accept_poll() does.
v2:
 - Drop BT_SK_ACCEPTED and the changes to l2cap_sock_defer().
 - Add the second patch for listeners accepting while the security is
   still pending.

Luiz Augusto von Dentz (3):
  Bluetooth: L2CAP: Fix rejecting all Enhanced Credit channels if one is
    refused
  Bluetooth: L2CAP: Fix leaking the socket of refused Enhanced Credit
    channels
  Bluetooth: L2CAP: Don't offer deferred channels before security is met

Mohammed Alquraini (1):
  Bluetooth: L2CAP: Fix accepting channels with insufficient security

 include/net/bluetooth/l2cap.h |   7 ++
 net/bluetooth/af_bluetooth.c  |   6 +-
 net/bluetooth/l2cap_core.c    | 204 +++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    |  54 +++++++--
 net/bluetooth/rfcomm/core.c   |   1 +
 5 files changed, 246 insertions(+), 26 deletions(-)

-- 
2.56.0

