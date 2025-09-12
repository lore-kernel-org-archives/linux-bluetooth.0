Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625E2D3A94
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663746; cv=none; b=tEPBWvHkPmiwt94Eg56Vxwc0hZOHitRb3/u+GOPlGtZEo3gwdriagdK2MNy0jQElYp/jNOIO7a8D2URRsUG+L9RBFR34urzeKD6/7NmJw9M7hMuO2jNTX/YkhGDy0H+7C4mN1NHEWESYttWOclMSdOYXcgYkRxgE6F+axOh3KKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663746; c=relaxed/simple;
	bh=kfNVN46xQi6B4YBQ5TetY1e5CntUtq4YMHoMkFi+AIo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bNPZ/Ejya0CrVqiMWSGC/phel8aZuQZORzeRL4xVCAKUi3yVHUswxBQvmpwRFD7HiTkxByQEoxL/kWRn6N/nROcHy6rovgxsyT7b98YQovwr+H0f/ad3JSeGE1s6BPETXCgZfGV6tBfJ55vULVpF2RTqZgA8UrYNGMjmNlHBNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jbmO5eGQ; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jbmO5eGQ"
Received: from github.com (hubbernetes-node-f9bcf7e.va3-iad.github.net [10.48.166.15])
	by smtp.github.com (Postfix) with ESMTPA id 2DAB0E0276
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757663744;
	bh=JTcNE348KG5pmPr/PcvVogeCNwcA41ksJ91gNCUypfI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jbmO5eGQRFSJ1k8aoPmyhyGg1Hu12EGxjbOGeAmdSmQIGSWoa7fX+xrU6/712xqiL
	 ifKs3Qb4nPlDENdHQTcaMPJCB0X4dB0FEwKNitXAlQsX+ov++ZO1qsfYpl4HVhMCnk
	 UOwpxiAna+RkaQIgsml2Ll6zE2ScVbeEfhPbwBd4=
Date: Fri, 12 Sep 2025 00:55:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990865/4c4c77-000000@github.com>
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

  Branch: refs/heads/990865
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
