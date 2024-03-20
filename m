Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD13AC25
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927125; cv=none; b=iJkFcjFguDMHXxtoDMCPCsoPISl2NbQvv1xIIyIF8pZq8KNFpCGeQ60yWIWA0bK5AxrbyMLuB3K/8hhbEmeyT4lgdavXtaHu2nYN+9gp1ZuP6ecNr9u0ls6PLi2kWtJHSrL1pQoNBn6iO/RJn40AL36QongyjKEXaVZvMrvp+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927125; c=relaxed/simple;
	bh=6QFvfGXjYolmBvtQBQBe1Umzpa8Lz3BBof1MhHnXWgM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZEMQTNKxnE5v/pIuIOlMh9W3KfTrACryLUCi3xNTX6wq7oUHCdamvtWeUk8aEtia/juGfoUajmOE16kWVdIP8xNhwjnQ6ngeZCilxukrfhuY7n/Veu1rf7NCv20t5DFqiaq4zS0gldrym1Ew1U8PYL22RkIS48iqRUaGfet585I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TNBEJfaY; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TNBEJfaY"
Received: from github.com (hubbernetes-node-caf0434.ash1-iad.github.net [10.56.224.45])
	by smtp.github.com (Postfix) with ESMTPA id BD8F7641272
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1710927122;
	bh=0U2LXB+TeH0IaKgACL7zQhs6zIcrqCTSJ+gTtDSPxUU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TNBEJfaY/Q5KjYgdX6KR1smJgBrK7DtdBj90V+R64NpQl00/EA6C81/ksFv8Jyyyt
	 CmsiRuAQxK1UtnOJ/OHS7o6dVCc8syaF9wn69FnKIGurCfD/jUTTHaWy9utq8B6cEy
	 22XdckzwxPiuByN8jck98/jNVLrqsaLYogGNtC6U=
Date: Wed, 20 Mar 2024 02:32:02 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8060d1-6c0393@github.com>
Subject: [bluez/bluez] c04b96: a2dp: fix setup->err use-after-free
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
  Commit: c04b96dda5ce1bbb07a72b7ffa5ad1786ccffe47
      https://github.com/bluez/bluez/commit/c04b96dda5ce1bbb07a72b7ffa5ad1786ccffe47
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-03-20 (Wed, 20 Mar 2024)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: fix setup->err use-after-free

setup->err is set to values that either are on stack of avdtp.c
routines, obtained from callbacks, or allocated on heap. This is
inconsistent, and use-after-free in some cases.

Fix by always allocating setup->err ourselves, copying any values
obtained from callbacks.  Add setup_error_set/init and do all setup->err
manipulation via them.

Fixes crash:

==994225==ERROR: AddressSanitizer: stack-use-after-return
READ of size 1 at 0x7f15ee5189c0 thread T0
    #0 0x445724 in avdtp_error_category profiles/audio/avdtp.c:657
    #1 0x41e59e in error_to_errno profiles/audio/a2dp.c:303
    #2 0x42bb23 in a2dp_reconfigure profiles/audio/a2dp.c:1336
    #3 0x7f15f1512798 in g_timeout_dispatch
    ...
Address 0x7f15ee5189c0 is located in stack of thread T0 at offset 64 in frame
    #0 0x466b76 in avdtp_parse_rej profiles/audio/avdtp.c:3056
  This frame has 2 object(s):
    [48, 49) 'acp_seid' (line 3058)
    [64, 72) 'err' (line 3057) <== Memory access at offset 64 is inside this variable


  Commit: 9fc5f9e05d840444868140a4794f42b605fa4046
      https://github.com/bluez/bluez/commit/9fc5f9e05d840444868140a4794f42b605fa4046
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-03-20 (Wed, 20 Mar 2024)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add util_iov_append function

Currently iov_append is defined in 2 places, client/player.c and
src/shared/bap.c. The player.c implementation is faulty as it
does not allocate additional memory for the data that it appends
to the original iovec. This can cause buffer overflows such as
the one attached at the end of this message, which was discovered
while running an Unicast setup. Therefore, the implementation from
src/shared/bap.c was used to create util_iov_append as it allocates
new memory appropriately.

==131878==ERROR: AddressSanitizer: heap-buffer-overflow on address
0x602000059dda at pc 0x7feee2e70ea3 bp 0x7ffd415773f0 sp 0x7ffd41576b98
WRITE of size 6 at 0x602000059dda thread T0
0 0x7feee2e70ea2 in __interceptor_memcpy ../../../../src/libsanitizer
/sanitizer_common/sanitizer_common_interceptors.inc:899
1 0x5579661314aa in memcpy /usr/include/x86_64-linux-gnu/bits/
string_fortified.h:29
2 0x5579661314aa in iov_append client/player.c:2120
3 0x557966132169 in endpoint_select_properties_reply client/player.c:2191
4 0x557966132a6f in endpoint_select_properties client/player.c:2268
5 0x55796616e0b4 in process_message gdbus/object.c:246


  Commit: 060e3dd69ed357bfacbc26ac0d778cfacab1fb94
      https://github.com/bluez/bluez/commit/060e3dd69ed357bfacbc26ac0d778cfacab1fb94
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-03-20 (Wed, 20 Mar 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Use util_iov_append instead of iov_append

Use the newly created util_iov_append function from
src/shared/bap.c.


  Commit: e96a7fdd697bcba9046fd1afab75fd411c5cbf0d
      https://github.com/bluez/bluez/commit/e96a7fdd697bcba9046fd1afab75fd411c5cbf0d
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-03-20 (Wed, 20 Mar 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Use util_iov_append instead of iov_append

util_iov_append has been recently created. This implementation
allocates new memory for the appended data, while the old
version of iov_append from client/player.c did not. This could
lead to crashes in some scenarios, such as Unicast.


  Commit: 6c039398fee20165bce0e453a28d49800ff7522c
      https://github.com/bluez/bluez/commit/6c039398fee20165bce0e453a28d49800ff7522c
  Author: Sergey Bobrenok <sibobrenok@salutedevices.com>
  Date:   2024-03-20 (Wed, 20 Mar 2024)

  Changed paths:
    M src/btd.h
    M src/device.c
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Introduce GATT.Client option

General.ReverseServiceDiscovery option is responsible for two
different things:
 1. It disables SDP reverse discovering. As a side effect, some BR/EDR
 profiles cannot operate properly. E.g. AVRCP-target profile needs SDP
 results to determine the peer's AVRCP version.
 2. It disables GATT-client creation back to the GATT connection
 initiator. It may be useful for peripheral devices, especially if the
 peer doesn't expect them to connect back (and currently some IOS
 versions don't). This behavior was introduced in
 8de73cd12 ("main.conf: Make ReverseServiceDiscovery work with LE")

For peripheral devices implementing only A2DP-sink, AVRCP-target, and
GATT profiles (e.g. BT loudspeakers), it may be useful to disable
GATT-client functionality, but still have SDP reverse discovering.

Unfortunately, splitting the General.ReverseServiceDiscovery option
into two different options will break backward compatibility on the
configuration file level. So a new configuration option has been
introduced in addition to the old one.


Compare: https://github.com/bluez/bluez/compare/8060d1208673...6c039398fee2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
