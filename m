Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF62C0296
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377144; cv=none; b=rcUqrJ7EKkaJULBd2QHwQWrEXVq8IAMCa7WsmmflEdYYi9fQ67/wtWSwAuzGElpvwrCtn7ItEJU0DfYt0OTP+oCaEjJjltntJOPtr3kMzVGQKAqTDKzJGsn/uYQOJ4GevDh44CTaA63jNZuI+5iO42Lyx4P4ywI+Q2I04naf4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377144; c=relaxed/simple;
	bh=nHMk72Il0qsaJfSTr3Rwbw8XO4c+NuKrvF1iIh5yA34=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iacbdb7nV/2zmlRwJ48fuI59FER6FKugfJfhTpwLGEGOfrUvsNmQqByt5bXiTQT62CYPzlqnp4LyOq9qU/gEWdKGrv3TC8H1v8TT3xz4wLjb629/4oH9CZquegltrXChatyXY06xQAyAyKO9YTi/6mOZv94FAIDyTLdMm2xEoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WllSJpD+; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WllSJpD+"
Received: from github.com (unknown [10.59.94.34])
	by smtp.github.com (Postfix) with ESMTPA id 291AF140B25
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760377142;
	bh=tfV6QbC89r9N9RTlU63c/wx2BmvtQxVBCkCg7DL9VRo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WllSJpD+G/gyHxu2iIBuS0iJ4Y2SPH4fMjO9oAEW6gaaxBulXVQEpunTX9B4MvZQl
	 PD1QqJDOzKyhM8DiFWLn/N49RYkV2NMuiZRN7qLQlvSnJuY/t7USU/296Z7m8QMtJM
	 lk1r0dX8ZNMdGlA+gtVWNyT7AJD2SFS+g2NddwfY=
Date: Mon, 13 Oct 2025 10:39:02 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b3dd59-3e17f8@github.com>
Subject: [bluez/bluez] 05f3aa: bthost: handle L2CAP_DISCONN_RSP and remove
 l2cap_...
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
  Commit: 05f3aab743f097d1f8f10de77201e579e29d110a
      https://github.com/bluez/bluez/commit/05f3aab743f097d1f8f10de77201e579e29d110a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M tools/l2cap-tester.c

  Log Message:
  -----------
  bthost: handle L2CAP_DISCONN_RSP and remove l2cap_conns

Handle L2CAP disconnection response. On receiving disconnection request
or response, remove the associated connection.

Change disconnect handler signature to take also the handle and CID.


  Commit: 3e17f888c840270472ec618b3c3b27472288669c
      https://github.com/bluez/bluez/commit/3e17f888c840270472ec618b3c3b27472288669c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  bthost: handle L2CAP_FLOW_CONTROL_CREDIT_IND

Parse L2CAP_FLOW_CONTROL_CREDIT_IND and track credits, instead of
sending reject response.  Nothing is done with the credit counts
currently.


Compare: https://github.com/bluez/bluez/compare/b3dd59987455...3e17f888c840

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
