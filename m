Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F336CE1E
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847172; cv=none; b=gbMa/M1NnTcaABuZjB2LRzyWe0CUfb/mPtH2iaErRuAMmjIEAqycdXoXMwQ6lgmvGqP4MeyRk3dWJtAwwllTZg86tOgcvSuVXZpi4pX76rZV9TRB4Aqa08T8WDoZwszL+TgNJfWN3b0vqDOuKFh7xQeFTzpuUxKCsLptg74Djew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847172; c=relaxed/simple;
	bh=zd18hxjNtWhZSEJqoQq3DD3hd0KhDCHaN1pPvEF2zKY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=duiAcwmk75Pkx2ZPWrMYUM9u7UA1qZAApSIeZLMKmBEBARUhBW9/p8lTw8fKYkNEefATKiHwvNEUn6rs7y1l48alcpo7PSaCywIlk7wuZNonxcXmgd+Z4oEUFbcDep8mvZeOMYK5Xc+aJPCizcoE/PW9wzi0/vsCWbVRx7tqIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hAgvvW/Y; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hAgvvW/Y"
Received: from github.com (hubbernetes-node-8285db3.va3-iad.github.net [10.48.209.59])
	by smtp.github.com (Postfix) with ESMTPA id 3C2893C1178
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761847170;
	bh=la1k8dBeLn+ElmrFcp9dCNTzZJeJH3H9/71+j6qmX7Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hAgvvW/YcQkeXQBVhm4D8dXem9liNZB2UYLSuByOHI4qOSP9L+LpzyfTtfS/BsgGj
	 D36uKVbAAmDrDKHfPiqbYXeE4VlgA1U53T70EBDIgo4yO015094V5FrKx5EdLetXUl
	 oZysy3bUErkgjJI9rHeiZWNCMr1XSgLOtcopjCA4=
Date: Thu, 30 Oct 2025 10:59:30 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1017464/802172-000000@github.com>
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

  Branch: refs/heads/1017464
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
