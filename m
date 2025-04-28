Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1599279358
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852264; cv=none; b=FvfPfWQDdcZvofMomPNP3EmI1Rej/U8v++mfzQY5owZnAt4Wjx7+UilB8KTKTXSACyy7j7TSnrbzfFIx9hfGzOvC2UNNZjiS5tEQ5CYF4DE1Dy/eGYk2p3TPZ1mtCkh2s5BGzuI3yyEzwF+L6Gg1wZntqyJR9kHUVUwEmgmc/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852264; c=relaxed/simple;
	bh=YDO4t3PviQTBOXHydRcS0liSTLHAPBAraVic9c35sNE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aEkAv687XkJK7OtrmRhYWt/tAx1q3epa6uJ1xK/6W/JrfiNeI89fWoQIGuFIsrBJMAuyr7GDHmb74+KvXzKhf/fyewUc8/CZX1dIFOoyJcd8c0UJN3SXY1vuHH5DjwXNeoPti9vRGE/NwZlm6JdMiP/wLuIbDKSq5NC9BNQmqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H+yVIWaz; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H+yVIWaz"
Received: from github.com (hubbernetes-node-f35bf9b.va3-iad.github.net [10.48.156.33])
	by smtp.github.com (Postfix) with ESMTPA id AF57C8C08C0
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745852261;
	bh=xSntEAQAro7Y3m4fYV3pAxk4KVRTkFIbXZbT7YwhK+w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H+yVIWazaAPeCLJKMVcv3WAkXUpg6UUOPCpJRBp19JVna6qiKxHiXQ2KhmzCZHuxq
	 /Tp1yfZNG2dq5MNBHgRToDjaWSbBjr+kDjyGcWvytigiHGRu5INVQReIeS5i/wg9cA
	 I3D4dCIIJD+m+V9i1q/SdMALPpQE43nD5sEVadlU=
Date: Mon, 28 Apr 2025 07:57:41 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c3b6f4-f1d167@github.com>
Subject: [bluez/bluez] 1be171: shared/ad: Fix crash on match_manufacturer
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
  Commit: 1be17107d22b9c92bf7c43ff763e656b3a6f5ea2
      https://github.com/bluez/bluez/commit/1be17107d22b9c92bf7c43ff763e656b3a6f5ea2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    M src/shared/ad.c

  Log Message:
  -----------
  shared/ad: Fix crash on match_manufacturer

When matching manufacturer BT_EA_MAX_DATA_LEN in case of EA since that
can be bigger than regular advertisements otherwise it can cause the
following crash:

data #0 __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:47
1 0xb6e05c58 in __pthread_kill_implementation (threadid=, signo=signo@entry=6,
no_tid=no_tid@entry=0) at pthread_kill.c:43
2 0xb6e05c8c in __pthread_kill_internal (signo=6, threadid=) at pthread_kill.c:78
3 0xb6dd63ce in __GI_raise (sig=sig@entry=6)
at /usr/src/debug/glibc/2.39+git/sysdeps/posix/raise.c:26
4 0xb6dc7f5c in __GI_abort () at abort.c:79
5 0xb6dfd608 in __libc_message_impl (fmt=0xb6ea1a50 "*** %s **: terminated\n")
at /usr/src/debug/glibc/2.39+git/sysdeps/posix/libc_fatal.c:134
6 0xb6e5a430 in __GI___fortify_fail (msg=) at fortify_fail.c:24
7 0xb6e59ffe in __GI___chk_fail () at chk_fail.c:28
8 0xb6e5a8a2 in __GI___memcpy_chk (dstpp=dstpp@entry=0xbefff7e6, srcpp=,
len=, dstlen=dstlen@entry=29) at memcpy_chk.c:27
9 0x004944f4 in memcpy (__len=, __src=, __dest=0xbefff7e6)
at /usr/include/bits/string_fortified.h:29
10 match_manufacturer (data=, user_data=)

Fixes: https://github.com/bluez/bluez/issues/1169


  Commit: 7763584f6d0186e77adcdc212b0a1c8a53e6ccc9
      https://github.com/bluez/bluez/commit/7763584f6d0186e77adcdc212b0a1c8a53e6ccc9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/tester.h

  Log Message:
  -----------
  tools: add tests for RX timestamping

Add tests:

ISO Receive - RX Timestamping
L2CAP BR/EDR Client - RX Timestamping
L2CAP BR/EDR Client - RX Timestamping 32k
L2CAP LE Client - RX Timestamping
L2CAP LE Client - RX Timestamping 32k


  Commit: a112d434577182894598ae8e7d0d98c0fa4745c9
      https://github.com/bluez/bluez/commit/a112d434577182894598ae8e7d0d98c0fa4745c9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: implement fragmenting to ACL MTU

Support fragmenting ACL packets to given ACL MTU.


  Commit: aeeb4fd64adfcf7ca7adaac8dadca43dab6f2939
      https://github.com/bluez/bluez/commit/aeeb4fd64adfcf7ca7adaac8dadca43dab6f2939
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M emulator/btdev.c
    M emulator/btdev.h
    M emulator/hciemu.c

  Log Message:
  -----------
  hciemu: set bthost ACL MTU to match btdev

Set the bthost ACL MTU to avoid generating larger packets than the btdev
ACL MTU.

This tests RX timestamping on ACL fragmentation.


  Commit: 682e9252def95c2db242c85bda02c97fb8dfe512
      https://github.com/bluez/bluez/commit/682e9252def95c2db242c85bda02c97fb8dfe512
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: support sending SCO packets

Add function to send SCO packets via bthost.


  Commit: f1d16721593566849b5ac096cd08cf3c620847ca
      https://github.com/bluez/bluez/commit/f1d16721593566849b5ac096cd08cf3c620847ca
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: add SCO receive and RX timestamping tests

Add tests:

SCO CVSD Recv - Success
SCO CVSD Recv - RX Timestamping


Compare: https://github.com/bluez/bluez/compare/c3b6f4e4b456...f1d167215935

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
