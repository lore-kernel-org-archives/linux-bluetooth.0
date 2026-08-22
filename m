Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0BD374E73
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389182; cv=none; b=Vmn74ObOPL4OzVq38a8ntOdNJKEgr5pPNbCCIqdE87f7N6CHG97KUbqtJoX9rbeTvzceVsEBxsR99zf0Pi9ENe21BoDfu5WCn1NEi2imWBLhD67UTqxyeRczMtW8ijMw6kekmIwAfImyzDVhc6fmdFoNUkduleURq8BOncQd8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389182; c=relaxed/simple;
	bh=HTZgtANZclxqPxnSGZbZXCnYHo9x/0487aC8wqChjXQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BGqUkeUfLW8QXUIrYBtl+9O1827d1WQfN+fo005lwGh1zpwX156qTTiz3gMfg00Kdy8XqLF+5HcvMtpBKG6H5HJEKlarQyinWNJO4o5VuJhqx8Q/4YKsKaPstzK+XcqNzp8o9lNmwRroDKEU09SNiPdQ+NMolw82/RtvAn9ZN3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PNmErQR4; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PNmErQR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787389180;
	bh=PI+G6pTqD53brrrJz6/Y9I4culbhOSCavJo9Gg5WgXI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PNmErQR48zfRoA0hg/hk3ciOOIdRBFq4K1plcClY3HjJZbX8pu4lAvYD2uFHikizP
	 2wloaXs6T0dNx7IS76eOm1cH6jIEVKlK8NpsvfEUCqZ0iBa1FEuNkjSH3PZzf9vIIG
	 Fv0goljugU8SPbNEH3OrnlGuT2ecF5qn9YyTABFc=
Received: from github.com (hubbernetes-node-0a042b6.ash1-iad.github.net [10.56.128.78])
	by smtp.github.com (Postfix) with ESMTPA id 2E6DF180086
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 01:59:40 -0700 (PDT)
Date: Sat, 22 Aug 2026 01:59:40 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1133038/bf6289-000000@github.com>
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

  Branch: refs/heads/1133038
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
