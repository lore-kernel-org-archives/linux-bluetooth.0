Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B4242910
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788114279; cv=none; b=WQ9syS6mRg+rWO7+cpSX8iXtn+UfrIlrGVgm+3e0ZR/Upb58f3gqM3WOGIAqshG+Ibvya+beU8gKLKizLkbtktzWtAkXVFDHfXLtT8k0iwkiayTJeFPYUCmk8BnHBtf6sgmmheue0MgpOuI1ol4LwDqMbFFlvg9XICCd2H+ALeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788114279; c=relaxed/simple;
	bh=04IJIFs8z5fGEDCZaw2ujPoSW4OzvzU6vEF8bky88lo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qQwr/p/1X0u2yzMyeZEiLVJD0tPG+xIqw4kC+oYk48vxOlEO4RW/n+3oepWBZGr3jZBaZU2+9Pw62Y1OuqFc3cugpoGsMU7FH31IAbHZIE8FwA1niDyH5MqlutY78ECJ2LlLc4aSmkHKWbZ0GZof6MdBFGpvgCMCD8y5bsabCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jP5W+/qy; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jP5W+/qy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788114277;
	bh=dHjjRY6peYsmygnhDN4qPCIoMnsIlBI9QKksrTKyFYs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jP5W+/qy+5D7KSAf3I8q+rKMSVQcllJD8sytcfOazcqbBEC0VSE//aLFBuxE4K5/B
	 WfGzNcXyCqf19p7pZ9dRp7fQF6wb43rGTfboCjq0Hz2NTgC1SGg7kRR4GNCzjdN/+s
	 VAL43/pSA18JTRhZ5yi7yeCr3hwQVPcaUBRIxaHw=
Received: from github.com (hubbernetes-node-5d6a3a1.va3-iad.github.net [10.48.67.100])
	by smtp.github.com (Postfix) with ESMTPA id 5D9EF340E48
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 11:24:37 -0700 (PDT)
Date: Sun, 30 Aug 2026 11:24:37 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1153941/000000-737e9f@github.com>
Subject: [bluez/bluez] 737e9f: gatt-database: Fix freeing wrong client notify
 IO
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

  Branch: refs/heads/1153941
  Home:   https://github.com/bluez/bluez
  Commit: 737e9fd7230a28990dee19ba14ab82a8f6e0dbce
      https://github.com/bluez/bluez/commit/737e9fd7230a28990dee19ba14ab82a8f6e0dbce
  Author: Jerry Wu <jhs730127@gmail.com>
  Date:   2026-08-30 (Sun, 30 Aug 2026)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt-database: Fix freeing wrong client notify IO

When a non-bonded device disconnects, att_disconnected() drops its
device state and clear_ccc_state() invokes the CCC callback with a
NULL pending operation. ccc_write_cb() then takes the notifications
disabled path and calls queue_remove_if() on chrc->notify_ios with a
NULL ATT instance.

match_client_att() matches every entry when the ATT instance is NULL
and queue_remove_if() only removes the first match, so what gets freed
is the head of the queue, that is the client which subscribed first,
and not the one that went away. With two or more subscribers this is
deterministic, because the disconnecting client's IO is still queued
at that point: sock_hup() only runs on a later mainloop iteration.

The victim does not recover. Its link and its CCC value are left
untouched, so gatt_ccc_write_cb() takes the "value is identical"
shortcut on any subsequent write and AcquireNotify is never issued for
it again. To the application the notifications simply stop.

The disconnecting client does not need to be handled here at all, as
its IO is reclaimed through att_disconnect_cb() -> io_shutdown() ->
sock_hup(). Only remove an IO when there is an actual operation, and
let the NULL case fall through to the notify count accounting. That
also restores the StopNotify call when the last subscriber goes away,
which the early exit used to skip.

Fixes: 8eb1dee87e01 ("gatt: Fix not establishing a socket for each device")
Assisted-by: Claude:claude-opus-5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
