Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FD246762
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079070; cv=none; b=pj+GQaYvptCgRqyeFuuIgbKh0GxFgP3M7vfI1I2aGmTAgE0nLuGyKAuFeCRvi+Q8FZJrxy1ZiDnRrjqu6AzrNTAVeadKtfcbJ0h+hgW/58gGgYilOWYmGqSksEUvZ76qJ+aL6FdaNZhZxKIYGLeEGiWr0l+Nb9kRjw6e/WVnM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079070; c=relaxed/simple;
	bh=NR8pS5ZlJXxVvIpTa8QCyxf1tGyv1T+jHyet0MvAeK4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U/Ua69r99vLwruSdwqpiw8VvvDPWQ7PB5jJq/S793FxaD6+Yx031PJIpWwM5vQ0xDihsuDAUptqrDjJwdINlCShHGBdxZlhfjzC7XuMDKcjDB6XquqIxgHxXdmt+z2UYPlUddnglDbQgB2p/6ZjUVCxLynXc5mH6rv20ZfnY0T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZQx0Ktel; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZQx0Ktel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787079068;
	bh=bq/d6a9xcQJMkRz5N8G8fOEvBAifTTP5HFS0TmAZysU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZQx0KtelEBAeZTG0XqCEAuvvznJgdi+kCBfRi6ShQG/BIxys1CZxt2yy+JVt8c+jL
	 Qkb2N9y8hN26ofWOAgaT+4ObtZhpWIXBWoFeof3b9+CwI2yROce9HCKa6fbuqHnr77
	 Rbk7korJkJlZanY5EihMNU2NdGxMocs+0QT3rHJQ=
Received: from github.com (hubbernetes-node-dc367bb.ac4-iad.github.net [10.52.85.55])
	by smtp.github.com (Postfix) with ESMTPA id 9B142A0291
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 11:51:08 -0700 (PDT)
Date: Tue, 18 Aug 2026 11:51:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1147412/1734f8-000000@github.com>
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

  Branch: refs/heads/1147412
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
