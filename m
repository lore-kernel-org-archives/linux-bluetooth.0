Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E324E4A1
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865433; cv=none; b=N//OAbhUpPI3cvpyKn2LOVJEllVJApUkd4AcrvuGM5pJDl1m565AWrQwejc0yqROeiMO/EeG08f56573aHapmLAA7fqXBMAOmISHBXd2WNjdqrCtlgDsnx9hO2MD05dJvRA3Z7hLAbN/SqBfj/PWN9NY/VEkwvb8i7/WlF6GtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865433; c=relaxed/simple;
	bh=rrFb7u+qf5QhG6Yw+6smq3bSG5VYkqunqdrn64XFySI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W8On2BU+sac+rxJ4tFwD3eBYyi73Q1NsyeSpLDsbQQAwGLEvUq7MStgF8sy+Gsl6XT31wJ+Y21S00RrzQQO/Bwdf8VbZpCnhy3Nfr/AYPTl6i4TQlrEoabuc/Oe4HYBGkGH5XTmsNho/TPwLYDaYvJzGRwXSLRBFqqxI7PdU554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cdxBR/w0; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cdxBR/w0"
Received: from github.com (hubbernetes-node-29dc8c5.ac4-iad.github.net [10.52.177.34])
	by smtp.github.com (Postfix) with ESMTPA id 6B0E321446
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764865431;
	bh=k/8ApOFuSGTYB3IftrgAlRgqnytxLdyOZHeiBYEpSIc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cdxBR/w0b2zp4usOeIf2ZhILGFAzKpBLx6TZ+aLN5uGXiznknoRHoSgG+MyLwHHWo
	 C0GtzMTUnNeQtx65hSh/uBDGcOlFB23+yqNf/uo3w5ODDt/fDREzXJfMsz8MShjXwC
	 UNqhSgdBnz6+HfjoXYXD51gYy7SfvrO1Kk0vAMME=
Date: Thu, 04 Dec 2025 08:23:51 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e55dd6-d383c8@github.com>
Subject: [bluez/bluez] d383c8: client: Fix transport.acquire auto not working
 as ...
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
  Commit: d383c81f848d5c8db325901857c7c51138f55127
      https://github.com/bluez/bluez/commit/d383c81f848d5c8db325901857c7c51138f55127
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-04 (Thu, 04 Dec 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Fix transport.acquire auto not working as initiator

Transports configured as client/initiator do not transit to
State:pending since that is used to indicate that a stream has been
configured and has to be accepted, when acting as initiator role
SelectProperties/SelectConfiguration can used to indicate that
endpoint stream configuration has been initiated locally so use that
to mark endpoint to auto configure if that has been set.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
