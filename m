Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964B3AB292
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795793; cv=none; b=Zefz70d1eA8RemYajEGpgEw4GpWr5oD1ASoAGagtSKGtQpqFdcnK9g3LvZdYg365P+zW/uV01xjNGpvZLGkT7ndB8qGYmYVCUf0SJtPjEyd5vbkn0b3ZMs1O86mLifgqtfYR5GmnbqSXopitX7YvVbFF1kkCoJne9eJP8aOLcjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795793; c=relaxed/simple;
	bh=RAlCYV6RmBczeEltYtYhdlpE8ioZOH0osiFm7kcHJIs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hXr3OlwXvIV5/k4KFytyWqYmN23mtuFyh3eSCvu/mZxFvoRj2KEw4KoCnk1TSVIktoaUYnj4CSqEHaoWoJrivW2jdYFUEAU3XNJ92FVigVJbg1lt2ZhOPq5vpw9mGY2WH2t6oR4IHjZWk1WQlK10mb+wkEZ+iXdR5dOsv1bElZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=kECVSDhJ; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="kECVSDhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790795790;
	bh=z8Bf9TGAw1WX3I6N/d/o2x8r8I07jymTWS6uvweJIXo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kECVSDhJs52+VHqEuVo7RCUjD78vqgnw1WvK/hBE2Tz2af2rkaR/Qslc5HBzk+B/K
	 hDkhjShesrHcSRbvaM8b3ckloiLyA3D6nK/TKVP+4+7qlkYd+Eju23TkZ7HVKKeOZ5
	 K3sOuupa2X2o3PEUa4yRZz+kTvWPtnts24JvCdAsbgEAaplM683747114C9Y5w3zJF
	 HZL5+wxb6fNoXe54JWJzWzq+JNK7yJrmc3W2tGG4A8fbcwAPMyrHqaE0CjZ879uZYG
	 4UTSh/pPiWwBIDQD7AANe8YemLk7gdOTtIHDn1KjOIYHs2cayHxjq+aafw8cBd2j5S
	 U3zc9TyEEnzIg==
Received: from github.com (hubbernetes-node-1532923.ash1-iad.github.net [10.56.178.17])
	by smtp.github.com (Postfix) with ESMTPA id E33AE84040C
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 12:16:30 -0700 (PDT)
Date: Wed, 30 Sep 2026 12:16:30 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/dbc610-549f3d@github.com>
Subject: [bluez/bluez] eda426: audio: Fix stale AVDTP connecting state
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
  Commit: eda4262191ba00ab6912f54c86c2cdacc2f8b8d9
      https://github.com/bluez/bluez/commit/eda4262191ba00ab6912f54c86c2cdacc2f8b8d9
  Author: Kun Ma <mk02092022@gmail.com>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

  Changed paths:
    M profiles/audio/sink.c
    M profiles/audio/source.c

  Log Message:
  -----------
  audio: Fix stale AVDTP connecting state

When a remote dual-role A2DP device reconnects autonomously, both sink
and source services transition to their respective CONNECTING states
upon AVDTP_SESSION_STATE_CONNECTING.

If the remote device only configures one direction (e.g. initiating a
stream from remote Source to local Sink), the unused direction's state
remains stuck in CONNECTING even after the underlying AVDTP session has
reached AVDTP_SESSION_STATE_CONNECTED.

Subsequently, when policy or userspace attempts to initiate audio
playback (e.g. via sink_connect() or source_connect()), the call fails
immediately with -EBUSY due to this stale CONNECTING state.

Fix this by only returning -EBUSY if the underlying AVDTP session is
actually still in AVDTP_SESSION_STATE_CONNECTING. In addition, check if
a stream already exists on that service to prevent concurrent stream
allocations while the session is connected.

Link: https://github.com/bluez/bluez/issues/2381


  Commit: a086d234e503daf6260fec61b7f4fd8f1028e165
      https://github.com/bluez/bluez/commit/a086d234e503daf6260fec61b7f4fd8f1028e165
  Author: Seonggon Cho <jmsmg1@me.com>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  mpris-proxy: Line-buffer stdout

mpris-proxy reports adapter and player changes with printf() but never
flushes stdout. When it runs as a service (tools/mpris-proxy.service)
stdout is a pipe to the journal, so glibc fully buffers it and nothing
is written until 4 KiB have accumulated or the process exits.

On a system whose Bluetooth adapter went away and came back every two
minutes, the "Bluetooth Adapter /org/bluez/hci0 removed" and "... found"
messages reached the journal in bursts of exactly 100 lines (about
4096 bytes), all carrying the timestamp of the flush rather than of the
event, i.e. up to about 80 minutes late.

Set stdout to line buffered at startup, as bt_shell_init() already does,
so every message reaches the journal with an accurate timestamp.

Assisted-by: Claude:claude-fable-5-1


  Commit: 05870ea62923caa4a7de233e733dea8bf77223d7
      https://github.com/bluez/bluez/commit/05870ea62923caa4a7de233e733dea8bf77223d7
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c
    M src/shared/rap.c

  Log Message:
  -----------
  ranging: Route CS subevent results by connection and configuration

bt_rap_attach_hci() allocates a state machine per device and registers the
CS subevent handlers of each one on the shared bt_hci. LE Meta subevents
are dispatched with queue_foreach() over every registered handler, so each
CS Subevent Result is delivered to all of them, not only to the device the
event belongs to.

The Subevent Result and Subevent Result Continue handlers then passed their
own sm->rap on without checking which connection reported the event, unlike
every other handler in rap_hci.c, which resolves it with
find_mapping_by_handle() and returns when the connection is not its own.
The Connection_Handle was parsed into the event and never read again, in
rap_hci.c or in shared/rap.c.

With two CS connections up, one set of ranging data was therefore consumed
by both sessions and sent out over both peers' RAS characteristics. Resolve
the mapping and drop the subevent when the connection is not tracked.

handle_local_subevent_result() and parse_cs_local_initiator_data() also
took a config_id they never checked against the tracked one, so subevents
belonging to a second CS configuration on the same connection were
appended to the procedure of the first. Ignore a subevent whose config_id
does not match the tracker, once the tracker has one.

Assisted-by: Claude:claude-opus-4.8


  Commit: 549f3d50686bbf18f01b949a913ddd10cb6e8b5c
      https://github.com/bluez/bluez/commit/549f3d50686bbf18f01b949a913ddd10cb6e8b5c
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

  Changed paths:
    M obexd/plugins/phonebook-dummy.c

  Log Message:
  -----------
  obexd: Fix FILE* leak in phonebook-dummy

fdopen(fd, "r") transfers ownership of fd to the FILE stream, but the
loop was calling close(fd) directly instead of fclose(fp), leaking the
FILE structure and its stdio buffer on every vCard read. Also handle
fdopen() failure, which was previously unchecked.


Compare: https://github.com/bluez/bluez/compare/dbc6102ccdee...549f3d50686b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
