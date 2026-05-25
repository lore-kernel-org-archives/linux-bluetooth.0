Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443CE34E746
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704338; cv=none; b=d2F5HzikAuZXl9QarABQXnIcrNUDHLqjD/GFwQr/KCz9YWLVETuHqo4m8BDIQGpYZmw+wnskhMQU6zSS5HMELKqYRcGmrDR0GCgU96SlzNDk6ZZijDLpWocwH+iqvfR5VhPuL+IwBIxcLyMdVpLZ6r2XXeJoSv33B7qyfplQmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704338; c=relaxed/simple;
	bh=ZM3UZrBeWBSbV2rlrlUD+5sl9CGzzgadEmT1zo1GwKM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=L3PERuxTrOMXYjaW1APfOS/VE33vuZfigwuldhy5DtjQmzNnzZWUBmU3saum1yZmjcYVbG4HpAXIOp1kB4yMSoqrZsaIEbEry21w+aTjFUGur4sYcnk3BcL5po2lqz15QVkyMa+kCngjVeMNR6am/oo92TLI17CG0UtVsK9GRa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k0EfSCgm; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k0EfSCgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779704335;
	bh=qnDq7UyLibfB6KX3OCcsa11xNRz3YCK0+c9iprSHwAg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k0EfSCgmhUWHmzigMquDvjBBBa5IYQdcZ3ZRZ99+sWLMNXzaNVBpI+RnCq4dWnWHG
	 ylee0jae5Ib2Zyybrxddthyr8884q04qrA0gvjDgp9VuSjtTvWVSoApvWIrRLRxTJ1
	 IhYHQKyPC0LptAcDZTJlnCnY1ZZ01Rxw/B+JvGb8=
Received: from github.com (hubbernetes-node-a1d53a7.va3-iad.github.net [10.48.168.28])
	by smtp.github.com (Postfix) with ESMTPA id 0AA9B80101B
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 03:18:55 -0700 (PDT)
Date: Mon, 25 May 2026 03:18:55 -0700
From: Tarjei <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1100262/000000-dc3162@github.com>
Subject: [bluez/bluez] dc3162: adapter: Add configurable default LE PHYs
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

  Branch: refs/heads/1100262
  Home:   https://github.com/bluez/bluez
  Commit: dc316288b2356b3b2285ef20851b4aa4a112764f
      https://github.com/bluez/bluez/commit/dc316288b2356b3b2285ef20851b4=
aa4a112764f
  Author: Tarjei Bitust=C3=B8yl <tarjeib@gmail.com>
  Date:   2026-05-25 (Mon, 25 May 2026)

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

v2:
- Check MGMT_SETTING_PHY_CONFIGURATION before sending PHY
  configuration commands.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
