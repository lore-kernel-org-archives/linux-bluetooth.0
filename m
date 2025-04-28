Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF8FA94A
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876585; cv=none; b=I14f7m6jIcvUMKqT+S4nmX/rJgyJGIv+Ft97EXXUO06leoSj3HjNsCQcfvd+YRW/kEN48vQ2aW+Mq0c8k4lqN8mDOQ5Fw7M45kXmkPwsfY31yk6cfnCClj/BwkXYih0yidhomrV6buxNSSfnvu+6Jh6674YH5gZXz0UVBgBwmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876585; c=relaxed/simple;
	bh=B95wiTEbV3O6gpCgS2I4ZL+NT8Y8AUeojaBCjeUI/3Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=d90NjWW1jsFjt0xbF/xrg37hfBF44bForoiwx67iujAXoppCKlJBu2ni2mXHvEtIPbmReiTNYQMAJpNOB9O9LGzI3uzUhIQjPbrsLseylgtJuLhopmkOhZWlH/Y2g09FqHWTctiV8XX2qni4rZfSTIHOlFLQuVv1reqy3O5DVz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HRfWJsPf; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HRfWJsPf"
Received: from github.com (hubbernetes-node-27384e3.ash1-iad.github.net [10.56.147.25])
	by smtp.github.com (Postfix) with ESMTPA id 765F8600B07
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745876583;
	bh=0cMrXdeQBCCobV4AwboA62bmNZVTGICgWSIClG7boLs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HRfWJsPfacv7nz8iaaPy+DHZxCRAhZNOmArgI3+6iWN9EQtbevjfbZU+UvJzoPX23
	 A9ndYy7b0AWf7OTFypAnm4qJPdvWnG+NqT19piXivrfc+HfYuDVg9l++t2XbWEC18r
	 zWdYPvrvb+FPUDBoqKku87ZsdrqBpg1glzPW2xMQ=
Date: Mon, 28 Apr 2025 14:43:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957841/cc95d1-000000@github.com>
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

  Branch: refs/heads/957841
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
