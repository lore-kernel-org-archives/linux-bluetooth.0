Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6498239E9A
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424154; cv=none; b=ZhEmvEf2QoBRC+LDn/pxvLXpVmua/rrwe/puT5jGqGlkQYlXSjt5HbZkrGaLZz1sRxddgoazDcCpTJfWPISWEaurA+KRkQvS7Qw3VXpBY89XLLaZk0/QWykWK15z7sYdW1dbHPlzdGVM8ULzPRLwuCoBZmjRYttFNiXRMl8ywkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424154; c=relaxed/simple;
	bh=mQeU9H07SKGIk15FFoOvQ6CZDpdJ7HAoLr6b7ifnNls=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tv2ulIim6hYCmdBxkjUYTrPoPQ1zMuINI05OVrvGuCET/ofIoJEnG3UFJaUGMxrrl/TlTd7BtzMJwpUeF944JL8nKrKDrwq4SNEfK7zHwzWl/e1IXSpJXVf1hs2ixtJxmoAERYo/QoHCM4O2ebasSaHK8469qpM3R9wcDFAHHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BvZvq1Xm; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BvZvq1Xm"
Received: from github.com (hubbernetes-node-b699d9b.ac4-iad.github.net [10.52.208.19])
	by smtp.github.com (Postfix) with ESMTPA id E6FB5640FF7
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759424151;
	bh=+6PEvlR7mZJCyQEnlAaAF42ODyCsit8a+k83/F6g3/Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BvZvq1Xmwr5XLWIhiWyyjYK7iIIffOs7dvDg1vT3aLlqfP2/x9BAWk0LcDqPZsUQb
	 lFmFoRDav951AumdPYykAR50fIcQaOOwg/PjZmwjK9G7f4TahvrgsC1pHh2hlhJYB9
	 mluYYuklyoOp/KGeTLQBMpYmPBZhei98+wNCDZzo=
Date: Thu, 02 Oct 2025 09:55:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1007799/a9f981-000000@github.com>
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

  Branch: refs/heads/1007799
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
