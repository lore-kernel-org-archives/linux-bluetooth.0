Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8682E413
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998952; cv=none; b=mGyV7pb4ngJUOfCnk+C4BYKpge2EbV1iItvlgqVu40x4kgFt6B9pZWbbb2iEX7tXVLmVf7K03YbA2oFTFUrnyV0N+n2wUbH1UaIufcfQ7nyYGE60u1hk+CciKV+JzwUxjAD27degblijGdWTSV6DMaUgcXvIttl9lCpvFRlO8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998952; c=relaxed/simple;
	bh=h2vj6c9l61r1o2VdImzuhz1lVFDoOZAGs76f/eRXl78=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=L1bMGgCy/q9p1JRrdDKENtADnxdsDipAEfSyAXelE+68x4mGzZ75H95s34ZnXl2U1GRfMXg4KaPQ7rSoZC5A9f9QwehiGV8FdAMv0IDWD6baB5Q/u6GmLvSoL6R10VTVmnAgK3HSGws74sRfjwjPxxVAQupuvi4P2b/CLtGZPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gTYjtusI; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gTYjtusI"
Received: from github.com (hubbernetes-node-c9ad705.va3-iad.github.net [10.48.137.13])
	by smtp.github.com (Postfix) with ESMTPA id 256893C0E04
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 14:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767998950;
	bh=VuJASR0+ockH+MnPcxZeku9U5424IGaL3EWcPMhMXuk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gTYjtusIw/wNTGd2rkfR+dPMSWlReDtZiSoIiwjW31fv6vq/jLkba7oXK+5N7yBEY
	 P9qvqyJ/4pzl1kapPNMURa3Gzig8Uo4KXYb+3X3n3GyH4xIgE5fKGos3mGstzT3U3b
	 lgYxPKOV29nZhwuAyxsLbvXVRdGGktiWqNBT9JaY=
Date: Fri, 09 Jan 2026 14:49:10 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1040618/c355eb-000000@github.com>
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

  Branch: refs/heads/1040618
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
