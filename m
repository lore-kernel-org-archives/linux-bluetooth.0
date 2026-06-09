Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681848A2CA
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023063; cv=none; b=QGpj4SahrfSmI+DeMi6JQFk/AgNTlfd8IamwkWixNbWlmh/mwGZUCq4+Y4HsxwqDORqVRf0OKHLy+wOSSAMz9Xt2xMZXQLYJ3vOW90UtkLhEDOevkcaZ38k5ooyemBmlPl60bXCDnD3WfGjBO0eNM7k/lzwMCOq1Yek/+Xgo2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023063; c=relaxed/simple;
	bh=7kxjQOmA1fEuEqLiwwdFglNowIwR++JAIV6U84Vw0Qk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OqilE1HspErjRt5ePup8d1fb0NR+lBChnGF1IAQv5HXfJPGVAS++yW/MGpwleAf5wZ5F4LWYxfM1RGC4ABBJZ3UMeGBIzEMJVegV9sbmCmwpJoGg5+5kYzvMIqPNElPbnUTpviqdWdtYmKdjqw/IsnMxirptTj3WCITuHD550ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fBJfoNWu; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fBJfoNWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781023061;
	bh=faZCliEgjsSIhZ1sUyrRFCdyp3UxV7041BbDQ965WPQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fBJfoNWu/awRyBZeiE20P32ot1/agE1zsIeDS4x9VXmvglxoE5ApBLyb2NR02hYcn
	 MAgOu4hu0elFEbqzpqDS9PeKqfA2NQO2N4WzUKPjqW2amayn7g5svS1UQ87tv7V9Wu
	 NBly+TqHBuP5h08ekmZAHCjab1KC+kI31btdTOe0=
Received: from github.com (hubbernetes-node-ed3185a.va3-iad.github.net [10.48.160.15])
	by smtp.github.com (Postfix) with ESMTPA id 488D250101E
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 09:37:41 -0700 (PDT)
Date: Tue, 09 Jun 2026 09:37:41 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/622a46-912d67@github.com>
Subject: [bluez/bluez] 27eb49: shared/hci: Avoid redundant BPF filter updates
 on ...
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
  Commit: 27eb493882aed659339579adb29ca99b61042379
      https://github.com/bluez/bluez/commit/27eb493882aed659339579adb29ca99b61042379
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/shared/hci.c

  Log Message:
  -----------
  shared/hci: Avoid redundant BPF filter updates on duplicate events

Skip updating the BPF socket filter in bt_hci_register and
bt_hci_register_subevent when the event/subevent is already
registered, since it is already part of the filter.

Similarly, skip updating the filter in bt_hci_unregister and
bt_hci_unregister_subevent when other handlers for the same
event/subevent still remain in the queue.

This avoids unnecessary setsockopt(SO_ATTACH_FILTER) calls when
multiple handlers are registered for the same event code.


  Commit: 9320e1cb47494aa67cf86bc0dda1913f4e489478
      https://github.com/bluez/bluez/commit/9320e1cb47494aa67cf86bc0dda1913f4e489478
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/shared/hci.c

  Log Message:
  -----------
  shared/hci: Debounce SO_ATTACH_FILTER with timeout_add(0)

Coalesce multiple BPF filter updates into a single SO_ATTACH_FILTER
setsockopt call by deferring the update to the next event loop
iteration using timeout_add(0, ...).

When bt_hci_register_event or bt_hci_register_subevent is called
multiple times in succession (e.g. from bt_rap_attach_hci), each call
previously triggered a full filter rebuild and setsockopt. Now,
schedule_evt_filter() simply marks a pending update which fires once
in filter_timeout() after all synchronous registrations complete.


  Commit: 8bc6dd81c9c21137f0b63ac59db49c26b6af6c65
      https://github.com/bluez/bluez/commit/8bc6dd81c9c21137f0b63ac59db49c26b6af6c65
  Author: raghu447 <raghavendra.rao@collabora.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: add ASE Control Point error responses

These changes are required to Pass BAP/USR/SPE/BI-01[5]-C tests.


  Commit: 912d67d1d3a46f5ef946eec2dbe310b97247f085
      https://github.com/bluez/bluez/commit/912d67d1d3a46f5ef946eec2dbe310b97247f085
  Author: raghu447 <raghavendra.rao@collabora.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  unit/bap: add SPE tests

Add unit tests for the PTS BAP/USR/SPE/BI-01[5]-C tests.


Compare: https://github.com/bluez/bluez/compare/622a46ebcd72...912d67d1d3a4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
