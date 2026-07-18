Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9DB12F585
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784403781; cv=none; b=Zc8NGwmMcwvBf58oI3aC/CH2iN8DgzINa5zrYiaQJ+8RDUzK57Asbbg/jy8/8WPssQTnFiCSe6cZ/qOJN7MlbpYsJ68X0a0jZrS4bjA1EN3cVZ+lCtIT4FNNCeNzdFR2D+vwVTt8ni48Tgu1RSARXKZgX/AhUq4VLkjwexesrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784403781; c=relaxed/simple;
	bh=gfWnYB09kngWlOhDRlIjcfo1hUmM+ICgCLZkvUjovVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKsCYnoOxrUiOT3QgcnUcck/RvKVJQzvn0o1jJOapWUgpOJJbqwFoohUvkR1dE44uuhsPNb7hGo2y08xjVNWVDhRfaKItm1s+28bNCspnUNaFpE7l9ZOVIum1d7V91vaBKyk5FmW3EiOPa2kUGc/RTVTyAdYb4wOqZhIsRv+EqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pipobscure.com; spf=pass smtp.mailfrom=pipobscure.com; dkim=pass (2048-bit key) header.d=pipobscure.com header.i=@pipobscure.com header.b=YRfizz08; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pipobscure.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pipobscure.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pipobscure.com header.i=@pipobscure.com header.b="YRfizz08"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h2cd51Jhnz8tyL;
	Sat, 18 Jul 2026 21:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pipobscure.com;
	s=MBO0001; t=1784403769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5hlB9WCv6lD00cX5HJcLJLL0tdDvROZwXJmGge1lwvg=;
	b=YRfizz08ssFe2nk7C7cFwKlbvPGMQZkvwyclbZQM9W8NvTVoHYgjzNnZ0/Uu+w7b3WdFV4
	3RfvdmpNtXZPTU+lPspQM8uTfgJ4Jt2CLHEbIErdV/+dQ0EPzeDb8HNEEZV//J1nmQ386l
	ghe6WIhQdvbAcgYYoJhXAjxP0Zp1QzgFnCjDsF/eT7GSzScSo6KJmVy6NEfKFwunab4Oje
	aG0rX/GGBY4WJ2JYJb1OI5kyU4QIILydBeFj/G5BQKAuZ1qEY4IfsC9PDoNGdezTFs8rNv
	eKAgAiZJA/ASAQN1jH2ntmloDea6GCWFE3qpNmouQoveYunNFMBP52D3aNqeQQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of pip@pipobscure.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=pip@pipobscure.com
From: Philipp Dunkel <pip@pipobscure.com>
To: linux-bluetooth@vger.kernel.org
Cc: Philipp Dunkel <pip@pipobscure.com>
Subject: [PATCH BlueZ 0/2] Don't auto-bond on reactive GATT security elevation
Date: Sat, 18 Jul 2026 21:42:28 +0200
Message-ID: <20260718194230.35959-1-pip@pipobscure.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4h2cd51Jhnz8tyL

bluetoothd probes every freshly connected LE peer as a GATT client
through its built-in profiles (battery, mcp, ...). When such a probe
reads a characteristic the peer has protected, the peer answers with
Insufficient Authentication (0x05), and change_security() reacts by
raising BT_SECURITY on the ATT socket. On an unbonded LE link that
starts SMP pairing, so the user is shown a pairing prompt for a device
that merely came into range -- a bond nobody requested, logged as a
device_bonding_complete() bond with a (nil) requestor.

The existing opt-out does not help: change_security() only bails when
chan->sec_level != BT_ATT_SECURITY_AUTO, but sec_level is recorded for
BT_ATT_LOCAL channels only, so an L2CAP/LE channel stays at AUTO for its
whole lifetime and always elevates.

Patch 1 adds bt_att_set_no_auto_sec(), a per-bt_att flag that makes
change_security() refuse to elevate, and sets it from gatt_client_init()
for any link that is neither bonded nor in a requested bonding.
In-progress Pair() and already-bonded devices keep their existing
elevation paths untouched.

Patch 2 adds a unit test: it arms AUTO security and then forbids
elevation, asserting the auth error is delivered to the caller with no
retry on the wire. Without patch 1 the client retries and the test
aborts on the unexpected Read Request.

Tested against Android (Galaxy Z Flip 4), iOS (iPhone) and macOS
(MacBook): each connects and is probed with no unsolicited pairing
prompt, while explicit pairing continues to work.

Both patches were developed with the assistance of an AI model
(Claude Opus 4.8), disclosed per-patch with an Assisted-by: trailer.
Every line was reviewed by me and the result was built, run and tested
on the hardware above -- behaviour observed, not inferred.

Philipp Dunkel (2):
  shared/att: don't auto-bond on reactive elevation
  unit/test-gatt: cover no-auto-sec on auth error

 src/device.c     | 13 +++++++++++++
 src/shared/att.c | 20 ++++++++++++++++++++
 src/shared/att.h |  1 +
 unit/test-gatt.c | 28 ++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)

-- 
2.55.0

