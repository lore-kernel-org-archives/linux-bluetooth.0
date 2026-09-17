Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F74DDB3D
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675500; cv=none; b=HqT6ffWZl0ZGHNAh85EHmXSLIV/mJfY4wDIZwzdkZ3uHrWT8TdaTz7ELwBPelDxDQ6Vwq2nBLAvNpHCpQYvOgLhc6NpRbp6bEAyHQC9pl+fwb1p3qT0mJjGxdgxw47+z9njRZZFcAgvLbg19OiliIuhhReDZH4rDAErDzJik1lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675500; c=relaxed/simple;
	bh=hW6RpBj/VVUz0c/YmcNLcZK54pDzty42PQFOFFSUMLg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=s2/9zsRdh8MLxmF7DZagWCzwK5eqYJlpe3zk1zNUZVCaNX9cc6I7nUdVv2BfamZOcC0pXIi/SafaVuTYQ/Ww47t1r447/0uKCx63j6klCp7Uq4lTzv0D0VLe0dRuH+Rh+a5FGdq82HbhRtFn2PQ9R4/p0GUFEZmQJeTHNT47esI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AHp1H1qN; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AHp1H1qN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789675494;
	bh=bmFfqqr+lN+53uI+h6gB8lhK0vfzZF23hTxm0xn93yU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AHp1H1qNBBpjC7tjO/bFeOrzdBjJ9VjdCBaU/zqcmgjP0XDw0P/gE/ET8O2e4SbRL
	 LqBOsIxNMrhdwH4b/8zkNdl4gfioYiw8+/d287W2znyjEYZJEh6cOCa5NOiWS7H8Fv
	 DqATHQdZa6C71S8+BSO9F7GUjIBHh9HroJZEPMGs=
Received: from github.com (hubbernetes-node-5781008.ash1-iad.github.net [10.56.15.15])
	by smtp.github.com (Postfix) with ESMTPA id 93F35521527
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 13:04:54 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:04:54 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1167792/c27e15-000000@github.com>
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

  Branch: refs/heads/1167792
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
