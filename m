Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF923C4FF
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068154; cv=none; b=eE1PBFz/ghLrhkiN9OIx7COxvFn3hMmtg8u57UAG011kWJUaq5TWBsRybgoxiaa6QfVvcB0ba3Yq5IMJw+BcVsmJClHi9q4mREJHQCUVUK+KW02Q/adJKVz95aPtFoFOUivbPPpTLddvZlJIR1tZcZ723X8NQCu6+pbPgq7RKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068154; c=relaxed/simple;
	bh=66dZScyYgsx1whCzaU5glTwzn03fXEy8ISGoiYdMvNI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KcvD4TDrKr6j9xwK1AMZxNHcftuu2l6zeVj2XsAH0NEX6ZDJnp/PXtWqfq+BdQnyFpiaygkyFfrOHFJeeqkmWE68bf3fopb6EIDYg4hk8uF8h3YYx776Lpe+nJm4dtNT1p8qxer8ycl1nlExIJHebxU4mHr8B6+WZJeZBTgHef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KN7Gl76L; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KN7Gl76L"
Received: from github.com (hubbernetes-node-67aeea9.ac4-iad.github.net [10.52.166.15])
	by smtp.github.com (Postfix) with ESMTPA id 3F90070025E
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747068152;
	bh=9mAN/j9rwKW2MEMGoFo3h+A8dTq3l5+qyI8vzJ9+yPY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KN7Gl76LhuakX/aqQ13ylu41LmWYGGEPPxAtmrmPSuNNpf78PhsCAaLAQwns4GvOY
	 jrzJpEpU/V7aG5kIHthEJ6Uke6chrLh3BVLj4TH2Q0KZ/1Sadn6gCIOZW9DIyyku3f
	 Hf9i9MyL+8Eqob27T3dRXpA6+ZzvvKhvIDGwKWV0=
Date: Mon, 12 May 2025 09:42:32 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ab6ce0-5e248d@github.com>
Subject: [bluez/bluez] f6f82b: mesh: Fix possible null pointer deference
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
  Commit: f6f82b39d3287ae5eb4ee3ac323373265c72847f
      https://github.com/bluez/bluez/commit/f6f82b39d3287ae5eb4ee3ac323373265c72847f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-12 (Mon, 12 May 2025)

  Changed paths:
    M mesh/cfgmod-server.c

  Log Message:
  -----------
  mesh: Fix possible null pointer deference

This fixes possible null pointer deference for label reported by
cppcheck.

Fixes: https://github.com/bluez/bluez/security/code-scanning/1771


  Commit: 5e248deb85872a1031d2e18602ad04f39eae61d0
      https://github.com/bluez/bluez/commit/5e248deb85872a1031d2e18602ad04f39eae61d0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-12 (Mon, 12 May 2025)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: Don't attempt to listen on BR/EDR if disabled

If BR/EDR is disabled don't attempt to listen on ATT PSM.


Compare: https://github.com/bluez/bluez/compare/ab6ce0c8f3e0...5e248deb8587

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
