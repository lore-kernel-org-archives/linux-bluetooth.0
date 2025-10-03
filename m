Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885610F1
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508522; cv=none; b=ktOJicdKo6yTmJPqivOGsvp/3fY4EsJAPl4IilY9ELed7hMTAlxSYP4nI3bDamg91HSaOdnHmEWmC5P3AmRqeIirEFtbqraP8PX8ibLyjOwJdXy8ylvSPwvDyyyTGk1u5Q/pkJfZsnwSSooD60qjCYwCxbTkJShE/fBBlq05oh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508522; c=relaxed/simple;
	bh=sFIb5CtEsBvuZUqX7qaJv5Rtg0aUzDzWt0DacSEVASY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=j5537DMa35SpLd79XENjd8K2atDYiI4BTSRgPxZBxWqSddAcHIPqVPYoP8T18WdaEK+yF+389v0YzkVF1lyRB5kJEi4wpXrtuQGFScnXbcrv5dwG+Qe4NKWQQdp+jzlVRlandsZ+PWX0mYl+0DiVP3kdsdDFIP+se+tDsbyhtwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=S+vGjHNl; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="S+vGjHNl"
Received: from github.com (hubbernetes-node-85c6ce3.ac4-iad.github.net [10.52.13.23])
	by smtp.github.com (Postfix) with ESMTPA id 7867820A23
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759508520;
	bh=+//zn2r4RNIne7Q4B/tzg/UsHV35jrcwkcY/piYWVA0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=S+vGjHNlJLjpt2vxHaxiEnQ5ih0zB14qJt3stmOx4mmlFngiMuPRQHD+n+OHOXLJZ
	 4n4laYy1qd3FZNdGVvsmQ7oz1/CqI7IPsRAgxz9QEgBZHzM+6zkkLOA+Qbgxdy9fx5
	 4RJlII9qjpNW7RPTnDC2PIQzaXGWCTUH0oDsUuXY=
Date: Fri, 03 Oct 2025 09:22:00 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008324/000000-c3e880@github.com>
Subject: [bluez/bluez] c80697: monitor: Use PAST to refer to Periodic
 Advertising...
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

  Branch: refs/heads/1008324
  Home:   https://github.com/bluez/bluez
  Commit: c80697cdefe17c0a353a201728e5f808d2284573
      https://github.com/bluez/bluez/commit/c80697cdefe17c0a353a201728e5f808d2284573
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-03 (Fri, 03 Oct 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Use PAST to refer to Periodic Advertising Sync Transfer

This simplify the command and event names and their structs to just
use PAST in place of other terminology currently in use.


  Commit: c3e4809d6eac4440574292ede2cfb6458bbb7aca
      https://github.com/bluez/bluez/commit/c3e4809d6eac4440574292ede2cfb6458bbb7aca
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-03 (Fri, 03 Oct 2025)

  Changed paths:
    M client/scripts/broadcast-sink.bt
    M emulator/btdev.c
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  emulator: Add initial support for PAST


  Commit: c3e880574f70edfd670ffe7aa3e3c8ef1b2be916
      https://github.com/bluez/bluez/commit/c3e880574f70edfd670ffe7aa3e3c8ef1b2be916
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-03 (Fri, 03 Oct 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add tests for PAST procedures

This introduces the following tests that test PAST procedures both as
a sender, either for colocated broadcast source or a third peer, and as
receiver:

ISO Broadcaster PAST Info - Success
ISO Broadcaster PAST Sender - Success
ISO Broadcaster PAST Receiver - Success


Compare: https://github.com/bluez/bluez/compare/c80697cdefe1%5E...c3e880574f70

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
