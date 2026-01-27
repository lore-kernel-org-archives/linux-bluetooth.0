Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC42D47E1
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536945; cv=none; b=f92pejmx9bZMDp/bmzJCpiAif3POoMg51krs62bOo67o9SJYg/ewDVXFi2fZ/huZEhtQ5Xuf1k68sepOWEipr4MB/rPNdsXXM1iyVzfYWyx6Az3iAVcv+i97dKOIIqfnpv0avSdYAx7wEvZbb5r3mOHYgAkJK9xSaVuoMuLTLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536945; c=relaxed/simple;
	bh=KYVZJ4bbHHpDk4UoxxRiyhoQC5MdyeAjipp0LJA27wk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aODAyix8NTm3QpJVtRdVJNEG/9Hh21hUv7ejlQ+zLk0owMk8QQJlvNpTxP5Ziioo8eJ/vVKhPK9f0i/Qh9iTUMuZ7JL/Uo+9S5pbWDZ3klfau/xxPH70MdBaLNUpNV7nWI4OuVIUzGo7+9M5Lce8O+J14O0bMHoMRmr+6u6jBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mvDCEL10; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mvDCEL10"
Received: from github.com (hubbernetes-node-86518d7.va3-iad.github.net [10.48.149.56])
	by smtp.github.com (Postfix) with ESMTPA id 2FADCE1464
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769536943;
	bh=ktlMyUjHndOWKHiOs7X4OhBkgdkwTmrsu6/4IjOR23w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mvDCEL10vsRpAvwXBpHsvj5YWcQs7Z2XcjyqKTBzVnu2dogekmVfmL93Y5V7F0tka
	 7ksFlfOcBo7E0inneXxS02qei7tmI31/v7ShopRV6I6e1WANoSS3jV7liHjmAvdsXO
	 5PZT4yBmoMbXdg9dXjwC7KWb8bPotwoJ0L11IrJg=
Date: Tue, 27 Jan 2026 10:02:23 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046215/cd6e34-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1046215
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
