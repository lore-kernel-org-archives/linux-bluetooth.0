Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB927FD49
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650183; cv=none; b=iR7QLJPvgP/FiSOeq+PnrAHBkT0O2bAk873grbuhg6cKLphuP3av/TP2FGbmy6FgtZG/nrPt39vjPuImWcMKTFrxAoxOrfmgChEqXf+bam3ZPU8ZCTtMA3zDQZdHTzu+/X1MQp2qzLzNVJ/AKoAX/t1Yh+2mCWG1cs8/i2aMrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650183; c=relaxed/simple;
	bh=L3oAA0hqHwi58prT+hhxT1ByIicvBa+bgwwgUIxqoSs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lktyMDopcRM8eieTNZOO4qIH3JzhlcRECgEuYLar86a6ycmpNB9byL4axigwJYTAQYcx1atc54V5phhpbBLTyo21+yMHHKXBVNJN+5Nc4n8cqf8U/ChYsRfNzlcalMBOZN1JxFx3LVGsLeYbjTMXME0rh4MeIlxS0hZYhL7dnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I3nqe4XI; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I3nqe4XI"
Received: from github.com (hubbernetes-node-a9cd48c.va3-iad.github.net [10.48.142.31])
	by smtp.github.com (Postfix) with ESMTPA id E90554E12F5
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749650180;
	bh=fZmrS0EEsclZ1zYfJ/jMmgpOwmE1H3IlEOlJp15xbKg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I3nqe4XI9m6t6YSxw7Pq2KNORRNPVo7u47bUBCuHTnrnJn2mwOhRMaIXxkYVfKCQY
	 7ZfinqQQcLuknZkjpqphEiTnsDyUxqmTj9JgJl4t6KuzlOAmCx/TdzBLw1cJJPuSeR
	 sCSiJ7OrKDl8+edgDbGR1kgbKDO7cogMcgxK1/Mc=
Date: Wed, 11 Jun 2025 06:56:20 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/968319/022aba-000000@github.com>
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

  Branch: refs/heads/968319
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
