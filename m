Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57C3382F7
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578314; cv=none; b=TEXRUxSnwWcTH6rW1Zlrp3VBg83oazbBSwawpEJ+rBNsRgqYG0qVGtpCU0zUpnkf2ntRjnRULpJKg2g4jTHon1zAl+a4pKQ7gOcwH9G64hgDu63SLbn2uyItNVJUH67p0fOl2Y/zOcYP5HEzVIX73jw4BnkVTH5nPRf+66CXMTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578314; c=relaxed/simple;
	bh=Pgtvjf+eJo4+OMAL2HZj1kK55bZVtxwNL7HRVMSGWRw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=V9rmtZimAlfc8JfKheAE3kUrrZ1ocFn3UU0FxFgap0zcjCQ4iUo6MwL2Mt5J6gFiimKPu/AY0VNJZV7nYIM6Szd1tfxDJUgAoGyVo+o4v8u8ItAs2bCcNBZ2/5DSadYN87AaYQEmKJxJwNIR6ObpZWgMA8ofpq4mgEl0vfqPZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UvKPBVKi; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UvKPBVKi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777578312;
	bh=MMjLB+bGN5Kr3o6EATAngk3DIhdoRg3ZSpiXVfIlmEQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UvKPBVKibFa8KPEepjAnN0cJiylozFy2vudu1eY6jz5yRc/x0XGHZTyfIduh3mKIc
	 rkImWEPFN54DkLBJIN3eWMWNIi4HfdOoXUPR8bujL2hKwkwJT2bgRjTA7wh2zLS+qc
	 Ub/lJX+pqkC6/QaPDiM4lh97VjQPtMfQw4pMEZHE=
Received: from github.com (hubbernetes-node-e44b0b4.ac4-iad.github.net [10.52.223.16])
	by smtp.github.com (Postfix) with ESMTPA id 15B7D78117D
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 12:45:11 -0700 (PDT)
Date: Thu, 30 Apr 2026 12:45:11 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/303ea3-d01616@github.com>
Subject: [bluez/bluez] d01616: gatt-client: Fix use-after-free caused by
 reentran...
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
  Commit: d01616f0c276a441dad8afe4e8f7bb261b26ba0a
      https://github.com/bluez/bluez/commit/d01616f0c276a441dad8afe4e8f7bb261b26ba0a
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-04-30 (Thu, 30 Apr 2026)

  Changed paths:
    M src/gatt-client.c

  Log Message:
  -----------
  gatt-client: Fix use-after-free caused by reentrant client teardown

btd_gatt_client_service_removed() can be called reentrantly via
bt_gatt_client_unref() after the services queue has already been freed,
resulting in a use-after-free.

Reset client->ready to false before destroying the services queue to
prevent reentrant calls from dereferencing freed memory.

This was found with the following backtrace:

    #0  match_service_handle ()
    #1  queue_remove_if ()
    #2  queue_remove_all ()
    #3  btd_gatt_client_service_removed ()
    #4  gatt_service_removed ()
    #5  handle_notify ()
    #6  queue_foreach ()
    #7  notify_service_changed ()
    #8  gatt_db_service_destroy ()
    #9  queue_remove_all ()
    #10 gatt_db_clear_range ()
    #11 service_changed_failure ()
    #12 discovery_op_unref ()
    #13 bt_gatt_request_unref ()
    #14 bt_gatt_client_cancel_all ()
    #15 bt_gatt_client_free ()
    #16 bt_gatt_client_unref ()
    #17 bt_gatt_client_free ()
    #18 bt_gatt_client_unref ()
    #19 btd_gatt_client_destroy ()
    #20 device_free ()



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
