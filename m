Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168A25332F
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327564; cv=none; b=SXItsy9j9A5rTxwni14ivBu0Ppf11ljd/ntekddwSFXb5+jhQO5+IEWh4veRIBmnlIhRGylEB84Iyk/UhMsIZAJRIFHlVjW/miR/Jz1OqZmQeiTZP9f5HevjhLU4Befs9clipOnlkkQbDH+SnVB0FKFLHnD6FAe/SBiFVO6IcNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327564; c=relaxed/simple;
	bh=z2ELkRi+bSl/lEVoJOosBImRTVp3DG/jVEGF7SGRkew=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=r8ygYDWuMALVRGFj+NOtLY59d9SnKYzELMcBRbp+Q3Mt2fE3KFg0SbmOS+8apJqQYHpJxiMExGh4fjmC8q8ObJP7V5d2gd7wEwU4ZCVjq4tEPA7enYgJodmyonbXYm23aMP+7OyfR7hio581nLLuEkcbu6SXB2r5/qMZvZR2XG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=geaYW1j4; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="geaYW1j4"
Received: from github.com (hubbernetes-node-dc10950.ac4-iad.github.net [10.52.153.32])
	by smtp.github.com (Postfix) with ESMTPA id 47FAB21249
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 May 2025 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747327562;
	bh=jmVbTve6Kr3NUxrqdE3T/ulYoJKj1tp69V/NWnOc6JM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=geaYW1j4yJ+KsBNcZywKgl6OiArNJNDcp++a8/5sA0BxqUJh+CZ9EIjdNWJpNVdYD
	 IkEvSHoy+qb6yGoUygp8OcjzRsCuPMNg5EkJ+qap7DfM1qkKOxkHKVXeMi3k4IpuU/
	 JuBci5iMQQcwBuggwAwz7EbqCXPCN221OoJx7vLE=
Date: Thu, 15 May 2025 09:46:02 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/963312/000000-9f18f6@github.com>
Subject: [bluez/bluez] 9f18f6: device: Reply br-connection-key-missing on
 connect...
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

  Branch: refs/heads/963312
  Home:   https://github.com/bluez/bluez
  Commit: 9f18f6c4ebf26f9410f74cd6db39f37f3e55274d
      https://github.com/bluez/bluez/commit/9f18f6c4ebf26f9410f74cd6db39f=
37f3e55274d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-15 (Thu, 15 May 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Reply br-connection-key-missing on connection bonding error

Currently when connection is removed while the client is waiting for
Connect() the failed message is br-connection-canceled, even if this
is due to bonding error.

Implement to reply with br-connection-key-missing, when the connection
request fails due to a bonding authentication error, allowing the client
to differentiate connection failure reasons.

This has been tested by:
- pair a device
- disconnect
- edit pairing info to change last character of Key entry of [LinkKey] in=

  /var/lib/bluetooth/<adapter_address>/<device_address>?info
- restart bluetoothd
- in bluetoothctl, connect <device_address>



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
