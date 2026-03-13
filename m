Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52238F634
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397801; cv=none; b=nutKRNn7WcK5HSl/hgXOZ+NLI2OmPMqh0euami+qeXWANGzTiblY8xZrme2bNPX2XTk/VZhqaIDeOA6EWr0B0Nw+e/bUQYwGziwfRbXBULkLFeXJzyfTqWJ9WjWaM0znBa4Ci5+FXquMnni0X7f9Ivu+YnNBdlYU23MqMwJlfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397801; c=relaxed/simple;
	bh=ipXauSJfUcBEUxseh7ve+ugqWXisS5r69mRaL5hdnkE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=L/zMe+pGoj3wM745N4ewFlZgPyyp698rVy7ERvj4RGh3lAiygLYpeGy5ECna0dEAPJhM7I52lr8gpuzoi35cDugMTeRKLdlRTuPy5Pf9JckPlN3pt/RVQtZ3ifxUwinIMkWXY84XVzNF8suPvVORLwCsvu6zsCjcjWcsFen4Ceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hc3Ld2Nm; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hc3Ld2Nm"
Received: from github.com (hubbernetes-node-b4e50fd.ash1-iad.github.net [10.56.211.40])
	by smtp.github.com (Postfix) with ESMTPA id 16FFB12110E
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773397799;
	bh=OcVOu7dpzUFzhk58TlTuRHAYmQv3UpDZ8h5JI1Ip1Pc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hc3Ld2NmL16zSIFigSpCjw5zvIdac8yCuHLd7yKE5NDw75UofTCHrexhx97DRcYVN
	 0vFbVyk0l4Iud8SpbKn9tSJTLIP81K2RA1lNpgqPaxv/09HDgxcfZv3emLTKrraCsz
	 fEIanVMqM+HQVNUnwZg8SmZmX38Sh1Bl7V5wa+D8=
Date: Fri, 13 Mar 2026 03:29:59 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1066232/000000-13a23d@github.com>
Subject: [bluez/bluez] 13a23d: client: add advertise broadcast-name helper
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

  Branch: refs/heads/1066232
  Home:   https://github.com/bluez/bluez
  Commit: 13a23d98c2731bb180f4612c6c96da4f945eee9a
      https://github.com/bluez/bluez/commit/13a23d98c2731bb180f4612c6c96da4f945eee9a
  Author: raghava447 <raghavendra.rao@collabora.com>
  Date:   2026-03-13 (Fri, 13 Mar 2026)

  Changed paths:
    M client/advertising.c
    M client/advertising.h
    M client/main.c
    M doc/bluetoothctl-advertise.rst

  Log Message:
  -----------
  client: add advertise broadcast-name helper

Add a bluetoothctl advertise helper for staging BLE Audio Broadcast
Name as AD type 0x30 using a plain string.

The helper reuses the existing raw advertising Data field and
registration flow.

The documentation is updated with relevant details.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
