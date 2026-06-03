Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5143D51E
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524937; cv=none; b=CXUIwWpq4JrvqPvpcFceMYewT0smAGZ7OHO/KA9i82V1IiIYqmgqL/KlJr/UBiJli8iKEINLOy8gUPDSmfK5QG+ELah/TWvunKx9kQHZ8AcsG9mNnpMUfgNIqzzP+YAL3NEjLGr8eU/yOZW9ASRI0oWm+0n24Pb3sqzVFQfcPiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524937; c=relaxed/simple;
	bh=Ya9EfYhBFCZTHrBzgBIZVp4CHf4tAC36PIyw5XVbGXQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oTV9bt0s/CBVSP466damUBW84Yla/Huubdwf0e9TEOEAZlhBZZz2vddItDTbzVITLYRh+17CqyR5fUAe6otCs2aQ1mjeujBslBWvxiVdTqR30yPVplSVTSaXtGPiq/6oUbqcnl7ycTXkSWZu5ZkQW+kx6cH8eP+VJyuDsVcQ+Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fPdpWFNG; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fPdpWFNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780524936;
	bh=mgl3841y2gXGJlDqrhnh0JGkEzvCnEzE40jROXHYpqc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fPdpWFNGazn7PtqwXW3qB8dBTY3InBUaqsBjjba7lta32ZmJ1eDM3ffYyBGExEQwx
	 jYu1oJuRMAFi0ucvWVdJn2CckTQsIIQSsR0xVW+jG6mFtrUE8Jq9Y6DNflGMKZclkI
	 LFx8IX/0S3rVxGJMLcz4qseuBBkBXKn7OdGCfOPA=
Received: from github.com (hubbernetes-node-709e1fc.va3-iad.github.net [10.48.86.34])
	by smtp.github.com (Postfix) with ESMTPA id 128972810B2
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 15:15:36 -0700 (PDT)
Date: Wed, 03 Jun 2026 15:15:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089467/d11e06-000000@github.com>
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

  Branch: refs/heads/1089467
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
