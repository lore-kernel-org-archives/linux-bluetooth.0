Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2C180A99
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019709; cv=none; b=YWiiaX8RMk8PQYZR3wCE4rV1Le0UbRj73CyE5yMOpsxc00UTYZ4ecADuj1f4t8rkDPYyJ7xRoY3KrUYrBcpIcHKikf1PxeJOC9vhZ0TZLx/aqh60QNA/6dhab0IqwvOlLD6HU3WhT0IUCdQOJWMT5xYMgVyhGdDUgraa0EkXkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019709; c=relaxed/simple;
	bh=WgxsLb2cI2VGSUgFIGCMUma6A5FH+ZAhFLLmYhxJp48=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cvU0R2NkhJxHPr/PPFcIM4uBrFkmwGxUdXEz6n6DqC2n/UReFmRQGroKMzVvXhx7Nr4nR+E8JkhetUNAZdw5IWjhqsvAcBaguuv9GaV9v3199uflFcVbtSoUPxnxPln77atfsLYyN1xHQQ7R7ZfSz8FpS7WC4xDg5A83/S6ce9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KNp8N3fh; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KNp8N3fh"
Received: from github.com (hubbernetes-node-5b0aef3.va3-iad.github.net [10.48.142.39])
	by smtp.github.com (Postfix) with ESMTPA id B6F818C0A70
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1720019706;
	bh=rNRjQjb7Z1qmuO2eQr8G8Rqrh4/gBUv2pEnzJ38j/GU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KNp8N3fhykFe5FymbXv4QYguPWiiZDSc+aekwIYL2/pHoio4ItwkE4md5e8F8S2pT
	 ZsKpVXpmfEN5Ovtc9VA8e+nuLSQbU9334i+pzwVg8/7q/NWSK/9zl90ak1Oc04SqjJ
	 bhyuPfufQ/XNnZN6Bob3iUSqsCeLQi53DUDLga+g=
Date: Wed, 03 Jul 2024 08:15:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/be0b08-176cf2@github.com>
Subject: [bluez/bluez] 7c896d: avdtp: Fix manipulating struct as an array
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
  Commit: 7c896d7b73cbad2e073fccfb7ddb765f8468602c
      https://github.com/bluez/bluez/commit/7c896d7b73cbad2e073fccfb7ddb765f8468602c
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Fix manipulating struct as an array

Don't manipulate the "req" structs as if they were flat arrays, static
analysis and humans are both equally confused by this kind of usage.

Error: ARRAY_VS_SINGLETON (CWE-119): [#def26] [important]
profiles/audio/avdtp.c:1675:2: address_of: Taking address with "&start->first_seid" yields a singleton pointer.
profiles/audio/avdtp.c:1675:2: assign: Assigning: "seid" = "&start->first_seid".
profiles/audio/avdtp.c:1679:25: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations.
1677|           int i;
1678|
1679|->         for (i = 0; i < count; i++, seid++) {
1680|                   if (seid->seid == id) {
1681|                           req->collided = TRUE;

Error: ARRAY_VS_SINGLETON (CWE-119): [#def27] [important]
profiles/audio/avdtp.c:1690:2: address_of: Taking address with "&suspend->first_seid" yields a singleton pointer.
profiles/audio/avdtp.c:1690:2: assign: Assigning: "seid" = "&suspend->first_seid".
profiles/audio/avdtp.c:1694:25: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations.
1692|		int i;
1693|
1694|->		for (i = 0; i < count; i++, seid++) {
1695|			if (seid->seid == id) {
1696|				req->collided = TRUE;

Error: ARRAY_VS_SINGLETON (CWE-119): [#def28] [important]
profiles/audio/avdtp.c:1799:2: address_of: Taking address with "&req->first_seid" yields a singleton pointer.
profiles/audio/avdtp.c:1799:2: assign: Assigning: "seid" = "&req->first_seid".
profiles/audio/avdtp.c:1801:30: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations.
1799|		seid = &req->first_seid;
1800|
1801|->		for (i = 0; i < seid_count; i++, seid++) {
1802|			failed_seid = seid->seid;
1803|

Error: ARRAY_VS_SINGLETON (CWE-119): [#def29] [important]
profiles/audio/avdtp.c:1912:2: address_of: Taking address with "&req->first_seid" yields a singleton pointer.
profiles/audio/avdtp.c:1912:2: assign: Assigning: "seid" = "&req->first_seid".
profiles/audio/avdtp.c:1914:30: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations.
1912|		seid = &req->first_seid;
1913|
1914|->	for (i = 0; i < seid_count; i++, seid++) {
1915|			failed_seid = seid->seid;
1916|


  Commit: 3f1b3c624a9600f73ebb8f31c9533467b8b32584
      https://github.com/bluez/bluez/commit/3f1b3c624a9600f73ebb8f31c9533467b8b32584
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M mesh/prov-initiator.c

  Log Message:
  -----------
  mesh: Avoid accessing array out-of-bounds

We would boundary check the expected_pdu_size array based on the value
of type, but would still access it out-of-bounds for the debug message.
Split off the invalid type check into its own message to avoid this.

Error: OVERRUN (CWE-119): [#def23] [important]
mesh/prov-initiator.c:676:2: cond_at_least: Checking "type >= 10UL" implies that "type" is at least 10 on the true branch.
mesh/prov-initiator.c:678:3: overrun-local: Overrunning array "expected_pdu_size" of 10 2-byte elements at element index 10 (byte offset 21) using index "type" (which evaluates to 10).
676|	if (type >= L_ARRAY_SIZE(expected_pdu_size) ||
677|					len != expected_pdu_size[type]) {
678|->		l_error("Expected PDU size %d, Got %d (type: %2.2x)",
679|			expected_pdu_size[type], len, type);
680|		fail_code[1] = PROV_ERR_INVALID_FORMAT;


  Commit: 99750d2acd9deba2870932ecaa8050263b9dc8de
      https://github.com/bluez/bluez/commit/99750d2acd9deba2870932ecaa8050263b9dc8de
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M obexd/plugins/messages-dummy.c

  Log Message:
  -----------
  obexd: Fix possible memleak

Fix possible resource leak if a attribute is repeated, overriding the
original value.

Error: RESOURCE_LEAK (CWE-772): [#def28] [important]
obexd/plugins/messages-dummy.c:362:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
obexd/plugins/messages-dummy.c:362:4: var_assign: Assigning: "entry->handle" = storage returned from "g_strdup_inline(values[i])".
obexd/plugins/messages-dummy.c:362:4: overwrite_var: Overwriting "entry->handle" in "entry->handle = g_strdup_inline(values[i])" leaks the storage that "entry->handle" points to.
360|	for (i = 0 ; names[i]; ++i) {
361|		if (g_strcmp0(names[i], "handle") == 0) {
362|->			entry->handle = g_strdup(values[i]);
363|			mld->size++;
364|			continue;

Error: RESOURCE_LEAK (CWE-772): [#def29] [important]
obexd/plugins/messages-dummy.c:367:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
obexd/plugins/messages-dummy.c:367:4: var_assign: Assigning: "entry->attachment_size" = storage returned from "g_strdup_inline(values[i])".
obexd/plugins/messages-dummy.c:367:4: overwrite_var: Overwriting "entry->attachment_size" in "entry->attachment_size = g_strdup_inline(values[i])" leaks the storage that "entry->attachment_size" points to.
365|		}
366|		if (g_strcmp0(names[i], "attachment_size") == 0) {
367|->			entry->attachment_size = g_strdup(values[i]);
368|			continue;
369|		}

Error: RESOURCE_LEAK (CWE-772): [#def30] [important]
obexd/plugins/messages-dummy.c:371:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
obexd/plugins/messages-dummy.c:371:4: var_assign: Assigning: "entry->datetime" = storage returned from "g_strdup_inline(values[i])".
obexd/plugins/messages-dummy.c:371:4: overwrite_var: Overwriting "entry->datetime" in "entry->datetime = g_strdup_inline(values[i])" leaks the storage that "entry->datetime" points to.
369|		}
370|		if (g_strcmp0(names[i], "datetime") == 0) {
371|->			entry->datetime = g_strdup(values[i]);
372|			continue;
373|		}

Error: RESOURCE_LEAK (CWE-772): [#def31] [important]
obexd/plugins/messages-dummy.c:375:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
obexd/plugins/messages-dummy.c:375:4: var_assign: Assigning: "entry->subject" = storage returned from "g_strdup_inline(values[i])".
obexd/plugins/messages-dummy.c:375:4: overwrite_var: Overwriting "entry->subject" in "entry->subject = g_strdup_inline(values[i])" leaks the storage that "entry->subject" points to.
373|		}
374|		if (g_strcmp0(names[i], "subject") == 0) {
375|->			entry->subject = g_strdup(values[i]);
376|			continue;
377|		}

Error: RESOURCE_LEAK (CWE-772): [#def32] [important]
obexd/plugins/messages-dummy.c:379:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
obexd/plugins/messages-dummy.c:379:4: var_assign: Assigning: "entry->recipient_addressing" = storage returned from "g_strdup_inline(values[i])".
obexd/plugins/messages-dummy.c:379:4: overwrite_var: Overwriting "entry->recipient_addressing" in "entry->recipient_addressing = g_strdup_inline(values[i])" leaks the storage that "entry->recipient_addressing" points to.
377|		}
378|		if (g_strcmp0(names[i], "recipient_addressing") == 0) {
379|->			entry->recipient_addressing = g_strdup(values[i]);
380|			continue;
381|		}

Error: RESOURCE_LEAK (CWE-772): [#def33] [important]
obexd/plugins/messages-dummy.c:383:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
obexd/plugins/messages-dummy.c:383:4: var_assign: Assigning: "entry->sender_addressing" = storage returned from "g_strdup_inline(values[i])".
obexd/plugins/messages-dummy.c:383:4: overwrite_var: Overwriting "entry->sender_addressing" in "entry->sender_addressing = g_strdup_inline(values[i])" leaks the storage that "entry->sender_addressing" points to.
381|		}
382|		if (g_strcmp0(names[i], "sender_addressing") == 0) {
383|->			entry->sender_addressing = g_strdup(values[i]);
384|			continue;
385|		}

Error: RESOURCE_LEAK (CWE-772): [#def34] [important]
obexd/plugins/messages-dummy.c:387:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
obexd/plugins/messages-dummy.c:387:4: var_assign: Assigning: "entry->type" = storage returned from "g_strdup_inline(values[i])".
obexd/plugins/messages-dummy.c:387:4: overwrite_var: Overwriting "entry->type" in "entry->type = g_strdup_inline(values[i])" leaks the storage that "entry->type" points to.
385|		}
386|		if (g_strcmp0(names[i], "type") == 0) {
387|->			entry->type = g_strdup(values[i]);
388|			continue;
389|		}

Error: RESOURCE_LEAK (CWE-772): [#def35] [important]
obexd/plugins/messages-dummy.c:391:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
obexd/plugins/messages-dummy.c:391:4: var_assign: Assigning: "entry->reception_status" = storage returned from "g_strdup_inline(values[i])".
obexd/plugins/messages-dummy.c:391:4: overwrite_var: Overwriting "entry->reception_status" in "entry->reception_status = g_strdup_inline(values[i])" leaks the storage that "entry->reception_status" points to.
389|		}
390|		if (g_strcmp0(names[i], "reception_status") == 0)
391|->			entry->reception_status = g_strdup(values[i]);
392|	}
393|


  Commit: 4b3fe69df7c77043d8f4b39a34431e4ef19c2071
      https://github.com/bluez/bluez/commit/4b3fe69df7c77043d8f4b39a34431e4ef19c2071
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M obexd/plugins/messages-dummy.c

  Log Message:
  -----------
  obexd: Fix memory leak in entry struct

recipient_addressing was never freed.

Error: RESOURCE_LEAK (CWE-772): [#def36] [important]
obexd/plugins/messages-dummy.c:379:4: alloc_fn: Storage is returned from allocation function "g_strdup_inline".
obexd/plugins/messages-dummy.c:379:4: var_assign: Assigning: "entry->recipient_addressing" = storage returned from "g_strdup_inline(values[i])".
obexd/plugins/messages-dummy.c:404:2: leaked_storage: Freeing "entry" without freeing its pointer field "recipient_addressing" leaks the storage that "recipient_addressing" points to.
402|	g_free(entry->attachment_size);
403|	g_free(entry->handle);
404|->	g_free(entry);
405|   }
406|


  Commit: 5475aba84edcafe5f7d2043262a780312ceef27a
      https://github.com/bluez/bluez/commit/5475aba84edcafe5f7d2043262a780312ceef27a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M obexd/plugins/pcsuite.c

  Log Message:
  -----------
  obexd: Fix leak in backup_object struct

Error: RESOURCE_LEAK (CWE-772): [#def37] [important]
obexd/plugins/pcsuite.c:370:2: alloc_fn: Storage is returned from allocation function "g_path_get_basename".
obexd/plugins/pcsuite.c:370:2: var_assign: Assigning: "obj->cmd" = storage returned from "g_path_get_basename(name)".
obexd/plugins/pcsuite.c:379:3: leaked_storage: Freeing "obj" without freeing its pointer field "cmd" leaks the storage that "cmd" points to.
377|
378|	if (send_backup_dbus_message("open", obj, size) == FALSE) {
379|->		g_free(obj);
380|		obj = NULL;
381|	}


  Commit: d79e429a9fc3c37b3a25fcde474c242d8b094bcc
      https://github.com/bluez/bluez/commit/d79e429a9fc3c37b3a25fcde474c242d8b094bcc
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M profiles/health/mcap.c

  Log Message:
  -----------
  health/mcap: Fix memory leak in mcl struct

Error: RESOURCE_LEAK (CWE-772): [#def40] [important]
profiles/health/mcap.c:2052:3: alloc_arg: "set_default_cb" allocates memory that is stored into "mcl->cb".
profiles/health/mcap.c:2055:4: leaked_storage: Freeing "mcl" without freeing its pointer field "cb" leaks the storage that "cb" points to.
2053|			if (util_getrandom(&val, sizeof(val), 0) < 0) {
2054|				mcap_instance_unref(mcl->mi);
2055|->				g_free(mcl);
2056|				goto drop;
2057|			}


  Commit: 5dcc52a486f27867bdb685a39e10fadc9e6afa6f
      https://github.com/bluez/bluez/commit/5dcc52a486f27867bdb685a39e10fadc9e6afa6f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M lib/sdp.c

  Log Message:
  -----------
  sdp: Fix memory leak in sdp_data_alloc*()

Make sure to free already allocated memory if we run out of memory
before the end of the loop.

Error: RESOURCE_LEAK (CWE-772): [#def8] [important]
lib/sdp.c:542:4: alloc_fn: Storage is returned from allocation function "sdp_data_alloc".
lib/sdp.c:542:4: var_assign: Assigning: "data" = storage returned from "sdp_data_alloc(dtd, values[i])".
lib/sdp.c:550:4: var_assign: Assigning: "seq" = "data".
lib/sdp.c:552:3: var_assign: Assigning: "curr" = "data".
lib/sdp.c:553:2: out_of_scope: Variable "data" goes out of scope.
lib/sdp.c:552:3: overwrite_var: Overwriting "curr" in "curr = data".
lib/sdp.c:545:4: leaked_storage: Variable "seq" going out of scope leaks the storage it points to.
543|
544|		if (!data)
545|->			return NULL;
546|
547|		if (curr)


  Commit: 1707a836223093de92f7911ca703ba9fa99e44b4
      https://github.com/bluez/bluez/commit/1707a836223093de92f7911ca703ba9fa99e44b4
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M lib/sdp.c

  Log Message:
  -----------
  sdp: Check memory allocation in sdp_copy_seq()

Fix a potential null-dereference if sdp_data_alloc_with_length() fails,
as is done in other similar functions.


  Commit: 922a8a8bd4949b073e6423a0f0d59bb273d88014
      https://github.com/bluez/bluez/commit/922a8a8bd4949b073e6423a0f0d59bb273d88014
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  audio/a2dp: add NULL checks to find_remote_sep()

Make find_remote_sep() safe for passing NULL pointers.

Found with the SVACE static analysis tool.


  Commit: 537f96a28399ad9a4140801575b384c8c5716bba
      https://github.com/bluez/bluez/commit/537f96a28399ad9a4140801575b384c8c5716bba
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: add return value check of io_get_fd() to transport_timer_read()

It is necessary to add a return value check.

Found with the SVACE static analysis tool.


  Commit: 605e078556d0a23b60e9a65b5db20334a544e738
      https://github.com/bluez/bluez/commit/605e078556d0a23b60e9a65b5db20334a544e738
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M src/gatt-client.c

  Log Message:
  -----------
  core/gatt: add return value check of io_get_fd() to sock_read()

It is necessary to add a return value check.

Found with the SVACE static analysis tool.


  Commit: d36983e032e98545c3d90154b1d94605c73170c2
      https://github.com/bluez/bluez/commit/d36983e032e98545c3d90154b1d94605c73170c2
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: add return value check of io_get_fd() to sock_io_read()

It is necessary to add a return value check.

Found with the SVACE static analysis tool.


  Commit: 1b961b9e15c6de1cf96de29ed16d0008b9c64c5d
      https://github.com/bluez/bluez/commit/1b961b9e15c6de1cf96de29ed16d0008b9c64c5d
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: move checks for NULL before dereferencing

It is necessary to prevent dereferencing of NULL pointers.

Found with the SVACE static analysis tool.


  Commit: 8a22c17bc9960772a1baab310a7cc0a60ab4763e
      https://github.com/bluez/bluez/commit/8a22c17bc9960772a1baab310a7cc0a60ab4763e
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: prevent dereferencing of NULL pointers in ascs_ase_read()

If the user_data argument is NULL, a NULL pointer will
be dereferenced. It is necessary to prevent this case.

Found with the SVACE static analysis tool.


  Commit: 5f0002cc90997d14083e54a91c1f45134b7905a0
      https://github.com/bluez/bluez/commit/5f0002cc90997d14083e54a91c1f45134b7905a0
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M src/shared/csip.c

  Log Message:
  -----------
  shared/csip: add NULL check to foreach_csis_service()

It is necessary to prevent dereferencing of a NULL pointer.

Found with the SVACE static analysis tool.


  Commit: ee46e92bdef44e85cf4d6b10e08d56a2aa7706be
      https://github.com/bluez/bluez/commit/ee46e92bdef44e85cf4d6b10e08d56a2aa7706be
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: add return value check of io_get_fd() to input_read()

It is necessary to add a return value check.

Found with the SVACE static analysis tool.


  Commit: 176cf2e12a289f9f94666e188c79fa6cc1ff249b
      https://github.com/bluez/bluez/commit/176cf2e12a289f9f94666e188c79fa6cc1ff249b
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-03 (Wed, 03 Jul 2024)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: add NULL checks to foreach_vocs_service()

Make foreach_vocs_service() safe for passing NULL pointers.

Found with the SVACE static analysis tool.


Compare: https://github.com/bluez/bluez/compare/be0b08770e92...176cf2e12a28

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
