Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2838E5E6
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495092; cv=none; b=cmIxgQcnoHSLvZUuF/wncBWgkosaEb2FYgyUpnuTyc3B3VUcCBz9uqazVG3jL1nQV3C3B1DGjEa907Tp8wyEOxKSdnepThERk2snuBrPHuE8hFxM5ah10R/UD6P15Mrud+TOidod8HkCdc6j8Li9KDiutTXIqa3JsXPj8b5YqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495092; c=relaxed/simple;
	bh=X61KHFTL/AeRaA65u6zw0ormEvlACtK3G+zSba+rHcc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mvriaW7bD+XhKXQ9PbiBlqo4KNZ3jfp7vIJVdeI1+ujCIYyIwgUJJkwJqETZWwgMjmIaYDGCnc6GzqHrdO4yIOlIiwQmaPUwVWPtMbYW4is5OAL02B7ai1Id3s4oKdFcleyPy0fDWOUGVLt6Zo2MsGe9SoulatnAKMZuiEHOANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=W+zYvXi6; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="W+zYvXi6"
Received: from github.com (hubbernetes-node-54e58d9.ac4-iad.github.net [10.52.179.61])
	by smtp.github.com (Postfix) with ESMTPA id EF856300BF4
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 10:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775495089;
	bh=Vj4YIMfzXdWBLYeE2IfkDP1urjX013serO/pIs29KM0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=W+zYvXi6CsbsIab97DvnD/j3g7WQ66bkrqKJ0XSa/SBDjARv5IprzHUFiV2eefwIp
	 98aSaSA0pvCn8ygYJmHsPb4dw2hVHNk+C5nI6q7Yo9Pxn0Gr09F2uTNEcavNt6LClV
	 +O6srF/j1Ag+5R1LsA0jkpbHMeRH2bQ6+SXVt7cY=
Date: Mon, 06 Apr 2026 10:04:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077632/422868-000000@github.com>
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

  Branch: refs/heads/1077632
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
