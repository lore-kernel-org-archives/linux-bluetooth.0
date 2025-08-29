Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822925394A
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449740; cv=none; b=onNnDjbldwo+3U2fWJizLa7DFg2mbdUTxLcbT03Cuk6ceUmxK/cURA4ha/lFeL5p3/nxbNRyhz3XF/XFFeLRl+3PJfliqdWLzFsxXtfsgqabrJnw8D5AnRDvI8zUQ5CuCy7xd7ViG0igOlhq3WdR4ku0g+yK7eyOUo76vatXJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449740; c=relaxed/simple;
	bh=2Gy7I64iZcSl+Bm2Dq0gpc7fDdnIhrb634aTnCCXZSk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Wc0VmRqjCMMRfaNCv6jL2Pfv6pT2FvnsP/GBb4CkQMns+OLnu63A1m67mkl7CM3+ahBgwPb4jBd1KgetpIT+4fsgaK7lCUzxAqynMOmp6HDRKgpkfvRpq2GcV4hIB9Cj6FKf0dU99BXSva/gdFlMcuhrK/oPRpS1s86Wbiaad50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a1e8dnb9; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a1e8dnb9"
Received: from github.com (hubbernetes-node-50ab028.ash1-iad.github.net [10.56.224.71])
	by smtp.github.com (Postfix) with ESMTPA id 013426010C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Aug 2025 23:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756449738;
	bh=ybmjcVxf2rf62kVJrBet/bK49g6dzJuJVjQSQjX7HNk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a1e8dnb9nJUl8X9i0Val278UY7CITC69nYwjrEEw++NrZ2o5zF1G1CU2HII9zq1El
	 7wiroGFRdcImvRHNLEx4/Gs3fF2zHtGCpDQippjy1+QPYjnerbP22/G95gHcppprt0
	 jP5zJmzT92eUSk1cZQiC/x9preDlhJtuekP18FH0=
Date: Thu, 28 Aug 2025 23:42:17 -0700
From: fly602 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/996765/000000-dc6c9a@github.com>
Subject: [bluez/bluez] dc6c9a: obexd: Refine error handling for agent
 authorizati...
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

  Branch: refs/heads/996765
  Home:   https://github.com/bluez/bluez
  Commit: dc6c9a60b5ace1f7f1877600e6d3b586b4372655
      https://github.com/bluez/bluez/commit/dc6c9a60b5ace1f7f1877600e6d3b586b4372655
  Author: fuleyi <fuleyi@uniontech.com>
  Date:   2025-08-29 (Fri, 29 Aug 2025)

  Changed paths:
    M obexd/src/manager.c

  Log Message:
  -----------
  obexd: Refine error handling for agent authorization reply

Handle DBus error types in agent_reply() with specific errno values:
- Use -ETIMEDOUT for DBUS_ERROR_NO_REPLY (timeout)
- Use -EPERM for OBEX_ERROR_REJECT (permission denied)
- Use -EBADR for other errors

This improves the accuracy of error reporting and makes the authorization logic more robust.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
