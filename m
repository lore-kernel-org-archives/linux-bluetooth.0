Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624042;
	b=ttwF0anSBA/OdnqWtunyMRnJlywZUQ+lKoxLCHZxVuP65FEPQIZ+oNHXfcdnYxn3qYYY
	 mlEPuoiWGCpw2sr3HXWntOTmERqm5g6DGWwPKHIWHAN/EtVUx4+ZfXRHcVZbunytWvu0O
	 NLYy92Cvc+NXLo6OgPPjryab79AjKErQJG032qdzlAUPcdt7xPH4nqrOBGbYwXkh7+tfb
	 RKNufIs5dy0WfzBKAEfBpKnMWIuLKl0zUR5JMiFH/uJ5Fp66SVGAc6OxG3E7pFrjuL48G
	 RRb8kXKImQFF3HWjEnVqHs3dhQe8vsWy9KHG+VFMbDctSUZ/eA1d8NZXjDyqEqyMfKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qeTcQ3BugGGevST7GUA8qz/Ew21bmYCOH4sal6YvUEY=;
	b=XuKglNlAEdBTPN2rgHllmQSmQ/1S57FXK0sVjw7tCz7JW5NzBFBHo/8CdLkzrlA9S+gI
	 hTRnb0VXKL+cnoX+igLtUufVtFiByZpLtrDm9qd/Kw528TKugMB6WFasgMGqUWyJf/kKl
	 olDyQ1pFzSede3WrXpI027qa8q+sbnWV0PobOLnu7lm8H4+EyZSMmNnyjnZon9ittjRjZ
	 v3T5dwOJjFKWy6QcTpObR4TM95qiO+NfgMMEMwEGl6X/RszuLmCkK7g8GU0QXC8LXtEqD
	 BW6Ueef81WxfcbPc2JK9THEnCc4UhDltQ+vD6H35Kcjo4zC70ldv36qqZQH83Y3n6xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dh148AJV;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772FB606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 772FB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dh148AJV
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9908c849564so1659533241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795624041; x=1796228841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qeTcQ3BugGGevST7GUA8qz/Ew21bmYCOH4sal6YvUEY=;
        b=Dh148AJVxkvJn4XAx++kjoxlw4y7qF1cWs6c3KUioU0NGIb3q+qKN/dlwxDrMKbHte
         ZjKT24rZWEMOlpDCtkTknueGA0moS/McvteyEKM6mPybg3bV3md9RIT+Ze4vbiyUsPFZ
         Bq3q/201z1z1Yeq2Hyvu1/Et5pjrpPE8Js4OfgmYagF0YebVsz297LcC3DBadbudyHcN
         Fme67UwkXZCuW7BccB+q2pryMxXJ7A0lJviJ1pegt150V1uLutAWmH1SVcR26glSHwW2
         6URNp3SST1trnAvV1XB0pNZLzp+XjgIqPZB1aoDzPYvxIeeX+ID0txv4jGASqt/ZyeZd
         jHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624041; x=1796228841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qeTcQ3BugGGevST7GUA8qz/Ew21bmYCOH4sal6YvUEY=;
        b=u/n9flVoNgXkDz7CPGd1mF5nDPjM84d1rV3bHG0Xvd4eX86hP1sNBM+ajxjvozpNm6
         TZr+peBYQqnNhKxtDrIklxG/WYJcxoqVawMJbHCKciP6LzWEfiCCGe21HVZE4hf2cRVa
         9hlp87+WCvkP6MYGGxJuVUBQndo2bPmOwitBZamDR0h/r9wiS5dQ1CUAFvaCQClKBsyI
         q8BdcHoiA8XS5K3y3FBX0G9ND4ETnBVcpbKKerXvderPBJ81teg1yVJ0seZWsPHlWaUy
         eDzpFUlcLINgPso2w9xMkIlDRZg1CN09gTPHO8y1oxVmQzt38WYwvBdIp/V5CacR1pRb
         DZ/g==
X-Gm-Message-State: APuU4Z9W/RERfXYDs3LWrkOFIoGV8CQ0CmmVeeUiozWy2LUzDBtcHtRI
	tYMiTThIbwZwtzkdILP0O75iGctkb/6H3/3ta1cgJ1unqmPRR7c4NRAYQnn5mA==
X-Gm-Gg: AZFdTZefBH4GcB9YVTS13W9AtlMYV1gDVP2ccj9LpKDC3zAmZMORhdTqfOonfORFWJY
	pWfzJ5fmOSncXtd2QQ3M0FoLHQ/hsRywbgiBF9sx1xRcgZh2eSeGzm+CDyw66ovmQozHuiImMc1
	KwW7DYHFYsEWYBMXdIYxVqfzejw7W3Ehzex1ApE/rdwbuKSg9xufPQqQNHHRRkZPBQ0lpHKld66
	O8QRhTLltXS2B8P2G8jMdGyQGdvkcznVyActWe604D/7PuWjuF+mo3wHhbrVdF/mmxNvHFbfL3g
	Ir8f+7fGPFIw0YMAb5SJmax3jKiPbmGznJxsK9hrBaiq96LSh0qt718JEhXToDKQvA5sdrzu4hN
	JbKORxIpmk/uZT4UR10FXHQkVl3HMtXSm63g7+JG/8ae3vb64Kni9L/bphlp5ZeyzCEtfWNuMrm
	QL4J69oxCVsFzUexKAfJRkanSfvTjHcux+PbP6URWw9dvCrqOLwpy+rjNzymDyUZrrm4i1yRfCL
	hUzufuY0OgWtPbC0N7cLm9ZPHMkelGVzIx1JW4BOiVXumReZkqEuL+ngSufVrPxRP1apUdMorH2
	ZL+E/wIWe7qLweNtAZ4azW6/kBcN56RBRV0XZlpF/aNXYmoUT3VX9Q/7mr4b8hCbmkWawXHIQV0
	oVBJ1ZOqPNkTntVHJ6v0lfzqJnzvXT8TwNsTxXcjw7KYUdKrV0BsTWEfRNUSJu6kZSKLvwjFsKa
	8hUPc=
X-Received: by 2002:a67:e112:0:b0:7cc:2152:4f88 with SMTP id ada2fe7eead31-7d7395cc4f9mr7391279137.21.1795624041255;
        Wed, 25 Nov 2026 08:27:21 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e8265e55sm19511881137.11.2026.11.25.08.27.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:27:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 0/2] L2CAP: Fix channels being established with insufficient security
Date: Wed, 25 Nov 2026 11:27:17 -0500
Message-ID: <20261125162719.1407771-1-luiz.dentz@gmail.com>
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

The first patch makes l2cap_security_cfm() compare the security level
of the link with the one required by the channel, which is now kept
apart from the one of the link in min_sec_level: encryption completing
below it is a downgrade, so the channel is no longer lowered to match
it but disconnected, or refused if it was still pending, and the link is
disconnected if the channel is a fixed one since it can't be
disconnected at L2CAP. Channels waiting to be accepted or started only
proceed if the link is encrypted and meets their security level, and
deferred LE and Enhanced Credit Based channels are refused when
userspace authorizes them if it no longer does.

The second patch makes a BR/EDR channel visible to the listener only
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

Luiz Augusto von Dentz (1):
  Bluetooth: L2CAP: Don't offer deferred channels before security is met

Mohammed Alquraini (1):
  Bluetooth: L2CAP: Fix accepting channels with insufficient security

 include/net/bluetooth/l2cap.h |  6 +++
 net/bluetooth/af_bluetooth.c  |  6 ++-
 net/bluetooth/l2cap_core.c    | 83 ++++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    | 43 ++++++++++++++----
 net/bluetooth/rfcomm/core.c   |  1 +
 5 files changed, 124 insertions(+), 15 deletions(-)

-- 
2.56.0

