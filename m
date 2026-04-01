Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B329D27D
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052145; cv=none; b=nvoRi7b+8pHQrQsujkCSrE2n6k7tpZy45R+4oSkLUlGnVpu0yGMocuPH5xJGxB/E2B4Y+21wFD+pv4NE231Pu0PvmgILoKUsPnUQs30BArg3/iObc14bqwNzs1m2uPP/YuWU6KiFhyxc1E8q9q+d1eTUyfC3e+m7QeCnS1oGhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052145; c=relaxed/simple;
	bh=zoiizX7zI0+nTdl7ADEN6209KVLYO+038gh50V2TDb8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Gc3e/AdVAuP01zzKKHmt5jJuo6f0+MaMNeNRSIZ26NH0KsUcmFDq2v4mIMhSn2pMlBuYcVrd+ZkEw5oxh/zK9IhLiipaNbsi1cHQDH0dxJbyishfUzzip99OBCLPG/+nQUP7zQ5Cx4mxP9PQ5YKXtuNToIHgAJw3Mmav6aGRoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TstAwIfU; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TstAwIfU"
Received: from github.com (hubbernetes-node-da468ee.ac4-iad.github.net [10.52.171.37])
	by smtp.github.com (Postfix) with ESMTPA id 9CC82701125
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775052143;
	bh=yXrCOUGCZwdW5Rot5dthavePnsSdUZTwgPj7riPlTlQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TstAwIfUhoo/CHQxx+77payZIX1BSZM0FeuKd+VIMTJa80y94KJnZvlYkyb9E/Fmo
	 AHt+G7YdISCN/KsPlFVuDi3hKShFzTxpPRbDuujQfaCEjAw1HikS9pH0Uz0MiDPMiL
	 hQ46go+QOh8jIF287QDbOXP4UNXHX7XVAPiFZzTI=
Date: Wed, 01 Apr 2026 07:02:23 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1060034/5d4c8e-000000@github.com>
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

  Branch: refs/heads/1060034
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
