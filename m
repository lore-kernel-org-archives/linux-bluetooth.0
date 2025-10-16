Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796323EA83
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647319; cv=none; b=q9b6Mh+o7p03C44OhsQhK+JU8KU7RTYKqGcVZ8N9wigr6Zj38thcKoO0k9z7cqPpkUVnPpyU3NEpWFtsdDESvKgjfvgLTafqPMCrbLCI5meEIf6VcZ0PVaG3T1iwY/pANM0bN1PVZWF/bn7GlX27etfle9T/w0BrAPMTRRS3h4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647319; c=relaxed/simple;
	bh=J1X8FgmAsuaKXcZqo+r21CbqB+sriNbzPVnr5SU/+ZI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DPml+gmdmF8kinxqS/HlscOAkvUfHQY17W48Anq3XMsyk/pNDWkir3z35q9860XiZDmL5NPURj7uKQ9FNj7aLbyJMKisNrRHtO5D8Guqfr1qbi715JqGafvrHuIY68dpRpilIdhsfBDWctnYuEDTR+ngUMlU2AX7rzyq00hbtxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QEPJXga8; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QEPJXga8"
Received: from github.com (unknown [10.59.94.34])
	by smtp.github.com (Postfix) with ESMTPA id 2DCF46010CA
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 13:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760647317;
	bh=tt701uZJBfo/BqGSGuY54PBlVb0zsEkDArUoSH44bnw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QEPJXga8QCKdXOzX7JGNQB6OSz/Nx2PLeC7jk08rC6ZL890YFirOTA/dwQAieyXWB
	 WShPLR5pqKUEbOgAhqnuJzT4EOAIUPTI6u91dljGMbx4o209ZAa1ZUkOHmbkx2fNnc
	 ZLdTApRfw904R6tWC4ifk0TS/mJP1xbA9dhNPGcE=
Date: Thu, 16 Oct 2025 13:41:57 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1012365/34dd68-000000@github.com>
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

  Branch: refs/heads/1012365
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
