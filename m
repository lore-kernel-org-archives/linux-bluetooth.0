Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1699D1A9F89
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023003; cv=none; b=tdJMHthibekxKt+Sn8hCDNHU0URjMWSQTYhwzyuxWyQVMIybnH3vd1zGdlayOq2UiSut7mF74cXMQu5b73DJ3Yc1sIuX0orCq/JpWaJDR/21Yt9QyymBC4K3oDi9jLc1R+jBCa1K+U9bSPVeqh1rwXAJ0bOuEyrWmTWnCvajOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023003; c=relaxed/simple;
	bh=jSRkv+wS+K+gvW9snGmI7ZnTJWOywWCDtT3zNG+aQkE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aeRGvDWwwcocmtVix+CI9mCPiALmTOds1vvMJ+5GSKjzMkjzHG0WeXdN1H+P41RYgu2skML8UwhT0sSKtHtWxTjpLX2wTyjMq6X8FHpTuHPlko18bfUFQf0pynD8Mc6/OlR0Rs/W821dI2zwD1Olt/snRg9bhADIB0iS5A+pkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZscSg1Ei; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZscSg1Ei"
Received: from github.com (hubbernetes-node-808ae52.ac4-iad.github.net [10.52.150.41])
	by smtp.github.com (Postfix) with ESMTPA id 2571F640425
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755023001;
	bh=VEcngsySg0BkJRBUunDtF67E2JTjSygcatyBc25Hf3Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZscSg1EilkIaIPPJ0TAF/TiCtYAu8ra9ZH4TM8Dm+vFUu3jwiIW4FfxYqCda4mwzq
	 pI1t0RvhsGY9y9+w8weq7VGVgpn9MBKPhR5KbVehX2DxM2ONBa6Bi+d+lJBdt3LOkm
	 HNeF7Z7Fi7vXHPAsAkCZvIGT6GQOhCW7C+AdPRIc=
Date: Tue, 12 Aug 2025 11:23:21 -0700
From: Myrrh Periwinkle <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0491cd-9cdbad@github.com>
Subject: [bluez/bluez] 5db6d2: audio: Don't initialize media transport volume
 fro...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5db6d2fef66fb87217b7795b3d24372e219a9692
      https://github.com/bluez/bluez/commit/5db6d2fef66fb87217b7795b3d24372e219a9692
  Author: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
  Date:   2025-08-12 (Tue, 12 Aug 2025)

  Changed paths:
    M profiles/audio/avrcp.c
    M profiles/audio/media.c
    M profiles/audio/media.h

  Log Message:
  -----------
  audio: Don't initialize media transport volume from media player

Media player objects may be shared between devices. As a result,
a device without support for hardware volume that is connected after one
that does may end up being erroneously considered hardware
volume-capable.

fa7828bdd ("transport: Fix not being able to initialize volume properly")
introduced btd_device_{get,set}_volume that is used as an alternative in
case no media player objects are present. Therefore, we can remove
media_player_get_device_volume and instead use btd_device_get_volume to
determine the initial volume.


  Commit: 9cdbad590b7476b83e2ef240a486fd5159251be8
      https://github.com/bluez/bluez/commit/9cdbad590b7476b83e2ef240a486fd5159251be8
  Author: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
  Date:   2025-08-12 (Tue, 12 Aug 2025)

  Changed paths:
    M profiles/audio/avrcp.c
    M profiles/audio/avrcp.h
    M profiles/audio/media.c

  Log Message:
  -----------
  audio: Remove media_player.volume

With the previous commit, the media_player.volume field is now
completely unused. As this was never the right place to store the
initial volume to begin with, remove this field entirely as well as its
associated supporting methods to prevent confusion.


Compare: https://github.com/bluez/bluez/compare/0491cdf31754...9cdbad590b74

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
