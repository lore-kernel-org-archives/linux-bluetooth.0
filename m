Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B53227EC7C
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168857; cv=none; b=EiN46hdpjOh01qXpDzoUw7/waL58s3nDvenam6sU/1U5T++anTTCvKKxATCmQ5PUB8yOdLGG4A4Ey9Lz+D5oBwYBnud6rpMgvy25QENOOc6WVs+h1QpNMLaHCJwzdTD8v2+HK00A8k64XK09zVirpHBviqzZnfFie47U03zKGNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168857; c=relaxed/simple;
	bh=yChirZpFzJxy3Q98HJXVS+oKtrLM4C9hVspQvIEc6eE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QTzJsQYrbvAVTZioX8H2wLd+JZNbDFSjqGeeLlrHONnq4JbxzPO8kkgrgN2nAGlVFxVqGAZeLH0qrIl9OraLil/s2nvbzwiDAVU+wThC7C4m6AMmntyC9FVBfeGtDqu5UWEdCvYtsiWL33SwypgbaIUqRTnatj+M5XDacHdaevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ExtwBIVi; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ExtwBIVi"
Received: from github.com (hubbernetes-node-3294be7.ash1-iad.github.net [10.56.159.37])
	by smtp.github.com (Postfix) with ESMTPA id 5BCDE60050D
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761168855;
	bh=hpxlswco/f7jJ10S5q1MfoCzabzAHW0rdLo+7bCRadg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ExtwBIViyfZZ/i8JaPtVwFegCn4fEfNeWTVt3QGb4660aspXJ4v1nrUuCiE1N+6Q0
	 /t+TAKGuNJiTjoLPE2KK9l5cZgJ1XZDxGTMbO9MGG7qlPf2RmNo2ClhVDcEiiYMXdp
	 JdYhd4Dz/9K7V+vrvQOsjIfdtChj3OKYMKAcDp5A=
Date: Wed, 22 Oct 2025 14:34:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1014654/fd9000-000000@github.com>
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

  Branch: refs/heads/1014654
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
