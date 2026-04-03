Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F76368263
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222386; cv=none; b=dY0ieMhaGySPYWSxT4XKvMs9r8Sm6l9GBATitcZRhBErdxstn/UebygvJbhgIoC8zKNtvBfWp9kXppc04r8dg51VoHNRi26prQGI9zTJ4jnYouyZRMN6IXHvln5k7Rb9UmbirQu8zFNcOFELfMuLfkUEF1/e4o/5p+GYIQpbRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222386; c=relaxed/simple;
	bh=0UoPIxGYMf064H8qP08Jmh356eYZERjggJB+BZWL/es=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LIrFfpu5MFRG7gV24FFh/3rlatZ0RpccwtXMLgMmtWonLjXn4rb0/Si/dmwToW1BlQv4/ZQHJ8i85z9lfx4TCw2v2weJIUfeAdoipGSovbPn+ylMui+8edu+IZDu/T/mUoUVriPPubOb6FfgoziKxcugonkaO1G2dOVsG6vJv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PH4Mlzli; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PH4Mlzli"
Received: from github.com (hubbernetes-node-a30f74f.ash1-iad.github.net [10.56.131.54])
	by smtp.github.com (Postfix) with ESMTPA id CF860860095
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 06:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775222384;
	bh=1lxHuFiWunMWjytXKhYus6ExGR6vauCTXZtS/1FRrQY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PH4MlzlihF4QtuR1TbPFrMOtaPibedBrmaln3LO6ud+saKefC88EOj7b9kg8crSrc
	 MpAswe8fdLwvgbBtHH9QRoB4Azcdykf3Z9lnKkvndOwZjKxEKIES4HytpD0iU2dLmk
	 73BJhLtfOwb/E73AeWYVTAeLVHQ39w1xw9NoUC6g=
Date: Fri, 03 Apr 2026 06:19:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1075804/6a68f0-000000@github.com>
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

  Branch: refs/heads/1075804
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
