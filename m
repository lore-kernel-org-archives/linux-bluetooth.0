Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62DC3A48E4
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435612; cv=none; b=S9eCISQjMtz7koMQIa6dxSLYHCM7ofBZTbu1A61cDeNmzycHSI3Br0BYxoXBJQSjykBXHuWGkMPNThDYJi3lmd4dizWWsF0aejCH8T4m8wn0w9mTKdEeLNRXmTX9HyPx6/fD+VjDjk4kVWRwhkGedxOm+i3mfBxijOWtgBkwsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435612; c=relaxed/simple;
	bh=+M99j2aOGPrf9mOf6LayV/sakyXRhhHm6IqZ6PdgQkg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=og2q40HPbwX4YymSNthuUW2Nek2IAlSwR+G/NAbpfgPtSOIhix/ShYmMl8sfIuzvZP7A3YFTNKUmuImAA1/SimR53EvFh8dGbG4ZYvu5mPBx0eRdmAJfmvTOnsOJxxXf2lbJhEIjMZ7oVWGD77zgsLabIGSHGzQvu294G06bxHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bHcdC2sg; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bHcdC2sg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780435609;
	bh=JUKlHZwlQf1ZhqTvQaJawGeSApu5pKPVRRA6ae//W5I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bHcdC2sgH+P/6FdM8DtyPzbbhW1YPRycEcoJHib9m5/QbIM6QLDYWEvLh1A5GOTgx
	 PFIiN91v0S2MhoGEkcXlE2tlr98FnmPw+F1KgZRY3DpqNyjWj8jWR5vRwRC+QzZjez
	 5i9FesTXB2Vd+AACYuIsZFv6xDZh6szRGKDiZ9V4=
Received: from github.com (hubbernetes-node-8dc3829.va3-iad.github.net [10.48.140.26])
	by smtp.github.com (Postfix) with ESMTPA id EBCB48007BB
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 14:26:49 -0700 (PDT)
Date: Tue, 02 Jun 2026 14:26:49 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1104856/000000-269d2a@github.com>
Subject: [bluez/bluez] 68ea8a: profiles/audio/bass: Use BASS_Modify_Source
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

  Branch: refs/heads/1104856
  Home:   https://github.com/bluez/bluez
  Commit: 68ea8abc431536ceb035c81f58a9380350765616
      https://github.com/bluez/bluez/commit/68ea8abc431536ceb035c81f58a9380350765616
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-02 (Tue, 02 Jun 2026)

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


  Commit: 916f13168fadded01ecf4b5ff38d6778e7f43607
      https://github.com/bluez/bluez/commit/916f13168fadded01ecf4b5ff38d6778e7f43607
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-02 (Tue, 02 Jun 2026)

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


  Commit: 6086c0bddadba995f868ede7a730a6ff33c6b7da
      https://github.com/bluez/bluez/commit/6086c0bddadba995f868ede7a730a6ff33c6b7da
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-02 (Tue, 02 Jun 2026)

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


  Commit: 269d2a4f137316ab45db0cc767f2995bfd4c6bf9
      https://github.com/bluez/bluez/commit/269d2a4f137316ab45db0cc767f2995bfd4c6bf9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-02 (Tue, 02 Jun 2026)

  Changed paths:
    M doc/org.bluez.MediaAssistant.rst

  Log Message:
  -----------
  doc: Document Push behavior when MediaAssistant is active

Document that calling Push on an assistant already in active state uses
BASS_Modify_Source to update the existing source rather than adding a
new one.


Compare: https://github.com/bluez/bluez/compare/68ea8abc4315%5E...269d2a4f1373

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
