Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73CA381AF1
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389180; cv=none; b=XKQeanbrbscQ1RVwb6MTCFnr8VPgHLQBiuLsx8q2H+3QzFDIRGjTUafvllYsraM4s6nHUcSYs2We9rivI6xmkpWetl/3+f8zjyTAG/6lTaxtioI7wL11gwdrDfHKFORtJp/XHVDcd40BIJ7oxnbOaDLI2BX7BT0IMA1Tt1dv+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389180; c=relaxed/simple;
	bh=G4czkpqQ+J6OdiDp+mQWPM7J5jxhUj4tym6BkAR6Oqk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VHIgZzQ10IUXaXSF4wiKK/Ay3h3nj37IGE7zcfugTUgcTFXkVo2BCtT6dZSpePwQGWukcxkHjl1X7IOpN96ZCGrQiKjISqsrl5IqCkiAOD05q8xM27swfavEspBQ9k1PBWylepvkLOY3Q0NefKJRUgPezWd8iKuBT2qWQDK5K+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HYHFrTwN; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HYHFrTwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787389178;
	bh=pKKVq6gqe6iZwEY1vYNYgj8p1bByKY8budj5rPECfrI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HYHFrTwNaRmdjeP1xiBvQtwbEu4EwGkST2AA35TDHwvuVAy9JlpURutPPQp9GiJMp
	 p+5kLqm1x9xe8qS9e0AzfUGRz8cDqexXLopsadmY7Ggtt6tKaYdEYvOQM8dG1/MqCK
	 l6Z/Y4xplaQmrNQSNrgtJuMg7rvLHLWxv3Drgnxw=
Received: from github.com (hubbernetes-node-be22b59.ac4-iad.github.net [10.52.211.67])
	by smtp.github.com (Postfix) with ESMTPA id C565994061F
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 01:59:38 -0700 (PDT)
Date: Sat, 22 Aug 2026 01:59:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1133053/faa9d5-000000@github.com>
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

  Branch: refs/heads/1133053
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
