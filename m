Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB723C6BA
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730762244; cv=none; b=CQ5PRI36OpexOpBryn21y4dc6aNUlZa8hIyX+a9su/a7vMSGzCudUP3Y4ak/ubbOvivtOmUbzszZ/ldAYRsXJ8ViTm1b8yteL+x1BxtLtaU5y6rscSWTVcrk+fmeheZBlLQlmJW/ybwtkfBR7MNOO20cUOMNFBfJpWanNrm2xe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730762244; c=relaxed/simple;
	bh=v3CbOMiN46wwOPd1ZT1x7yGNAm+IqU4gvUZ/m73BxuE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RY+IntfNyvzZy/xx0OTy0/GdnptWXLamaGAzZEEWnnhPKGm3rieShXRtUrpJ5huqYoFk0lcdVtzpKAhCfSp4E90w8H8WxfQxVGV4wmWb+F+eA0JRmrDPKx/w7cOpx/4gLp50Vm9KQwJJMna4XAgbrPu9Ecy55MxSY6bKv/oRVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O61WFTeO; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O61WFTeO"
Received: from github.com (hubbernetes-node-741e309.ac4-iad.github.net [10.52.132.30])
	by smtp.github.com (Postfix) with ESMTPA id 412867004F6
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730762242;
	bh=b/JelXlNdp5qErlwL5NE7KHtWbT9nkx7eLNkodklV28=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O61WFTeOyApkXICivlNeeasoB5En7f+WXOpqaGJMCILRo9epOZJWXXm+cFVHn8wiB
	 6slJfaeUQ3G8T4EDpJ+ORnzglJB1ND5VW1UwS8DYUdO/F8M31yavhXaI5k39uKyD4V
	 Fn8oU80bVhfwTk1haTMvjqz2RSbckHKcjXX7+J8U=
Date: Mon, 04 Nov 2024 15:17:22 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/664a5d-7322ec@github.com>
Subject: [bluez/bluez] 7322ec: adapter: Fix up address type for all keys
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
  Commit: 7322ec38fb65afe8f34b9e363ed9fce37e1ff868
      https://github.com/bluez/bluez/commit/7322ec38fb65afe8f34b9e363ed9fce37e1ff868
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-11-04 (Mon, 04 Nov 2024)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix up address type for all keys

66a8c522b64 ("adapter: Fix up address type when loading keys") didn't
fix all instances of wrong address type being loaded, so peripheral LTK
and IRK were still left with possible invalid types.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
