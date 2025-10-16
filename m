Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218423EA83
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647277; cv=none; b=f1WST4QbR2vCEl4JBEibPB3Q+yG4MWW6TCbJDbgqfq+bIaUqFFmOXIEC3JDcbLCuX9yzDPXtRAECWiL0bE0iEKPYw6K/04QnQIKT+Quvj0/BHuhLqRkms6S3z5QppUfjPWu9pFe1ztB+cJaWPtCt10e4jfC/TV1ws+oDelAozhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647277; c=relaxed/simple;
	bh=Hg05rg/2+Z0T8BDQM4mCZaAEMmIwgC5VpQ8wcvNAqRI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mvpcAfsHHlsFM4VjWXo4H4rdwKcWNYxUhvEabssrnOyIK/SFypgGpco+o3FtdQm+trLUJ4oTB14saubEhE1jLd31ORAc9U4fsSpyUk72SfUp+FBj8ofQ1AqVcg9GEIwgXPrtxlTi6kXpRJAORD2eMdKkR1G9099HUUapHdRBcgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Xkz7IEX/; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Xkz7IEX/"
Received: from github.com (hubbernetes-node-0e5c959.ac4-iad.github.net [10.52.139.30])
	by smtp.github.com (Postfix) with ESMTPA id 574A9211C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 13:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760647275;
	bh=Agsws6e+9HVxTV6eoSQzBDnTFLkCVhyu2f/W3BHPMn8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Xkz7IEX/X1U9M7zkTpoPxqe/hIHvx7HSR8BC5mAZ0OBjPxaNfmVrW8N8FM+KYsK2Z
	 6YeWYe279kPSo3Ks6C+Xjh+ex+ko3T1ZZTs/B5SAiQDWTXM8phl4akRTKmxB00Gp+i
	 qoMvwAAued5fSDNdfJgZYu4a2BIXDDG+epQTieAU=
Date: Thu, 16 Oct 2025 13:41:15 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/025d2e-8d181e@github.com>
Subject: [bluez/bluez] 8d181e: mgmt-tester: Fix handle value
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 8d181e4e4a06996bc9550cf5dee250f57fe36f5f
      https://github.com/bluez/bluez/commit/8d181e4e4a06996bc9550cf5dee250f57fe36f5f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-15 (Wed, 15 Oct 2025)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix handle value

Recent changes to emulator has changed the ACL handles to start at
handle 0x0001 in order to use dedicated ranges for different link
types.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
