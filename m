Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA41758F
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900042; cv=none; b=NxpAWHjWGQEjnNW5BgU+Jfan0MXpDmjfoE58uC1P83Xj9KI8+uekkIXkMYr2YserIGUdkJs1luUB45wknJWViNDeHLOSG44DAZslRr2OPUazOZOvVG8+DjHhMXe+emCrI+vbYmP1EzJsH/fVctsxRCy3/QpYuW79n5gZFqw7s1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900042; c=relaxed/simple;
	bh=Vr0wE8DxC9XuHl31ERbYkXQ9j3wJ3r0x+iY3PE84nrA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OoSKfK6cXh3qR9BEsgy4tS62Ree2EovYPZc4kwuARHEukCkJjYrgy9RJmiH4lFoxZUpLWf4tMO4voxuv0hOzWaSE7G1TTj8SWClpj5X42Mx5i1sFbMddjBZB+5yMY5E3cIagmXbWPnd1hTEZBYykAlHKDQxft5L6NWhsmGJxq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RQtUx/AQ; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RQtUx/AQ"
Received: from github.com (hubbernetes-node-7cb6da4.va3-iad.github.net [10.48.14.65])
	by smtp.github.com (Postfix) with ESMTPA id 766604E08DA
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 09:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1725900039;
	bh=Xn1SNaUya9LRHp5FnGJeWkltK5nkcfmJOIt3BV/10H4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RQtUx/AQBGob76AH2fbmemQdIla43I2PtFkBd7sUqS7GlNo1oy2Xr02cW4IgKNSKZ
	 UneBkGocaGp+IIkmJJc4/oSfcjnWQnqNxO96lNk81t+PY+SXW9wmosoAMTe9TKFXmI
	 fWyF6Vbeu91svcZMZQcYaxOW+UlUjNT3j3vqlqwc=
Date: Mon, 09 Sep 2024 09:40:39 -0700
From: vlad-pruteanu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e8575b-4ecfde@github.com>
Subject: [bluez/bluez] 5c9431: doc/media: Add Encryption and BCode fields to
 QoS ...
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
  Commit: 5c9431fc2b97b24f8523b3cb9a3df2fedec3000e
      https://github.com/bluez/bluez/commit/5c9431fc2b97b24f8523b3cb9a3df2fedec3000e
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc/media: Add Encryption and BCode fields to QoS property

This adds the missing QoS fields, Encryption and BCode.


  Commit: f72fd8265000bbd5e3bf4b705576cf046ca2c8a5
      https://github.com/bluez/bluez/commit/f72fd8265000bbd5e3bf4b705576cf046ca2c8a5
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Make get_bcast_qos return the encryption flag

This adds the encryption flag to the response returned by the
get_bcast_qos method.


  Commit: a1bde349db6bdb483f0396d1ba79f9078a3df431
      https://github.com/bluez/bluez/commit/a1bde349db6bdb483f0396d1ba79f9078a3df431
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M gdbus/client.c
    M gdbus/gdbus.h

  Log Message:
  -----------
  gdbus: Add g_dbus_proxy_set_property_dict

This adds a new gdbus function to allow for the setting of a
dictionary-type property (a{sv}). It receives the name of the
property, the name of the first entry to be set from the
dictionary, it's type and value, followed by the second pair of
entry_name, type, value, and so on, marking the end of the
entries with NULL. Additionally, if the type is an array, the
type of the array and it's length must also be proviedd. These
values are passed as a dict entry, to the set method associated
with the property. There, it must be parsed and the appropriate
entry updated.

Example of usage:

g_dbus_proxy_set_property_dict(proxy, "dict_property_name", cb,
user_data, NULL, "entry_1", DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
value_1_len, value_1, "entry_2", DBUS_TYPE_BYTE, value_2, NULL)


  Commit: b48d366458edd180679de6c7b21a49feb4a86b1f
      https://github.com/bluez/bluez/commit/b48d366458edd180679de6c7b21a49feb4a86b1f
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc/media: Make QoS property readwrite

Update the QoS property to allow for write, so that fields such as
BCode can be updated.


  Commit: c922cc4a74e25b672b3e8a055f63e5048e8824b6
      https://github.com/bluez/bluez/commit/c922cc4a74e25b672b3e8a055f63e5048e8824b6
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Add set_bcast_qos method

This adds a set method for the QoS property of bcast transports.
This is needed so that applications like bluetoothctl are able to
modify the QoS (for example, for setting the broadcast code).


  Commit: 8d43c209f084628c0896526174b3061171c9a64b
      https://github.com/bluez/bluez/commit/8d43c209f084628c0896526174b3061171c9a64b
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Enable set qos method for BT_BAP_BCAST_SINK stream

This enables the set qos method, bap_bcast_qos, for the bcast sink
streams as well.


  Commit: 35f2bb95171e595df6ed7495afcf125bc0fee274
      https://github.com/bluez/bluez/commit/35f2bb95171e595df6ed7495afcf125bc0fee274
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Prompt the user to enter the bcode

This adds support for entering the broadcast code on sink side. When
the user selects a transport, if the transport is encrypted, the user
will be prompted to enter the broadcast code before the process of
transport selection can continue.


  Commit: 4ecfdef3b52fbd39a5049baa2321942637c2bc0e
      https://github.com/bluez/bluez/commit/4ecfdef3b52fbd39a5049baa2321942637c2bc0e
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Refresh qos stored in setup before doing BIG sync

When syncing to an encrypted stream, after setting the broadcast
code, the qos values stored in the setup must be refreshed so that
they reflect this change.


Compare: https://github.com/bluez/bluez/compare/e8575b6196ab...4ecfdef3b52f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
