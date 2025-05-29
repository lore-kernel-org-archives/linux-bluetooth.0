Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7323278D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748547769; cv=none; b=B05noL14rgfJRs00UubfTd8TsTNR2hbTWaKxZ5YxyHlfmxICh/cAUnsEcHuFvEeeOjdvlbzc9oT68rtw3Q7lfCnyfC/HdFB6a15OQNj81Bdwh7Zsex9no2HHE8OtEVTqi07APObvEa37zXIJSJOB+/l7mcRYfjEgyP8ewCHfUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748547769; c=relaxed/simple;
	bh=3yYYobfaRBqWQfltslsCyNJtwv6HE54Sq9OFIOLf9kw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mmEpf5MuROjcAijZI7xKMc+E4cxxtCbS0LJUsJjUaohl56GitU1RUdxpUtW0kII6ipdiXSwczCM+T21t0TGcHzihsMotA/TRfH17E22ttlDSbGDEUheCRqU6XzR6XRkHenXC+c8MJQVfsmhyD4tZHOlve76T6xswJfIaEzctyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CcmMbVDd; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CcmMbVDd"
Received: from github.com (hubbernetes-node-7f8436a.ac4-iad.github.net [10.52.145.54])
	by smtp.github.com (Postfix) with ESMTPA id E546B640A28
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748547766;
	bh=a/mVhfPUf+7qI2b9g/3+d2YZ+6Q6M5UBD7sKTM/o9Qg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CcmMbVDdsWG4swdba0d6ZB08ZnI6vWcp8UAL7PSvZM6TFndJ2/NMuqMDAChXF+1lY
	 +hnCMczHBecgxBgDYBfu+gsS2qmtL8qL4X8Lj2kcBcPABQaANL7U7dla1RQWUjJrk+
	 OU8tdg6gslxLhjatL8CTjjkNyrX2YHk/zo+o0FRk=
Date: Thu, 29 May 2025 12:42:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/967384/d12f4a-000000@github.com>
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

  Branch: refs/heads/967384
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
