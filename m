Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE147D46A
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844476; cv=none; b=FuxwGAO765hJLDSev4wMjo53KNFTYwwGHg7qLcYWImcieoxkYli05Ijub1892mzkVvn02CXHPeeZGSVPzY5L7566G1ouBpSPG1XZWxhf4f+fJu+hpJDUQAvmFO5vNrKY6zSfuoJkq1B6x5mEvNYqxTOKaaGYdShy1qV96mG1qDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844476; c=relaxed/simple;
	bh=XqYyIBazJhDlwkN4gAPpDC9ANKxC0ohanTS+J5Ic54M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LDGa7TNMwFK/Nd8RCRms2aCTLHO4tivoAdotyCfOuUHvZE9mg25pE0+90+zFxoG+DpTCf3nP85TmlyQUF0jzlDS9kK98RF8643kTr++76tFuDXQxShs/OW525DnbQ9UMDBsvVgi0ZkgSxdRXn+zXAxW0HaOOc8c79vgdEKpYqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DlJxiZ+X; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DlJxiZ+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787844474;
	bh=akbtzFM7sWZry29XuuJDX6TqBVeVMYfkZBvbJq2ZQac=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DlJxiZ+XAa7Tdx2Hr6BXmc/tMCNmCKeqymnrSup/1ZFdH9WUmrtVIAtTIBWTlB6wa
	 yx6i3FDqKqGkpOjS5vhifpapGsnBgK5MbJUkPRvsT4Ae9Ycv5KPwc/G8CxXz2r04nb
	 B2KIaM9ivyvxwL8CmiOQwpE3JromJD+RiilRAJgM=
Received: from github.com (hubbernetes-node-2d47f23.ash1-iad.github.net [10.56.14.60])
	by smtp.github.com (Postfix) with ESMTPA id 883B5841678
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:27:54 -0700 (PDT)
Date: Thu, 27 Aug 2026 08:27:54 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152689/000000-fb092a@github.com>
Subject: [bluez/bluez] fb092a: all: Fix typo in AVRCP_ATTRIBUTE_ILEGAL
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

  Branch: refs/heads/1152689
  Home:   https://github.com/bluez/bluez
  Commit: fb092a10de2721f369777cb3e70aaf11c4632f8c
      https://github.com/bluez/bluez/commit/fb092a10de2721f369777cb3e70aaf11c4632f8c
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M monitor/avctp.c
    M profiles/audio/avrcp.c
    M profiles/audio/avrcp.h
    M tools/parser/avrcp.c
    M unit/avrcp-lib.c
    M unit/avrcp-lib.h

  Log Message:
  -----------
  all: Fix typo in AVRCP_ATTRIBUTE_ILEGAL

It's "illegal" not "ilegal".



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
