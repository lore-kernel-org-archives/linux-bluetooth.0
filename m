Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF377487BE
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779661892; cv=none; b=AdfQsYVhLrU/ax+EbZRlsMKKyZLeCvjzhBn1fChZM+XuNzliS9l/1Izc9SyZ7WPtzNxzCG3DhsuYqBJ63NOq/sNCeeK3/6LiKwhR+R5i2Z0h/25EhD7QfOfh0O0/FcV8RHqFghlNsCd/9d583bGds2tKQ0lLT+EDHEaNfcJdIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779661892; c=relaxed/simple;
	bh=MSaQ8Dg0UInhsF7hSOpDctgDRbN/3Qw5OvdgliLljdQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FRGB4Fo4ch2rs6zR3EwZeiaR/HCJvoCZx1YmK/guJpKgEObP/jdkaBHsHnzlvrVZGYqlyWXw1TCNqBghP+Ahg5yJETV0hVUohOiaHEoaRW+J21U5ksIHQK7UdMGCusRe+YLTD9vvviPqqECgYFLIhG8L0sI04kaWQouRxQgbApY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J45vwlpX; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J45vwlpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779661890;
	bh=5+CpBPoZA6HlzSWPHxTpsNPZxW73q8hrPePE6F+NlC0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J45vwlpXamIfMob9ATY8lqhVqwqMItiQyZH04wOYZ4Jv5Bd5xdUCcqKgXp2RFxB9F
	 EJON7pDukREc1UnXX6rRcNsR8E7/tu2MUeyiPnL3Oyq7ScFdTL0GGW7MpJe08lRMqz
	 0QZVsFyt7y/nMzumu3FcVWV0qpSlOzTfrR1bIlcE=
Received: from github.com (hubbernetes-node-fa01fd4.ash1-iad.github.net [10.56.162.47])
	by smtp.github.com (Postfix) with ESMTPA id EF9D6361059
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 15:31:30 -0700 (PDT)
Date: Sun, 24 May 2026 15:31:30 -0700
From: Tarjei <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1100107/000000-4655bf@github.com>
Subject: [bluez/bluez] 4655bf: adapter: Add configurable default LE PHYs
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

  Branch: refs/heads/1100107
  Home:   https://github.com/bluez/bluez
  Commit: 4655bfc06e6f8ee87adbd613d99b4f2ea018a75e
      https://github.com/bluez/bluez/commit/4655bfc06e6f8ee87adbd613d99b4=
f2ea018a75e
  Author: Tarjei Bitust=C3=B8yl <tarjeib@gmail.com>
  Date:   2026-05-24 (Sun, 24 May 2026)

  Changed paths:
    M src/adapter.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  adapter: Add configurable default LE PHYs

Some controllers mis-handle LE procedures on specific PHYs with
certain peers. On an Intel AX210-class controller, connecting to a
Frostbay BLE device can fail during early ATT/GATT setup unless the
adapter is limited to LE 1M TX/RX.

Add an opt-in [LE] DefaultPHYs setting to bluetoothd and apply it at
adapter startup using MGMT_OP_GET/SET_PHY_CONFIGURATION while
preserving non-configurable PHY bits.

This provides a generic, adapter-wide workaround for controller-
specific LE PHY interoperability problems affecting scanning and
connection establishment, without adding device-specific quirks.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
