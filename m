Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD37470115
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452108; cv=none; b=bakhRE93IPQKXV2J5x++DAmu6SWoMOzZtrkdB3zmi9bdQFRT8BSyIFZ5DosgmynQOycM4MciajNyYWh9+7zg5gcn3YWUQAHuUOB8yfJBGK+ggD+nISuLQO8ZQI8tTbzw3dFYKMzMjKUMhwuCLxLj8gr/t+1OodsKqKcpPfl396s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452108; c=relaxed/simple;
	bh=sWPZ69KWnlxtdiKv5btHPzOXmKv+k7Y2qdY6UF1oIIc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VwBylRK+GDrZ9ap1WWiNNYeTygP7bz5bomfI0QgMn1AB/OuS3mMw4UgNH7J7ch+49JX+3mRflLTOMiu1Onl1damk1COilNbEkcCioEqrwSD3OKke8rG2uGyt2Ji3f8Vg5MIKiSGm87aL9HsSi7fZ/kWdhKOEIZVTJIaXKdnjFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=e2suxoFS; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="e2suxoFS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791452098;
	bh=ksQglUlapWfwZJomnEnQKYe3Fw0N7VvKBAbnj8DKKTs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=e2suxoFSHhAsdD49tHdXRHLEImWeS5cpvIWp9V3dTAhU1t5uDcTD79PFj0Ocs4Oyi
	 DSt1I669lDWr/b/7azFwmu128WqpPmkof+AitpczNOzpbcMCkwtG1YtUIl9znBnoiP
	 PEe9vS4RIqamx6Ycd2oash6nDgE8xUPVTRg6AoAMwszmMbLyfbtD+2o8kC6rxULYFv
	 DMz83O6PLBjXThlWIl9OK1nIDtmdNwAxRuy49WZP7HIxhlcoAQoBxUC/+hQsU9HR4W
	 CsB2VCgPUYsEtWoHWVAJkZ4YhzeiQ0sO9nVSN2oAGe5GA5bvMUKeqwcMwaCghHABUb
	 qNzoN1lHCibug==
Received: from github.com (hubbernetes-node-60c530e.va3-iad.github.net [10.48.70.52])
	by smtp.github.com (Postfix) with ESMTPA id C21BD281500
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 02:34:58 -0700 (PDT)
Date: Thu, 08 Oct 2026 02:34:58 -0700
From: IAROSLAV VOITOVYCH <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181228/000000-5b628c@github.com>
Subject: [bluez/bluez] 639385: shared/mgmt: Fix notify leak in
 mgmt_unregister()
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

  Branch: refs/heads/1181228
  Home:   https://github.com/bluez/bluez
  Commit: 6393853cec256db4d656c7f17351ccad324f7f1c
      https://github.com/bluez/bluez/commit/6393853cec256db4d656c7f17351ccad324f7f1c
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M src/shared/mgmt.c

  Log Message:
  -----------
  shared/mgmt: Fix notify leak in mgmt_unregister()

mgmt_unregister() called from a notification callback takes the entry
off notify_list and marks it removed instead of freeing it.
process_notify() frees the removed entries still on notify_list once
the walk is done, so this one is never freed and its destroy callback
never runs.

If the callback unregisters the next entry rather than its own, this
is also a use-after-free: queue_foreach() has already saved that
entry's queue node, and queue_remove_if() frees it. That is the crash
fixed for mgmt_unregister_index() by commit 872729a91632
("shared/mgmt: Fix crash when removing index"), still present in
mgmt_unregister().

Leave the entry on the list while notifying, as mgmt_unregister_index()
and mgmt_unregister_all() do, and let process_notify() free it.
Unregistering an entry that is already marked removed now returns
false, since it is no longer registered; for an entry marked by
mgmt_unregister_index() or mgmt_unregister_all(), mgmt_unregister()
used to return true, take it off the list and leak it. No caller
checks the return value.

mgmt-tester, mesh-tester and userchan-tester unregister from event
callbacks, and under ASan each reports these entries as leaked, for
example userchan-tester:

  Direct leak of 80 byte(s) in 2 object(s) allocated from:
    #0 in malloc
    #1 in util_malloc src/shared/util.c:46
    #2 in mgmt_register src/shared/mgmt.c:974
    #3 in test_open_success tools/userchan-tester.c:275

Fixes: 872729a91632 ("shared/mgmt: Fix crash when removing index")


  Commit: 5b628cd3c7935db169bc49bd3887624f5d1bac54
      https://github.com/bluez/bluez/commit/5b628cd3c7935db169bc49bd3887624f5d1bac54
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M unit/test-mgmt.c

  Log Message:
  -----------
  unit/test-mgmt: Test unregistering from callbacks

Add /mgmt/unregister/3 to /5, where a notification callback
unregisters its own entry, the next entry, or another entry followed
by mgmt_unregister_all(). The unregistered entry must not be notified
again, its destroy callback must not run inside the notification and
must have run once by the next idle callback, and unregistering it
again must fail.

Add /mgmt/unregister/6, which unregisters outside a notification: the
entry is destroyed at once and unregistering it again fails.

Without the previous patch, /4 faults under ASan (heap-use-after-free
in queue_foreach()), /3 never destroys the entry, and /5 gets true for
an entry already marked removed.


Compare: https://github.com/bluez/bluez/compare/6393853cec25%5E...5b628cd3c793

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
