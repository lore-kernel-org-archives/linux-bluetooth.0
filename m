Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E43054C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299029; cv=none; b=W4YkSJ5tD88kr+8yySe/oV6ksNO19uLw9ODRKZo6G/yD7R7GWx21pUOzt/71TUXuuBGkWkqPnE9InW96ku8noBWZ/WfOsKQhqoBfa8BkkFgOV9X15RqPB/ZfkOWerejJqRpRORxARtsMBrQL5Ph6/uJNgiWuZyOOXSYQTeqPKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299029; c=relaxed/simple;
	bh=CyBRIFKE4yDZJD6NFxKBn24NOh6hueOx3bhNpNLqGFM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LEjB/5M6O23xmH+8QH6sKoonIcPBpLFQ/kSodimlsv0/1XWXvj7zC/OoBpOBpQgGHNV6hOl7ob00vyC1SzUwEbukfW9m3hamI8xeuaA+XvmhpLYMz6j0IHhHtchumbUYGLKsf3mq8GN50wGopkFnSIQznPQXW/o76GzMf/qc9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RbTYScJO; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RbTYScJO"
Received: from github.com (hubbernetes-node-a24da8e.ac4-iad.github.net [10.52.14.12])
	by smtp.github.com (Postfix) with ESMTPA id BA011401290
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 02:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761299027;
	bh=aDLNWDxGbxUB1vSVZQa/sWvZPLOeJAyGnUAPdFrLl/g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RbTYScJOKjblwEC88ZXQHRdWRHGghHLtxMJVA0uqL0RxcmLKpVBCrq7eqVuwYjnRR
	 vRBa1PiFx+RcChX7PQ+uLGxxnNvNATV6P6tCGQX86DSSM97WQZfG6oNPPeZB9JjSEb
	 XeVhtrMEQUaAepI+dDWI8GJEshbl6iFyIbCvzyyA=
Date: Fri, 24 Oct 2025 02:43:47 -0700
From: Antoine Lassagne <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1015404/000000-3c062e@github.com>
Subject: [bluez/bluez] 3c062e: obex: forward nicer failure messages to dbus
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

  Branch: refs/heads/1015404
  Home:   https://github.com/bluez/bluez
  Commit: 3c062ef43f1126bd0531abbb3c0f40ace9b9844b
      https://github.com/bluez/bluez/commit/3c062ef43f1126bd0531abbb3c0f40ace9b9844b
  Author: Antoine Lassagne <antoine.lassagne@canonical.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M obexd/client/session.c
    M tools/parser/obex.c
    A tools/parser/opcodes.h

  Log Message:
  -----------
  obex: forward nicer failure messages to dbus

Without the fix, the following error would appear:
"OBEX Connect failed with 0x53"
After the fix, the error message becomes:
"OBEX Connect failed: Service Unavailable"



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
