Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0713C1CCB23
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745807; cv=none; b=OXK8E2yl6LwH5EBnAYXKhaGrnj/2Gwv8fDaE6R8OMS+gtfPjyg1NTGS/A8RxgiH4djXz1+MnT1NtgS1tm1r15e0oPgEtUQen0QrFcpcWLxExpabjOUD7VoKbm1ggP3Q3h4Jb5XV5UE1pDR25II4MfAvrmPb4rf/nAwqNpts6bs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745807; c=relaxed/simple;
	bh=FvDZM0HICiIHF/7LjqFBJbny8hhBHkMpHGHEurHLAIo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PyyrABx677MYe5kwJTVB7rIkUv5OmFDewp6qk1zuZM8B0KvVgVruQc/DUEFjI6rWcCljK71aMIUZH7hYJuG+V3irDX1U97yDrowpLZmQtc4yL6tjXlBywAhaLEiqJq4WynvgIUY0A+O6+C+XZND+hOrfp71rI4v3XIuGKeg0qtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LTK/vuGa; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LTK/vuGa"
Received: from github.com (hubbernetes-node-668c9cc.ac4-iad.github.net [10.52.151.33])
	by smtp.github.com (Postfix) with ESMTPA id 16E3470038C
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 10:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730745805;
	bh=Pt988uZiNr73KaYLt+PkA7IFzUBWXAqRDtFolBcvtb4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LTK/vuGaSGFzmRTQ7VSbG8592Iho/QCYUXl6/ViiZuyU0KhgnI+/fyyMKDhM09XZn
	 Zri5eQUvEUCstGMa7OV20gssUVv57GOb7nBJLlTtGOfbqqvZPcxYAcD3f24zHBXAiq
	 SJYrll0Nec182XOL9FZHWPz5uHpPDKMFnVt2NLhg=
Date: Mon, 04 Nov 2024 10:43:25 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0845b8-664a5d@github.com>
Subject: [bluez/bluez] a14d59: transport: don't disconnect A2DP if canceling
 Acqu...
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
  Commit: a14d59725ef35d91b8504770046c701d0a2efe07
      https://github.com/bluez/bluez/commit/a14d59725ef35d91b8504770046c701d0a2efe07
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-11-04 (Mon, 04 Nov 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: don't disconnect A2DP if canceling Acquire() with Release()

User can cancel transport acquire by calling Release() while Acquire()
is in progress. This calls a2dp_cancel() which sends AVDTP_ABORT_CMD,
forcing AVDTP state transition to IDLE, and A2DP profile disconnects.

However, Release()/Acquire() should only result to transitions between
STREAMING/OPEN.  The expected behavior is that either these calls return
error, or they block until the target state is reached.

Fix by: Release() during pending Acquire() first sends error reply to
the Acquire. Then it waits for START to complete, then sends SUSPEND,
and after that completes, then it replies.

This also fixes SetConfiguration() after canceled Acquire(), which
previously did not work due to AVDTP disconnect. Now it does
START/SUSPEND -> CLOSE -> reconfigure.


  Commit: 664a5d3785a1a57989d236b6fd649321a39451f5
      https://github.com/bluez/bluez/commit/664a5d3785a1a57989d236b6fd649321a39451f5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-11-04 (Mon, 04 Nov 2024)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: don't change setup sep when it is reconfiguring

If a2dp_resume/a2dp_suspend are called while setup is being
reconfigured, they make the reconfiguration use wrong SEP.  This occurs
if transport Acquire/Release are called while reconfiguration is waiting
for CLOSE_RSP.

Fix by failing a2dp_resume/suspend early without changing the setup, if
it is reconfiguring.

Such resume/suspend calls would in any case fail, because
avdtp_close(stream) has been done, so avdtp_suspend/resume would return
error.


Compare: https://github.com/bluez/bluez/compare/0845b8f6ef2a...664a5d3785a1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
