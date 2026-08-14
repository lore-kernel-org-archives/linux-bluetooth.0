Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C945D5E3
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702799; cv=none; b=lP1ur03Vi8X3QBRRy8Dmvn3F6FQC7owcyw/Treg+JliLPTOfhmDuSjRW3IcvDH0j8JbsT6pCJWF+PBOsde6QILgJt0yntiQVo4o8WISDjjNM31gq4DXPmhlAovuEAjELUoXjGdId6KQmWjfU6V1l3q1Z6PJj1SgepyE8W+Vzi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702799; c=relaxed/simple;
	bh=wufgSXUz6AmqWuIU5rq3Jh9cF6Lu6vHnS7rqYL8j/2c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iq9JDSuFzy0SF/j4aRawQAzIS2A5jfs3oAWm6I9HnB3mEV8Pb4CtjQtywb9wWltr3/xL6W3y8O5PyCzglIDjdFY5CWI/geJqAsByQb35utMUlJbP6ZTtCNptxWFnFqjozPvcDIyK6rezSIUE/8kTHRajBMdlTN9o51G3pC2Q6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UpST9mEQ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UpST9mEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786702777;
	bh=yDTrVPljpg7CKu1+1XTX3BYnI8Qa4vyU0MHZCb3C/dM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UpST9mEQ8tQmRldN/hgJqknbaGGKSrds9Zz0qVAEwK6SslBVyPzVx4HHyEEEgy/kG
	 C3QPEo6UH7b01oxf8IbrJP9fDO6a5Iq/mpaLam5P2Vl+Yx2O+K/nxHmCXOPoi5YzbJ
	 aMiOOot7P5H91ZbQocEXlaJb76Lz+YYINy8aju9o=
Received: from github.com (hubbernetes-node-bb32a62.ac4-iad.github.net [10.52.87.35])
	by smtp.github.com (Postfix) with ESMTPA id 3E907780606
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 03:19:37 -0700 (PDT)
Date: Fri, 14 Aug 2026 03:19:37 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1145981/000000-3ca1cb@github.com>
Subject: [bluez/bluez] 3ca1cb: attrib: Fix smatch "non-ANSI function
 declaration"...
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

  Branch: refs/heads/1145981
  Home:   https://github.com/bluez/bluez
  Commit: 3ca1cb0f46a2c5e3a468ea2f865934eb7c51f72a
      https://github.com/bluez/bluez/commit/3ca1cb0f46a2c5e3a468ea2f865934eb7c51f72a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M attrib/interactive.c

  Log Message:
  -----------
  attrib: Fix smatch "non-ANSI function declaration" warning

attrib/interactive.c:175:27: warning: non-ANSI function declaration of function 'disconnect_io'



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
