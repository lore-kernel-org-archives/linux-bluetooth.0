Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC803403EE
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751743; cv=none; b=bJfjtoagno2TuEwuRvgZ0iB0+AtwVIx8JSUCdyc2ERMWvzXL6IhcPkKPtweBG7sodWovuimTR7aCcGskN+mGDzs3eWsTT42fJSc7mQBHZ7tQ+CtSxCUc/WBxCxRP2XdGWlvEFEw8RPTiFrH7659kwez3dpfPNNqS2i+cIUBcDJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751743; c=relaxed/simple;
	bh=OnN2oz8FDZpe1gH+I8ACkDhy+z+bWgMIEE4Ch4ndyQY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BJbKiauro3gYSrVeGXWva/vbYd7qxUOeS0sxbTp1++SDo7079Hae5eEQM+GpcUtD8VisGHLLThJONowuRg0cMPJYL7gp2M6ApRW9mx+E+x3OU26Ni65/gMeKNuurICeRSivI3e7CnuzTp60J0cUsiDZGlsXUrh3bZkX8FcEZZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bWg+7JGL; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bWg+7JGL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782751741;
	bh=ZebRRN4E0gXCZWEHWwf5xqlISxt/DIGhbYInkCRaJis=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bWg+7JGL/AD1sjTqYvhDcNa/YHe5KB7yClbfwSgg086mHwTczlG87mDP7nnLH7Fca
	 g09WVVZ7TkgbO57vJ8tFHWEJ3Tn4WZo+EWfcBt1AdTYmj4QLfO9qqwmUAlBM/n4HUv
	 KXE0QTB6RCp2OfuUJgdcHpMfEsQOvaR3qKh2tClE=
Received: from github.com (hubbernetes-node-ac5b5fd.ash1-iad.github.net [10.56.143.36])
	by smtp.github.com (Postfix) with ESMTPA id BB76918C9AA
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 09:49:01 -0700 (PDT)
Date: Mon, 29 Jun 2026 09:49:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1115551/a0072e-000000@github.com>
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

  Branch: refs/heads/1115551
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
