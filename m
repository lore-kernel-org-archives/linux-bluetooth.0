Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BFD2FE596
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 22:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765839600; cv=none; b=pt8xjphKh4V0+dqPZOBDv2ltmMQEMylm3UyG5//KADJzCCFvR5e00OeLMdDqgW60JmHcSI7cp6En6k912WJl1SqicNswq2O3WWQp2vMwkLYIRF9LwrTTOLEzPck+FxkIlHyrmHQu6c7vKmrqLdwmWcaTCjxp11dfMxH6T+hoeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765839600; c=relaxed/simple;
	bh=I02jyK/FQKj6ZaJgi9YtCVv5a3UrDVDXpY3sD5DGcbI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RcBF6NnAKlTmWGPvZY+1s1ZvaG34MDgp76bOn8EoUIF75g+/lAKkv1I9lddsDGe2p/Z0zEAvPiGcJeAq9d+XdgUc7E6HHb+vPkUgSOlKFQlCAkSRhtC9/Lktl3sDmM7tEmTOrXhPvQ+SuNVfc3uC/cvYNCgCSpZRmrmAYUFtynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KU/4Vcdo; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KU/4Vcdo"
Received: from github.com (hubbernetes-node-2e927fd.va3-iad.github.net [10.48.209.83])
	by smtp.github.com (Postfix) with ESMTPA id 7BEF74E0B88
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 14:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765839598;
	bh=CW6XNYls8jFi53iVsuJTqkBuvUlcb4yxKT4/sol8W3U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KU/4Vcdo3mMvjBRAesbTkht0NM4qvPE0zaocd7hxxkFxP/VzQT6UXLLLoo8PdGanV
	 DsE7JVyFvFKZ31+wOE7enPDuHYNcVYr8paoj/AAU0wA/xyUcjKxGZnUsiBdhUP294C
	 pFAwzMfjsgObndMSlzAG/JeptEXvvFGYhIDHUmZ8=
Date: Mon, 15 Dec 2025 14:59:58 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023879/245bcb-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1023879
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
