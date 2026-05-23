Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142638837F
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 May 2026 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779540261; cv=none; b=QU+AyPELMuthUbmsyiq/HGar62J2nYx+2xepqlrDnknJPsHySRIOQaZkv1G0sRjhOKMgCkMf+DuxuMVdO1p3mnnjWTM9NIIECEavVcLmFE4mmGdYHzJb1U/NjZVX2BeY4tKVUJkDZhnRNTcB6LTHSoKQO9MhVm/4IBALZn3bh7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779540261; c=relaxed/simple;
	bh=XdTX7U/4VCaxSiZydiuKJn968rgw1ESzu0VHc8QYHSc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VFLxLQ6jPG/fbREdcOOlmJgiHb691yIGquuO9B/7bQnYdp5EITsdXUyextAo8nY8MbgXGSFWnhiMhcEB0uahrapawOgXx4NDAlXK0s4ukEDWZLFfqLT4ZNY8XGo89FYe6NG/nhmWW0ZxLl48MSFQhfqklnK0agqbWZaQ5ubfX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EAa3kZih; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EAa3kZih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779540259;
	bh=MYX48A8jZg5RAvg+Vm9HDOedXLEQcBi5Fw0QsdeAw2c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EAa3kZihhRPDjj4OKLS+7NttpjwZhAnz9KeDm+JQG5WxIU2RW6Pd+0y4oVeOmcYfl
	 UR7Lmvm9I4JC0BGtfR11XlsZRKYIfsB+01JvGNhxQvF0N1oogRmNw/z08jkouv030E
	 AXS4v0ZGS2yed3F2OgDK2u8A/EljAKv8MhQrY0UE=
Received: from github.com (hubbernetes-node-4e6be2d.ash1-iad.github.net [10.56.187.48])
	by smtp.github.com (Postfix) with ESMTPA id 0DC66180C81
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 May 2026 05:44:19 -0700 (PDT)
Date: Sat, 23 May 2026 05:44:19 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084652/ed9b9a-000000@github.com>
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

  Branch: refs/heads/1084652
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
