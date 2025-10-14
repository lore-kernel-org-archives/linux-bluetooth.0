Received: from xtrwsrct.outbound-mail.sendgrid.net (xtrwsrct.outbound-mail.sendgrid.net [167.89.101.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4F1FB1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.101.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481111; cv=none; b=KIERl6aSDFc26Rp8mgvWZsYpXuJ5ytjCZl5vijsbRyE4VzcojWRRIk/gJnXwhF+V8+o2QpmGp4F2MvKbDk16kk0vCmlUjO/2KEwj4j6V6UNwkUiMl5ZtTZbzKYKpwwvrhxWNnO1utBkz4TSNqKLViAWaAf+rHma19HF4lq6CZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481111; c=relaxed/simple;
	bh=D+HXnfAgdUAg5wVVtf6UY1PUHg8Qvbe1GxxjRy2+17M=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=kMZ1ltD0LG9wt0LiY90JjocTSRY2yxscigSdDniCySH/Js9e8aNcYeJ18J3KHdRUls2bYeZqi8QmqslXI/YOkAnEGYQaLPbCtRWvQWukVEvkZMlGWiEA2YVc4F2dOX64Sp8Vp8YCtnD8ili4AIwqX2KVUayVDDlefo/l3zjJEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I2MA8q/c; arc=none smtp.client-ip=167.89.101.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I2MA8q/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=D4uoFB2JzsokQuPY0oAKSqcmoXla/ZFmh8ChAgCgxI0=;
	b=I2MA8q/cwwEv2H0ealkDM1nWLIKWIA9Xt5O4N3Nsh47qVfu5DWWchWLv6tyiqKgtIxfB
	C9Q4w/0yxBwVbHzuOjj0VvpFcpX3Hz+Cpit2r4KYzhhWdUFy0LzBN2EWh76AjoYcvplSW2
	hHUX9NxbOISj32ErqubI2jRUhyiMVlTLI=
Received: by recvd-6fc848bf8d-cmxpr with SMTP id recvd-6fc848bf8d-cmxpr-1-68EECF54-83
	2025-10-14 22:31:48.682584886 +0000 UTC m=+11425624.662528397
Received: from out-25.smtp.github.com (unknown)
	by geopod-ismtpd-22 (SG)
	with ESMTP id gmuPWR7HQOeYEM4ZyqYGPA
	for <linux-bluetooth@vger.kernel.org>;
	Tue, 14 Oct 2025 22:31:48.637 +0000 (UTC)
Received: from github.com (hubbernetes-node-7c42e0d.ash1-iad.github.net [10.56.200.81])
	by smtp.github.com (Postfix) with ESMTPA id 174BD14115C
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 15:31:42 -0700 (PDT)
Date: Tue, 14 Oct 2025 22:31:48 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/2db2d3-025d2e@github.com>
Subject: [bluez/bluez] fb183b: client/player: Add 'auto' option to
 transport.acquire
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2E8ki=2FFbqwlQO04QBiriT34f6qhM6wd38+BQvADylPPTIQmeZqt0Mdj+E9P?=
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIAidk7I9ugkZE?=
 =?us-ascii?Q?EHBXrIGDWyYyXHmkKOIFfQe3nQ5PkSikzhASozg?=
 =?us-ascii?Q?LRfR4L4gwqCvpbgsE5DxUTiDgrDOyaII9IB2xkY?=
 =?us-ascii?Q?mHmiOUqjyQDFuOcQfi7SdUyS9MaIE=2FuHlPVXour?=
 =?us-ascii?Q?jHzLj+AYTC5CFDTLTOSq1zu+ihdJeagkRyL5Szj?=
 =?us-ascii?Q?xtX8RBGhqqHQMu1obMujzmA1zw=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: fb183b2805eeb04eb6730c4e5f39fe705898dcf1
      https://github.com/bluez/bluez/commit/fb183b2805eeb04eb6730c4e5f39fe705898dcf1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add 'auto' option to transport.acquire

This enables transport.acquire auto which enables to overwrite the
default behavior of prompting when endpoint is registering without
setting auto accept.


  Commit: 5d2616a70c5e18d90b41596ba3b5eccea87de19c
      https://github.com/bluez/bluez/commit/5d2616a70c5e18d90b41596ba3b5eccea87de19c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add 'auto' option to transport.select

This enables transport.select auto which enables to auto select the
broadcast transport configured with the local endpoints, the selecting
process will also dealt with linking the transport so it needs a timer
that waits all transports to be configure to then start linking and
finally select.


  Commit: dacb93ddc1b9c2a2a345ea02ab7eccbd29ac6289
      https://github.com/bluez/bluez/commit/dacb93ddc1b9c2a2a345ea02ab7eccbd29ac6289
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Attempt to reuse object paths whenever possible

This attempts to reuse object paths whenever possible to make
scripting a little more predictable by not having the fd number
being increased regardless of the actual number of transports.


  Commit: 620c5b4af4fd78d0d11b9e996e677471dd2d316c
      https://github.com/bluez/bluez/commit/620c5b4af4fd78d0d11b9e996e677471dd2d316c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Use PAST to refer to Periodic Advertising Sync Transfer

This simplify the command and event names and their structs to just
use PAST in place of other terminology currently in use.


  Commit: 8656f1aa15560e96ff34cf5f684814ef6c9bd9d2
      https://github.com/bluez/bluez/commit/8656f1aa15560e96ff34cf5f684814ef6c9bd9d2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M client/scripts/broadcast-sink.bt
    M emulator/btdev.c
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  emulator: Add initial support for PAST


  Commit: d4811ecbcef6ea99e1a19b29b5fe705140da8637
      https://github.com/bluez/bluez/commit/d4811ecbcef6ea99e1a19b29b5fe705140da8637
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add tests for PAST procedures

This introduces the following tests that test PAST procedures both as
a sender, either for colocated broadcast source or a third peer, and as
receiver:

ISO Broadcaster PAST Info - Success
ISO Broadcaster PAST Info RPA - Success
ISO Broadcaster PAST Sender - Success
ISO Broadcaster PAST Receiver - Success


  Commit: a6974c55c0c417d769604a28f14ea398897fdfa7
      https://github.com/bluez/bluez/commit/a6974c55c0c417d769604a28f14ea398897fdfa7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for PAST MGMT settings and flags

This adds parising support for PAST MGMT settings and device flags.


  Commit: 5c53260bd5c4c86f7f771e15629a344651b7b5a1
      https://github.com/bluez/bluez/commit/5c53260bd5c4c86f7f771e15629a344651b7b5a1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M doc/mgmt.rst
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  MGMT: Add PAST Settings and Flags

This adds PAST Settings and Flags definitions and documentation.


  Commit: 025d2ef81245cce52539339d18deb6e72e1d7ba8
      https://github.com/bluez/bluez/commit/025d2ef81245cce52539339d18deb6e72e1d7ba8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M doc/iso.rst

  Log Message:
  -----------
  iso.rst: Add documentation for PAST/rebind

This documents how to use PAST procedures by doing bind on already
connected socket.


Compare: https://github.com/bluez/bluez/compare/2db2d3593799...025d2ef81245

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
