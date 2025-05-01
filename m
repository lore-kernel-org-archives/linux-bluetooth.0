Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2EF367
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746127373; cv=none; b=T1Ug3ZRMACo36voB+l3M2OBWg82VmkQ/fSOs04nvdVR29QvSmrLpoo1om9Tszpogp7DbjxiCcKhKcMoWZaoya4/6ioW8alf1ztmGBH0DNoTflzcAx8PF+7es71IvXEdEB8tb7TqDcQqQ7D8JL0ZYEEsFrrABBuPtn3yft0YL5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746127373; c=relaxed/simple;
	bh=0VJbiIFF7RUUeu/KZliUOchIJMTlxbfytFK27m9Dk0I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DlWzJHLL5tqI4jMmWYxmZyT0xmzfOF9Y0YC3kGscIc7IbZiiqAvh+RN5I9c0J4aHccoJn2A8OECYLO+2mQ6lNXRILhXM95OxRH+v2KvDPg8iA34G3vedT/Z0om2ase03I1bKGD/y2sNGC4Ug0HRvTx4Dl5307mTJGKcpbEnYq98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FtHWZuUF; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FtHWZuUF"
Received: from github.com (hubbernetes-node-9f6105f.ash1-iad.github.net [10.56.177.19])
	by smtp.github.com (Postfix) with ESMTPA id 93DB9600936
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746127371;
	bh=W+WIgOL0mWu1flx4YhwDrPbfDKcPJmga0k4x3L43Qvg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FtHWZuUF7xfCFyZRyl0Z5olBSziHVFHBQ12OxL6fW0iDOj1n6CSrsDLaUhOaRvGTp
	 G4f0aBJTZ/01wAYkhipcTwWFYwXPqXPj+iqewU+6wMfDZOZ3ggNa6vX4049FfuCmj4
	 gGsFuYbtlXM5wLwhtjtLBI1tkReUxEKdD7LZ9ItQ=
Date: Thu, 01 May 2025 12:22:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958828/b62395-000000@github.com>
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

  Branch: refs/heads/958828
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
