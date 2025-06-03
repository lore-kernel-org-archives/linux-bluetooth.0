Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E41DE3D9
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945628; cv=none; b=WMR5jZeoTW+a9X+R51agmXqh3MMcGTBAhqlT4MTweeyGW3xSyq7BSO9ySkPb6LnfV8jWW8ApiD1SdAEbbPujH4Z5fG3UJA9mtpDuyb+izgbmy+OVQ67HRlQr04BGgSdVWw1fNKiSEaCNqRnkO60zV/8WvyKKkFk28AohnUfMgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945628; c=relaxed/simple;
	bh=M8cmPvqa5RT1Z3lqpB+gQcTp7NyFxlQuCvqDnWF32HE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jR+GVIH3PDWCtDxrIV1hNzPN5ZzDkmjxY6I8nv+Iosdj+GoE7J/XW4MLhGbIWhKuKE8yp3ruZHaLrxPhlTCy8es+isEU4U28Q3/s+5MJq1YJVJtpn+XFZqVNgrWZYPcuq/g+ekaLrBva2BJEptTkqIz6lSnSIxNbxTraA6ZYNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dk1Q5z2a; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dk1Q5z2a"
Received: from github.com (hubbernetes-node-32f4b8f.ash1-iad.github.net [10.56.160.42])
	by smtp.github.com (Postfix) with ESMTPA id 817609211E9
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748945625;
	bh=xhaaWlVhBdTexuw9cCUj/WyIeisA8JWge9Oipdx9yJ8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dk1Q5z2ar1N/AUl6IH7QqdcDzYbycGP0e7fNNiRwasO6Hb3shyPFldzva5/3mWKmv
	 h0owxwsLbVGYBfTyIx8pcdaK+cHlQgmsZWM88KAAbBiAg09lBnCCWoMlnxaIlmMH0p
	 ANy/wIIpnjavojsdADfKardBDo/Az+URkctrrfNU=
Date: Tue, 03 Jun 2025 03:13:45 -0700
From: Egor Vorontsov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/968245/000000-99b6f0@github.com>
Subject: [bluez/bluez] 5bc17a: profiles/input: Add cable pairing constants for
 Du...
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

  Branch: refs/heads/968245
  Home:   https://github.com/bluez/bluez
  Commit: 5bc17a3d844bb31c912a943a7bd7ce7a70e303d6
      https://github.com/bluez/bluez/commit/5bc17a3d844bb31c912a943a7bd7ce7a70e303d6
  Author: Egor Vorontsov <sdoregor@sdore.me>
  Date:   2025-06-03 (Tue, 03 Jun 2025)

  Changed paths:
    M profiles/input/server.c
    M profiles/input/sixaxis.h

  Log Message:
  -----------
  profiles/input: Add cable pairing constants for DualSense

Sony DualSense & DualSense Edge controllers support cable pairing
the same way as previous Sixaxis controller generations do.

This patch prepares their input profile for its implementation.


  Commit: 99b6f0c9cfaeade4862708b29183691aa0b7dd7a
      https://github.com/bluez/bluez/commit/99b6f0c9cfaeade4862708b29183691aa0b7dd7a
  Author: Egor Vorontsov <sdoregor@sdore.me>
  Date:   2025-06-03 (Tue, 03 Jun 2025)

  Changed paths:
    M plugins/sixaxis.c

  Log Message:
  -----------
  plugins/sixaxis: Implement cable pairing for DualSense

The code is very similar to that for DS4, but I found it's better
to separate the matters instead of generalizing it via constants.

Also added a request to enable Bluetooth on the controller to initiate
pairing without the need to disconnect it and power on again wirelessly,
basically emulating what PS itself does. Only for DualSense family now,
but can be expanded to DS4 too (I don't have one at hand to test this).


Compare: https://github.com/bluez/bluez/compare/5bc17a3d844b%5E...99b6f0c9cfae

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
