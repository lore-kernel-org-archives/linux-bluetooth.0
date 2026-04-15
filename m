Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174831E82B
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240216; cv=none; b=MH2Mp/LkqjK76VrCdlTzndRT2l+ongqIKYLQsp1104KKyh3KsKwpdWi+z7buISYv45T1kwwihJV9GbSztgzy+jFoFsduhVCNpO5p8Uv/aWvKbQg4Vu99RtTDTTBbRC3XLeBCPJLux5O3HaNy1fpMFrpFcQhmRYogPMODLccwgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240216; c=relaxed/simple;
	bh=opjEHSLC+y4PUtYYvxGMkhXzEqgl7VZyxlDKJ0GoKcU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=teVMN09S09WlEI9duL4wxyLKNGbB2tzNIQIh6Ti6c7JIO5U003qyxgUVdP6pZBjzq/YmhdELZJNJPpPLLnCL1LnieC3e6AvbUTQI7lnEewNoniIZnnU92wkiW3AYFdFiZHEIhJqYMW6HxPvFLq7qFaMJrEV/Tce3T9OUhy8ebMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ftw4B9G0; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ftw4B9G0"
Received: from github.com (hubbernetes-node-de24387.ash1-iad.github.net [10.59.89.32])
	by smtp.github.com (Postfix) with ESMTPA id DF3CB140183
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 01:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776240214;
	bh=YgfS9fRfOC2Y3T7RfJApe0+FTKQhgu8UZrhjDvjWqC0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ftw4B9G0VtKJXsNzPk+lPDuXBB9wECraHm7GtHT8FaOuQoGJeAme3bP7Wa1TTgDDB
	 XGZcANfTcLRQb72ykjgSWGpXUmgtC17t3UqSzZHtGGrWI6DCTkpGQnEAhjrxP7n/wk
	 ulr0AWYmQ35MtAdpejnpIXJrkjNhmddjhZIT06NM=
Date: Wed, 15 Apr 2026 01:03:34 -0700
From: apusaka <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081435/000000-f10e74@github.com>
Subject: [bluez/bluez] f10e74: monitor: Add decoding for Microsoft defined
 event
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

  Branch: refs/heads/1081435
  Home:   https://github.com/bluez/bluez
  Commit: f10e7485e0f18571e9f12c05328bb75341e805e4
      https://github.com/bluez/bluez/commit/f10e7485e0f18571e9f12c05328bb75341e805e4
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2026-04-15 (Wed, 15 Apr 2026)

  Changed paths:
    M monitor/msft.c
    M monitor/msft.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding for Microsoft defined event

This adds decoders to MSFT LE monitor device event



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
