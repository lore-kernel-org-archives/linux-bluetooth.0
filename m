Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC8A921
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980526; cv=none; b=PxxY6RXkew5OW5u5TxR6CFXKyckfP2c810c+ns1pySPv6oT1iWZKY2R1WhmzOIlIcdiYiPXR0uLJjda+wu98f2/9O0y5g08cGoieisflawPGeLxC4a1oJVEOivel/kdKi+jYbHe7HzBnbgavVuO2Ny3brzSVjR0es+O5DmhM9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980526; c=relaxed/simple;
	bh=RnAwunyrq5i/pAYWj7O8eKFSSYYucKXMcwnr6j1MXHM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=S/tKdOn6e+Wtx2LLw8AtZ8VukXqD9NY6/9s3bfjyTwWgoBWJLYpsRGiTqfJDZ18bG65VSfF3eQuwbappYn9NgjzZFf4cRcuxjGKW5Au9C/jBSXpp+m2bgrnJ3LdcvsQutH7uqeyZkMV9xJooCXLeB9M4W/aaVGcZNEHXaOeacE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XVOzrOmh; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XVOzrOmh"
Received: from github.com (hubbernetes-node-5c03966.ac4-iad.github.net [10.52.184.32])
	by smtp.github.com (Postfix) with ESMTPA id 2BD5A700817
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753980524;
	bh=awhRoum5pfQELBwFcRh0vVIfECN9itMNFAJOO0888XE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XVOzrOmhGOTS1yFMIg33Qarh4X3dXZWbPX1o9g1M8USS7gY4ElcNj9Eh3UqA6TE5W
	 DfLd/llsLVt2ggCSqfnjZg/ktLyBUQMo5iQwtLxjOwroqjJBtqqsCZAJiOv8Il0iTp
	 izB5ZjZ1SamKqJRiV3xCVdsIkvKdInJU2+ckBgHQ=
Date: Thu, 31 Jul 2025 09:48:44 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/987426/000000-956da7@github.com>
Subject: [bluez/bluez] 956da7: shared/asha: Do not start ASHA in case of CoC
 conn...
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

  Branch: refs/heads/987426
  Home:   https://github.com/bluez/bluez
  Commit: 956da72565db0bf4142ab6438173550d606cd1b9
      https://github.com/bluez/bluez/commit/956da72565db0bf4142ab6438173550d606cd1b9
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-07-31 (Thu, 31 Jul 2025)

  Changed paths:
    M profiles/audio/asha.c

  Log Message:
  -----------
  shared/asha: Do not start ASHA in case of CoC connection failure



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
