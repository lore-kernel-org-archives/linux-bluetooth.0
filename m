Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A82D9480
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143832; cv=none; b=Av8zzBa8r+n4ir4c+tvkfvk3ClSzSjhoqp00wH6/KovecdlNhO8JkCCmKMxdwerpj9gTRjM5LyF32q5ii0voPS/J+TKf1YtK4RG6pvlcm7dt0RVgpYjb/7p3mbYdHxaj+IO7a2a/1YkC2BBxWVzFruaWxsPVsbTDDbyT38+OZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143832; c=relaxed/simple;
	bh=ST9yEWpYbMiLA0fs4Cj+/R8Fl69aeftlLSIpqmkCqOo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OfUXtkApLAEenXdeXMasm9qdvzhsvIfNvKncsaJdCPUwPl3Ca5BeSkpqZT1pIp8HToVMIHia8b2G3SVTQ5rTIRB2Lf0lnEtfExty+k7I4jpUeDtZwQRtq2mA2Pr9rIDGM6+mgTzIfM7Jc+uktWwMH6imH9mFI/SDNHqf01YfPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=armtMm0G; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="armtMm0G"
Received: from github.com (hubbernetes-node-f819557.va3-iad.github.net [10.48.132.33])
	by smtp.github.com (Postfix) with ESMTPA id 434448C0312
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752143830;
	bh=HvBOKykd7v6TMwY86PVGi20r61EH0OShZESsGss8FB0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=armtMm0GZYT3iUPAgOlnodSNdn/Yo2fNy85i/H6ralJA4Tt9IUPPW37QtIYJNURuN
	 2bImWOAr18bmZz6Ob8klp+XpPFyFVtmrb4SEhKeM2LT00U/JiMcnaPdjSNg0col8Rc
	 vW7XMbKX3YPMtG0vORatQGwpXdekcTRrt28L5mUM=
Date: Thu, 10 Jul 2025 03:37:10 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980952/000000-63201d@github.com>
Subject: [bluez/bluez] 63201d: avdtp: fix not adding stream to global streams
 list
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

  Branch: refs/heads/980952
  Home:   https://github.com/bluez/bluez
  Commit: 63201df7daa4e326e706028e1fe3d7bf99af09d9
      https://github.com/bluez/bluez/commit/63201df7daa4e326e706028e1fe3d7bf99af09d9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-10 (Thu, 10 Jul 2025)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: fix not adding stream to global streams list

stream_new() shall be used to create new avdtp_stream, so that they can
be found from global list.

Fix one case where it was not used.  Fixes crash when unregistering lsep
and then disconnecting, due to stream for the removed lsep not being
cleaned up when SEP is freed.

Fixes: https://github.com/bluez/bluez/issues/1325



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
