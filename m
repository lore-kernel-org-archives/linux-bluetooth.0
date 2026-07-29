Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12924286D70
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317411; cv=none; b=CkYfId3bkjjaOSWeA04K8MiObCfF+uUQBcHm7T1GK8rteku9YY6b9yGkoIcsnnrhg7nF/tLUoLnu+yiBveNYmfWw5VvW64XsUtFKcepzna0Z4Bq8E7wvvXvLEyrsSV0ZTdX+65K37gWAbf9ebTPsCNrxreBM25GZsZDbJRuuBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317411; c=relaxed/simple;
	bh=bgV1vb3tFhwW7qlnf2Xb9EzjWe+vqLu4htDuSO7umgM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rZYcIhX6OJortFpdy3pcYmjQ/qCffUgq1RIyK1TGyUPC6WXaDefyKEZ0zot8L0R+Y6qOT8N2ltgmDRkzzs0uFC/j+RIyFN47Cxbu5hDNcO43uQKJYnmcPUMkJIegMs0svHe75Tl/ZDQdL8afbP9x7/2K1S6taRWcdTMWAef2EU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=facR4h0R; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="facR4h0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785317409;
	bh=Ci6uSsfeo1ZSe3PYp7q9BvDM/oKKU0ttTTvJsL5ZQZw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=facR4h0RsO8VMtz+1XgEpH+yxL1udMZnkuubvSnHsBM6pMVd1GiovdmMO1aP3RqNy
	 6JW3EuceM8//o0yojrIZEhndI0EllPiyR3zJUZNFRaBDi/8X5fJddE4oNPn2Kf35WO
	 1N3eFiA5CrNTMsP3PE+h5gXVJew64VVuQJxxODD8=
Received: from github.com (hubbernetes-node-fa6a146.ac4-iad.github.net [10.52.157.35])
	by smtp.github.com (Postfix) with ESMTPA id 14E26740FBC
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 02:30:09 -0700 (PDT)
Date: Wed, 29 Jul 2026 02:30:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1136288/6ed544-000000@github.com>
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

  Branch: refs/heads/1136288
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
