Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E674E9C16
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631119; cv=none; b=YaXn6RYSZeDMZJJ7uXpMwWP0355S+Z4PNabTLSct13X7PhrVPqOEhtq7DEp8ua0tUdVIBnVZ61X48nzvOt30S9xzbkNgKcF2HpnMNwGWbD8vZ3fqQSVuvcY8G/dWHGlFKa2j2eho52Hp3FQ75Ur4DULCjXOv78jGgUfsDfR5kCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631119; c=relaxed/simple;
	bh=E8P6syb4aOat1bPzr3DoNzJ91rgpGwUC9YEO/29vVy0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=muLlfct0yrAB7d1vUGQeliyieStKwsgEbjBbjT0CN+NTSiNrExj2Q9JycEfU8QueYJn7bUfQHy7jU4x1yeSLsDkpGmpD49wKFPDnmFZI8DtGcMKFnlhMz8pIbDMGKxXbuT+/gXEtSgZ1rpiedtD87x9GoDFyElBYmN2yEX/j9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E/8/qUQi; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E/8/qUQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790631115;
	bh=WbjQCA8By9gDaIPE5NtQ3Twe9qY9QLRT1oK5bWDo4aw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E/8/qUQicj+bc6NP/2ue9LTlQEwbTi5VveQ6o6bNUQx9c2MSYQQAoLgCJ4C9Ja1A7
	 /Bz5jI8R37lRO9qh8X1SHheN+zhYYo/luVYaV2uYg3JTShPrWU5U7BvCH4bvx4bufG
	 7ehgwUjZKq+3dvcwSNDyOT5woCg6RBToKZC1/9eI=
Received: from github.com (hubbernetes-node-a101e17.ac4-iad.github.net [10.52.14.33])
	by smtp.github.com (Postfix) with ESMTPA id 47EB57401EF
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:31:55 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:31:55 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173751/c88882-000000@github.com>
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

  Branch: refs/heads/1173751
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
