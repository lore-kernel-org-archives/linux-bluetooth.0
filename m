Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B9207A32
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767646447; cv=none; b=BGA2vlzuKP1bMLhekaFCYEALaarCMhbRxAkdhBrlJz53CX7fTPUsrY9Mz2wp27DcYb5qcueNUtMPzkELnzUBvBa6K5zcto/7LPwQJSKGJXComH4y62OoEGKBGbnoT2PrnyUCiHKYtvn1deE90ErL3KSdyN8BZVKo08c6zwvEw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767646447; c=relaxed/simple;
	bh=5zrCsic/3ex4LmgRqbmWZ+S+6NLqFrMfmcA5rh+T2Mk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FJAYzRA8mavIkNkpNIHn+bntkBjTT+ykXtmdGyONX0dnHmf9tzRomomyQie0FuHl+5snxBbciME9YarBsiN7hp7PQ4Fc1r/DRAQO9tDtPRnAERRGaMCv1CvmiYH1xFCcw8SeF1AhLX3uacfQP0OyNU4/Ilp4bEA1suieuo3CceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=e6qiwBCP; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="e6qiwBCP"
Received: from github.com (hubbernetes-node-c5b395e.ash1-iad.github.net [10.56.184.39])
	by smtp.github.com (Postfix) with ESMTPA id 0FC68920970
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 12:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767646445;
	bh=ggM0miSndloJFsm5G5Z/rv5n29FnbFcg5rU7V1XHDBw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=e6qiwBCPe42yvySb6iFij2h8FrTrzASkHqCr4htItp42LDdPzTmGq0aaxc6NFL4sU
	 lOe4gz9xEzWAwepS/GcABfxGPrpsbOVewSV2bAZHscKwCDc+jd11oAVwnu1U1Jtzw2
	 KKX5YB0Q38RSUyQXYCVqb/xUK6LYc8S8B3YrJWjw=
Date: Mon, 05 Jan 2026 12:54:05 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1035801/b707db-000000@github.com>
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

  Branch: refs/heads/1035801
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
