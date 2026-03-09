Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB3317163
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773034635; cv=none; b=Rv5SOzqSRMuHapLHnBaCi9GFPgkzoDPb174ZJ7zLyRYWDzPVHMozaDKv+hVFw3l/Axy5Cli4HDW7gEi4A5OOImqOpsxolxJlf+nVIaW1gqJ6NvkyBNPXszbELAgy1u1zGsG7XfD3wv8TKOHb4j0/Zxi+paXuBaR99Sl+MQHKbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773034635; c=relaxed/simple;
	bh=4ebF65vj07SgW9b3nFtQPn7N1YQ9w/S89vNyB/ufudI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UfoTE2dz0vEFA4NQRAmtp6Qp9pI06Wp/q90wI9TB4qJMBLv0ufaF3yIgWlu6Lx6xqxvcehGtSlsr9OZ7E4XXvVcTsPFGJ5JDTGC7ObEEVa42qWF7W3ykg2d+6nYq9Li7HERfYwRkCv4eH4/hpmTPBNj842nvECoCpOGMl/ei0YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mWrJZPL5; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mWrJZPL5"
Received: from github.com (hubbernetes-node-72aad46.va3-iad.github.net [10.48.125.100])
	by smtp.github.com (Postfix) with ESMTPA id C0B3C4E0673
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Mar 2026 22:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773034633;
	bh=87D4QJpI95u+l8JZH2Ulzr9J0gKBLIhH18ENH1HAFf8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mWrJZPL5QJ+V368KxqlTM0xKByysq24+1rmBiSfVAXWp9O7OsBEbK/UvajdWenv4/
	 HPlxa9zGwWzgDqj5fNiMCiFi5wzAmDxG+qRk/LoXFJKL8RAdcRJPn3dpd0TFJTXhLV
	 cjvFdzk6plczAB/hBbIwivfMdVDP5TNvBJUkUJCY=
Date: Sun, 08 Mar 2026 22:37:13 -0700
From: Gabriel Woloz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1063415/000000-537886@github.com>
Subject: [bluez/bluez] 537886: lib/bluetooth/mgmt: Added missing command "HCI
 Cmd...
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

  Branch: refs/heads/1063415
  Home:   https://github.com/bluez/bluez
  Commit: 537886665cfaae51a1ebc79b6eddfe20692a5d1e
      https://github.com/bluez/bluez/commit/537886665cfaae51a1ebc79b6eddfe20692a5d1e
  Author: Gabriel Woloz <wolozgabriel@gmail.com>
  Date:   2026-03-09 (Mon, 09 Mar 2026)

  Changed paths:
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  lib/bluetooth/mgmt: Added missing command "HCI Cmd Sync" to mgmt_op



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
