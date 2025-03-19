Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FCF155C97
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415358; cv=none; b=f5o0fNdKsg7KYipcysLTfGrCUNeXm3ouvkZiZQZrX6HjbeF/J9WlV0Yi0X2DK1mEjEjF21+m2HA1qmpbQR6qUpVfLRN+kY7OxYaT6Ms2S2VHEVf5sk4a3EeirVEKP1OXDE7xX7Qqn+jUL6Syblhmx1IRoqMkHA7mKOXzgKigBlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415358; c=relaxed/simple;
	bh=ndi2v+A/ybEmS7tlveZWyeiSMB82S70K/MtGcw1toxY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mHh3QFgsqTu8z0P1sOtkgvn4Hd7ED9BFt9n2D5ppQ9N0nsZEq2euD7RJmsmj9szZKI2WzS2uX0NOHB11nZWpogOg6K+mkRBukbBKKE8AngxF/K73c78+a7qGXnV9b8GS66QWH5HMF434hN0RL4Etu0J0DFliGkqY17QF7RWYnOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UD213qLg; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UD213qLg"
Received: from github.com (hubbernetes-node-edc456d.ash1-iad.github.net [10.56.147.19])
	by smtp.github.com (Postfix) with ESMTPA id 21687600B38
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1742415356;
	bh=BXAZaI7TSIBVwZdtzjtnRjWaJ5VHBx9G7MebakcPqIw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UD213qLggR+6Oz9aqMeVgAvbZTeSFzbRgrD/TkYYnJub0/HvJPH7ctd5BlJDg8oBA
	 KjVfCRR932VUNFpc2uE/qk+MAFwrhQupmx+qTcS/V/VO7y5oefEkn9wyXyP12a3DoT
	 l/zx3ghop8EOh0BZeRmNYQPn416xLpxdmwFTwNGk=
Date: Wed, 19 Mar 2025 13:15:56 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/50a01b-f77e72@github.com>
Subject: [bluez/bluez] e88f91: profiles/avrcp: Fix AVRCP PDU parameters length
 do...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: e88f914ea700dc5f67e3a260a29b592df0cf2936
      https://github.com/bluez/bluez/commit/e88f914ea700dc5f67e3a260a29b5=
92df0cf2936
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-03-19 (Wed, 19 Mar 2025)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  profiles/avrcp: Fix AVRCP PDU parameters length don't match

This is required for passing PTS test case AVRCP/TG/VLH/BI-01-C
(To verify the behavior of the TG receiving an invalid SetAbsoluteVolume
command).


  Commit: f77e72c3ab11d8c06f487ff7892afef2aefbd0f6
      https://github.com/bluez/bluez/commit/f77e72c3ab11d8c06f487ff7892af=
ef2aefbd0f6
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-03-19 (Wed, 19 Mar 2025)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  profiles/avrcp: Fix PDU for SetAbsoluteVolume with top level bit set

This is required for passing PTS test case AVRCP/TG/VLH/BI-02-C
(To verify the behavior of the TG receiving a SetAbsoluteVolume
command with the top level bit set).


Compare: https://github.com/bluez/bluez/compare/50a01b0c17e9...f77e72c3ab=
11

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
