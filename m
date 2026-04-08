Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120BA37D127
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677381; cv=none; b=Sg5Z/wPJ5hr3fydAHDvCj9mOKVwKnlFJFeD62qS7q9RhxSSnXZ+JGBz/VY15w5ldrXKPgVro8AHND2f1u0vn9L2cDk1j5AbY4nXnoExpQRh0hmutzlObILfMhQmZQYXd7aiwXjBiauLEXi1xUTrLifT3bi69Ny4iGvBe91FPf0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677381; c=relaxed/simple;
	bh=/RaguIFD2wqYr7cz8IsQ220Ld7T1kuPTpSp9bdQXTRU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dGsJTJ6Qhka9vjQgw8DWwLf8Yt98/MjneQyvDn4KM7L/2gmkntPR63cyfbeKDUyBOlzqglDXb2cOoP2oQtd1AAXrSmoXnW3K/1VbjwwHMHCjqTXXe5JCri8SI5/IVSBmSlGG4DVsyRJzqMLu1bwM1yIfqQWZMqbvbTJf3JiRYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Buvv986Z; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Buvv986Z"
Received: from github.com (hubbernetes-node-a6b8dd0.ac4-iad.github.net [10.52.156.35])
	by smtp.github.com (Postfix) with ESMTPA id 1CC1A80B44
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 12:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775677379;
	bh=t+tJWNGsuLjDQIFd0MIjektzBV77h+MRVLw9cFxq9ig=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Buvv986ZOufZNPMwJZ4HYwYHtMsMPcVx5wRC1siyD+ykKZDr3JdqiTtQkO1drxRrZ
	 TAeU/X1SBmFSGDaq1BsLyVXGlWmrTLmSgo+eVfxfHLTz3Ocfm00f3u99zy8T4/YqYf
	 ngjR0ZuAVp+M3qjh9f4kZQA6Wv8Kwm4wFvoQ3V6Y=
Date: Wed, 08 Apr 2026 12:42:59 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1078371/4013af-000000@github.com>
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

  Branch: refs/heads/1078371
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
