Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8E130492
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281524; cv=none; b=tlJ83g7UFX4GDyLCZ8Z2P3/FbzyjMemT9yDczgl1SJNe+0SJgYKbHlCteNzuk/3MTGLbK1/iO9rY26HkxAFRhWcCWjcfhSTuFKOZxV3yU4xwcTIVIs3HYxSaSv2f1Sk6tnLaZ1MoRCjDcxhLhpiGgqpMU4p0AT/q+Mz+Ayzv+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281524; c=relaxed/simple;
	bh=lbz18IGmehc15EZYcltT3YWI4eSF1ULZxqb6P0iDm+U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LbxM5zrRTHAvFYLOl0kmwiEb41xFtPYqWlEAaUaNYG+wFRPy6arU6qg1bzbCKaWoXfsyHT8FdCANLmXCw3l1un+Cg5IBRhpA7MCTdf3MGJd2W06Q1GRz+nZgZvzGLWf6iz4B5UUSrYCziSn87oZeRXuMrjlujmf4tSI8ylkJyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V5uz5lGP; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V5uz5lGP"
Received: from github.com (hubbernetes-node-b5859dc.ac4-iad.github.net [10.52.141.32])
	by smtp.github.com (Postfix) with ESMTPA id 9BD9D5E0808
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713281522;
	bh=N4hhHCjlL0jqPalG0vEgDrp89dwOemD1a1epnGuukqE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V5uz5lGPIhLToF6kUjcZNUFr8badHStsmuDLZF1zKQ0Mb9kal9NiDqZLdexSZfS2Y
	 eA7w6tPPzWGcUUZ70MNO9drBeUrFYCoXcJV2ok7eLtz6z6TuxnYSGguHI1xt1hN9a+
	 XE5LKbxzKO/XIuddN8ULF7WIcQPbXNDz7zpYCwGY=
Date: Tue, 16 Apr 2024 08:32:02 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b94f1b-b411b9@github.com>
Subject: [bluez/bluez] f78e63: shared/bap: clean up requests for a stream
 before ...
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
  Commit: f78e639f810cb9b7469ad55af0af1dc930ac8502
      https://github.com/bluez/bluez/commit/f78e639f810cb9b7469ad55af0af1dc930ac8502
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-16 (Tue, 16 Apr 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: clean up requests for a stream before freeing it

Cancel stream's queued requests before freeing the stream.

As the callbacks may do some cleanup on error, be sure to call them
before removing the requests.

Fixes:
=======================================================================
ERROR: AddressSanitizer: heap-use-after-free on address 0x60d000013430
READ of size 8 at 0x60d000013430 thread T0
    #0 0x89cb9f in stream_stop_complete src/shared/bap.c:1211
    #1 0x89c997 in bap_req_complete src/shared/bap.c:1192
    #2 0x8a105f in bap_process_queue src/shared/bap.c:1474
    #3 0x93c93f in timeout_callback src/shared/timeout-glib.c:25
...
freed by thread T0 here:
    #1 0x89b744 in bap_stream_free src/shared/bap.c:1105
    #2 0x89bac8 in bap_stream_detach src/shared/bap.c:1122
    #3 0x89dbfc in bap_stream_state_changed src/shared/bap.c:1261
    #4 0x8a2169 in bap_ucast_set_state src/shared/bap.c:1554
    #5 0x89e0d5 in stream_set_state src/shared/bap.c:1291
    #6 0x8a78b6 in bap_ucast_release src/shared/bap.c:1927
    #7 0x8d45bb in bt_bap_stream_release src/shared/bap.c:5516
    #8 0x8ba63f in remove_streams src/shared/bap.c:3538
    #9 0x7f23d0 in queue_foreach src/shared/queue.c:207
    #10 0x8bb875 in bt_bap_remove_pac src/shared/bap.c:3593
    #11 0x47416c in media_endpoint_destroy profiles/audio/media.c:185
=======================================================================


  Commit: d3a6a6459cbda91693106fb8d43de319b334a3a4
      https://github.com/bluez/bluez/commit/d3a6a6459cbda91693106fb8d43de319b334a3a4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-16 (Tue, 16 Apr 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: cancel stream operation before freeing setup

Before freeing setup, cancel any ongoing stream operations, and indicate
failure for pending DBus replies.

Fixes:
=======================================================================
ERROR: AddressSanitizer: heap-use-after-free on address 0x60d000004758
WRITE of size 4 at 0x60d000004758 thread T0
    #0 0x557159 in qos_cb profiles/audio/bap.c:753
    #1 0x89c38f in bap_req_complete src/shared/bap.c:1191
    #2 0x8cb7fc in bap_req_detach src/shared/bap.c:4789
    #3 0x8cb9bb in bt_bap_detach src/shared/bap.c:4801
    #4 0x571e25 in bap_disconnect profiles/audio/bap.c:3011
    ...
freed by thread T0 here:
    #1 0x558f2b in setup_free profiles/audio/bap.c:890
    #2 0x7f34e8 in queue_remove_all src/shared/queue.c:341
    #3 0x7f0105 in queue_destroy src/shared/queue.c:60
    #4 0x55cdc8 in ep_free profiles/audio/bap.c:1167
=======================================================================


  Commit: b411b98bf4f51c18c77626f786a4f2b8cdc28982
      https://github.com/bluez/bluez/commit/b411b98bf4f51c18c77626f786a4f2b8cdc28982
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-16 (Tue, 16 Apr 2024)

  Changed paths:
    M src/set.c
    M src/set.h

  Log Message:
  -----------
  set: don't modify input sirk key in btd_set_add_device()

Currently, btd_set_add_device decrypts the sirk in-place, modifying the
key passed to it.

This causes store_sirk() later on to save the wrong (decrypted) key
value, resulting to invalid duplicate device set.

It also allows devices->sirk list to contain same set multiple times,
which crashes later on as sirks-set are assumed to be 1-to-1 in
btd_set_add/remove_device().

Fixes:
=======================================================================
ERROR: AddressSanitizer: heap-use-after-free on address 0x60600001c068
READ of size 8 at 0x60600001c068 thread T0
    #0 0x762721 in btd_set_remove_device src/set.c:347
    #1 0x7341e7 in remove_sirk_info src/device.c:7145
    #2 0x7f2cee in queue_foreach src/shared/queue.c:207
    #3 0x734499 in btd_device_unref src/device.c:7159
    #4 0x719f65 in device_remove src/device.c:4788
    #5 0x682382 in adapter_remove src/adapter.c:6959
    ...
0x60600001c068 is located 40 bytes inside of 56-byte region [0x60600001c040,0x60600001c078)
freed by thread T0 here:
    #1 0x7605a6 in set_free src/set.c:170
    #2 0x7d4eff in remove_interface gdbus/object.c:660
    #3 0x7dcbb3 in g_dbus_unregister_interface gdbus/object.c:1394
    #4 0x762990 in btd_set_remove_device src/set.c:362
    #5 0x7341e7 in remove_sirk_info src/device.c:7145
    #6 0x7f2cee in queue_foreach src/shared/queue.c:207
    #7 0x734499 in btd_device_unref src/device.c:7159
    #8 0x719f65 in device_remove src/device.c:4788
    #9 0x682382 in adapter_remove src/adapter.c:6959
    ...
previously allocated by thread T0 here:
    #1 0x7f5429 in util_malloc src/shared/util.c:46
    #2 0x7605f1 in set_new src/set.c:178
    #3 0x7625b9 in btd_set_add_device src/set.c:324
    #4 0x6f8fc8 in add_set src/device.c:1916
    #5 0x7f2cee in queue_foreach src/shared/queue.c:207
    #6 0x6f982c in device_set_ltk src/device.c:1940
    #7 0x667b97 in load_ltks src/adapter.c:4478
    ...
=======================================================================


Compare: https://github.com/bluez/bluez/compare/b94f1be656f3...b411b98bf4f5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
