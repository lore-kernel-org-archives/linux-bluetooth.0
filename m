Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757C36B
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198730; cv=none; b=ZepgCZg2t7gSrSN6/poxiTMflFzPhn3BSE7iXVzgyN5xH2/a2/KyO7/odK8q/6xzyVTSGEaR3KbYYpn9loDDYP8vJpPgxPBP9t4+TQZ0kfZ1j+KGURu39l82XVEAUCaldeG8KG1u0oA5/mUSKOD7OEmjI1Y9Bm4NAOV5/BGbUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198730; c=relaxed/simple;
	bh=POBwSFK78SLZ80Tm8+IOAtAuV5q46RFnXA+wlOUby74=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=K7WpflOfDzn3ovinzzoZGejq7feuLIAEMtgH1bfy9aeqrsAtzB9djoaNbWP+syqH6btYdkLOa2NL3hsWbPiiUoPiIfu7Qx0HvNtoYlZb6i2qu4DNcni8VeyK8SIznfytrh+oWQJ03gGxI3MmmWBEqOJM4vX5RsxsVIUp18IKTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UFrHZnBJ; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UFrHZnBJ"
Received: from github.com (hubbernetes-node-c61440c.ash1-iad.github.net [10.56.212.69])
	by smtp.github.com (Postfix) with ESMTPA id 141FE6010CB
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713198728;
	bh=iC4hENnFRQU5EqBVWQi3MfbQ5cQlw5Ss7qO8ykKD52U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UFrHZnBJ1p8VEfvnWfmuPQNmvKdF3IOZ1+Gw4CQbWIgaPBAE9xBXKAq7MSmY8g3iM
	 Mwhmc5yU1L9JnE1yIjBTM2XLoH7eEbQesaVDcg5GlTc8CqeuEhqmip1SiBdXMDhAEo
	 ElQm0LsseHrsykZmwqn85XpU1nH5q3rUeMWWCx0o=
Date: Mon, 15 Apr 2024 09:32:08 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1955b8-249216@github.com>
Subject: [bluez/bluez] 249216: Release 5.75
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
  Commit: 249216dce21f97d92144f0f72cc8b97f25203184
      https://github.com/bluez/bluez/commit/249216dce21f97d92144f0f72cc8b97f25203184
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-04-15 (Mon, 15 Apr 2024)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.75



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
