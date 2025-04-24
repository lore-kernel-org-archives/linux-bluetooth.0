Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C327A126
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512210; cv=none; b=dblz8S4JXoaUixc0F6NZrJforPTA6GSvDD48u3Zag0WSpUDRIoiA5IFRSlnVYRP6XCtYZn9vB6u9w/81Hqr426eHzcGZWK3EUenSK+nRMEXcb/LwNZH01LWxdoRkcgZisoVdDOqxcrqk/CFNzNHd8ZYoBGuCMGyFz7MhBpf9LvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512210; c=relaxed/simple;
	bh=h0mDnhrgTo5OEM0utOuNSjGWeUdy2efTTdJHKY1Fc4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HllQ3w7T5e+p5CjnvBM0g77XgfPbvcNz3uP+oC866A0nPY5Cupw4aqcXuM8xYp9mvwNKImcdCASfef5Yc6T8FZoLu0cp/uyAs6AX78sN50xiaXFZjoDU4KFaTv38RKcxFzO90qFOVeNooiYYo7ozkw3pFqtwmCKFrOT4yN9l8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F3PNf44K; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F3PNf44K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745512206;
	bh=h0mDnhrgTo5OEM0utOuNSjGWeUdy2efTTdJHKY1Fc4g=;
	h=From:To:Cc:Subject:Date:From;
	b=F3PNf44Kvd3JWuaf5mbfSKmKsYOYYr1eKao3orRl7OzKAAeURF+fQOnq4b7B9yifj
	 pA/2VxUPH/vgKBLSa7jzbxhRnB5zeEWoZxyQK23puN9f49EjBGdNt12pHqlVFZVQmV
	 trdBOO5SX2WKTDJZMJPVvwtTbzCHqiUSZW7XT8hTFuNYtdfKLkmCRMPO/NYy/SL41t
	 VIwqD6thrk+hIKsBnnd37lxOC48zWFH97OgfBiHKca4EH9lGtYAQJqfF3zM88eUJGI
	 xzW1fLaDBleCBeGUapB0w2EwzVhrjB/D6De3hkczTkit6P41UezNas6MDcTTW9jQZe
	 6ooRtAyW9m8qw==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CF06E17E091E;
	Thu, 24 Apr 2025 18:30:05 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v5 0/6] Support Sixaxis gamepad with classic bonded only
Date: Thu, 24 Apr 2025 18:29:27 +0200
Message-ID: <20250424162933.182103-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new "CablePairing" property to allow us to
indentify devices that have been paired using a custom USB cable
cable method and that don't support the canonical bonding with
encryption. With that information, we can dynamically enforce
encryption to drastically reduce the attack surface, compared to just
disabling the "ClassicBondedOnly" property.

The "CablePairing" property is exposed via D-Bus to allow
clients to potentually show this information to end users.

As far as I can tell, starting the listening input server with
BT_IO_SEC_LOW and then bumping it in `hidp_add_connection()` should not
have any negative effect regarding the overall security. However,
please let me know if it turns out not being the case.

Addresses https://github.com/bluez/bluez/issues/1165

Changes in v2:
 - Start the listening input server with BT_IO_SEC_LOW only if we
   actually have a known sixaxis device

Changes in v3:
  - Change the property from being sixaxis specific to a generic
    "CablePairing"
  - Remove the manual validation of Sixaxis HID report descriptor
    because we already replace it with a pre-dermined SDP record
    in `sixaxis.c`

Changes in v4:
  - Instead of setting the server security level in adapter.c, we
    do it when registering the input devices, during probing

Changes in v5:
  - Fix `get_necessary_sec_level()` comment

Ludovico de Nittis (6):
  src: Add new CablePairing property
  client: Print CablePairing property
  sixaxis: Set CablePairing when pairing a Sixaxis with USB
  adapter: Add btd_adapter_has_cable_pairing_devices()
  input: Automatically use sec level low when using a cable paired
    device
  sixaxis: Set security level when adding a sixaxis device

 client/main.c            |  1 +
 doc/org.bluez.Device.rst |  7 +++++
 plugins/sixaxis.c        |  8 ++++-
 profiles/input/device.c  | 20 +++++++++++--
 profiles/input/manager.c |  3 +-
 profiles/input/server.c  | 63 ++++++++++++++++++++++++++++++++++++++--
 profiles/input/server.h  |  3 +-
 src/adapter.c            | 17 +++++++++++
 src/adapter.h            |  1 +
 src/device.c             | 40 +++++++++++++++++++++++++
 src/device.h             |  2 ++
 11 files changed, 157 insertions(+), 8 deletions(-)

-- 
2.49.0

