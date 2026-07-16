Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57385409624
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197263; cv=none; b=jdq5aCbqrd9st5AW4ApGFnAm6ZoN17g/ymRsjL6vXbBmHPkEEzU9bC+Ur1gBSBMYQZdkF1GGGlGax2/BB+A1S8+U55yHjUa2HyB1ara1wkhU+SQX0USgFo2d8ictNAi5Dy3N621AUocyC1fv897J2fxQ0Z8R+TwJewbMC7WAtko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197263; c=relaxed/simple;
	bh=3HW4dOxSZ0N64EDBK5tn4UEL9qKTZJo7mr+RYenm3V0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uyKaKr3gmAO0ChVPS23RmWCAU9ZpUYhuapw2L/BBPO/nyHUee4p27Gtp2rCi/W2215SxWbcQ5xNdtI8T+KpImTZgw6ongV9aRTaMVgu2mw5lDdW+pszx4Ih6yf3PrU3t8h5UMV/8pAhAKUvU2uieEsQGjOkquvRshXJNL8jFneQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gAcmM/fR; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gAcmM/fR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784197261;
	bh=Ki5pUtEsnxyW2zN2SnnwmMmQ0bJMBtriQM0vN/PBXHk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gAcmM/fRmRcIRAyShzvEk0bHqMYmJhvWU4RMkV3RmO+id1Ogi8qlh+cPqMDa+8rmw
	 j+GsyLxasFOefunTVbwi6uLCmdMdRsFDMxayMAeMaWO3aDgVP5Aa+fWtaVYXfvPF6n
	 hAEolim3Bv8buPjzHSw8ewq2LAPeVTWSMg9UBlwM=
Received: from github.com (hubbernetes-node-cc47a34.ash1-iad.github.net [10.56.226.63])
	by smtp.github.com (Postfix) with ESMTPA id 794E418070E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 03:21:01 -0700 (PDT)
Date: Thu, 16 Jul 2026 03:21:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1112149/fd0161-000000@github.com>
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

  Branch: refs/heads/1112149
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
