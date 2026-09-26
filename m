Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AAE283CB5
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383118; cv=none; b=E7g9X0P+3iWL33vuIE+eC6B+P3+FwRo2IgGmrU+KIV58HYN8HiCP8d+oXQVexcHp46hUsvB2JQYhSu4O9YQOj+JlqTBVXrjRx+N+6XIpbCJzzfRxDogiQpJiV9R/E5jasRZxrD22q+OwcsSE8fQ1yb1wHDssTMIfVmhi3sJET64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383118; c=relaxed/simple;
	bh=49fyBchJgdoyOXaGhwoXjN/j1kmGlzp9yp2skrPpNbI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ttIHxAKisaylXoCjbf9L/3LMqfbEyf8D1t416LsFHwES0kWQ809hYw4zzk+NQLeLVKDXzTXQQusDz492SRJDCk4R2YlIB+KgSz+4mqD1ICtzeOc/lOEKJCFWcp5m0t+aUupzV24jBlXkWofaMgNId2xIuWh1VtRJEaVoLKHiYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=KIiE/qYS; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="KIiE/qYS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790383116;
	bh=SB+CLR4dZeHbgkFKcWU4HazbNN4uEis0dLQMXUNWuhQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KIiE/qYSgLVgbK29X/Npb16R9mXcdLQcbVethiu6gt1PqhxY3Fqic5n5dRGdZZWlW
	 9h7iOt48ubqF+FWgXA4XhUQ3OaWSBjrfqUdi3n8UEI09O9NGJNEr1gEUebWthUVbWM
	 fzBbVgwwShk+MJ6/uxpH5mBB0QdujH6JL34Je6OG0xZ1prjytbsTwDgJYmbZ2ikQaw
	 vm4hJn7jIckHW3p4PqHIyWuRTbRx0qPVPl/7Qzd+SRBcu/jUDI1FNvqU2PtcUSg1SD
	 qmTR6u86vJ7ZR3q4sV99tcFTT4kMDn6ejI6s6nBH341+CWuUak40lUhQYx2i+gCT/O
	 w9Hza4URRDEMA==
Received: from github.com (hubbernetes-node-7b125c8.ash1-iad.github.net [10.56.154.24])
	by smtp.github.com (Postfix) with ESMTPA id 87C9C520369
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 17:38:36 -0700 (PDT)
Date: Fri, 25 Sep 2026 17:38:36 -0700
From: "ooonea.eth" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1174115/000000-ad9f35@github.com>
Subject: [bluez/bluez] ad9f35: input: Reset report map state on detach
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

  Branch: refs/heads/1174115
  Home:   https://github.com/bluez/bluez
  Commit: ad9f353d3126394de02a19abc185a83c96127d3a
      https://github.com/bluez/bluez/commit/ad9f353d3126394de02a19abc185a83c96127d3a
  Author: Giuseppe Piscitelli <35407790+ooonea@users.noreply.github.com>
  Date:   2026-09-26 (Sat, 26 Sep 2026)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  input: Reset report map state on detach

read_report_map() leaves report_map_id set after a failed read. Detach
cancels queued GATT operations but retains that ID, so a later attach
cannot request the report map again and never creates the UHID device.

Clear the ID when cancelling GATT operations on detach. This also lets
a reconnect retry a read that was still pending at disconnection.

A socketpair reproducer fails to read the map after either an ATT error
or cancellation before this change; both cases create UHID afterwards.
The existing HoG and UHID unit tests also pass.

Assisted-by: OpenAI Codex:gpt-6



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
