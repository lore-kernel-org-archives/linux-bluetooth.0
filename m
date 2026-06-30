Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B834CDD
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853547; cv=none; b=iV2k6Rw2+nJ9/tcGPzrOjYQRzdqElgnJiIiX1ehtDvLDPO7oB6+burgQ7++IoZv9cn5oXsp5izvY1xuozlbz6nMjQNmctbkgKvH6Vef0wTmdiL8aHRElku/zmfseVcnF/DKl7bAPb6yHeKjHl1hqP3B+KWMrAjcrp7hpLF9GUQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853547; c=relaxed/simple;
	bh=xK19st+rALWEBGua0QseEetYCwj+Sux8P9nJWIVdcXE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OXF/f8HYsIKD2HlDGOsr8JuF01xfc09qF83vfh2qB4js70cauGNJimG6KoLU0R7EFFWp/ngPeFuaaN1cGmnDaH/k3aMXfZYRDpxoHGpNOqUMsKimtZKDk1tnOiv0+QwQO1ZRu8vtzK5YUB5fJRMjOT0sKlPWlATB7b1H5vrYu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OMQGFgBD; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OMQGFgBD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782853545;
	bh=26WQJGnOVCxQKH9zKqtYoOlLifS7N9qu7FXGZr7peHQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OMQGFgBDKRVFLXT1IbFJMIkHHpiebcjQ4iCvHjLXLFMH3cMe9k4+2zacQj1T0Cr5K
	 HUcOh+vwdWTDDyYfmG4AWyatWKNlL8JiJhiQbdMGTPxxaE+jPd6F5ej8QF2vYcdENJ
	 ZfPu1/j3pYp0G1nDxH+79phmT1o/JnWxVJaAJ8Kc=
Received: from github.com (hubbernetes-node-1bcf34c.ac4-iad.github.net [10.52.134.23])
	by smtp.github.com (Postfix) with ESMTPA id 905D678E825
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 14:05:45 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:05:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1118322/dc5f00-000000@github.com>
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

  Branch: refs/heads/1118322
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
