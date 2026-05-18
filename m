Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F2261B91
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779145011; cv=none; b=Nz5FZRfOWitRHuzuTxjKV4K4oEIUYyU1lSwHCU7wS+gUSCZX5XMm430wWu8E+hPlPkao7w2zK8fzEj0lZj2hlCHiFomKr8KFNSnPDZT/tBv9OyFMGTVKzIfw9P3lZ0VNVen0p8A89FrAxU3uVr/50aQ5I4t5sDr+iY8wIZb0GwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779145011; c=relaxed/simple;
	bh=+DE4de7mdIG1rOX92gvUC03ZHvpdQFhwLDe5dWwJdNw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uQMisKkOJRejUwp0OomXM9XdO3V7SEGzb4jiHaxAf8rYptk50P7NKyN+le44E0+A/mN5t39Y/qF7DN03af39imUZHjHOGr8jPdl4q71SsNll/G85sqBUxYD+H0bI5Ge1vhzkPP/uxPQYpA1opTgdZakrRlMvcJbeIDLKWofdeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Dv0pqGXJ; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Dv0pqGXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779145009;
	bh=UbRl9F6Se1xHLhPg/NpsD7Ct54ArrJj0tSOZm+D1V1I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Dv0pqGXJ6+x93QqmL8mZ5bNV8DdrGYXyr7aqxxvM/9HhpOA8hYOK/M8iTMqL4WFOF
	 0anDim+XIgUCACpDgRFxgAxXB/3S61UfvCc1GEkpVTkSsVUPEdT7O0AO5HU65iJEmD
	 SAhuLLuEwX0VgI9UuBSYtECBBEWm8J3oheYhcbb8=
Received: from github.com (hubbernetes-node-9c81d10.ac4-iad.github.net [10.52.201.31])
	by smtp.github.com (Postfix) with ESMTPA id C1F873211B3
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 15:56:49 -0700 (PDT)
Date: Mon, 18 May 2026 15:56:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1096354/51f3a3-000000@github.com>
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

  Branch: refs/heads/1096354
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
