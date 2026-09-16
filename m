Received: from remote.fiveco.ch (remote.fiveco.ch [46.14.118.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391244CCDF2
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.14.118.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552986; cv=none; b=aq++Oq85k6uIpCwDlxzEpHKWlTzNj3d+XsTPiHWHsRipc8RVfLMfomZpffuCmICXTgioapCAxPzs39a5fB4M4NI4nW5frx4Go/FAxeC5jKYRhXoQveKu6Y4yqz4q9OX+ekO8EdpxTGa2NGstZosuZhhMgciwAy+zFHqMrSxjD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552986; c=relaxed/simple;
	bh=Ktd4sc5LhJL+NHyEvMw2yBon7QuTSQTdWOD91LQiQcY=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=t+DZQ8XU/6d8pIR/e4gqwIeilNaxh7z/t1KDcFMcpoU02JNNk9SeqlktUvEVLkp3q2fQqGm5asmrlRCEnCwF8egbR+3mf/ueTkdWFzq8IV2HimaFSFPaR15ciA95BDHOA0kv8+ayvJ5zWdgK+Qt1b88HSObo7INDUybFS75P9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch; spf=pass smtp.mailfrom=fiveco.ch; dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b=C+YF3CA+; arc=none smtp.client-ip=46.14.118.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiveco.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fiveco.ch header.i=@fiveco.ch header.b="C+YF3CA+"
Received: from [192.168.16.44] (port=11920 helo=remote.fiveco.ch)
	by remote.fiveco.ch with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <valentin.kindschi@fiveco.ch>)
	id 1x6mTB-000000003i1-0p4r;
	Wed, 16 Sep 2026 12:02:25 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=fiveco.ch; s=fiveco; c=simple/simple;
	t=1789552945; h=from:subject:to:date:message-id;
	bh=Ktd4sc5LhJL+NHyEvMw2yBon7QuTSQTdWOD91LQiQcY=;
	b=C+YF3CA+6fPx7rZN5tEyFsjl0yJ2gXXkd2vT21s6lAvWgTS9VvQszqAA9+O54kYJuHPoNXPTKhk
	oSUHTVgx9kHxoZqnlIXVSxRfHi0+Itt3EXJ96AlqvcyhhB4TtUWRzd2/uS25ha6DJIMc3JfCZWigc
	3aNg5wjGDsULxUTfLcQ=
Received: from fiveco-vm-vk1.fiveco.local (192.168.16.29) by
 FIVECO-MX01.fiveco.local (192.168.16.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 16 Sep 2026 12:02:24 +0200
From: Valentin Kindschi <valentin.kindschi@fiveco.ch>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
	<linux-kernel@vger.kernel.org>, Valentin Kindschi
	<valentin.kindschi@fiveco.ch>
Subject: [PATCH v4] Bluetooth: hci_sync: pause advertising for the scan address update
Date: Wed, 16 Sep 2026 12:02:06 +0200
Message-ID: <20260916100206.3062073-1-valentin.kindschi@fiveco.ch>
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
X-SASI-Version: Antispam-Engine: 6.0.0.1, AntispamData: 2026.9.16.92719
X-SASI-RCODE: 200
X-SASI-SpamProbability: 8%
X-SASI-Hits: BODY_SIZE_7000_7999 0.000000, CTE_8BIT 0.000000,
 DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000,
 HTML_00_10 0.050000, MULTIPLE_RCPTS 0.100000, NO_CTA_URI_FOUND 0.000000,
 NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000, OUTBOUND 0.000000,
 OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000, WEBMAIL_SOURCE 0.000000,
 WEBMAIL_XOIP 0.000000, WEBMAIL_X_IP_HDR 0.000000, __ANY_URI 0.000000,
 __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000, __CC_NAME 0.000000,
 __CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000, __CT 0.000000,
 __CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000,
 __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
 __DQ_NEG_IP 0.000000, __FROM_DOMAIN_IN_ANY_CC1 0.000000,
 __FROM_DOMAIN_IN_RCPT 0.000000, __FUR_RDNS_SOPHOS 0.000000,
 __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
 __HAS_XOIP 0.000000, __HAS_X_MAILER 0.000000, __MIME_TEXT_ONLY 0.000000,
 __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MULTIPLE_RCPTS_CC_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PHISH_SPEAR_SUBJ_PREDICATE 0.000000,
 __RCVD_CTE 0.000000, __RCVD_EXIM_4_96_AES_128 0.000000,
 __RCVD_FROM_HOMEUSER 0.000000, __SANE_MSGID 0.000000,
 __SHIPPING_ACTION 0.000000, __SL_HEAVY 0.000000, __SUBJ_ALPHA_END 0.000000,
 __SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_STARTS_S_BRACKETS 0.000000,
 __TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000,
 __URI_NO_WWW 0.000000, __URI_NS 0.000000

hci_active_scan_sync() programs a non-resolvable private address with LE
Set Random Address on every active scan start.

BLUETOOTH CORE SPECIFICATION Vol 4, Part E, 7.8.4 says the controller
shall return Command Disallowed (0x0C) for that command while legacy
advertising or scanning is enabled. hci_pause_addr_resolution(), called
just above, only stops advertising when LL privacy is in use, so on a
controller without it the command is issued while advertising is still
on:

  Bluetooth: hci0: Opcode 0x2005 failed: -16

It does not converge either. hdev->random_addr is only set on a
successful command complete, so it stays BDADDR_ANY, and the deferral
added by commit c2994b008492 ("Bluetooth: hci_sync: Fix not setting
Random Address when required") is skipped in exactly that case. Observed
on a BCM43455, which has no LL privacy and no extended advertising, at
the scan restart period of about 10 s, for as long as discovery keeps
restarting:

  < LE Set Random Address  Address: 02:16:91:90:F1:D4 (Non-Resolvable)
  > Command Complete       LE Set Random Address, Command Disallowed
  < LE Set Random Address  Address: 26:90:57:96:9A:3E (Non-Resolvable)
  > Command Complete       LE Set Random Address, Command Disallowed
  < LE Set Random Address  Address: 16:32:01:BC:B5:CE (Non-Resolvable)
  > Command Complete       LE Set Random Address, Command Disallowed

Pause advertising for the address update regardless of privacy, and
resume it on every exit path. The resume was previously guarded by
ll_privacy_capable() and only reached on the error path, which matched
the pause being privacy-only.

With the patch, on the same hardware:

  < LE Set Advertising Enable                            Success
  < LE Set Random Address                                Success
  < LE Set Scan Parameters                               Success
  < LE Set Scan Enable                                   Success
  < LE Set Advertising Parameters                        Success
  < LE Set Advertising Enable                            Success

The last two commands are the resume, issued with the scan already
running, and both succeed: on this controller re-enabling legacy
advertising during an active scan does not need a further address write,
so it is not refused.

Over 35425 btmon records and about 4 minutes of continuous active
discovery with advertising enabled there were no Command Disallowed
responses of any opcode, against one per scan restart before, and a
central could still connect.

One caveat this widens, flagged on the previous posting. When
HCI_ADVERTISING is set, hci_pause_advertising_sync() also clears
HCI_DISCOVERABLE and HCI_LIMITED_DISCOVERABLE and zeroes discov_timeout,
and hci_resume_advertising_sync() restores only HCI_ADVERTISING, so the
discoverable state is lost for good. It reproduces today on an LL privacy
controller through hci_pause_addr_resolution(), with no scan patch
involved; this patch makes it reachable on controllers without LL privacy
as well. On a BCM43455 carrying this patch:

  btmgmt -i hci0 connectable yes
  btmgmt -i hci0 advertising on
  btmgmt -i hci0 discov yes
    current settings: powered connectable discoverable le advertising ...
  btmgmt -i hci0 find -l
    current settings: powered connectable le advertising ...

hci_suspend_sync() already calls hci_pause_advertising_sync()
unconditionally, with no privacy guard, so a device that suspends loses
the same state on any controller today. The clear is also reached only
with HCI_ADVERTISING set, i.e. when advertising is mgmt-managed, not for
a device made discoverable without it.

That asymmetry is pre-existing and independent of this patch, so it is
left alone here rather than folded into a scan path fix.

Tooling disclosure (Documentation/process/generated-content.rst): an AI
coding assistant was used to investigate this and to draft the change;
the patch text and code are its output, reviewed by me. Inputs were btmon
captures and kernel logs from the affected device, with the request to
identify what re-issues LE Set Random Address every ~10 s and to fix it.
Three earlier explanations it proposed were discarded after being checked
against the captures: bluetoothd restarting service discovery; RPA
rotation (excluded, Privacy=off); and the static-address branch of
hci_update_random_address_sync() (excluded, both random_address and
static_address read 00:00:00:00:00:00). The cause was only established
after decoding the command payloads, which showed a freshly generated
non-resolvable address per attempt. Testing is as described above, on the
device, using btmon and a second device to confirm connectability.

Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY")
Assisted-by: Claude:claude-opus-5 btmon
Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
---
Changes in v4:
- Report the HCI_DISCOVERABLE asymmetry raised in review rather than fix
  it: hci_pause_advertising_sync() clears HCI_DISCOVERABLE and
  HCI_LIMITED_DISCOVERABLE and zeroes discov_timeout, and the resume
  restores only HCI_ADVERTISING. It is pre-existing on LL privacy
  controllers, which reach the same pause through
  hci_pause_addr_resolution(); this patch widens it to controllers
  without LL privacy. The commit message now carries a reproducer.
- Keep the explicit return on the success path, so the resume runs there
  and the function no longer falls through into failed:.
- Address the review question on whether that resume can itself be
  refused while the scan is running: the capture above shows both resume
  commands succeeding with LE Set Scan Enable already sent.
- Shorten the added comments to one line each.

Changes in v3:
- Resend, no code change; v2 had no reply. Rechecked that it still applies
  to bluetooth-next.
- Added the second capture described above, taken with the two patches from
  the "endless adv params retry" series applied, since in bluetooth-next,
  confirming the fix holds with cancelled outgoing connections in the mix.

Changes in v2:
- Rebased onto bluetooth-next: mainline renamed use_ll_privacy() to
  ll_privacy_capable(). No functional change.

 net/bluetooth/hci_sync.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6264,6 +6264,11 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	if (err)
 		goto failed;
 
+	/* LE Set Random Address is disallowed while advertising is enabled. */
+	err = hci_pause_advertising_sync(hdev);
+	if (err)
+		goto failed;
+
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
 	 * private address.
@@ -6292,13 +6297,14 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	err = hci_start_scan_sync(hdev, LE_SCAN_ACTIVE, interval,
 				  hdev->le_scan_window_discovery,
 				  own_addr_type, filter_policy, filter_dup);
-	if (!err)
+	if (!err) {
+		hci_resume_advertising_sync(hdev);
 		return err;
+	}
 
 failed:
-	/* Resume advertising if it was paused */
-	if (ll_privacy_capable(hdev))
-		hci_resume_advertising_sync(hdev);
+	/* No-op when advertising was not paused. */
+	hci_resume_advertising_sync(hdev);
 
 	/* Resume passive scanning */
 	hci_update_passive_scan_sync(hdev);
--
2.34.1
