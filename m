Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50833985A
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776524035; cv=none; b=h5P822Ir8ffNIjMoVzJAi3DMFH/SgOFwc8UCRyRo8+GWXr537xUlABkKLVxW39jPpdYJgrSfxnmPZchb/HK/RnajvhGQqk/ZLUJHU/rTJvcAXoLDsnlj07FPg10k7u69eJQu5PsCvLS7DaBYdZo0vKuMdyitD3B113e88sqHrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776524035; c=relaxed/simple;
	bh=CDSKsRxZFLZ5maJPEySNgbNByYVGkn0sCOTww/kbLPQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eZzuCTA9TyXeP0EK2Z3H4gY664QeQJbo0I8rj8cJtDAZKf7doYwuoUrvFlBeTF0R2W4NB0U42NK/z6Ohw6yMzV4KsyyABfjVXbB223GGLVAAQ3Fehtt49qR5Zni/zpUK9JGNkjCg5c6yaAJYmJAuukn8bhjvZmbJuc8uXJ1xXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JZMFgR1o; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JZMFgR1o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776524033;
	bh=rx196qn4b3uMyGltZgnrYRM7T/asoYEpz1VcA8X9vUo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JZMFgR1oCfD250Eau4OLWI9h6boQGR3oBtc1G8lC/iP15x4W/jfRD86mkdhKEUh4X
	 K4ruyQyG7/0kg+SxQGk2yM6ub8Su6TUKbKJYKaAqYwcGr3VtOMlrxUMfUPDwepAkH8
	 x8+2yjkbyDM3R/KXzBBPmvU19xbFBp2sIsndVwMI=
Received: from github.com (hubbernetes-node-e6c0ae5.va3-iad.github.net [10.48.180.50])
	by smtp.github.com (Postfix) with ESMTPA id 7D1D780108D
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 07:53:53 -0700 (PDT)
Date: Sat, 18 Apr 2026 07:53:53 -0700
From: Bobberino <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082799/000000-0e78f7@github.com>
Subject: [bluez/bluez] 0e78f7: adapter: add DisableDiscoveryOnConnect option
 for ...
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

  Branch: refs/heads/1082799
  Home:   https://github.com/bluez/bluez
  Commit: 0e78f7b650be5bc91ed43d289caf346bd0e8b85f
      https://github.com/bluez/bluez/commit/0e78f7b650be5bc91ed43d289caf346bd0e8b85f
  Author: StefanCondorache <condorachest@gmail.com>
  Date:   2026-04-18 (Sat, 18 Apr 2026)

  Changed paths:
    M src/adapter.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  adapter: add DisableDiscoveryOnConnect option for combo chip coexistence

On systems with combo chips (shared Wi-Fi/Bluetooth antenna), background
LE scanning for auto-connect devices competes with active connections,
causing audio stuttering and Wi-Fi packet loss due to antenna
multiplexing via Packet Traffic Arbitration (PTA).

Add a DisableDiscoveryOnConnect boolean option to the [General] section
of main.conf. When enabled and an active connection exists, the option
suppresses adding devices to the kernel auto-connect list in
adapter_auto_connect_add() on kernels supporting KERNEL_CONN_CONTROL,
and gates trigger_passive_scanning() on older kernels.

The option defaults to false to preserve existing behavior.

Signed-off-by: StefanCondorache <condorachest@gmail.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
