Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44A4AD7FE
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274750; cv=none; b=nY/D3ApQd+gozGLOTRj9x/KWjK5oP7VsqBHMRi914a4ZglRijDNL8w6MCmQgHP7nIi6++l+FLdU5acuqRxrCNkeAtA7YAwy/cP2KqJKnujZJ7FnLyi1gfPJSACZrgHM6D6nOqNV2J5XObxzm9KuG60U6YdPsTGDkCXzLX446V/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274750; c=relaxed/simple;
	bh=leOifWtt+2tDNuyNKyppML8BX31IH9bdUYq8/7iFuvQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GJFxKxUGlwCzQuzgTG9v02kG/6taqoyi/R3O3Cv0FPavzm9Bv7bmSZuQDLjKlqbNW/sC/i2n/Uo2m6sdBApC7rKU6vgSWkTMMdBeSLtyYk6gqPkUTiSsHyibDUhCZQrRDbsBTuaGftprC0ADTc42kSgqY0pJmN4AvhlYPuQKOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JFP0jTfr; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JFP0jTfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790274747;
	bh=nB2X89jH9wRfscGvplmfbhtyeEyF45oxW70veI0YpJA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JFP0jTfrNxX13KagjCmZtgzHUcIYnG9+MbJDLl4ryUmztUWIUba3/AQD6H8Q6pjwH
	 AEGnSY9VpAOEQv0hVX5vfRVjc89KtBkgr+djKRTy6Gbu3G4rxu+Cpb2po1ImYToyEA
	 r4iN9BlxcirTpmE5cyiR+nr/4qDTF88B9VGVaKt4=
Received: from github.com (hubbernetes-node-a2ce640.ac4-iad.github.net [10.52.145.27])
	by smtp.github.com (Postfix) with ESMTPA id 98B3F7810D0
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 11:32:27 -0700 (PDT)
Date: Thu, 24 Sep 2026 11:32:27 -0700
From: Alexander Sarmanow <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173237/000000-0ac718@github.com>
Subject: [bluez/bluez] 1d23b6: doc/org.bluez.LEAdvertisement: Add broadcast
 name
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

  Branch: refs/heads/1173237
  Home:   https://github.com/bluez/bluez
  Commit: 1d23b6bd62a665145b16c2fd20e735c133292385
      https://github.com/bluez/bluez/commit/1d23b6bd62a665145b16c2fd20e735c133292385
  Author: Alexander Sarmanow <as@discnull.de>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

  Changed paths:
    M doc/org.bluez.LEAdvertisement.rst

  Log Message:
  -----------
  doc/org.bluez.LEAdvertisement: Add broadcast name


  Commit: 0ac718fdac770c9bf6a31de1f3fa3afd1eb4ff03
      https://github.com/bluez/bluez/commit/0ac718fdac770c9bf6a31de1f3fa3afd1eb4ff03
  Author: Alexander Sarmanow <as@discnull.de>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

  Changed paths:
    M src/advertising.c
    M src/shared/ad.h

  Log Message:
  -----------
  advertising: Add broadcast name property support

This update enables setting the BROADCAST_NAME property via the
LEAdvertisement1 object.


Compare: https://github.com/bluez/bluez/compare/1d23b6bd62a6%5E...0ac718fdac77

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
