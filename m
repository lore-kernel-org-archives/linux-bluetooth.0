Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B942D9EE7
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864055; cv=none; b=Nx4IqksTckxbhu1Uw1y8pCxLHlKaIc1Ivg8Vt4sFlrutT4PFttzPA7mbNQiDZfc9k3kYcFe3SZmuviSxavxy95yM72ckpZze7Crs2UW+ZN+TpU3ha69CrDA1LE9f/KKjdp0cG9WsM90lGj4X4zTGsZdNcPGWo5/ARbRFxdb8+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864055; c=relaxed/simple;
	bh=5dnFYtrofhsjR0xDSY1DYD03ASKeXYycnoWKPigwwf4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DgJMq702p7Mj5Pg8mfMLYLkLztPLKXd/YTIdnhlXCYzfY1Pobb6hvrUyhN9Z//aa2YSwYCipE11gvE3gKh58bV3SBs9oEMM2vUn5CjFD2NluhK0DgVYnLnlux+QqRLeAnByGMuqGfMXKqST+oglt7wZSEKXvQ/XLzbJb570xuiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=SpRm8KBy; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="SpRm8KBy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791864053;
	bh=SbUxrEBera+Tp2ZTzgmLFgSWbWU3+dF9/dmMT1c3LJM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SpRm8KByOa8HBZuXT0EQ4kbzhG87agHS2S4i00e/tsbmPUeIlSfK6xC8R2OZGe9Tg
	 BsL43MWMT5yBIi1T7QJYm0fP+mbf5kZGSCQa72j5ecMw9b/M+weDf6okfjyC803Svu
	 TcvLqb5RNZVzIXd1roEe7sRq7/aJgEKeroikGzHfsEaLPES1hAjv7diPfwyVrR0s2P
	 sgeg/AxNXbDQCRQIqZvgNaqPMXOO9cySEL3pp/d3CNZt+waP1YaijFZcyho5z9R2Nf
	 ejJvMTn3PyJ8l9otlnsWRVwJn4aA1T/GosTNDv7ZTb3q7eUTetIS8n0uII/0TdDqTD
	 EYzw5ae9DVXkQ==
Received: from github.com (hubbernetes-node-5cccdc6.ash1-iad.github.net [10.56.77.33])
	by smtp.github.com (Postfix) with ESMTPA id 56FF1521280
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:00:53 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:00:53 -0700
From: cochcoder <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184363/000000-e04c6b@github.com>
Subject: [bluez/bluez] e04c6b: asha: Notify connection interval changes
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

  Branch: refs/heads/1184363
  Home:   https://github.com/bluez/bluez
  Commit: e04c6bffe4f203b054a5989c43bb682bbdc6c04f
      https://github.com/bluez/bluez/commit/e04c6bffe4f203b054a5989c43bb682bbdc6c04f
  Author: Kyle Pepper <cochcoder@proton.me>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    M profiles/audio/asha.c
    M src/shared/asha.c
    M src/shared/asha.h
    A unit/test-asha-conn.c
    A unit/test-asha-interval.c

  Log Message:
  -----------
  asha: Notify connection interval changes

Omitting the connection-update STATUS notification causes repeated N8
supervision timeouts even with a negotiated 20 ms interval. Restoring
the notification alone prevents the reported link failures.

Observe successful LE connection and update events per adapter, associate
them with the ATT socket's handle, and announce the observed interval
before START and on subsequent successful updates. Clear the observation
on disconnect so a reused handle cannot inherit another link's interval.
Notify the attached HiSyncId peer as well, matching Android's
connection-update STATUS handling, without truncating the interval byte.

Reuse the verified socket handle when delivering a live update.

Add tests for event delivery, controller isolation, disconnect/reuse,
pre-START ordering, failed updates and peer notification.
Use source-level mocks so the tests remain valid with link-time
optimization enabled.

Fixes: c26389c466a0 ("profiles/audio: Add an ASHA plugin")
Assisted-by: OpenCode:gpt-6.1-sol



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
