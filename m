Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E733F6
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759573071; cv=none; b=s8YEVWztq5k/0HytHZjOhdbkrQP8hgoYHpb+0iWBF+35j5jEalAMSdChwp5a5KX8w+gx1cnofbNZMNleJQ6SmayJo12Hq0lxz1g/AndP60BArl/RfyhtTcD5H2JdKM799JGoCBwToHj/ycgd7aRFjKzRn451l6+FuKz6RizFJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759573071; c=relaxed/simple;
	bh=3kuEOnSfrGqzlhMghy3f3iC3/keUxVFzUpVuu0Eg210=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lnirNYa7G+F4JrDsATk9COxrcTpKTyKvgKfCxyM0UVFMhnj8/DoiT+d+AoVuDevSsSPG8ZVv5hzx26vpZoZ/ieDkcPy6KyWTvZXkp3BGKKhMjLn6YbIbg9aLYtBoOEOiohZ+ai9T38bsTD0iWRwqwzjIpOmE+D6fXQsjDYUcUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J6XK6G9R; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J6XK6G9R"
Received: from github.com (hubbernetes-node-4ea565c.ash1-iad.github.net [10.56.171.26])
	by smtp.github.com (Postfix) with ESMTPA id 006DC600262
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 03:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759573069;
	bh=3Q66uX/NPNG5AMkxkP07rpV0HuKZgIPxRKlkayI+xR8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J6XK6G9RBcU/Y4Ql2UmjtBhjadm7/5oop3BwmahC9PuLBJoMv9RkM+HQEa2mAOZbX
	 OzDnEj1nyALhMzH97vg0BOlVclxAOpKNLuksneZCc9poK71vkEbSOX+yTTFXaOLwET
	 rBjJG5NeLhezABkJumkcSCrFCAwmo9otc/dGWJLM=
Date: Sat, 04 Oct 2025 03:17:48 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008427/000000-771cfb@github.com>
Subject: [bluez/bluez] 771cfb: transport: always show A2DP Delay property as
 sink...
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

  Branch: refs/heads/1008427
  Home:   https://github.com/bluez/bluez
  Commit: 771cfb1337c787b900d45e754e3b315bde71b940
      https://github.com/bluez/bluez/commit/771cfb1337c787b900d45e754e3b315bde71b940
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-04 (Sat, 04 Oct 2025)

  Changed paths:
    M profiles/audio/media.c
    M profiles/audio/media.h
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: always show A2DP Delay property as sink if DelayReporting

The Delay property is currently not shown to sound server unless remote
side has acked delay reporting.  However, when we are A2DP Sink, we
reply to delay report requests with the current value, so the value
logically exists and is active.  This behavior was apparently changed in
commits 05f8bd489fd1 and 5d4efe960fd.

Show Delay value for local A2DP Sink endpoint if it has DelayReporting.

Fixes: https://github.com/bluez/bluez/issues/1541



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
