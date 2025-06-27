Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7E2E7F20
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035912; cv=none; b=T8KRMWJMtgpsrlcmy3LdNDe0lo9ZeRMPcEzFrT3s9R7uIhn/5g1k0POHBnsMg4C9pzTnvxkFlnJeoZsu74YJAKpx++8LCOYKiPw9lCF7YQjZvHsD9QkPL6ed+FWE5IOVnnT5pRQqZ9sIBgaEwGw5obD9VpfgYw2icfeBNZsJDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035912; c=relaxed/simple;
	bh=sF780AteIAYk1mmQcFuCq9OtQlBOZ36WqwXeRGQMaao=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=G/LVeOQ/K8zhYez3QkLmaMFTgOJv9X/pG/1AGBNFUuHVXIOLkclJvaGdrdyg63xAPY5JEQkbQN9TZ2LQsB36hzZz0ZK4lTQu/+2y4cVSN9kACy7yzZJya1oqUatKiTfh0hdo/ivD4EQDWQeim6MPckezGNmsi4E7k+mcFqToCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D+UC8oBb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D+UC8oBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035902;
	bh=sF780AteIAYk1mmQcFuCq9OtQlBOZ36WqwXeRGQMaao=;
	h=From:To:Subject:Date:From;
	b=D+UC8oBb84x+RNb5B561bvnYK21LyHR3mydt7q4yzU8RQTQSajLQ7zO21iVNhz4iZ
	 uivgCBA4XaXnnLN3JAvgYsxt5LrS7uZkBUgNifsiDF+oAyQg/1Y4JSHyQtlcoQ/p6I
	 7pcaE2hIweZKxu3yt4vXI1vpm/jcGa71hu5rz1m27xLZ4sS7frFqfD95sSqN8cCcGM
	 GmTAoGocr00FiYDmrD9m9bdqw87rxOZ6/7G9gYzo4jTwOnV5vELcG730rvJy458Mb6
	 0gD83EJK7xyWgfMz8Ka6qkPpMFKujTG0Lwmg1VfZ7XzcL5fgqyrk/xAem3Z64HG0oS
	 VNUB5MBsB2iXQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CABD517E055D
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:41 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 00/27] New Telephony interface for HSP, HFP and CCP
Date: Fri, 27 Jun 2025 16:51:09 +0200
Message-ID: <20250627145136.421853-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This will introduce a new Telephony interface wich is intended to be
shared by the profiles able to control telephony calls.

The idea is to split the call control interface from the audio streaming,
as it is done for AVRCP and A2DP.
As for A2DP, the audio part will be delegated to the audio daemon (like
PipeWire) by the creation of new endpoints for CVSD and mSBC, LC3 endpoint
already exists.

The interface is mostly based on the one done for PipeWire's native
backend.

This will simplify the qualification of the telephony related profiles as
the qualification will no more depend on external projects, and calls can
be controlled from bluetoothctl.

A first implementation allows to dial or hangup a call using HFP.

v1->v2:
  - Rename org.bluez.TelephonyCall1 to org.bluez.Call1
  - Remove reference to profiles in org.bluez.TelephonyAg1 object path
  - Add profile UUID property to org.bluez.TelephonyAg1
  - Add OperatorName property to org.bluez.TelephonyAg1
  - Rename telephony_set_call_state() to telephony_call_set_state()
  - Use first available index of call for new call
  - Fix DBus message memory leak in hfp_dial_cb()
  - Display UUID and OperatorName in bluetoothctl telephony.show command
  - Add hangup-active and hangup-held support
  - Add SendTones support
  - Remove HFP specific comments in documentation
  - Add HFP HF server and related SDP record
  - Add OperatorName support to HFP HF
  - Add call line identification property support to HFP HF
  - Disable NREC during HFP HF connection phase
  - Enable Waiting call event to HFP HF
  - Enable Extended error support in HFP HF
  - Add telephony_call_set_multiparty() to telephony API
  - Enable Enhanced call status support in HFP HF, and use it to update
    calls status if available on both side

Frédéric Danis (27):
  doc: Add new telephony related profiles interfaces
  audio/telephony: Add shared interfaces implementation
  audio/telephony: Add skeleton for HFP profile
  audio/hfp-hf: Add HFP SLC connection and event support
  audio/hfp-hf: Add dial support
  audio/hfp-hf: Add hangup all calls support
  audio/hfp-hf: Add answer a specific call support
  client/telephony: Add new submenu
  audio/hfp-hf: Remove call interface during profile disconnection
  audio/hfp-hf: Create existing call during SLC phase
  audio/telephony: Add hangup_active and hangup_held functions
  audio/hfp-hf: Add hangup_active and hangup_held support
  client/telephony: Add hangup_active and hangup_held support
  audio/hfp-hf: Add SendTones support
  client/telephony: Add SendTones support
  doc: Make telephony docs more generic
  client/telephony: Remove IncomingLine
  audio/telephony: Remove IncomingLine
  audio/hfp-hf: Add HFP HF server and SDP record
  audio/hfp-hf: Add operator name support
  audio/telephony: Add call line identication property support
  audio/hfp-hf: Add call line idenfication support
  audio/hfp-hf: Disable NREC during connection setup
  audio/hfp-hf: Enable waiting call if supported by remote AG
  audio/hfp-hf: Enable extended error if supported by remote AG
  audio/telephony: Add call multiparty property support
  audio/hfp-hf: Enable enhanced call status if supported by remote AG

 Makefile.am                       |    4 +
 Makefile.plugins                  |    5 +
 Makefile.tools                    |    9 +-
 client/bluetoothctl-telephony.rst |   95 ++
 client/main.c                     |    3 +
 client/telephony.c                |  676 ++++++++++
 client/telephony.h                |   12 +
 configure.ac                      |    7 +
 doc/org.bluez.Call.rst            |  107 ++
 doc/org.bluez.TelephonyAg.rst     |  206 +++
 profiles/audio/hfp-hf.c           | 2092 +++++++++++++++++++++++++++++
 profiles/audio/telephony.c        |  808 +++++++++++
 profiles/audio/telephony.h        |  118 ++
 13 files changed, 4139 insertions(+), 3 deletions(-)
 create mode 100644 client/bluetoothctl-telephony.rst
 create mode 100644 client/telephony.c
 create mode 100644 client/telephony.h
 create mode 100644 doc/org.bluez.Call.rst
 create mode 100644 doc/org.bluez.TelephonyAg.rst
 create mode 100644 profiles/audio/hfp-hf.c
 create mode 100644 profiles/audio/telephony.c
 create mode 100644 profiles/audio/telephony.h

-- 
2.43.0

