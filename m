Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6AD1F09A5
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785010754; cv=none; b=oHAT20bKc4/zcgR615F2vdG7GlxhQ3plHQ6TWJxI+GZquqh8Ru4+AxBpV4epiWYfCdrErQ+CGCpj0HGVxJFdcZI2xTW9viTywMmjHh3WDamtG32qXeUxsA6l300d4sY2W36uz9mh1oO1pKJIhiP8ui34X18qly6iPfNTh2jz6WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785010754; c=relaxed/simple;
	bh=FCKr3O1M92d0XKzchW45RbOi+TM3lSwFF5rGX/wT/Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POE5fu6deraE/3GcSNiJ4mG3pSOKOl3gL2uq6GDEB8H6dRGWhX5CIrJqpdbte1pR8IbELKMRe9On+T2Ht/PLxP/xoaIJqFulMWJ0JmssNXrDW/czFdGxOcAkiTuem2vPZG8GAoW4Eozktx3F3LwHs6nhkfJ+rQAhjClNRGGDZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bWIJ6HpU; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bWIJ6HpU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785010749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5rCDKU1ObVu8yXaHAICarX4ybOABA3BElr5Oehi+vA4=;
	b=bWIJ6HpUbpaC6jqSg02wl4ujjQTKOYt8eh+AQz/LSHcejVSwvEAQ8L0y7tXnD1S5Zn59D7
	RufwdE0f8FSvmvrzq6VXdU2rSQosNsRy8JKQ9GlVkCwmqozU8WqJRhZtbzG1Le0l78jGYL
	wJDWrD0FHT5TlFeQfn40WaGmShlhnho=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH BlueZ 0/3] Hide WakeAllowed when the adapter cannot wake the host
Date: Sat, 25 Jul 2026 13:18:53 -0700
Message-ID: <20260725201856.2142333-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The WakeAllowed property is currently exposed on any device whose
profile supports wake configuration (HID/HoG), regardless of whether
the host controller is configured to wake the system. Clients may decide
whether to offer a "wake the system by this device" toggle based on the
presence of this property, and end up offering it on hardware where it
won't work.

This series gates the property's existence on the adapter's current
wakeup configuration, read from the power/wakeup attribute of the
closest USB ancestor in sysfs. That is the same attribute btusb
consults through device_may_wakeup() on the underlying USB device,
and hci_suspend_sync() skips wakeup configuration entirely when that
callback returns false. Only the USB case is handled, so controllers
on other buses keep the current behavior.

Matthew Schwartz (3):
  adapter: Add btd_adapter_may_wake()
  device: Hide WakeAllowed when adapter cannot wake
  doc: Mark WakeAllowed as optional

 doc/org.bluez.Device.rst |  7 ++--
 src/adapter.c            | 70 ++++++++++++++++++++++++++++++++++++++++
 src/adapter.h            |  1 +
 src/device.c             |  5 ++-
 4 files changed, 80 insertions(+), 3 deletions(-)

-- 
2.55.0

