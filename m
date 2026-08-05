Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC429B766
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949028; cv=none; b=GC6EDShYhrD5b5lg6CO4T9btAJNGyLJaSjY+HCe/GpKq9sZdrnGSKrZYZhPT4mDMXNW5fL2TJ8cfUe62ehozr27Ca/K0zUGmtHLhERggXipEP8Ods0qIX29xhBRWNXVRRirRNjruYwIfEbKEbpvg/3V6VXAc8L662PbHlR/NcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949028; c=relaxed/simple;
	bh=9/7JjxgRGCVZYuYUm2/m0yUA7r0ZrVLHkPVKC3hWi9k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PnOBeRLFwDZkRusAJB8lhab+bV/EsfYxPorr8P6bpjiv4K9GZyodyJr8ztY0fwslBjhNmKnofV/Tx1Os+jOeDDUuhzfVgGuXmppYr10qJUybLGbZHfiVRd4hkW/VroiVTQmHenFCoW1VbCnUx1kYxD2uCMr4B3L3dlFWyk7eYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T//3Xwq3; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T//3Xwq3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785949025;
	bh=H9f5gwKL8lUVog2vLxjK0CE6sDSjHrFlwqxgEEbssp8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T//3Xwq3K+0y8kbez3vJhzebRaLGiQq7xGg1xGl2Bs6THmGFHIHLldpaZowaVhMrI
	 UNb615DO5Rw18/6yaaMjZZhsRyLN1PSLD5Ctdjl1er42tMThP7Pe3iXArzLzKBOO8y
	 mog2YLnxrjwpYchB12xyoFwrMu8LwZoorHNJ6RuQ=
Received: from github.com (hubbernetes-node-0727ce0.ac4-iad.github.net [10.52.220.67])
	by smtp.github.com (Postfix) with ESMTPA id DB50A7809A3
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 09:57:05 -0700 (PDT)
Date: Wed, 05 Aug 2026 09:57:05 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1140838/b24d0e-000000@github.com>
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

  Branch: refs/heads/1140838
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
