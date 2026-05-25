Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A88384242
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716657; cv=none; b=NVAheJap7Z3s2AqIRCNk6PdS7K6jbuiNTw/jZB6GIujb9YHRRIigGbFf13f7Wc+bw/k0R9Qq1w3q4EJYoIGUK6AgzZEDiasGVSY8K4pOWh5EC5c0TbMdtjidEuf0mbkGystd3lAkNn04weXdQqmWrN7ZM19Bcwr0nCsT8v1bB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716657; c=relaxed/simple;
	bh=Lskot5QOBlQWjdANp6gfMLJbgsbttLZR8SgegxN43ig=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hOopijJN10i8XY5lgzYO/HZZd5eCunwZoSdgyImKMUnaS84OxjM422CWqO8OiybtAUKMNmq1CgcXZxQZJFR+nnCBK6168hF35AyNBFQ05z/QV+qI3rPJ6bqGs0UmRLpyN+sFLmw2pa3sm4PF+FwK7ALVQ3uxleBupg+X9jI75f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UQawmleA; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UQawmleA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779716655;
	bh=GvQaHOpKSyTKTK4898YJTxFStH+Jm6Ra0dyo/VUTs9k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UQawmleAGkeOui6waLvja4mgNffsAvXSSG+OdOnsFSiRQuZRWcg/uGx89444AZWrS
	 ZwxLKkORN0YmKvGtzcXDx2ujihcC+b97YCocTNJRXgxBtwjMiGfqffwVOTMsejIBKc
	 O/VSCUoAP3KQDpPqNjOfwWcqlgNJlDxNd6SPWW/k=
Received: from github.com (hubbernetes-node-4cc2aaf.va3-iad.github.net [10.48.207.107])
	by smtp.github.com (Postfix) with ESMTPA id 750338011BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 06:44:15 -0700 (PDT)
Date: Mon, 25 May 2026 06:44:15 -0700
From: Tarjei <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1100433/000000-360693@github.com>
Subject: [bluez/bluez] 360693: adapter: Add configurable default LE PHYs
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

  Branch: refs/heads/1100433
  Home:   https://github.com/bluez/bluez
  Commit: 360693d705ade0b49c1b21b4ad9b93dc3624d01a
      https://github.com/bluez/bluez/commit/360693d705ade0b49c1b21b4ad9b9=
3dc3624d01a
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

v3:
- Match the queue header include spelling in main.c with device.h to
	avoid the Sparse redefinition warning seen in CI.

v2:
- Check MGMT_SETTING_PHY_CONFIGURATION before sending PHY
	configuration commands.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
