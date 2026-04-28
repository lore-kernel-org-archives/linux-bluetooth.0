Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF6358381
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390825; cv=none; b=ssGyJHvNky0IXS+Hq7JWtPQ7p9kv3AhaspXe9+jg0CaiXy8byiYhcmOkC40gxI9JALN7CpvzpPyclaKUFTsXDLs2QIGfO3+xeLmsuA4v6oBuFjHL8VTDefFRRNg0Tdm65hrc27QOqQ057Lx+KscC13BqFciRPKem2xJDAoxjuyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390825; c=relaxed/simple;
	bh=V0TM0TGhrpzOvYoreiUsDSUBxQWD7zAjK8ua8RGSb5U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=N7fdat836j4TUEf9JllsWKEAa8uIi0sDIgY75pDstsiwuCjN1Lv/0lm773WaEFQOVlYgXyoEp5gXl089PLaIcw86zfzHwVePCdtd3B1y8Qhp1nSxtVJR097H5nj9YKEashOzxWGNSK0pY9zjoV6qHTP3EQ6JSOHZ9T4epEbMorg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jYoUk2N6; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jYoUk2N6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777390823;
	bh=vi9EKifgkaogsO76FUbB+zDuky4QzFjUFCxQubJ3k3A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jYoUk2N62e7WdndtRPdl9QqjWfeAxRuK1zOSwPFpOoWgetUYlJezBTbUyYV7KsSOE
	 QN//txIDy0e4dj5jBeT5KsGEdTu88bEB556VsbrYHsxlc24gY5nX4SHBSb6Aou5nZV
	 Zo1HkcbsckRH2RJ27wdt5L6rV+l2sR9Lx+NPgjPE=
Received: from github.com (hubbernetes-node-44ac701.ac4-iad.github.net [10.52.132.24])
	by smtp.github.com (Postfix) with ESMTPA id 8E81132040E
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 08:40:23 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:40:23 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081265/25ba1c-000000@github.com>
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

  Branch: refs/heads/1081265
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
