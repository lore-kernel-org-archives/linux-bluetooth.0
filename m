Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5227510B
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377482; cv=none; b=fxrvTB1L9ZCDYtvJDUzisVWE6Xlv+IWV1PAdhM5Jo4SbYHzqleG8pc1FgRevn7uFJWBI4v7KIIaTSUcOeRQrRQe+W6TxJwT155vzed5wcm5Dk6vHH+voje/fQ+FCXe6cc3NoNrQejjc1/DmXc1BHO7Sn4FB+06M0FLWRw4qa+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377482; c=relaxed/simple;
	bh=29uPdS+YRzY0xLSMcARr3A4fNkmxfuY+DTOA9qsq6WU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=f0KBqhAaDBhYh5yRj4rK6YFi3uqn7BwGT6Yjfh6/azbXRgg67wiSaNjVBMqfeS/pKPtGq4qGz8dr6rc5vVSDBOpgFtozN2GaaMyrgSFc4qWDbDx8OPl6uA82Rx274eSM/bPrmModWQbk5Yk4zcJy79FB16wRKeT+njNedhHOduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P8HRhA6F; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P8HRhA6F"
Received: from github.com (hubbernetes-node-5895fa3.ac4-iad.github.net [10.52.137.32])
	by smtp.github.com (Postfix) with ESMTPA id 1F4A420442
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760377480;
	bh=G01fKa8yCNVhj2e+2QyRqc0DQE/QM12V2iP2Te+YTcM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P8HRhA6FxB98aO6bEkH0/9LeOgO5EUaN+2iXAfZx5IS1P18ueTiCiIxBjpE0mIyHa
	 h1tqJBm/UfIdEPd8mk1rchXJ9OiQvGSgp9FqpTIXQdWo+AgaaovXTcJOlTuhvL5DP+
	 UeQeydrnNJcGbf7KsnOKbGQ0jjP9Xu0Q83p2AH5M=
Date: Mon, 13 Oct 2025 10:44:40 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3e17f8-9e76fb@github.com>
Subject: [bluez/bluez] 9e76fb: bthost: Fix crash on l2cap_ecred_conn_rsp
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
  Commit: 9e76fb9f6ce830cebb71a0b54a662ea8bb50bd54
      https://github.com/bluez/bluez/commit/9e76fb9f6ce830cebb71a0b54a662ea8bb50bd54
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  bthost: Fix crash on l2cap_ecred_conn_rsp

This fixes the following crash:

Invalid read of size 2
   at 0x4019907: l2cap_ecred_conn_rsp (bthost.c:2554)
   by 0x4019907: l2cap_le_sig (bthost.c:2650)
   by 0x4019907: process_l2cap (bthost.c:3137)
   by 0x401BBA3: process_acl (bthost.c:3242)
   by 0x401BBA3: bthost_receive_h4 (bthost.c:3402)
   by 0x4008835: receive_bthost (bluetooth.c:2989)
   by 0x493B862: ??? (in /usr/lib64/libglib-2.0.so.0.8400.4)
   by 0x49447A7: ??? (in /usr/lib64/libglib-2.0.so.0.8400.4)
   by 0x4944A4E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8400.4)
   by 0x402645D: mainloop_run (mainloop-glib.c:65)
   by 0x4026A34: mainloop_run_with_signal (mainloop-notify.c:196)
   by 0x4025C55: tester_run (tester.c:1084)
   by 0x4002A7B: main (l2cap-tester.c:2799)
 Address 0x400bc02a4 is not stack'd, malloc'd or (recently) free'd



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
