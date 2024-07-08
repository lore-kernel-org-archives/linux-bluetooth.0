Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD271E4A6
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451729; cv=none; b=HN05Wpf7hhT6vtiqNYrpndPg9xsXLnYeHQRIpsY9jdnD2CzX37lvCxCsri1j7uYBZEPK/dCJ3HmlnDjfJ7NYJRgKd44O+iz8Y8qWarYOcUq/RM/RBJ6bLJcguuplCt/8kes8IeLs7ZB5JQpStSgaGyDYG/DIrrUwQ9y5WNtGIlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451729; c=relaxed/simple;
	bh=umI2qRw2sNRT7HWWTnHs/eoemRq08JoyKSLIpi48WZ8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EwkXdf0glyWQ/K0HswwRw+57heSjXto8JV8hukZy5ljZ5GAHVUAhbiISQqo/WPhaSEXnlpWZCryZ0tTRWlK6CXtUi6OggUfHCFuVX3sn8sbbJtIUgi4mk16g8YwVgC7MQ9A3sRv/dvFCV4M7EykbgPoumP0xtEAeKFNVwtddqso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ht/AQ8qX; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ht/AQ8qX"
Received: from github.com (hubbernetes-node-dbc1788.ash1-iad.github.net [10.56.166.39])
	by smtp.github.com (Postfix) with ESMTPA id 845866C112F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1720451724;
	bh=bgAqthJry1hMLN0Hujt0g+GLHNeQyCrYtZAjgQeDaIs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ht/AQ8qXF5nhhQg7USA6dveMvHzgfTxRacGwYx3sdlzh9JIf7WsnQMyuk9dGsnYon
	 khLBIUne7GrGs8VGxBhX8yKCQOWCHQIsHSenvDMaFQCaBE5Ey7QrLwshINAGeStG9g
	 P5MIVq7lbbb0bZCy94yLqnBSEM1sdPMRhGYAZHCs=
Date: Mon, 08 Jul 2024 08:15:24 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/176cf2-804696@github.com>
Subject: [bluez/bluez] 243384: shared/shell: Fix fd leak if -s is passed
 multiple...
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
  Commit: 2433842ea33bcb80a9c157cbac472efedae8c8d4
      https://github.com/bluez/bluez/commit/2433842ea33bcb80a9c157cbac472efedae8c8d4
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix fd leak if -s is passed multiple times

Error: RESOURCE_LEAK (CWE-772): [#def37] [important]
src/shared/shell.c:1305:5: open_fn: Returning handle opened by "open". [Note: The source code implementation of the function has been overridden by a user model.]
src/shared/shell.c:1305:5: var_assign: Assigning: "data.init_fd" = handle returned from "open(optarg, 0)".
src/shared/shell.c:1305:5: overwrite_var: Overwriting handle "data.init_fd" in "data.init_fd = open(optarg, 0)" leaks the handle.
1303|			case 's':
1304|				if (optarg)
1305|->					data.init_fd = open(optarg, O_RDONLY);
1306|				if (data.init_fd < 0)
1307|					printf("Unable to open %s: %s (%d)\n", optarg,


  Commit: 8de21f74c5f309bdb3872293db23b5a0f20ae163
      https://github.com/bluez/bluez/commit/8de21f74c5f309bdb3872293db23b5a0f20ae163
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M tools/btsnoop.c

  Log Message:
  -----------
  btsnoop: Fix possible negative memcpy length

Error: INTEGER_OVERFLOW (CWE-190): [#def41] [important]
tools/btsnoop.c:438:2: tainted_data_return: Called function "read(fd, buf, toread)", and a possible return value may be less than zero.
tools/btsnoop.c:438:2: assign: Assigning: "len" = "read(fd, buf, toread)".
tools/btsnoop.c:473:4: overflow: The cast of "len - 9L", which is potentially negative, to an unsigned type could result in an overflow.
471|			/* next 4 bytes are data len and cid */
472|			current_cid = buf[8] << 8 | buf[7];
473|->			memcpy(pdu_buf, buf + 9, len - 9);
474|			pdu_len = len - 9;
475|		} else if (acl_flags & 0x01) {

Error: INTEGER_OVERFLOW (CWE-190): [#def42] [important]
tools/btsnoop.c:438:2: tainted_data_return: Called function "read(fd, buf, toread)", and a possible return value may be less than zero.
tools/btsnoop.c:438:2: assign: Assigning: "len" = "read(fd, buf, toread)".
tools/btsnoop.c:476:4: overflow: The cast of "len - 5L", which is potentially negative, to an unsigned type could result in an overflow.
474|			pdu_len = len - 9;
475|		} else if (acl_flags & 0x01) {
476|->			memcpy(pdu_buf + pdu_len, buf + 5, len - 5);
477|			pdu_len += len - 5;
478|		}


  Commit: 0de4b9f71eb9e01ee972755cf3444592706356c7
      https://github.com/bluez/bluez/commit/0de4b9f71eb9e01ee972755cf3444592706356c7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M lib/sdp.c

  Log Message:
  -----------
  sdp: Fix possible null dereference

From the BlueZ scanbot:
lib/sdp.c:586:12: warning: Access to field 'attrId' results in a dereference of a null pointer (loaded from variable 'd')
        d->attrId = attr;
        ~         ^
lib/sdp.c:967:10: warning: Access to field 'dtd' results in a dereference of a null pointer (loaded from variable 'd')
        switch (d->dtd) {
                ^~~~~~


  Commit: 0b52ecca60ea2002a3b3236f32543210e92c0e95
      https://github.com/bluez/bluez/commit/0b52ecca60ea2002a3b3236f32543210e92c0e95
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M lib/sdp.c

  Log Message:
  -----------
  sdp: Fix mismatched int casting


  Commit: 1d73dc6a1a9a7a83dc77e547b0d639cea8b2d903
      https://github.com/bluez/bluez/commit/1d73dc6a1a9a7a83dc77e547b0d639cea8b2d903
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M emulator/amp.c
    M emulator/bthost.c

  Log Message:
  -----------
  emulator: Fix integer truncation warnings

Error: INTEGER_OVERFLOW (CWE-190): [#def1] [important]
emulator/amp.c:693:2: cast_overflow: Truncation due to cast operation on "(remain_assoc_len > 248) ? 248 : remain_assoc_len" from 32 to 16 bits.
emulator/amp.c:693:2: overflow_assign: "fragment_len" is assigned from "(remain_assoc_len > 248) ? 248 : remain_assoc_len".
emulator/amp.c:698:2: overflow_sink: "fragment_len", which might have overflowed, is passed to "memcpy(rsp.assoc_fragment, amp->local_assoc + len_so_far, fragment_len)". [Note: The source code implementation of the function has been overridden by a builtin model.]
696|	rsp.phy_handle = cmd->phy_handle;
697|	rsp.remain_assoc_len = cpu_to_le16(remain_assoc_len);
698|->	memcpy(rsp.assoc_fragment, amp->local_assoc + len_so_far,
699|							fragment_len);
700|

Error: INTEGER_OVERFLOW (CWE-190): [#def2] [important]
emulator/amp.c:701:2: cast_overflow: Truncation due to cast operation on "4 + fragment_len" from 32 to 8 bits.
emulator/amp.c:701:2: overflow_sink: "4 + fragment_len", which might have overflowed, is passed to "cmd_complete(amp, 5130, &rsp, 4 + fragment_len)".
699|							fragment_len);
700|
701|->	cmd_complete(amp, BT_HCI_CMD_READ_LOCAL_AMP_ASSOC,
702|						&rsp, 4 + fragment_len);
703|   }

Error: INTEGER_OVERFLOW (CWE-190): [#def4] [important]
emulator/bthost.c:3309:3: cast_overflow: Truncation due to cast operation on "len - offset" from 32 to 8 bits.
emulator/bthost.c:3309:3: overflow_assign: "cp->data_len" is assigned from "len - offset".
emulator/bthost.c:3317:2: overflow_sink: "cp->data_len", which might have overflowed, is passed to "memcpy(cp->data, data + offset, cp->data_len)". [Note: The source code implementation of the function has been overridden by a builtin model.]
3315|		}
3316|
3317|->		memcpy(cp->data, data + offset, cp->data_len);
3318|
3319|		send_command(bthost, BT_HCI_CMD_LE_SET_PA_DATA, buf,


  Commit: 249d2120bd904c5f6db2138a3412822c9ded1dfb
      https://github.com/bluez/bluez/commit/249d2120bd904c5f6db2138a3412822c9ded1dfb
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M mesh/pb-adv.c

  Log Message:
  -----------
  mesh: Fix integer overflow due to cast operation

Error: INTEGER_OVERFLOW (CWE-190): [#def15] [important]
mesh/pb-adv.c:174:4: cast_overflow: Truncation due to cast operation on "size - consumed" from 32 to 8 bits.
mesh/pb-adv.c:174:4: overflow_assign: "seg_size" is assigned from "size - consumed".
mesh/pb-adv.c:177:3: overflow_sink: "seg_size", which might have overflowed, is passed to "memcpy(buf + 7, data + consumed, seg_size)". [Note: The source code implementation of the function has been overridden by a builtin model.]
175|
176|		buf[6] = (i << 2) | 0x02;
177|->		memcpy(buf + 7, data + consumed, seg_size);
178|
179|		pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 500,

Error: INTEGER_OVERFLOW (CWE-190): [#def16] [important]
mesh/pb-adv.c:179:3: cast_overflow: Truncation due to cast operation on "seg_size + 7" from 32 to 16 bits.
mesh/pb-adv.c:179:3: overflow_sink: "seg_size + 7", which might have overflowed, is passed to "pb_adv_send(session, 0, 500, buf, seg_size + 7)".
177|		memcpy(buf + 7, data + consumed, seg_size);
178|
179|->		pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 500,
180|							buf, seg_size + 7);


  Commit: 9b346513cc35c83da332c4b6ebd65b4674178a26
      https://github.com/bluez/bluez/commit/9b346513cc35c83da332c4b6ebd65b4674178a26
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M tools/mesh/mesh-db.c

  Log Message:
  -----------
  tools/mesh: Fix integer overflow due to cast operation

Error: INTEGER_OVERFLOW (CWE-190): [#def29] [important]
tools/mesh/mesh-db.c:551:3: cast_overflow: Truncation due to cast operation on "ele_cnt" from 32 to 8 bits.
tools/mesh/mesh-db.c:551:3: overflow_sink: "ele_cnt", which might have overflowed, is passed to "remote_add_node((uint8_t const *)uuid, unicast, ele_cnt, key_idx)".
549|			continue;
550|
551|->		remote_add_node((const uint8_t *)uuid, unicast, ele_cnt,
552|								key_idx);
553|		for (j = 1; j < key_cnt; j++) {


  Commit: c44a2a233d1b1873a7d4a9085c8d6bd61835bfac
      https://github.com/bluez/bluez/commit/c44a2a233d1b1873a7d4a9085c8d6bd61835bfac
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M src/shared/ringbuf.c

  Log Message:
  -----------
  unit/ringbuf: Fix ineffective guard due to signedness

"len - end > 0" can never be false because "end" is unsigned, so the
whole left handside of the expression is unsigned, so always positive.

Error: INTEGER_OVERFLOW (CWE-190): [#def22] [important]
src/shared/ringbuf.c:240:2: ineffective_check: The check "len - end > 0UL", which appears to be a guard against integer overflow, is not a useful guard because it is either always true, or never true. This taints "len".
src/shared/ringbuf.c:242:3: overflow: The expression "len - end" might be negative, but is used in a context that treats it as unsigned.
src/shared/ringbuf.c:242:3: overflow_sink: "len - end", which might be negative, is passed to "memcpy(ringbuf->buffer, str + end, len - end)". [Note: The source code implementation of the function has been overridden by a builtin model.]
240|	if (len - end > 0) {
241|		/* Put the remainder of string at the beginning */
242|->		memcpy(ringbuf->buffer, str + end, len - end);
243|
244|		if (ringbuf->in_tracing)


  Commit: 0fda2dd545fc0c2d879db729ab3be22e88be7072
      https://github.com/bluez/bluez/commit/0fda2dd545fc0c2d879db729ab3be22e88be7072
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M obexd/plugins/filesystem.c

  Log Message:
  -----------
  obexd: add NULL checks to file_stat_line()

gmtime() may return NULL. It is necessary to prevent
dereferencing of a NULL pointer.

Found with the SVACE static analysis tool.


  Commit: 85d98aecd6a9504cb51a4bd4f8b37cc11a0057f8
      https://github.com/bluez/bluez/commit/85d98aecd6a9504cb51a4bd4f8b37cc11a0057f8
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: prevent integer overflow in bt_shell_init()

An integer overflow will occur if index < offest. It is necessary
to prevent this case.

Found with the SVACE static analysis tool.


  Commit: c389209ce4554fd8fdd3ca99ea6f73435a056c57
      https://github.com/bluez/bluez/commit/c389209ce4554fd8fdd3ca99ea6f73435a056c57
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  tools/isotest: limit the maximum possible data_size

It is necessary to prevent the possibility of allocating
a large amount of memory.

Found with the SVACE static analysis tool.


  Commit: 8e495f00cded86496ad5c32e7a3cf902a8bdbe82
      https://github.com/bluez/bluez/commit/8e495f00cded86496ad5c32e7a3cf902a8bdbe82
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M tools/rctest.c

  Log Message:
  -----------
  tools/rctest: limit the maximum possible data_size

It is necessary to prevent the possibility of allocating
a large amount of memory.

Found with the SVACE static analysis tool.


  Commit: 804696dee79515e2001ec445ae218d7b42887c37
      https://github.com/bluez/bluez/commit/804696dee79515e2001ec445ae218d7b42887c37
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M src/settings.c

  Log Message:
  -----------
  settings: add NULL checks to gatt_db_load()

It is necessary to prevent dereferencing of null pointers.

Found with the SVACE static analysis tool.


Compare: https://github.com/bluez/bluez/compare/176cf2e12a28...804696dee795

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
