Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5A1448D5
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476636; cv=none; b=ErvRAcObmvDZ7jzBDNsIGDIX9+lTegxir3rKrB7hsgZYlj4ZcoScDeFA0ODcL5ftmPJIkokAuOW57PG7qWedmfJblBavPOGFkEU/OUxirdDR5XIA8k4zWlJVgq4TW1A3H8s5Vfocg1R8enKDiDTnlC9OPRXWbtxjrtWRENLz/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476636; c=relaxed/simple;
	bh=j/GYXufEQrxwI/H6v/mOpzrcGOnX88kF6cUtNd5UrYU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TQmNS8u59RNd/D59A+ys4OAnt6vzPvA+SNS0UTTnW0PqWl/NpXzZQqcw5Oo3AOZs+TBE1HTe0SjuXBPN/1YrHOU8i1rCkMUeLjUy9kxOj78y4yrE/UpN8iSPIaNksiFtREfi1y2DFKoG+wxb+bqwXqTUPZvfcPeM72DZ+tyFX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M+tYyx5s; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M+tYyx5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777476634;
	bh=KZHa+2J5SkJBgLP5wTaNhKSmutE+gyAKzRnpfkc1jmg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M+tYyx5sVphAwsB2Efz4/6ae7Am11fLir+WYU2BYb+wvwZsCT7PIMI/Qs52JpPr8N
	 FU/OZsacVt7TLg9b49cMZigteuQXHh+EJskYuqbOeoSiESyN/kwuGeV6wXDeaNzvxv
	 upbleww5c9Qs++eb/K6jnnL4YaOjKbO5HxxzLVv8=
Received: from github.com (hubbernetes-node-8e61edd.ac4-iad.github.net [10.55.94.31])
	by smtp.github.com (Postfix) with ESMTPA id 2D6D79411CE
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 08:30:34 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:30:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1087302/b6850f-000000@github.com>
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

  Branch: refs/heads/1087302
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
