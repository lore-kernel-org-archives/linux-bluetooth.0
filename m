Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0343F077F
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075847; cv=none; b=iGB3xYRYtk80Qgsv5N3tcqUL7HIzrsenZJJUNL8M8dD3SS/v+6vFq9kaPjlO1iW/EWBeWOi35kWUTXJhLkFMqZnxSESaOkulCECk89xYAc08j41fomLBS/wDpFh0J8KVxo1j07twAQNty9gmrLoO0RKYnYLUPwjctpUHMhIUPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075847; c=relaxed/simple;
	bh=r6xtn8mUnEXJ2Oy9pMwHT6pQgC5gx8OOd5Ae97dXOcQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=u5qPV9l4MdXgd2uKLlFKpWGzimHY//+uLm0aEE6W4zAbdKTAqTzcfrrbEW9AXSiOxQppfkTwwl/qBvmCvNK0OdsMY1/hmDUGoLuDXajZltpU3aWyY2IJNG20Ejs1kDskLfI8A9cUwbb1f27FYIcydjXm1IWb7NDoaE4Q1pc8v4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gV6Stnl5; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gV6Stnl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778075845;
	bh=IW1O7uXED69S2c24bckuP01UjyZskPt1Fs63Ys4UTA8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gV6Stnl5EOq+6dVbkogQC9DcAhyRhOhPVbIzb+TVyq8CyFMSqxWlQVWiY4RXb4AiV
	 Luqo87KRhB5Speh6GJJebGb70aFp2tjVss2ouQgTYO0kyKsTNWoNX02uLPcwiBzmcM
	 NRkGp4PCJZ+VXDKc5H08KTqIz3tef6cMtumq08i0=
Received: from github.com (hubbernetes-node-4d31d62.va3-iad.github.net [10.48.204.50])
	by smtp.github.com (Postfix) with ESMTPA id 25133800A4A
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 06:57:25 -0700 (PDT)
Date: Wed, 06 May 2026 06:57:25 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090123/5125b3-000000@github.com>
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

  Branch: refs/heads/1090123
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
