Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633141;
	b=fvXULpCaewK5rCjHfcfJe46a025mcUCbNCKdLZnDv0pg32h2SFSA+StUPXA4AI25l0G/
	 RmtHNew6C9+v3crJ1Q6bhXTYGUIlD1N3ZYw1F356C4oelBLBqCYSzGXRNXrmFUTM72sXy
	 ZDaZWygTgVyMaiYB5jkZd3W0MlueqliaoAoI55XHVOsIUw+QLhO/SHKIu1gRjDubEc7n6
	 bYUi+36FAmXxYOKWSIbP9D3Aa92QSLGP/8Qrb36Y3JLOpcfNGbk3gfUYvTtuJpPSfjVhg
	 T5OfOYtFEMNqKWO8MA5DN3Shteexp61leEIgEKXDdHANYFJ+5tsOIvg/y0FmYCDMtJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/2VIn1h8BBYQaXMkmox/NreCfQ8R7Nml7fz1sc0GVBM=;
	b=YO7eu5v9blKVWScieLRSKjk40ny03VYdTm2ThSrhNJ3kUQHRnYLHyUxhOXnQ5+xmrH3t
	 mdK9ZbaTWeF2RKPaPWxhacqyOaiPBPagwCOj1yu5x5WrWa7YkfHDl9AJ7q+PAcOCRc2Nv
	 THcg4yoXIgKy4FSsbG40Bc3KcemMeIXJflJGkhXTmt0q0fC4VvVZzdBAwmWRx3rcvRe4X
	 eP9F2YYGZaE+F3qvjsnYExXGg8usCzPhHnNTCsFps0scbxv2uAwrq7lVHERrTKdJzYsZi
	 kBttik1MtpVUMEJrjeHtDCJn6peKQu0Fp3ia0ulnq9mpsLPTXFxwAiMmbFb6AESl+Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vetsJ0/L";
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C185606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 18:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C185606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vetsJ0/L
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso2409427e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 10:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633140; x=1796237940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/2VIn1h8BBYQaXMkmox/NreCfQ8R7Nml7fz1sc0GVBM=;
        b=vetsJ0/L6vgMBYPfInG81tv+ZpPJj09eKRo6qrVQQ1xXeXc+0VcZw5wzVratWQpW0J
         9pQpDEAqB/GzxGeQnSVwWX826Up5voXRXRYlWdKI2PyFO8DBWFRn+V5xlP8JGoiUSNHQ
         jq/xO0Dr0GwhMoKehpweXRtT9Plel1V+5I1vSJRyAGVNt4bN6j3AKhAMTR8wl32Wx1in
         vrMQGuhCP4oJlGGWshzYmmUy+I/D9o3xzcO+/fYPmLwMsncbzFtMjf+qaAFi9JG8vJSp
         QtFztWBzNkSNkqBmpohOJcLjVZbZCvP519ic0OczSdF7lfmhVP+NfBbOLviLINy5SpQ3
         b0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633140; x=1796237940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/2VIn1h8BBYQaXMkmox/NreCfQ8R7Nml7fz1sc0GVBM=;
        b=cvVMD3lBa+t7EVZWdEH9e61lhQPbeCArpyR5PI09+l2V3CK8FuylLJVSvJMEvn9dN1
         QVBmvjBDbnXc882H6h/sdd/9kWZeQjEzLKanyuKvlW/NvjOkFDTv7yi5Zke9yAkWWJDf
         R3w1uqXQG6ZE1uPg4lVvIzO5RaBMPVbknBrwEPmue4t4I7Z+sGHn/MeSTGDqHxdlm4Oi
         ZKmvW7O/qxBE0VL58FtzVAW0iYg9bGDfE+sUuC/cwQsQGOTRnvuuVrKLqi50hc+AucYl
         nWNoCiyHPTNXyiKgglYPu9tksX6d78z32biycj9B4YDcCINKv2xwuD/yh6J6LyVA9WdY
         K/zw==
X-Gm-Message-State: APuU4Z83tHWSboLxbSvGfOa7ZicPY8+xI/RbpBZiyI9CvUIxm8LUCGrc
	T9CQ/nIJ8U45bbFkKxCWk6zvq1QbLws1QYhDbHzJ20vBQurqQ0DA0UyPnCQrEw==
X-Gm-Gg: AZFdTZd6PGW82xMc+lgO40I86JLf4jUjy1pF2x/7wiKYJI2n9Aef7/XJZCaaUHiq4zO
	6cbb+1yqFvOu81T69xuIJ8T7/Wg3wrTZhRhSspFI212UriUFyZcr0Y0t8p6EOrdh0vBcV+xZiHP
	qSor/aMNvtIJ5VQELu2TWxAYsOHus7U0EpItNsZ23fB1pZfOmYHKqkJ/aZOpkWW+kAJio/uWiqW
	hfr0CgeyPfwj9EjhXHsxUflBNs71Kdr1tjYEVVsYNYOKaYLlQNLaB4PqFRKFjPHfQ9XqVt28zVU
	1glje2V4QhhUv1qqDElGn+7YJwNU86ZbSkKvzQD5s91gDgI0fUCRAJcLfOpy2fYlLkKz6voBPNr
	1bmlC7aTxJPnsfYZJW0YwP2h9c7KbifCIKTmeNBXKwQ0uVg1YTAXkESLOiw32pZiEJDU2P25/zM
	4vefYRuuTF541GNkNzAiLxwJ+iYiD5Te0+cnPXdIvSB9MOSqwsBwUPA8jENM40SLvVc2lPqB+UE
	Y9rLmAuPa3Iw19QLFR4ANfZtB7qq/rZbom+nmdry7H3rzZ4YR27EP2peZrEkVV3ZucgA+sIwN1a
	N58OYB3K8fxSwCEr8XEBex5Q/kvAQzjv6a3HthtAiFb1WX0ZrF3NYaCG1EL0tFct/x/V7cIYAKp
	sauX0mfqv0FzyYqvIitEy86GZZb+OqEBO5sSGUqw37hLd4ZCq5uLkRSi0fW2faZLp4dmHwrv0bj
	yKoUc=
X-Received: by 2002:a05:6122:792:b0:5c7:a9ee:dcfb with SMTP id 71dfb90a1353d-5ee8aeb7fcemr10238133e0c.5.1795633139772;
        Wed, 25 Nov 2026 10:58:59 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee91a4e0cfsm16994459e0c.13.2026.11.25.10.58.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:58:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 0/2] L2CAP: Fix channels being established with insufficient security
Date: Wed, 25 Nov 2026 13:58:55 -0500
Message-ID: <20261125185857.1666852-1-luiz.dentz@gmail.com>
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

Luiz Augusto von Dentz (1):
  Bluetooth: L2CAP: Don't offer deferred channels before security is met

Mohammed Alquraini (1):
  Bluetooth: L2CAP: Fix accepting channels with insufficient security

 include/net/bluetooth/l2cap.h |   7 +++
 net/bluetooth/af_bluetooth.c  |   6 +-
 net/bluetooth/l2cap_core.c    | 109 +++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c    |  44 +++++++++++---
 net/bluetooth/rfcomm/core.c   |   1 +
 5 files changed, 151 insertions(+), 16 deletions(-)

-- 
2.56.0

