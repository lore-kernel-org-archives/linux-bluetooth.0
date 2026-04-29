Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB23F54BB
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463868; cv=none; b=UAOGuGHQxDXEL+2oAIqeXmec9TbKqPqFcCqTmeytOdtD7onmhUVdTD1UPg4Hxg7l7K/T6N0C8SrKYA01Ka72JaG37liQwSh+ltwbLmhuqE81Fh0tmOU/+xJT9lPXxBWKR6DKHOtDKjofWRSE1iqnkxymLLmpk59dAmq/ZL5jjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463868; c=relaxed/simple;
	bh=6yCnzwMgQDxP+wktv0IgbDd6unbHAPdkoE+9G+bhaTk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ezsa6MQBdIpYO323nvga9L61z18Sfqsn8ZPY8VSzDN5BjIjsCMKRMGwh1pLiaB0KiqFkx9o/Oua4/Zg519x5KgpKJsBxFnBbs+d3EsBac/vI8FEkpaHMVd3h6t2lmJx59tgfwbHa9JFy3/Lp50vYqk6zlLaxUcKwtYlmUvtA6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a8IxjG3/; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a8IxjG3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777463864;
	bh=wYERINIyEGf7I4jF3i48m/gZDupVnRfyG2ls91RGMRI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a8IxjG3/YkIMSNeDw0mmkJSoFZ3bhaym+uzoEhzQJ8Oo9rPaL0JBMyWs06LliYbok
	 iNQBas3XrTLStgY2pCdNLQqzVoF/+IeZE+lzx+6sTvsOk2iFF+3CWBH1L/Fg5OfrM5
	 AoNj0055KyyZHNYbmQwG/AoczGvwYeYwqKID55jI=
Received: from github.com (hubbernetes-node-a727a6c.ac4-iad.github.net [10.52.125.60])
	by smtp.github.com (Postfix) with ESMTPA id 25FB1A1175
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 04:57:44 -0700 (PDT)
Date: Wed, 29 Apr 2026 04:57:44 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1087435/000000-07c44f@github.com>
Subject: [bluez/bluez] 07c44f: gatt-client: Fix use-after-free caused by
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

  Branch: refs/heads/1087435
  Home:   https://github.com/bluez/bluez
  Commit: 07c44f7b5232fc39c0dbad1e351210daac0c77db
      https://github.com/bluez/bluez/commit/07c44f7b5232fc39c0dbad1e351210daac0c77db
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

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

Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
