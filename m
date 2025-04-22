Received: from o6.sgmail.github.com (o6.sgmail.github.com [192.254.113.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7526D4C3
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.113.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358789; cv=none; b=WVqOwszpWVyMpuOKk+Nky6cos5AdaIr/EmtvG++dRsZJ71lBHDbguTRN9xxPv+NQUs7kXLCL6Ed9kl1g/sDNpWhZvvtAoJ6R8ruaicS9UZ7ka46qwyT4RzdZzA2loybpMxL8n+zgC2zUH/QeeeHKBWof10YqsII0cc4CLqFfxo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358789; c=relaxed/simple;
	bh=hM9W8DDhbTGGv/LyXe6vNmOkSXePIFqcoe5Cbo8Sr7s=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=E3jcCzfC2z1GABOFosIqwV4v42txTts+/RbjgnRVg8QaaDV0MwxhKFScAFxkV+W4Hf8LiRwk183TMZ+41leSkfZKMxAEvVNohaiD/W4LZeu+MWvD+hXNsJiNg6sOaitmV/PyRYbrm28TXkxEgqbcH2sNRg8g9oLtPvJh6XVP+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=vESGddav; arc=none smtp.client-ip=192.254.113.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="vESGddav"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:from:subject:to;
	s=smtpapi; bh=hyjsXnfwP9YwLLXrHOKp9n++GJQ/8iTmzcsBo/woG2Y=;
	b=vESGddav+0DEWlz8GNv1eDcBWu7ObSBx6Mo1QXoqXEau8WEWqWVDeaILY4PvDBL4NeOQ
	CuoKLS05k2w9UFHIAF7rsGqROb6yKvkCAgWkaMNsUEAx4rgWl2bIQgNmWwjqkk59a95Ekc
	Fhf0msDWioBNihGzNJqeSNv3yHdfX8S8M=
Received: by recvd-d9d8c758f-7tj27 with SMTP id recvd-d9d8c758f-7tj27-1-68080FC2-48
	2025-04-22 21:53:06.993676495 +0000 UTC m=+1208673.511893528
Received: from out-22.smtp.github.com (unknown)
	by geopod-ismtpd-3 (SG)
	with ESMTP id qEXnM_Y1RQuXZGKD-3IW2g
	for <linux-bluetooth@vger.kernel.org>;
	Tue, 22 Apr 2025 21:53:06.970 +0000 (UTC)
Received: from github.com (hubbernetes-node-b6181c9.ac4-iad.github.net [10.52.211.40])
	by smtp.github.com (Postfix) with ESMTPA id 540D02104F
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 14:53:00 -0700 (PDT)
Date: Tue, 22 Apr 2025 21:53:07 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/3616d5-46e6a3@github.com>
Subject: [bluez/bluez] 46e6a3: workflows: Add sync action
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2E8ki=2FFbqwlQO04QBiriT34f6qhM6wd38+BQvADylPPTIQmeZqt0Mdj+E9P?=
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIAn9cYYyitBNt?=
 =?us-ascii?Q?msFIegYgDthqIfnrIlAN1UiXvCJQl5Epjf5NJ9e?=
 =?us-ascii?Q?Rwf+Ko5E59Ec=2FWeYugeEPxun76H1Nzvagaphiv2?=
 =?us-ascii?Q?JmhTxleOybR8zcDje9Ny0I0D01HBL9DuMI2CW1E?=
 =?us-ascii?Q?B44XDVbEHn+mYoZAYZ94qLWx6f80wF8XXejDiAD?=
 =?us-ascii?Q?MIQWEDhoe4dJBfgdZQvXJm4x7g=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 46e6a3856dbda48096a3510e16e977c12b93bae7
      https://github.com/bluez/bluez/commit/46e6a3856dbda48096a3510e16e977c12b93bae7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-22 (Tue, 22 Apr 2025)

  Changed paths:
    A .github/workflows/sync.yml

  Log Message:
  -----------
  workflows: Add sync action

This adds sync action which was part of https://github.com/bluez/actions/
but it gets disabled every 60 days due to inactivity, in addition to
syncing with upstream repositories it also syncs with patchwork which
created the PR and then triggers ci action to do the testing.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
