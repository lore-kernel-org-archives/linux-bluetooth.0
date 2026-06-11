Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85861E9B37
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208149; cv=none; b=loTxXDLakwjp4A5yCyDXa9M1OWpzhhpC30nDupeCmJ6w1a8+l8jYcjBij/UZL84wjxyE9tX7S9Y/WP23LmLn7hRfStFBepzhXSA+mHGhUuEG8vENVQL1HZAI63EoLMP62sCL2maaIRbtSgRRlpwb0QAkgnQ354W3RlHq9eSvCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208149; c=relaxed/simple;
	bh=t+Sa6JYVqje+X2VmqbLlHZ0WlmiDP284+5c9LlzSHz0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Dx8ehIX/Qlc3RB3iQb/zZUE4+xFSUFJR1z1BGgHqhy7WS51Ry7w6btBxovvDOgO4a/CdvknVl3YJH23+0eoOCkatKsMV3grEhv17KAfc4jKNXiZpuDiJ/9bpROmuvy1Yhb01cr/0bAeHWxeuIU1JZgb+kx8IesjkEx39rGwmB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HmQxW+aN; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HmQxW+aN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781208147;
	bh=CYuAP7IGML0fFWdQmWG9rQiIKFS6FmstToKOQ59LtuU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HmQxW+aNG4nQnSJNRi9VN+XASnCRwES/8GJO79QOpaKix1apt+cjP6aD63OnS34SK
	 2BiOkejKO1P5pI3s4WWeEH1LMLIiDCL/P7vcXMZmhZwfpXRh6mAsdvBl9/h5SdB8yQ
	 6I0KqiMXO7+qRbreQlF3KLheC+16J0Fp3Uqry/Fs=
Received: from github.com (hubbernetes-node-d2161f0.va3-iad.github.net [10.48.12.74])
	by smtp.github.com (Postfix) with ESMTPA id F00E480040C
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 13:02:26 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:02:26 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5d836f-40f2e3@github.com>
Subject: [bluez/bluez] ea6b63: profiles/audio/bass: Use BASS_Modify_Source
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: ea6b63562d9d249b5925d09813aa01510123aae8
      https://github.com/bluez/bluez/commit/ea6b63562d9d249b5925d09813aa01510123aae8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

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


  Commit: 590aae8b695082185b2354e9f194078804fd9f2b
      https://github.com/bluez/bluez/commit/590aae8b695082185b2354e9f194078804fd9f2b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

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


  Commit: 5b0c20727569e0ad6fee2c7d92dd375fa0fb45b1
      https://github.com/bluez/bluez/commit/5b0c20727569e0ad6fee2c7d92dd375fa0fb45b1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

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


  Commit: 40f2e34b373944cf8142154881ce69f92c2be68d
      https://github.com/bluez/bluez/commit/40f2e34b373944cf8142154881ce69f92c2be68d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-10 (Wed, 10 Jun 2026)

  Changed paths:
    M doc/org.bluez.MediaAssistant.rst

  Log Message:
  -----------
  doc: Document Push behavior when MediaAssistant is active

Document that calling Push on an assistant already in active state uses
BASS_Modify_Source to update the existing source rather than adding a
new one.


Compare: https://github.com/bluez/bluez/compare/5d836f1c697c...40f2e34b3739

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
