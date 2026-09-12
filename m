Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4E43B3C10
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237116; cv=pass; b=E6Z0RQr96IVZlyW6lojoY07Hfa3q33nMbG9sPfP/hPp6fsRFv3L4LUzKE2cX8MxMExqS1s66v9Qzh5+AUDvzseAcF9Y1N6FSlUMMM4vfDZIdzbA5UPTWWrTZULu3GNMnyK/JXK+xGF582Flguw+SKzE/Lg0KCGTgZ+fwaApRDyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237116; c=relaxed/simple;
	bh=CoZExRWEXWkkVmLehVtkq7c0UiyiDaz0dxeC/mjIwzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aaWk94UZINvon5lzoiMme3RlBoGDxP4a2OqAE+l/ci4HVBZWBY699qBQNKAyI9Ckwb+BOjDsdTZ83YOztkzAY0kT3dB3dVNN3boh+xUuUhO4EP3wSw2aHBpoa7UANgQE1UdaVBD/hRtX9nNkOB9NwG5N5yVg+xx9Jbg1u3oM3Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ss8TlYJ5; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ss8TlYJ5"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:5:f011:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hj05t3nw8zyNV;
	Sat, 12 Sep 2026 21:18:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789237106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cpvn7A0Q2QZvtyYaU7diE3RN/5HCM0v8MhJvKEl8+80=;
	b=Ss8TlYJ5+Lna/3M4Pab/Zl2JeOndi/d7AZI6KqWvyx6/wU6yBni8+hEXLICSQh4ezE+G3y
	w25PKe0rB4vwC9eulbUvjz+dOu6uU0MHt65TxH8uMFzj5ANP2262hgI6qlCqq/S4AaUare
	SF4TKYgOoWrdZFNFocpcqDtEhzMBXJY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789237106;
	b=kmql2vNnmhaAGzDEe3O2fzcHoZ2KtIt6Y8kqbXSNeHO3f8wi+aSk0BXtxhX5Ov2k8NgJFa
	iyOW1l18xF9CuTTw7O0oOQmsK/XxWHJ2ym9fkdvzC4GL5dZI0drqzbsLfz96ijNUETbasX
	/+7mYhNip9ryhYUIM2OcqBe3Dl31R7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789237106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cpvn7A0Q2QZvtyYaU7diE3RN/5HCM0v8MhJvKEl8+80=;
	b=WbutAwKw6FlZHYIeqvDo+F+pkrBwNmM+Y3z1VaZUjGxDOfvrykj06pNIBXT3Dci8QHaWLv
	vhZxWn6JZ4M+t4o2Gx3G70qp7jo9KkL/8pbZH6jLrc4RKoKMk9XLBsPX1LG4kq53q8c/aG
	YhwRt9ugSQGhq8sUOFHunOdZMEGQTGQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 0/4] test-runner: use virtio-fs by default, functional test speedup
Date: Sat, 12 Sep 2026 21:18:19 +0300
Message-ID: <cover.1789237077.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- refactor start_qemu() argv building
- split out rootfs setup to separate functions
- fix bug in check_virtualization() that causes problems here

***

Use virtio-fs instead of 9p, which gives 3x reduction in CPU time for
functional tests:

Before:
$ time make check-functional
real	1m56,857s
user	8m37,727s
sys	2m21,655s

After:
$ time make check-functional
real	1m4,714s
user	2m52,831s
sys	0m37,379s

Wall clock improvement becomes more significant under CPU load.

Requires /usr/libexec/virtiofsd installed, and CONFIG_VIRTIO_FS=y in
kernel. Enable that option in tester configs.

If virtiofsd is not available, fall back to 9p as before.

Pauli Virtanen (4):
  tools/test-runner: replace alloca() based argv setup
  doc: enable virtio-fs in tester kernel configs
  tools/test-runner: use virtiofsd for filesystem passthrough
  tools/test-runner: Fix CPUID register clobbers

 doc/ci.config       |   2 +
 doc/test-runner.rst |  10 +-
 doc/tester.config   |   2 +
 tools/test-runner.c | 414 +++++++++++++++++++++++++++++++++++---------
 4 files changed, 346 insertions(+), 82 deletions(-)

-- 
2.55.0

