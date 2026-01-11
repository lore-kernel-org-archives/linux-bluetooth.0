Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A513D539
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768166353; cv=none; b=Xvs8iNFZC8gYH6jA/Or4cspU4nUg9KWbAvpHlzFFlY5aJf9m01o9tKWRGZ2PfCfRfe5O4oL2nGVxy3pqIX3cvQivg4hGEDiAmLeOuY+6xOw65mvRHrWQ76P1o4FAzseDQcR2kqIZO+eelDsIoayZfOdWvvUHNgMGnk7CR3A8fk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768166353; c=relaxed/simple;
	bh=ADng7dB9sA42euP4raeoUeuB1OdP/4VEmfJXuJlPLbM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KCpHMLms6+/AYXJ07ohbyiAUW3fbsHq9Sy48dQbs2st6rDFrKDovhV/FYjp7kMXFf21kJ7HIDvN1IkC3530ckMjDeadyABNjTRxM/IBeH2au0jnGv/h+8nDhQH23x4hxiT424vkioyRXRVsru2hkq+hPeCGkpVIAkyczeEsf65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A3/rOVRR; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A3/rOVRR"
Received: from github.com (hubbernetes-node-95c5780.va3-iad.github.net [10.48.168.39])
	by smtp.github.com (Postfix) with ESMTPA id E695E3C1029
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 13:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768166350;
	bh=O0QoDelwCFlg4NlDRxQOCkIasI/1Dr0tP1qCSXeZNIw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A3/rOVRR1Nr7ReuI+ZOjbpfdgOM1FPOX1+ek3Ip4ByKWqXtLnBK1rEAUpwLkdTGk2
	 omQprH2Hz/5v6bLEfgXYe/KEZigw6l24mlFL6kQr0C+RyeuxVycKgsd2QkZ4Bx01PO
	 f9IvO5P0JG/IiMDEFe2LcQ+kRuMnkNJvGY+HI9mY=
Date: Sun, 11 Jan 2026 13:19:10 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032731/e1205d-000000@github.com>
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

  Branch: refs/heads/1032731
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
