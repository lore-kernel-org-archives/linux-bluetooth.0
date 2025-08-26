Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B099345730
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215936; cv=none; b=d2tqI+ysGZAaqTGSgmMctaCnLtzQPQCJSU2pyfjgJwQrjpvcTat8fHb7GAjB1qJ+2avKWJ10PT5nQEfrKV0qR8x5wQH6lWGKnID/HAZ/KI+h3lL3yCUoi2SJusZglBHQEN9GbrVMJ7Y3/sMaalU517UE02o62/9i+7eiy0B+dR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215936; c=relaxed/simple;
	bh=WQqMf0eE4rvQwDlW/PinrWdyuLiz4VvLP9Jlha/XP7s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pjSuzutfGDlVkFnKTaRO0kugrpjQzB8p6dlyQOlW+a04aYdlAJ1XnZmS9H1zjlW08ibalwN74TDT4ihUKCSjvUz+bF0Ke+GISlMsqlwHKMvgEoEn1Fl0C/vHBlpDXUciRoSgo7uQwxi4k19NVuPmQMQgMwLiwCw2NOLdrbAJPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DqZbNpM2; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DqZbNpM2"
Received: from github.com (hubbernetes-node-90cd870.va3-iad.github.net [10.48.131.26])
	by smtp.github.com (Postfix) with ESMTPA id 842D08C132F
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756215934;
	bh=vqyxA6dO4Oxbsk9S2NgKA3A6fo6q4eRqxRgjHp7VRRo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DqZbNpM2ucuFbttCkVtzJnLXvG1+/ou+IbeTC0221jkYf6qqsaq8iyq+r0QgNNLI7
	 4FiknPVeMM9VLut98Y67N+KEeYpn1jVDNUSO1mj6VCdgO15eRP0TWStXoVI4c2w4qm
	 tmkIJKS9LeKYdw3reDz8OQd/uC8hEnM/NkMEUbkk=
Date: Tue, 26 Aug 2025 06:45:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/995640/9e52d3-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/995640
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
