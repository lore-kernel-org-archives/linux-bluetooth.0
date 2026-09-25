Received: from out-1.smtp.github.com (out-1.smtp.github.com [192.30.252.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E932446066
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362795; cv=none; b=pQN24s87jIWR+ltvxVYSc4H5iZMEdMAENEcFHJkLaoUSSCAn3EnrOrwYR6DHrRTl7e6orUNMre1UGpI9YGQT92LwAP+7Mhxh6f8/CK6nYyzsmh56ldEVdyAPbT8grOlRWw67lr1sY8413bl9Sjm8qbKYx1B0YKewSNpwEjyru5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362795; c=relaxed/simple;
	bh=Rf6GK5j0YFN7PWsRBnuRtSUmDeYam98hOdE943BO6r8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kT5ocXi/Zgq/zch3a2eOOJzap93zG3LpvEnsbgBnhT6xo4cUYOOCB8CFUv5OqE3wiuGZMDLxMsjAT4N4U8cI9YOy5yM8yDPDTv0XedHX8C2KDcrTT+MlRqQ6WpXOKaJBqxYXpbbdIxZfEt0OVhBS7OeGmeBJ7XJO+JaWBuLpOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WolBvHO+; arc=none smtp.client-ip=192.30.252.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WolBvHO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790362793;
	bh=Cn8RONad5PhWKRgq8lnHLiwGwmxPCva2iJ8Me7ljl1E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WolBvHO+wgNz1Fa6uj8vXFWunwCbSqZZkb7FjQpqrwlleaR3mEZRcS6imUXS61iKr
	 twU1sgXp6Ae3ol9PFQoRXZQH9fB8BC8KhknZRnlsM9J4cxo0iqva0z5x/+MMIbYATR
	 Fz24QIhnBWgZyndKYVYGnWoZihxmevzVa6Q0Y5jQ=
Received: from github.com (hubbernetes-node-17ab701.va3-iad.github.net [10.48.81.84])
	by smtp.github.com (Postfix) with ESMTPA id 5F60734061D
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 11:59:53 -0700 (PDT)
Date: Fri, 25 Sep 2026 11:59:53 -0700
From: "ooonea.eth" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173956/000000-494109@github.com>
Subject: [bluez/bluez] de087b: input: Reset report map state on detach
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

  Branch: refs/heads/1173956
  Home:   https://github.com/bluez/bluez
  Commit: de087bad140bfa2bf382787f9c2e181cff9e45c4
      https://github.com/bluez/bluez/commit/de087bad140bfa2bf382787f9c2e181cff9e45c4
  Author: Giuseppe Piscitelli <35407790+ooonea@users.noreply.github.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  input: Reset report map state on detach

read_report_map() leaves report_map_id set after a failed read. Detach
cancels queued GATT operations but retains that ID, so a later attach
cannot request the report map again and never creates the UHID device.

Clear the ID when cancelling GATT operations on detach. This also lets
a reconnect retry a read that was still pending at disconnection.

A socketpair reproducer fails to read the map after either an ATT error
or cancellation before this change; both cases create UHID afterwards.
The existing HoG and UHID unit tests also pass.

Assisted-by: OpenAI Codex:gpt-6


  Commit: 4941097ab417c71166859916d7b9dfa0f2695f5f
      https://github.com/bluez/bluez/commit/4941097ab417c71166859916d7b9dfa0f2695f5f
  Author: Giuseppe Piscitelli <35407790+ooonea@users.noreply.github.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M Makefile.am
    M unit/test-hog.c

  Log Message:
  -----------
  unit: Test HoG report map reads after reconnect

Exercise reconnect after an ATT error and after cancelling a pending
Report Map read. Require a fresh read and validate the resulting
UHID_CREATE2 descriptor on a simulated transport.

Stub Bluetooth address lookup for the Unix socketpair fixture. Both
cases fail without resetting report_map_id on detach.

Assisted-by: OpenAI Codex:gpt-6


Compare: https://github.com/bluez/bluez/compare/de087bad140b%5E...4941097ab417

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
