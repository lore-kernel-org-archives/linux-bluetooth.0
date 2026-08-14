Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5553C199C
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749075; cv=none; b=Wl3/fF3x8tQrYoYOQfPxzNojz9M6aWRFL7dXunBLlAfnzb+xJZgeEm9Pa74z3vY6M7/7B0tV37JfRvyecHHtuc7+uxDjOFo7p0KJzUuYU8S0FCYJ0VnPen3ByW/WaNFCYcfSwr/DWhtP4q4t4+NH5YNF4oSTLO6/JUS2305eV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749075; c=relaxed/simple;
	bh=gJiKkZ7P5hnph+x4AMoIYyM44fV+ZLh+CYTkKmM8Suw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LrhqA2NCxBRqLZc8djOIiwpf4Y3MM6odTXKoybDvsBNpSKRfAE4GCm9en+JSci5uWo5iAWNLcS7lRUXJuepmimeQ/zMgoaa3smGqJe+D8SQZWYkhW7NiBflAUfR0rpgm8n7fYFLPPieFhVgA0kooBTeVEhC+8fqlyvVai/1+ZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dXP+1kiP; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dXP+1kiP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786749067;
	bh=Pz5D+orX+lWGbgh/rFuTYXBc5kcZ+rHqHM9qvNkiE3A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dXP+1kiPbcrOO+3EdPl4WqgsyEH2w26IH/c1P52jq8sKIus6foSMNXR9eDQ6V9PvS
	 iTekXDgtU8xPPmSTp8dIiKT3fLCdJdQ/8mhiPN7wv0KMb60/hK5owIEbznl5AKOGYG
	 Ro7VeR1JJl1XvyhjZ3BD9KeJbUxkhwBhbeVD9GEU=
Received: from github.com (hubbernetes-node-413f1f7.va3-iad.github.net [10.48.155.12])
	by smtp.github.com (Postfix) with ESMTPA id 35473800799
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 16:11:07 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:11:07 -0700
From: Chad Spensky <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1146334/000000-b0c2f7@github.com>
Subject: [bluez/bluez] b0c2f7: monitor: clamp max_len in print_packet
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

  Branch: refs/heads/1146334
  Home:   https://github.com/bluez/bluez
  Commit: b0c2f7dfc2a32a8479e9663db6e440795dc4b702
      https://github.com/bluez/bluez/commit/b0c2f7dfc2a32a8479e9663db6e440795dc4b702
  Author: Chad Spensky <chad@allthenticate.com>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: clamp max_len in print_packet

print_packet() derives the snprintf() bound for the packet text from the
terminal width and never bounds it against the space left in line[]:

	char line[LINE_MAX], ts_str[96], pid_str[140];
	int col = num_columns();
	...
	int max_len = col - len - extra_len - ts_len - 3;

	if (max_len <= 0) {
		extra = NULL;
		max_len = col - len - ts_len - 3;
	}

	n = snprintf(line + pos, max_len + 1, "%s%s",
					label ? ": " : "", text);

max_len can leave range in both directions, and either aborts under
_FORTIFY_SOURCE with "*** buffer overflow detected ***: terminated":

 - The existing max_len <= 0 recovery drops extra and recomputes, but if
   the prefix alone exceeds the column budget the result is still
   negative, and max_len + 1 then underflows when converted to size_t.
   len includes the "comm[pid]: " prefix built from struct ucred, which
   is only present when reading from the monitor socket, so this is
   reachable at ordinary widths. On a host with a large kernel.pid_max
   the pid is 7 digits, so a long process name plus a long label is
   enough and btmon dies mid-capture. Replaying the same traffic from a
   btsnoop file never reproduces it, because there is no ucred and hence
   no prefix.

 - col larger than sizeof(line) makes max_len + 1 exceed the remaining
   buffer. LINE_MAX raised the bar but did not remove it.

A negative max_len is also used to index line[] when truncating the
text, writing before the start of the buffer, so this is an
out-of-bounds write and not only an abort.

The check only triggers at _FORTIFY_SOURCE=3; at =2 the runtime pos
offset defeats __builtin_object_size and the check is elided, which is
why this is mostly seen on distributions defaulting to =3.

Clamp max_len to the space remaining in line[], and only write the
ellipsis when there is room for it.

Reproduced and verified by building the current logic and the patched
logic with -O2 -D_FORTIFY_SOURCE=3 and replaying a capture at a range of
terminal widths:

	cols   before   after
	  10   abort    ok
	  20   abort    ok
	  40   abort    ok
	  80   ok       ok
	 200   ok       ok
	2000   ok       ok
	3000   abort    ok
	5000   abort    ok

Reported-at: https://github.com/bluez/bluez/issues/1104



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
