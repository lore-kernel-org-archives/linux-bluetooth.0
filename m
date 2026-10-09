Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED6381AF
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589157; cv=none; b=AXb/Hp86fP+sCR5UT7OAXzWFXtD7JU04HcaXLxFO7qjOYx+0ZVybgrfQHgiHPwSqhwNLBJwLsnoJLrba0/ko25ylUx7qHeKQVay/bovhzkzIS+WZxnGZ47ACTxfHW5zF332eixykX7UwZyLbzvpxXI/eDvVQrl9zfGRkT655Cuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589157; c=relaxed/simple;
	bh=ZvWg2FaemMrumF8tqKgtjPNvsB1D0tmSps8VBzacKzI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h6TqW3M0qkuCMKKEg7kow9jo63zJmTlryFHzPZTxe4ennPknEtUi8lsC2ndW8mlo04UvNoU4Cj+X2ik8RSewN1af9uJCCDqJhnbr1qe38JLqxsnjO0Sl+PgtPPoMORMZjG5znHaXHA4h7WkxEmwNKWjL0pz4ChvvPq78UA2rCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=ekFcL3tY; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ekFcL3tY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791589155;
	bh=1KtNiv6dvhrb3eR/2eRQFZVYmpz953mQQyDa01g9S28=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ekFcL3tYXdlhNFftzoEvKkcfABLk35rDTWPKThAr8xnupozzZHoU8RShARRy0+L70
	 IsucbTzJSCxdBEe4yHhWJ15mTvWGDdTiB5jew4GGRyjk7306N6l/9Xkl4utYGAIPuq
	 9RC5TIZUMaOKkD48O0c5aGAxL+sMRWEu1fyb0D0PIDpb9+MbZPxMCOkJ36Zg+gUisQ
	 nVPwxUB6b+WkaNXrlwalBLrsk5O0VoitvvSY27ACKlIFeh4TqhnTeHCwcDB26xHBoB
	 P7Ly8/321sofm6wvPuwglk7fy3gauBjQLlCK2w3ItoGrkM3cinS79CJb0U9i7MOSTE
	 fHLSswNVPPSYQ==
Received: from github.com (hubbernetes-node-7ea5834.ac4-iad.github.net [10.55.94.27])
	by smtp.github.com (Postfix) with ESMTPA id A4E4F780737
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 16:39:15 -0700 (PDT)
Date: Fri, 09 Oct 2026 16:39:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182613/2957df-000000@github.com>
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

  Branch: refs/heads/1182613
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
