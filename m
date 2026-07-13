Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5A35C1A1
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973573; cv=none; b=aoeEHbyXWmG8eMMCcRScKBAwELhmTyyM3A43aiB8ufYEFUMVDhgoyG23Op5pqskf6tcx2omVMPezMQCojRY9v57Jd2rCx/SkPB1QO/7A3ecrushLPvgAcoVejYm2992eSug6vP8DJn3VcsXoirOBoKGvT4xAVZMGmLq1os3grSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973573; c=relaxed/simple;
	bh=oPQ3hzz4ZUybWYnv6f/6V49bVVcYpPdpNKJVZ5i7ZBc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tZOXojxt1r03Tt0fjzfHW/uN0qEV79Hd40oV253H078Lry1UMXDuZSTBqKB7p7go3NJP2K7S9lkrFjegGv7bKpGEvsDJ9dLxOgc3k55HNS0otd2nGELjRkk1VDhvGuS3BOBkCK2VyDCZvpS7TOH2zIhyY8Ywo907hbq2ap50HK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NOFK06n1; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NOFK06n1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783973570;
	bh=p/+vQpAEK7EaxhScnaqywjBL5RwhOcVT79b/dFtVw6A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NOFK06n1M2xr61FilA/Nx5t5kF+kjViRTlCKE13xUuDXDS76/Rg2NwaThApIXnrwO
	 UhBGN7jtj4eWCosYP1/moOvg/sa7rEcGClkfcN+Es8HKb0Fwm/QMbpT0FXaanP1GAF
	 VuN+rT0BWp//wkoQ+9Utzj/hmxvUVAX4tmzwuOFE=
Received: from github.com (hubbernetes-node-5a3eeec.ac4-iad.github.net [10.52.174.50])
	by smtp.github.com (Postfix) with ESMTPA id 5FBFB32122F
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 13:12:50 -0700 (PDT)
Date: Mon, 13 Jul 2026 13:12:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1126713/014940-000000@github.com>
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

  Branch: refs/heads/1126713
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
