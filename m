Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7C218AAB
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750452991; cv=none; b=FjTW3BK7kx7fDfzTpbgNgiY9grf0YVDKGm5z3sQBTiTjrftgwCopYQJ5OZ9UrEF/750zNTPJ2jQIO9SN+Gyb2a5nSgfXCmLnvUhdSv57SEhQf4ewXtw4IJOvKm5F6+zdTYzGexL3RnoVZU3Yk0yy0rb2MYjZZ/L7OQ7D0DpQWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750452991; c=relaxed/simple;
	bh=8UW0E32iDOLyqek+Tg9gMBNUt/ldB/ffAC3FTPcrHTA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CcLaESXImCGSnqZqH9ETxk32abZzhXDqE/cMbqy/PHr4MTpxoWsfEvWJ8Fv1jvkD7W/NWifk9vjnjHr+ox5drjeIj4o4Ltvx0w3f13D0xkinQJyxS3FuwnLfZZKUW+7Ne5GaeEBxIhl4GCD4p1bapQPYO85ps74t9LA51AfH3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P6m+qaRb; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P6m+qaRb"
Received: from github.com (hubbernetes-node-e5c2721.va3-iad.github.net [10.48.148.32])
	by smtp.github.com (Postfix) with ESMTPA id 49E6B8C031B
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750452989;
	bh=7PMq5XHTTT20R6djlEhIZs7btJ+ypdCb0t1uBiKkD8c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P6m+qaRbavEzxHjvTeNo0qbZeV7nW/WT9aWoxkuhKvH1C/r4XVto4Ab9R5QO9vaKy
	 bmTpVcGMoNmFRUIAZ50hh+U+Jd2tVTC97VuPmLfspBG6U+wEtdO/iiOgBVVs3HZjlq
	 n6a4ozqxbvS7zOn/C+iFsRIVuM3D3VG7dySaaUeY=
Date: Fri, 20 Jun 2025 13:56:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974152/70b054-000000@github.com>
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

  Branch: refs/heads/974152
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
