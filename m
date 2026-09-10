Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10F3C09F9
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065869; cv=none; b=rFftILcBdRNzlNmY/ubgK9nXb6/Zk1pLGxqWFEacZ84qdVETr+SGmHTNJsnlYhEpxBd8Pk+qE2VH0nSZeKwRMqWQL87p/xkWUzVipN9cG6lVjc9OyW010oUVCtAG9YmiTyAmIK3FSsNxU8OlXmGHPtpv5ikN+r35YNYNVmeeVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065869; c=relaxed/simple;
	bh=FuEPbJ8LybSSAKz4CzrjZfat6p8ubfrD4K75nEsxt9I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nolF+LGlij2gEzTP8TnEnHtsZ6U11HtlKGkUw/6seZ2PVu8um8kijG4aAjt9tJDU3yIc6QKfIhP0XVgFv9VxuNGbzjtVdcpKLlVpi3NEEkjaUsLKfLx0L15AJSU45fTx9/mPdcL++mot4aszKc433hfsracu+f2QLK8QzCc5gN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=nC5eSyb8; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="nC5eSyb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789065866;
	bh=URpv6EEuYGA7PcnIF3kRN4ZKnrX+xk/v1SYLNAW7zts=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nC5eSyb8r5/LxHVVo0FkHTsnR2DBIkQmPnHh+v2eIrXoyYEjN7N1NuSrcIaM4UgfC
	 SJl6cBl3M2xvFGrob1pnFCRIhaBbHFIwKtgE7TQrD21njNrMrK0G+9lb+q9ul5pnH1
	 7hyBUpG66Irnku0K0BOp4tVQpZqQgm+Ol8yAGT70=
Received: from github.com (hubbernetes-node-59ae671.ac4-iad.github.net [10.52.138.39])
	by smtp.github.com (Postfix) with ESMTPA id E4E3374085B
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:44:26 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:44:26 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1157193/dd7a28-000000@github.com>
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

  Branch: refs/heads/1157193
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
