Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFEF367B95
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397823; cv=none; b=n4itPS1WuZP5fC5f7J22hFrmmnBE+hoTmMQR9VbsqFbeRi2aAC2b8E6+Al0Or542fFo8ckfvkibt43Zn+qVz5Y2rIGKo/YpuJ+aqF/H1rHnzmpk5OJ4sOb6lYlls1h1QNkKtKSTY6IKNqpcakGuVylRYltbc1dgGSy/rRG9oWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397823; c=relaxed/simple;
	bh=bafe/M+gHImGYVd0/bplcdoZyhTuItAm8SGHPndW8Sw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Sjxof8Llg1hsucEkioYrpmN5ak6kUAjRyct4CLfVHrqZhwXXYPOo+89FTvN0AhayTTKRz7DjV+nRReCGSULWvr6aBM6AlUBsoKjF41jSLFatHgoH8w6W9qEXDhwZbvv2sY7B9JzWOxwhj2ai8VLMElf6q2svMQHbBZVBZA3g4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UW5wts41; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UW5wts41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780397821;
	bh=NFSWq241f7/01enWRGVC+Ho57uGFczq3/NpLfnnvgpI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UW5wts41XLgfgItAX9DVSU9axGXuzy9g9b2wHdcFBqrDLt9poYRIiSTL6iwGcp3AX
	 lvwzrzE3tAvBMZgQE0U2FYNg2NkuMPez7oEpXhH/vCXP5VAEiG71/3aHfhrwSFCkUq
	 /F5d3iFbpNaK4ewokPxP8cbXu3oYg2R63i+XLetE=
Received: from github.com (hubbernetes-node-637d5c8.ac4-iad.github.net [10.52.180.31])
	by smtp.github.com (Postfix) with ESMTPA id 9935BA1273
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 03:57:01 -0700 (PDT)
Date: Tue, 02 Jun 2026 03:57:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1092724/849390-000000@github.com>
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

  Branch: refs/heads/1092724
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
