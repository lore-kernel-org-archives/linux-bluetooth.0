Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3823EAB0
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776820166; cv=none; b=u+m4LO2c3qoUQLAbhtL2qId0IWcL3l4wepZgkwHwmNLGLdtGwv/asealVuQaR5pJzKQiIALLa8DO4WMMsm1VsiYKTo1EDv6eSXVIoQJBaNpa4qZR9oV2agi1KtJ1fk/rfZ1lt3S8PdUMW0q49TddRkNg4nfK3YVoRO6OmJb+1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776820166; c=relaxed/simple;
	bh=Sdl8gbAsKgEKZEAGG98AAIYOZWusnD3R2MqeZaFwO8w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EttqFYdEbsqSFeOSuqIMvM0frCpDd6JdNN+ljyNmfZGgt9/ooXx+d9GCw/OPMPA7YcA9ZwH9vNx1VgLwNTow8AEDidTc033Rawp+Xm+T053Y4LxNqW2m2YUdZ3r6MBVgBHpPwBRwlAhBKqrKl56Cbxs4v2i781rJ2Pt9JD3TJxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Q6Dn6uKs; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Q6Dn6uKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776820164;
	bh=ZFyenOr/T8f/8nYoEjgqisqpMdJ3rGqkyt9WmRSiaT0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Q6Dn6uKsxhjuj1NUKdZ30hWZibH1vRwYROgV60MiTMQ4E9uKf7qjTXrl9qjU4/gFy
	 Zr+hZkZlQU8tF3AfaX8cpsNMCD4TS3NzwrYIkqYjDQUZKtL3Bh2kCFXtTm0rVIeCQy
	 5q7JSDvNYqqHmFV+jglHG8CAucOAb3XuoPCUGCAs=
Received: from github.com (hubbernetes-node-cfff7a9.ash1-iad.github.net [10.56.14.13])
	by smtp.github.com (Postfix) with ESMTPA id 70753181144
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 18:09:24 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:09:24 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1070581/1fd489-000000@github.com>
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

  Branch: refs/heads/1070581
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
