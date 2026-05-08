Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83BD3E0C68;
	Fri,  8 May 2026 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271711; cv=none; b=CgC7vwugpI2x8jZoxLNnlJ7FADErWdkSLkNayxCnzXNIbRl1QOEwMcMislec25IhAwY2/JfJC0x8D11+1ZbAilJ6j3Ooi1QcDHP3J5SFxtZTLPHqF8tyg9EC9DqJmABNGgap7zIn0YXAFSbvHJYh4JSv/8m8gF0IOhV8QhpflMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271711; c=relaxed/simple;
	bh=h7Okj0vESTHKRIfSM1QhXOJbZ/AHuzLHYebB37wVJxQ=;
	h=Date:Message-ID:From:To:Cc:Subject:Content-Type; b=BSLADp3WEk7fQJrVzm3MfAa6/CpjhaOvuaT6zDcCxOMhfHVoWqap1uuBMdOI555DghdEq4rk29ywA/2hTJ0ae6BIzlw6bHptKmCEm4NligZhEKhHVTcW8vKGJY7MqrSEttgcri6uzp0Ba5kA5DkU4NCXZyeM8wiYX1kxRy85X/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desarrollaria.com; spf=pass smtp.mailfrom=desarrollaria.com; dkim=pass (2048-bit key) header.d=desarrollaria.com header.i=y2k@desarrollaria.com header.b=2tv1PWmE; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desarrollaria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desarrollaria.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=desarrollaria.com header.i=y2k@desarrollaria.com header.b="2tv1PWmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desarrollaria.com;
	s=s1-ionos; t=1778271701; x=1778876501; i=y2k@desarrollaria.com;
	bh=RTsuA/ujeeChSi54Rlos2jnRmjKLISPsXbMDnecJ8Mc=;
	h=X-UI-Sender-Class:Date:Message-ID:From:To:Cc:Subject:
	 Content-Type:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=2tv1PWmEb2p9ePYUMvllJGZxzo54UYqre2DjzZmgrPCIZzLLmlFitmdJJEIsOtrI
	 Jm2aT6DLQEHe6/0XuCwugQz5iHDvkyRTzeOAU8oZ6sierExJUnPtzBmWxlsDMqfI4
	 gQBzr81dKlSGZZYQ4/Xoui6UySfB17+fePEYbBNQxPw3Pzx5zeYfiJH5+aTFmo803
	 FyN6Q6HXuxpOzX3l+COl07HIJzWgdla/I68tTKk+QeXq2W4SH16Wr64V6eazZTzGo
	 fH4cVc5meIbW2Xyp1pYWlcDJ9Wn/m21F8Is2/9RSZ5BTwDIxd3dOlFWSat15m6ZZ+
	 x9p07AdKHo1hrPgU4Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.17.181]) with ESMTPSA (Nemesis) id 1MTiLj-1vrzWy0sAf-00YwKy; Fri, 08
 May 2026 22:21:41 +0200
Date: Fri, 08 May 2026 22:21:40 +0200
Message-ID: <8e1c30806d274ac3cfebce2816057875.y2k@desarrollaria.com>
From: y2k <y2k@desarrollaria.com>
To: marcel@holtmann.org
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Bluetooth: L2CAP: missing NULL guard in remaining l2cap_chan_ops callbacks
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:hUfxfKFAIhM7QIONkyMsBYs0jxFsr0khS0Kz/fVl/zhs037B5FG
 3O9qp/rEIFsDNK/sv7Y87xsJCNJ9aFCj9/xhEhvFVBWTusdFADEho735c1TPgzQo/eNKqh7
 vMDcpzP6qwYdUKLaogUbU8+zDmsfZJs0OvZuIxWuC9HRPrCuhY0PE00Rw177N4uUE8M38Jb
 BlR5V6229MRpBiri7cqDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gJMlNYBjjLo=;JNknSz3RfpcELtkHfCTN+r+jAPu
 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
 0+BTdROLhNdR0tm1Njfmr37D+zFSAl/j
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

Commits 0a120d961663, 78a88d43dab8, and 2ff1a41a912d added NULL guards
for chan->data in l2cap_sock_new_connection_cb(), l2cap_sock_get_sndtimeo_cb(),
and l2cap_sock_state_change_cb() respectively.

The same NULL guard is still missing in five other l2cap_chan_ops callbacks
in net/bluetooth/l2cap_sock.c:

  - l2cap_sock_defer_cb()       (.defer)
  - l2cap_sock_suspend_cb()     (.suspend)
  - l2cap_sock_set_shutdown_cb() (.set_shutdown)
  - l2cap_sock_get_peer_pid_cb() (.get_peer_pid)
  - l2cap_sock_filter()          (.filter)

All five dereference chan->data directly without checking for NULL:

  struct sock *sk = chan->data;
  lock_sock(sk);  /* or direct sk-> access */

The fix mirrors the existing guards:

  struct sock *sk = chan->data;
  if (!sk)
      return;  /* or appropriate return value */

Fixes: 80808e431e1e ("Bluetooth: Add l2cap_chan_ops abstraction")
Reported-by: y2k <y2k@desarrollaria.com>

Thanks,
y2k
y2k@desarrollaria.com
