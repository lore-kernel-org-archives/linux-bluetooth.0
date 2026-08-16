Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F42FB084
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786867032; cv=none; b=kVXbx4Y/YvRfP6RqHW8c4Q66/nBJFw1qzn9x82fzBj0X/SPo+XfluAdtqwIs6nPXgiFqlBi8bMkUO3DQuojMWc8BN7/WP37C4YZn1N+HngVSDC0XojzDMqkEFVNUQ69K/0Yb3I+vCprgOPdC8tT5Aoo/7zrk0nKu5WFmri941JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786867032; c=relaxed/simple;
	bh=Ma1B1Op8W5O8neUDQDX5HLHE9FboKjzjW4pq1u0H3PI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dbCK8S7Wbq9nqJ9gt7qSZ7In5M/ivQpoODa7uI7w+S8l7LI7Bgrosr7Ke4PloZEaw+bkAwtEVQ/TtPzcld+6S4bXF0mRGOXKsdRilI3dz0KAloocY1qI6oi1lMaH5GRbeOwkbRUp+IdsEb5va9GUz4FKPfrbCG+643XzxLrp8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fVtdtcMy; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fVtdtcMy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786867030;
	bh=JAovHnEfUh7DuE41nbVIW+RlAk9lollApp9B+YweICI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fVtdtcMyjuR/jT9EUbpnS2/ZuqueMj7zpPRhZA6edZVYXsb3K5Gh7cuZ/ONmqn7A5
	 2l94N81RGo/wKnDDqXaqrGylhEtHJsK9l8dHuC7UXeINW38oh/So/XB+yIWD69YkAM
	 2mbn42+2D9n8pKBpFkiUZh3uWLUsMuzkONRnlOp0=
Received: from github.com (hubbernetes-node-39f3ed4.ac4-iad.github.net [10.52.138.30])
	by smtp.github.com (Postfix) with ESMTPA id 684EA740AF6
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 00:57:10 -0700 (PDT)
Date: Sun, 16 Aug 2026 00:57:10 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1129350/27f844-000000@github.com>
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

  Branch: refs/heads/1129350
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
