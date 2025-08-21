Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D362701CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789640; cv=none; b=h37/E6408hxmwIGKZiLk4hdmd+zDvdR1Kyx+QxcPs1hLjbNqicODhguWFBJCcoUDXo0tQAekI/pouD6UJJjugtpBQMwgbuyy7AZoI3JU4FMeg1VMNnr+/w/0+8pR6MKIyWEY8mZG3OJ8NPPVEuKht0KI/M0zkS1mtg9l8os0xHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789640; c=relaxed/simple;
	bh=5jlxEYE1d4eCS1Hwx6viaOkYeVD4rP0D2i80p6YEY1U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JLvkNy55v/LDWw5K9sPKP2qk93pZP+1GsXGxVOIuTU6rMJOzw5rSXtHjHBsvAoGPexz+t1RC/cn2EalqFXEFvru0bSp65v1sLv/bYDhjYgKY4D//wxRISIt2pnPC8MyKvbOJEhmrnbgc1EkJguQXdEUijCgkT2hCMCO83rE6kvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Qe4xWSHg; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Qe4xWSHg"
Received: from github.com (hubbernetes-node-d48bfb5.va3-iad.github.net [10.48.150.26])
	by smtp.github.com (Postfix) with ESMTPA id 1A643E1063
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755789638;
	bh=PEVmEyv6kOz3TTIHbXkiGJqaQSrBXYCgBeKY3pAcu+Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Qe4xWSHgwdmK92E73QwoVtfQYVIvF5wS1PgH4bBOSrA60joZcB9cfmJFXdAAo9yer
	 8bq8zCocemvi8edaem0wB6+AP2UcJEzxRKHKP0ufwXcnU9mKEZgITu2oXTfOiKD3Aq
	 ClI0ZsNlBvINqkp5FvutaaKzJPsPthXIKNtQaPV0=
Date: Thu, 21 Aug 2025 08:20:38 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/994106/000000-aea455@github.com>
Subject: [bluez/bluez] aea455: monitor: Print message if the frame information
 ca...
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

  Branch: refs/heads/994106
  Home:   https://github.com/bluez/bluez
  Commit: aea4553fbb3a30b192382a686796bb16de5a00e0
      https://github.com/bluez/bluez/commit/aea4553fbb3a30b192382a686796bb16de5a00e0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-21 (Thu, 21 Aug 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Print message if the frame information cannot be found

While processing Number of Packeted Completed event the code attempts to
print the frame information of each frame being acked but if no frame
was sent it didn't print anything, so this changes it to print
:#(frame not found)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
