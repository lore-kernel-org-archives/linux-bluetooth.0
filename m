Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0222F1A
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Dd7zaoP/"
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC3F18B
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 10:38:52 -0800 (PST)
Received: from github.com (hubbernetes-node-33da3b9.ac4-iad.github.net [10.52.205.38])
	by smtp.github.com (Postfix) with ESMTPA id 9ECAF700DDE
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 10:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1699900731;
	bh=hw3KDgJdSTFtuhAxxbgCek3cCoE2kuG3dHmtaqEnRv4=;
	h=Date:From:To:Subject:From;
	b=Dd7zaoP/fUoSPFmsil6CzsKlXTqa8sdXB49IgWyRoqQ1WmrjcF4w6ZdU3yWMmeIOm
	 h6lS3DCNWqjE9CHPeQFM4nGiM1eJj20FSx5YbqlZYp1x/03brEqkhng+blcsHFbYTU
	 YnN+Skemqpty5CNvpT8IjGpi13ubXmu2UgWQoIv4=
Date: Mon, 13 Nov 2023 10:38:51 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/00fdb6-303925@github.com>
Subject: [bluez/bluez] 303925: shared/shell: Fix --init-script commandline
 option
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
  Commit: 303925b28110469ad002ac19ce0eb9c84d6aceb2
      https://github.com/bluez/bluez/commit/303925b28110469ad002ac19ce0eb9c84d6aceb2
  Author: Juerg Haefliger <juerg.haefliger@canonical.com>
  Date:   2023-11-13 (Mon, 13 Nov 2023)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix --init-script commandline option

The newly added option -i/--init-script introduced a short option
namespace collision with btmgmt's --index, both of which use '-i'.

As a result, a provided --index is treated as a file name:

$ sudo btmgmt --index 0 info
Unable to open 0: No such file or directory (2)

Fix this by using '-s' for --init-script.

Fixes: https://github.com/bluez/bluez/issues/639


