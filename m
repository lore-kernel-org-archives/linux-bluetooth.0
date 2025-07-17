Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BC61EE7D5
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778238; cv=none; b=r8qpe9EfNYdxBkfXtu7rMkmX8D2OlbbjBmN6x47W9mdPJqiIee6ZFgrLSW+gSAJAGIC7Fw/pglceM/sPxweGn8vPw8m2EN9qextqT0qvwLo1i4hxxxfKDi/nu4ZTUChcf7NHeAHvc63QfhjLh7eYcrEcKmUEXwLMtF9DvwTF2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778238; c=relaxed/simple;
	bh=hmB//itj6dzh1EoZ/7L4HS1KDfDv4SoVRUlplMXmX9Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cQCFXTST0nluOigtSpN0arfnOLGivKYiwq8NdwSMJZUX5MTfUplZP7Fj2UHwg57K9YS27Z9lr1/iXbkvREo3B6b/5dMg/FKIdGbqAMbR0YjR7VEzaU2W+dTsBsm9nKzmUToIDuA0f/Wm6lqBbOAj48NIiB0zWduwL9Tt5VubDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mTJ5Q3Ie; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mTJ5Q3Ie"
Received: from github.com (hubbernetes-node-8c9a3e6.va3-iad.github.net [10.48.205.51])
	by smtp.github.com (Postfix) with ESMTPA id 2AE8E4E1137
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jul 2025 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752778235;
	bh=YzmGzNVmxt01XNDTIpQB8SL671UKkssG3c+rdNgpm+4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mTJ5Q3IeCQCsrzFjLBZTlSd5XzgTfVd88TbkStY1Os2lzBi7HwT6BEshbmWpNvUfr
	 4FlV4Pv4BAlQ0CCr4Q5nZlbOLokd8We293tcguahrGvOsCRYrgu9eyA5Lygg68FOYm
	 pOGIRNJWTbG68moPUeOjwKBQ2GNdetXD+pDx0mu4=
Date: Thu, 17 Jul 2025 11:50:35 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4c431e-52de8d@github.com>
Subject: [bluez/bluez] 52de8d: doc: Add initial ISO(7) documentation
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
  Commit: 52de8da1a99cd33b517284f87d231055a0dee6bb
      https://github.com/bluez/bluez/commit/52de8da1a99cd33b517284f87d231055a0dee6bb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-17 (Thu, 17 Jul 2025)

  Changed paths:
    M Makefile.am
    A doc/iso.rst

  Log Message:
  -----------
  doc: Add initial ISO(7) documentation

This adds initial documentation for ISO sockets.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
