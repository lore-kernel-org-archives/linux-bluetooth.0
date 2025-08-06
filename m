Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D97261C
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443032; cv=none; b=Y7LJq220O6/Ea6MFq/fBN86QIY4ZNasIFfboTk7w7i59l9tS1TmOd/rTDXnuV1/8GE3FAidM3wkNJHQl2KRx/D3eXqbvI2iIbSfGCNdkm9GZDvzaElvps50wU3BO4Rxiwp8Hlhc2IoawoZVwhkQvyA79MJaNNmdrjSdbUwqch34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443032; c=relaxed/simple;
	bh=O7SsPGvx1+XBB8nL29Dc6TQWOCsyzKuesAJKJ/wXqWs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=V1yxh5FqpGPkbDFm1h2MPLrYL16X5iAVnJaFKXEcg0RYQDDBl4tCVD0U2tCJpNQY/sXd3o1a+IMrEQmCvt0YaRPhG8VbxJxIsDxfCUpQkhzp7HlTNT7Aw/a8IqmYEQbb9VY9rbspWKxYUNUHP1CtEyOiRPjklE1+HAia+zyuVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BeftpVa2; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BeftpVa2"
Received: from github.com (hubbernetes-node-c88ee3d.va3-iad.github.net [10.48.221.18])
	by smtp.github.com (Postfix) with ESMTPA id 8E7A84E02F9
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 18:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754443030;
	bh=PMQJjB8066PpYofXUo5DV9/xsePI5/sWWY1P3fEAOMw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BeftpVa23/GRq3916bpetLjIIibZrNzJeKtrHjYLNjTF+qWK/mROUR4nOhCtXm4KV
	 cr+9COvVCND9xagVO62NNYURKIBrCi5Hvg0JVf2S6/kjnNgi55/BV5nfueHvseuONO
	 q343/aD26GODRYHg4/RcUTH3T9f07mnvRSHGh4Gc=
Date: Tue, 05 Aug 2025 18:17:10 -0700
From: Myrrh Periwinkle <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/988588/000000-94ccc2@github.com>
Subject: [bluez/bluez] 18c07d: audio: Don't initialize media transport volume
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

  Branch: refs/heads/988588
  Home:   https://github.com/bluez/bluez
  Commit: 18c07de44a6b8c2bda66a0dcc455220df792e268
      https://github.com/bluez/bluez/commit/18c07de44a6b8c2bda66a0dcc455220df792e268
  Author: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
  Date:   2025-08-06 (Wed, 06 Aug 2025)

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


  Commit: 94ccc2ab32e46a7ab190dfbc4274e2ca8d0beef3
      https://github.com/bluez/bluez/commit/94ccc2ab32e46a7ab190dfbc4274e2ca8d0beef3
  Author: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
  Date:   2025-08-06 (Wed, 06 Aug 2025)

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


Compare: https://github.com/bluez/bluez/compare/18c07de44a6b%5E...94ccc2ab32e4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
