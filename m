Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F13998A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246422; cv=none; b=P4ZdImnBiWv9g9IrgnSvVEFFkCDilq1jQMCTw5bO/hqpJuYof2CxPLkh67M1GOVaPr+/y2F4NaKD0c5deizVS9xtrxxAuEgnlUZEGlSEKKt+cIQ+SlsLPFuZUPAajTRLFSnJO/FsUHPcOU0JIIRGeAH3d+syL+VeTdCuG/EbKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246422; c=relaxed/simple;
	bh=gnmHFnNXS2hhp7DiSXpWsghkh+hnjas8/6/cDNtqF9I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=b1ZUAfV1/+LWirSUhvGXaq7+OATAp9Kr85sytpiuOxL9gM7o0hJ+yNuJa8BoZEKHT4XqmtYW10FWP607Js0xEazb+rYbrO9FlCncsMrceBJg+QY2PidedshjhkCXIH8DYqXYOkIfIHD58zlRdfDFN1ZISgTBjBL/6czrA06mWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=L3fJY37j; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="L3fJY37j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782246420;
	bh=mAlehVK7x77j2LnqJ0JsAykr7RSt4xFfnjtdVZRr+90=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=L3fJY37jlX7RiAjXhRlcYPdsQB1Nu4T2PdZX2rHG2PDG9uPHEaCKwvdonImGb+Zzg
	 mOwZDr/bMasroyiQNYk9kls+faCROOxN5vAj2FcYy8ndJ5/0RCXnzvTiymeFQYTPHd
	 i79ercKOpqDAA196KNzz7ioHg0r9w2wAm7z9CKL8=
Received: from github.com (hubbernetes-node-4e356f1.ash1-iad.github.net [10.56.130.69])
	by smtp.github.com (Postfix) with ESMTPA id E5E4160107A
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 13:27:00 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:27:00 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1115551/000000-a0072e@github.com>
Subject: [bluez/bluez] fe6513: bass: Fix possible crash on
 bass_update_bis_sync
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

  Branch: refs/heads/1115551
  Home:   https://github.com/bluez/bluez
  Commit: fe6513bee8e6a73f926392b754020e62ade4cea0
      https://github.com/bluez/bluez/commit/fe6513bee8e6a73f926392b754020e62ade4cea0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-23 (Tue, 23 Jun 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix possible crash on bass_update_bis_sync

bass_update_bis_sync does use bass_remove_bis which may end up
removing the current entry causing a crash on entry->next, to avoid
that prefetch the next entry.


  Commit: d94c2e27556c19c45a93feb9b6d50f01ba4b2ec0
      https://github.com/bluez/bluez/commit/d94c2e27556c19c45a93feb9b6d50f01ba4b2ec0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-23 (Tue, 23 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Check if stream is valid before attempting to release

bt_bap_stream_release shall check if the stream is still valid before
attempting to release it just as done with other operations.


  Commit: a0072e317879e12e6fe474950721384e84248d30
      https://github.com/bluez/bluez/commit/a0072e317879e12e6fe474950721384e84248d30
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-23 (Tue, 23 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Don't transition to IDLE inside bap_bcast_set_state

Remove the recursive stream_set_state(IDLE) call from the RELEASING
case in bap_bcast_set_state. This call re-entered bap_bcast_set_state
while the state_cbs queue was still being iterated, causing a
use-after-free if a callback unregistered itself during notification.


Compare: https://github.com/bluez/bluez/compare/fe6513bee8e6%5E...a0072e317879

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
