Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F548166E
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200434; cv=none; b=twmk2ks44u0zGGUE+snBBBvOFJIsGCTbqHiNoAyyG0QeKEwcx9xKtUlSehyuoA+4THAMV7eynMkjqicegMlKubPjZVGyUdhWKRDvfNcLsTboS9UG7qLzCxBBjO1FCrVWA7wLrUgjYwSn/XxxAKRFhole8Mq3dg1oscOKVnVrJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200434; c=relaxed/simple;
	bh=0lO+YBGjDrqJ4X32a/zxx2KfU49/PLMPuj+cdlwD+BA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MlqR8H7Ncmuct6B41yfa26BsvVTOpOpHGVr1akumk8ciZp5LVvPKli9hPpDCJ8YNwZibcAGGAbJzCFw7fMS5l4cEHnZi9ErpSrmc3R3RCNFxDQiaVilUpuA6PdqcVIIVDCdW2Kcv/61ZNy92INgi3+UT3rLR2qHJFfoGZF4u/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DPdK2oVy; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DPdK2oVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781200432;
	bh=8SQs5UkVNb4AGaFxRi355/Yvbg4Hi1a767aoypA/nug=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DPdK2oVyDDv0vCuk+YEG37adVungQvHFU1KfBKuWVCwjuF57U39D6EWP9sD268oUn
	 fUOGdyI3NTmhBi4qDdvTc59Ad+uNSneQ0q4WZoFNi6QlSQ6IfCoh0cvUsBI9kGoChU
	 5MMuDy5S0uI0LBzjFtocP6be/nZKOM5Kw9QoM5x0=
Received: from github.com (hubbernetes-node-d8e11ce.va3-iad.github.net [10.48.180.64])
	by smtp.github.com (Postfix) with ESMTPA id 5111D1811E1
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 10:53:52 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:53:52 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1110215/000000-ca320e@github.com>
Subject: [bluez/bluez] b5b40a: profiles/audio/bass: Use BASS_Modify_Source
 when a...
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

  Branch: refs/heads/1110215
  Home:   https://github.com/bluez/bluez
  Commit: b5b40a4bd3dd23a5569c616ebaf14126881b7ed1
      https://github.com/bluez/bluez/commit/b5b40a4bd3dd23a5569c616ebaf14126881b7ed1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-11 (Thu, 11 Jun 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  profiles/audio/bass: Use BASS_Modify_Source when assistant is active

When a MediaAssistant is already active (streaming), a subsequent Push
should send Modify Source with PA_SYNC_NO_SYNC and bis_sync=0 to
remove the broadcast source, rather than adding a duplicate source.

Split push() into push_add_src() and push_mod_src() helpers. The push
dispatcher checks the assistant state: ACTIVE non-local assistants and
LOCAL assistants with a tracked source entry both route to
push_mod_src, while all others proceed with push_add_src.

Add per-device source tracking for LOCAL assistants via a bass_src
struct (keyed by bt_bass pointer) stored in a per-assistant srcs
queue. This is needed because LOCAL assistants never change state, so
we cannot rely on the state machine alone to detect active sources.

Also fix the bass_src_changed BID filter: the previous check rejected
non-local assistants when BID was zero, but this incorrectly excluded
LOCAL assistants in REQUESTING state whose BID happens to be non-zero.
Change to reject assistants whose own BID is non-zero when the
notification BID is zero, which correctly matches local streams.


  Commit: e7d235efae7ed33f0ae0df91205277668181e0f4
      https://github.com/bluez/bluez/commit/e7d235efae7ed33f0ae0df91205277668181e0f4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-11 (Thu, 11 Jun 2026)

  Changed paths:
    M profiles/audio/bass.c
    M src/shared/bass.c

  Log Message:
  -----------
  profiles/audio/bass: Handle PA_SYNC_NO_SYNC in handle_mod_src_req

When the delegator receives a Modify Source operation with pa_sync set
to PA_SYNC_NO_SYNC while already synchronized to PA, release all
setups instead of updating BIS sync which would not apply the
requested termination.

Also reset the encryption state to no encryption when the last BIS
index is cleared from a subgroup, so subsequent source additions
start with a clean encryption state.


  Commit: ef38d6371550e7596888e8198d328c802520bd18
      https://github.com/bluez/bluez/commit/ef38d6371550e7596888e8198d328c802520bd18
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-11 (Thu, 11 Jun 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  profiles/audio/bass: Fix delegator reprobing after disconnect

delegator_disconnect left the old delegator in the delegators queue
after calling device_remove_profile. When a new delegator was created
for the same device (e.g. on a subsequent Add Source after Modify
Source removal), delegator_attach would find the stale entry and
return early, leaving the new delegator without a service. This
caused the "Unable to probe service" error and prevented the BASS
bcode exchange from working on reconnection.

Fix by removing the delegator from the queue, clearing service user
data, and calling delegator_free before disconnecting the service
and removing the profile. This also fixes a potential use-after-free
where delegator_disconnect accessed dg fields after device_remove_profile
could trigger delegator_detach -> delegator_free through the
bap_detached callback chain.

Also add validation in bass_req_bcode to detect and discard invalid
(all-zeros) broadcast codes that may have been stored from a previous
connection.


  Commit: ca320ea1e889ef325c64aaf9d41e32acdc7285d0
      https://github.com/bluez/bluez/commit/ca320ea1e889ef325c64aaf9d41e32acdc7285d0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-11 (Thu, 11 Jun 2026)

  Changed paths:
    M doc/org.bluez.MediaAssistant.rst

  Log Message:
  -----------
  doc: Document Push behavior when MediaAssistant is active

Document that calling Push on an assistant already in active state uses
BASS_Modify_Source to update the existing source rather than adding a
new one.


Compare: https://github.com/bluez/bluez/compare/b5b40a4bd3dd%5E...ca320ea1e889

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
