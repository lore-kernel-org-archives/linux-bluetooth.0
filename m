Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44B51AFC1
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030588; cv=none; b=jUMvX01QIUbwoTf58pWztlf6BoG/Mc74m9jjSFyZdzlfoGmUzvG/JIp8Qv20jLPxaiCQB7afgUTv1cTUIyfZwoC3Z5Cvln4lql5tTj3cMqKfhZh2aRrc75VPhbHmBkPZq7IeErSDbXbEDxdXsB8VWh6rtt1/m8G2MVMCPzVDLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030588; c=relaxed/simple;
	bh=19PCjG/b2IUsEQp9haY7aUhNuySgQwPZoA3dnlAWqgY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RlX2tqbuVnCk2K1cRDhlUmwXGoXnAWXrtz+OmGvnHJP68npUfodOv0bRAmEJIxMCy7XSv1SsgszoTL77A1QZscKQ2RHFMXk0jkDaE7YTciYwOn0H5d5T7C9ml21dyy8n2z9n1dzzHNyDShAJ+dx3PDkom5OrlHtpQeonTxTNgtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RbcToOUI; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RbcToOUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790030585;
	bh=dred6kn0176ZhbFnZV6mFFJJkJE7Ta+VBBuOerutSaU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RbcToOUI6vFlA7KspfyDnsCH4YooQlWwwePi5XeZw3GYOtw9Jn5raSDUWlXAU2QT8
	 hAeimzIkPhqdMopQaw282n/G1KRma77z06kEyGa+ioL0RiZr6xUZrbi7u3v+89Ini1
	 VsGRjpRqItGPsAIeH1F2p1DbW/ag4YQQMDeOvObI=
Received: from github.com (hubbernetes-node-a888c7a.ash1-iad.github.net [10.56.203.105])
	by smtp.github.com (Postfix) with ESMTPA id CB19E36098B
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 15:43:05 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:43:05 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1170704/000000-959a7d@github.com>
Subject: [bluez/bluez] d2cf60: doc: describe the true wireless broadcast test
 cases
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

  Branch: refs/heads/1170704
  Home:   https://github.com/bluez/bluez
  Commit: d2cf6053569a902f289d8a5c5e721872e8cf35cb
      https://github.com/bluez/bluez/commit/d2cf6053569a902f289d8a5c5e721872e8cf35cb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst

  Log Message:
  -----------
  doc: describe the true wireless broadcast test cases

Assisted-by: opencode:claude-opus-5


  Commit: 505336bc3b00a39bd69107662d7fef130fa60805
      https://github.com/bluez/bluez/commit/505336bc3b00a39bd69107662d7fef130fa60805
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst

  Log Message:
  -----------
  doc: describe the true wireless broadcast assistant test case

Assisted-by: opencode:claude-opus-5


  Commit: dfce14a430df89220e92def94a97410ac0789d68
      https://github.com/bluez/bluez/commit/dfce14a430df89220e92def94a97410ac0789d68
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    A client/scripts/broadcast-sink-left.bt
    A client/scripts/broadcast-sink-right.bt
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: add the true wireless broadcast tests

Assisted-by: opencode:claude-opus-5


  Commit: 07b0f4b52599e558802fe0d0d0b33fd3b01e4855
      https://github.com/bluez/bluez/commit/07b0f4b52599e558802fe0d0d0b33fd3b01e4855
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: keep the push target per MediaAssistant object

Every MediaAssistant object of a local broadcast shares the bass_data of
the adapter, and pushing one stored the session of the delegator it was
pushed to by overwriting the bass of that shared data.

With a single delegator this goes unnoticed, but with one delegator per
side of a true wireless pair the second push replaces the target of the
first one, so the Broadcast Code of a request coming from the first
delegator is written to the second one, and the first never syncs.

Keep the session of the push in the assistant itself, and only handle
the changes reported by the delegator an assistant was pushed to.

Assisted-by: opencode:claude-opus-5


  Commit: 8eacebfca4f55fbfaef5e70c915e596bd8573957
      https://github.com/bluez/bluez/commit/8eacebfca4f55fbfaef5e70c915e596bd8573957
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M client/main.c
    M doc/bluetoothctl.rst

  Log Message:
  -----------
  client: connect a device that is already paired

Pairing a device that is already paired is rejected by the daemon with
AlreadyExists, which is of no use to the user: the bond asked for is
already there, and what pairing it anew takes is removing it first.

Connect it instead, telling what happened, so pairing a device is a way
of getting to it whether it is known already or not.

The documentation already described this behaviour, though as removing
the pairing first, which is not what happened either.

Assisted-by: opencode:claude-opus-5


  Commit: 959a7ddc3a87d95d77e071dff27266a2959e5432
      https://github.com/bluez/bluez/commit/959a7ddc3a87d95d77e071dff27266a2959e5432
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    A client/scripts/broadcast-delegator-left.bt
    A client/scripts/broadcast-delegator-right.bt
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: add the true wireless broadcast assistant test

Assisted-by: opencode:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/d2cf6053569a%5E...959a7ddc3a87

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
