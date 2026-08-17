Received: from remote.fiveco.ch (remote.fiveco.ch [46.14.118.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A881F63D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.118.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969594; cv=none; b=DZ3o67huO0KUJjnoxjQVJcfe96c/rpLlx3e4BglwWJL7ADn4SK0jVV6fIsz9yVet4QxZAL9JJy1pW6bl57gCROcNSutv696OAlOHURhsnx6KzhereWcid9MjahVp2pbAW7Cgja436b295IYpYNnJxk8+QIlQ6B/P7ZNOmKXH6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969594; c=relaxed/simple;
	bh=knoIW/vHnqAJgn3EbxRKFe1cw0Qk6w91Y2pKPe0R5uQ=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=o056ptBfbmavbqGIzF83qaWZoP7djUNlZS7W/y1QQOW0a98GHchICYFXnIaKpL5VvFyRMti4R51zQMu+fr+Zl+gXBtL0BcGDYOAWwCoVDMMFiqAMnv294ODArKUxFC7cwGITOXo3/2B935I/X/bvo21ARzqt/yZ8P8E3CVsUqdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch; spf=pass smtp.mailfrom=fiveco.ch; dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b=d0X+UIou; arc=none smtp.client-ip=46.14.118.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b="d0X+UIou"
Received: from [192.168.16.44] (port=17976 helo=remote.fiveco.ch)
	by remote.fiveco.ch with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <valentin.kindschi@fiveco.ch>)
	id 1wvwNo-000000003q1-3R9r;
	Mon, 17 Aug 2026 14:24:04 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=fiveco.ch; s=fiveco; c=simple/simple;
	t=1786969444; h=from:subject:to:date:message-id;
	bh=knoIW/vHnqAJgn3EbxRKFe1cw0Qk6w91Y2pKPe0R5uQ=;
	b=d0X+UIoux5PJajGU01oEZbYP6JqQiSqa4HfknhEZBjFdwGrhVh8kQU3jfgwrw0aDYTDtsy3oZpr
	N1OhC/DK02C1MnpxqV2X2+/HXDoobD9smeXep0F7m6L8S3wDO23LxBEo3Y//MyaC+2Ca7kTxMTzos
	SfT52WfT7VjRxZnlflE=
Received: from fiveco-vm-vk1.fiveco.local (192.168.16.29) by
 FIVECO-MX01.fiveco.local (192.168.16.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 17 Aug 2026 14:24:04 +0200
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Bluetooth: fix a permanent LE Set Advertising Parameters retry loop after a cancelled central connection
Date: Mon, 17 Aug 2026 14:23:57 +0200
Message-ID: <20260817122359.508375-1-valentin.kindschi@fiveco.ch>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: FIVECO-MX01.fiveco.local (192.168.16.44) To
 FIVECO-MX01.fiveco.local (192.168.16.44)
X-Sophos-OBS: success
X-SASI-Version: Antispam-Engine: 6.0.0.1, AntispamData: 2026.8.17.115720
X-SASI-RCODE: 200
X-SASI-SpamProbability: 8%
X-SASI-Hits: BODY_SIZE_4000_4999 0.000000, BODY_SIZE_5000_LESS 0.000000,
 BODY_SIZE_7000_LESS 0.000000, CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000,
 DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
 MULTIPLE_RCPTS 0.100000, NO_CTA_FOUND 0.000000, NO_CTA_URI_FOUND 0.000000,
 NO_FUR_HEADER 0.000000, NO_URI_FOUND 0.000000, NO_URI_HTTPS 0.000000,
 OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000,
 TRANSACTIONAL 0.000000, WEBMAIL_SOURCE 0.000000, WEBMAIL_XOIP 0.000000,
 WEBMAIL_X_IP_HDR 0.000000, __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000,
 __CT 0.000000, __CTE 0.000000, __CT_TEXT_PLAIN 0.000000,
 __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000,
 __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
 __FRAUD_MONEY_DENOMINATION 0.000000, __FROM_DOMAIN_NOT_IN_BODY 0.000000,
 __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
 __HAS_MSGID 0.000000, __HAS_XOIP 0.000000, __HAS_X_MAILER 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
 __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
 __RCVD_CTE 0.000000, __RCVD_EXIM_4_96_AES_128 0.000000,
 __RCVD_FROM_HOMEUSER 0.000000, __SANE_MSGID 0.000000, __SL_HEAVY 0.000000,
 __SUBJ_ALPHA_END 0.000000, __SUBJ_STARTS_S_BRACKETS 0.000000,
 __SUBJ_TRANSACTIONAL 0.000000, __SUBJ_TR_GEN 0.000000,
 __TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_NO_MAILTO 0.000000

A gateway device that advertises as a peripheral while also making
outgoing central connections gets stuck logging

	Bluetooth: hci0: Opcode 0x2006 failed: -16

every 2 s indefinitely, starting seconds after an outgoing connection
attempt times out and is cancelled. Measured on one unit: 5326
occurrences over 3 hours, ending only when bluetoothd was restarted,
which resets the controller.

The controller is behaving per specification: LE Set Advertising
Parameters is Command Disallowed while advertising is enabled. The host
issues it anyway, and then cannot recover.

Sequence, from btmon (BCM43455, no LE Extended Advertising, so legacy
advertising and the software rotation loop are in use):

  LE Create Connection                     Status Success
  ... 13.8 s, peer does not answer ...
  LE Set Advertising Parameters   0x2006    Success        \ done: resume
  LE Set Advertising Enable       0x200a    Success        / HCI_LE_ADV set
  LE Create Connection Cancel     0x200e    Success
  LE Connection Complete                    Unknown Conn Id
  LE Set Advertising Parameters   0x2006    Command Disallowed   [+63 ms]
  LE Set Advertising Parameters   0x2006    Command Disallowed   [+1.954 s]
  LE Set Advertising Parameters   0x2006    Command Disallowed   [+2.016 s]
  ... every ~2.016 s, for hours, and no 0x200a is ever sent again

Three connection attempts earlier in the same capture that *succeeded*
show the same 0x2006 + 0x200a pair and do not trigger this. Only an
attempt that times out and is cancelled does.

Why it never recovers: hci_enable_advertising_sync() returns as soon as
LE Set Advertising Parameters fails, before the LE Set Advertising Enable
that would set HCI_LE_ADV. hci_schedule_adv_instance_sync() re-arms
adv_instance_expire every HCI_DEFAULT_ADV_DURATION (2 s) and its
"already advertising" shortcut tests HCI_LE_ADV, which can no longer
become true. hci_disable_advertising_sync() cannot break the tie either -
it returns without sending anything while HCI_LE_ADV is clear, which is
exactly when the flag is wrong.

Patch 1 removes the redundant advertising enable that creates the
mismatch. Patch 2 stops HCI_LE_ADV being cleared for a connection
complete that reports no connection.

Patch 1 has been verified on the affected device. btmon counts:

  before, 2.6 min capture: 78 LE Set Advertising Parameters sent,
                           78 Command Disallowed, 0 LE Set Advertising
                           Enable sent
  after,  2.0 min capture:  3 LE Set Advertising Parameters sent,
                            0 Command Disallowed, 5 LE Set Advertising
                            Enable sent, all successful

The enable being sent and accepted again is the point: HCI_LE_ADV gets
set, so the rotation loop's shortcut works and nothing accumulates.

Patch 2 was deployed together with patch 1, so its effect is not
separately attributable on hardware; it is included because the same
mismatch is reachable through le_conn_complete_evt() independently, and
the current unconditional clear is wrong on its own terms.

Both apply to bluetooth-next and, unchanged, to 6.12.y - the affected
code is identical in both.

A third, unrelated Command Disallowed on the same device - LE Set Random
Address refused on every active scan restart because advertising is only
paused for the address update when LL privacy is in use - is sent
separately, as it has a different cause and touches hci_sync.c only.

Tooling disclosure (Documentation/process/generated-content.rst):
the bug was found and the patches drafted with the help of an AI coding
assistant, over a debugging session on the affected hardware. The inputs
were btmon captures and kernel logs from the device; the assistant was
asked to identify what re-issues LE Set Advertising Parameters every 2 s
and to propose a fix. Its first two proposed mechanisms were wrong and
were discarded after being checked against the captures; a third proposed
change (making hci_disable_advertising_sync() always emit the disable)
was built and tested on the device, broke advertising registration
outright, and was dropped. The two patches here are what survived. All
code and reasoning were reviewed by the submitter, and the verification
numbers above were measured on hardware.

Valentin Kindschi (2):
  Bluetooth: hci_conn: only re-enable advertising after a failed
    peripheral connection
  Bluetooth: hci_event: keep HCI_LE_ADV set when the host cancelled the
    connection

 net/bluetooth/hci_conn.c  |  3 ++-
 net/bluetooth/hci_event.c |  8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

--
2.34.1
