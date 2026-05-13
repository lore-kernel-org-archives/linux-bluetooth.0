Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D538E11A
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693314; cv=none; b=CRESBG71FBhpkvwge6qhCS1TnnIaxpc50ONWkly5cIF3Jci5i0yYRQ3mwqHVFLU1lSmH8Lmdg0leMfWLWdOgbcN2OAQk8s+VS7xG1GCFyd22eATJhkVijnPBzPfscziBpGAwAuiuirWL4UQMIWzj1nYubphbaOmMMicpqip88bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693314; c=relaxed/simple;
	bh=lDIWj0wctBRS1lhJkcxgpSonstTWnylFJZuyiRkGPAY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JPliQQRWghNkLEdmhZSWsC8KLgmZ7fIYz34XSeL6AMVv+YQzB15/yGhV9ftlsEgpZF6hiIjBdQAFIuKugw/E4cP4L1wLPPGlAwtrbuV7tW69asrOpQcdxNne9h49KT2I7WUZEkRFP9GF8PGvHHs2J6JvLst6YPmNgkNV1EENlQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A8O2NSJq; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A8O2NSJq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778693312;
	bh=mU65xPn4a4o1sVf9TBT7sDxFbpFSHAoXiOAvXYl6E5U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A8O2NSJq221XuWADqTk0nH1lY3X/YrTb0ZKp2WVWuFeGXtfYg92rpZoQdLV9HiPzW
	 bjVQ0N0uJxW5tYCNMdMtslgnmMrv+ln7hVqukyjCGXI/lrngrDPaBiMuDq/hlqbVmS
	 R6O5HbXpLCvpMxPzb7tAL6nDJIhKWtwLzWHQhAek=
Received: from github.com (hubbernetes-node-6f2f154.ac4-iad.github.net [10.52.141.43])
	by smtp.github.com (Postfix) with ESMTPA id A2031781009
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 10:28:32 -0700 (PDT)
Date: Wed, 13 May 2026 10:28:32 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1094333/000000-f91af1@github.com>
Subject: [bluez/bluez] f91af1: shared/bap: set QoS state when CIS is lost
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

  Branch: refs/heads/1094333
  Home:   https://github.com/bluez/bluez
  Commit: f91af1627fdca285e516f802c64a15b3e27b2c3f
      https://github.com/bluez/bluez/commit/f91af1627fdca285e516f802c64a15b3e27b2c3f
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-05-13 (Wed, 13 May 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: set QoS state when CIS is lost

This is used to pass PTS tests BAP/USR/SCC/BV-167-C and BAP/USR/SCC/BV-168-C.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
