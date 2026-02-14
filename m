Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71142940D
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771084744; cv=none; b=HX8krr5AXrCVlOHMeSCzU18PqaF5oF+2LbKD7aiPIx4/7fbIPfgjOiG5dyKG9RoOPmaNPKy3aSqNu4CMgTMQJcAXU0zCEvxlxc1mgtaMGIG3upbS8adcT9w6Mg3ck166Nhge9gNWWel1Q4IT52uojAlysUtNHU9C9qflmzcB+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771084744; c=relaxed/simple;
	bh=e9vCU3QqbKMfyJfgZljp7uK/88QSk2rlWR/kEIrkbtE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LJVKfjKqtEWY0bC4n+Tgf6IUOA8KDQPPduDMIavnoU7zYnLe5xcUrr6nycMP7sosf8AaE0S2qcdaq0prCPvI7XZOTHELzrd6eYZoKVEEcItN9Y7VSY6oaIm9Uzl4L776rdYtqHAT2tilGsdYQzieU/eVTqCGmUeB2ojgoDB79vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YKm0XTO1; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YKm0XTO1"
Received: from github.com (hubbernetes-node-9de8535.va3-iad.github.net [10.48.160.10])
	by smtp.github.com (Postfix) with ESMTPA id DF5D9E0224
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 07:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771084742;
	bh=xUSiONrOiE41QryNwMtMnBmI7qPAoSC/RtZzXCdCKig=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YKm0XTO1mgFhZ40sOIOuKQWaA6+ytrnuT/35ZIf2BOBxlaAMTwoH7vFA1Pvglbn9i
	 bXN5aEn0S0OdgedsGJbh9MVpn+El2fCQmd8PFPgXbj4jtlWm9dLIiAacJj4NHR0dis
	 A7u9dYceZrFCh9FTW7JMm7rJgooE8El2PHw8aDbw=
Date: Sat, 14 Feb 2026 07:59:02 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1053982/11f128-000000@github.com>
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

  Branch: refs/heads/1053982
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
