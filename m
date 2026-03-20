Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2713B19AD
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022140; cv=none; b=FaKbz5RsIbBVewWQ+f/m/nm1XQFkRWi7i9szO+RolAMicDDuGbwMlvYbZEauU0OcWPelldje94fKNL4iSZTKfB9kfpNNpA1OAjxLLZ380QiKwDflw1cXIOaployTQLg88LzmWSKmnMMkn+Y4EGhxtQTOr2hGNd649x/w7lKW28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022140; c=relaxed/simple;
	bh=9J3mbFTU7zbeWYD3mWGbJF+lEp3uazQj9ZO7RVZYVVI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=f5s9NAmFIIUH8qGWSn7MCn/yAN9NXYknRHoZGQteQaQ19iQAnRitv3A10nK6hYrAwsgBMaa6yIN9JOqgaNt0MJrrDA92nnoJwTRPklH5cPQF/rfnaBz2dXR2I7QaF7qKxEHPCQOKd1bkEjez6fjr2zBRtxaKCkEeUk08gYE0/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZrIho8kb; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZrIho8kb"
Received: from github.com (hubbernetes-node-6ea177f.va3-iad.github.net [10.48.201.89])
	by smtp.github.com (Postfix) with ESMTPA id 4D4FF920096
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774022138;
	bh=IvoCgi5Bp29n6GZiFlgJ8M6aTecYmchNi3Q+s06okQk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZrIho8kboShDXcb/l/IJCVA0x9hta62qWPX5WoTBpuw9RqhFlSt6luw6JSz2ClyqT
	 ZnGUnZCEum36VrD7bIR78/7IKcs0AmPHuXGQDd9gsewHLkrYC4HZV4+nJ1ig+Jo4op
	 bljZST8yT3H4o0GTDB1h0Oxm0f3Qr9d7u/XO5FCA=
Date: Fri, 20 Mar 2026 08:55:38 -0700
From: Sarveshwar Bajaj <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1069971/000000-843d17@github.com>
Subject: [bluez/bluez] 843d17: test: Fix pbap-client to work with system bus
 obexd
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

  Branch: refs/heads/1069971
  Home:   https://github.com/bluez/bluez
  Commit: 843d1755dff808c21e08ce02d2104632a343482a
      https://github.com/bluez/bluez/commit/843d1755dff808c21e08ce02d2104632a343482a
  Author: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
  Date:   2026-03-20 (Fri, 20 Mar 2026)

  Changed paths:
    M test/pbap-client

  Log Message:
  -----------
  test: Fix pbap-client to work with system bus obexd

commit 765356e80262 ("obexd: Unregister profiles when the user is
inactive") added support for running obexd on the system bus with
--system-bus flag. However, test/pbap-client was not updated to
match this change.

As a result, pbap-client fails when obexd runs on the system bus and
prints a NoReply error due to connecting over the session bus instead
of the system bus.

Fix by switching dbus.SessionBus() to dbus.SystemBus() and replacing
deprecated GObject.MainLoop with GLib.MainLoop and removing the legacy
GObject import fallback.

Tested with obexd running with --system-bus and with a paired Bluetooth
device.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
