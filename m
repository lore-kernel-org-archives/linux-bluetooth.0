Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8232F872
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767574721; cv=none; b=L0kHb2Nyunadb3BpQFZt47Asl2CCzbbrEEpx29VDAvhBV9UY7/M+nxXuRxHn3LQuWQ7WHlI1AcRLKfcIpsz2OrGYMQdH+TMC5+lwJFiQjuZ78gxJZLp0iOXTMtQT0vlRuuOLovM0fn8hFkle5v0W6lFrqJFM+5pmg3aU3vUR0dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767574721; c=relaxed/simple;
	bh=xw7R8ahRkS2uiNudbfA4qx1EWku+3JKZSJ/sUPAajgU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=grTJDTuLjMis/0X9CEATwacXvT+m+9jxSRufHhiuLeqDlnJV9LmZsuy5F6py6XzHpgEzk9tdOM0Kk8Hc7e6oSlM6+8SxQUhcmFRtVnd6V0GRhQxh/9TzCMsKWUOom5bWdxLz34Mk5zAA9enZFiYDEiHIBSrGi/3gdKBV/bCYiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iuS0brxg; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iuS0brxg"
Received: from github.com (hubbernetes-node-9cd35bb.va3-iad.github.net [10.48.13.84])
	by smtp.github.com (Postfix) with ESMTPA id 9D28A3C10C4
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Jan 2026 16:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767574719;
	bh=digEFuovOWBwHAJKlf2clOjYBXbZuDKP8pSBMgOZZt8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iuS0brxgK2zYVpanxEdmr3TnOBfTu6bipjqw7WKD4CKWzBZ8Xj/a52mYQM1v0yqzV
	 RHq/6Ucz4SWBNFG9/DbCG4UgkUj9Vvr/Ygb7qmOVyp//uUYRBdjUem4EaD4axqXz5y
	 XX+FW58dXoB7gjmBPiH9Dc8ASaC0V36XDaWMhnkw=
Date: Sun, 04 Jan 2026 16:58:39 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031011/b4e372-000000@github.com>
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

  Branch: refs/heads/1031011
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
