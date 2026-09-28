Received: from out-1.smtp.github.com (out-1.smtp.github.com [192.30.252.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ABA4FD298
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631134; cv=none; b=r5RNmFWEZyqS5dT14fK+HMWGmZbjHFu/swb0wHUuF46MgY8wFOanZj3qooDHh5jjcgaQ6Lrj78J8RFQFp1m++Ey16TFeBH4bFFYBaDNzZatzKWaEFgNaoKOPDUfojKBjFXSVIYggM9ubhmv2nXbMDQKKbAfyUrnlcXSlpJCHEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631134; c=relaxed/simple;
	bh=1wfAXOGqo8kkUas+eEGxazEREghz8gNCVo0Yk2xFP9U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NJ87kHarzHxoIqCv99c1pnh5pduH2yU0b2rTdFfmhVHE1si6+6SG6/uXINLiTmlz95VRanM6YH7F7rCXgIaKsAlMyebnSrcenZft8kZvIMIgChsoMO2Tydjq+7WnWrKUeongERb3DpmPZjROs4tsirwyzKRXGROhlln8lLvEwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NPBh8hnw; arc=none smtp.client-ip=192.30.252.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NPBh8hnw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790631128;
	bh=mLdN9aGd/9ndceAjaFMRVBLGrBiKKPumJg0jXzWNfQQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NPBh8hnwniCba95y7sXrL2hAHRvEaTk6/X20DaQqWmteDVkYHk/3EGXz3r/4GRENe
	 eXNJdj0Jd/W0tTvOBKe+5Dvs/sdKzm/KBlGQVnSROEveqrCzAMVx1Fc87UBiYUsID7
	 t6lzBeAk60wU+3siRcAykcP4ikgeNgXlynFCrQQ8=
Received: from github.com (hubbernetes-node-5eb4311.va3-iad.github.net [10.48.164.51])
	by smtp.github.com (Postfix) with ESMTPA id 6945A340B29
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:32:08 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:32:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173443/755ffd-000000@github.com>
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

  Branch: refs/heads/1173443
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
