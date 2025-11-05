Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0923009CA
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340258; cv=none; b=Z7qgVOhkfLlJnEviTHXFF5SmhINeDzLKB/Y4/r/OUqCFYOl+/fpjazFqZE1X2ipPZbCGkL4VD1MFfTHKniB8+VNntnpampRLnYJjRoJ8D/yb3ZetzHLCV/KBV6Sib3ok1aM7BLWJw9RSJjhSH5r8ASrlSZjaXynP5fDXnQEEm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340258; c=relaxed/simple;
	bh=0n1V9c+ocAvRf48cNaWM+5VtTNxyOsHHBF+DPJPLlmQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ftZPz69Hq5/n8XEx3bwij84lq8KsblA2msbJOu3lW4ScglTiQdNZ+392Nxr3y6AxFL7caEaRSu9uhi2gw0/qtt3cJtlFP1eFh/LohbeQzye020i/63uyfWmgQrCKV9+49rU3xBxvFgs0wixkevOlEbQndmrAJhFZjhOwzf3ha0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QV7jbxpe; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QV7jbxpe"
Received: from github.com (unknown [10.55.89.31])
	by smtp.github.com (Postfix) with ESMTPA id D1F59640352
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 02:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762340255;
	bh=OfipEshxZXEHUH1Dh0Vo1X99wnRaKnqL2Lq6+vm4mQk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QV7jbxpezL7dkhFCD3IcZSgakkL3IjxVerRtw04dZYN3AhxjO1ifZ0kfJTV75JFWW
	 31deuRMqj1g5q9DAJf0dTLugB5gOLCCa6vxUDkgCJouDSphJRMHEcmfIhQhwAVQF2m
	 QcO2rw1xMl8SOKBbqazQuu2w69i1/doHbD/7oAeY=
Date: Wed, 05 Nov 2025 02:57:35 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1018486/f507f6-000000@github.com>
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

  Branch: refs/heads/1018486
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
