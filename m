Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669A2356D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211369; cv=none; b=p5Iq+FDMxi8nLoaogm1Kyr09uIYKhlAj9lN4jhHFJDSsWBmA+swzwCJRK2J4V4gFUX6L3Iq7sUfdUnYJ74s+mGedfAv35CLG/yCaLWVmRrldDCmqoPdVeb/btjJO2opCy6f2WFSyhojbktlBKU86KVQPEORrs8k6hAqw6bx4P/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211369; c=relaxed/simple;
	bh=f/z7Av9ENtgdU8saeN+CoSIYpRxNv+NIzM7D7jzu1f8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H/pmwzeFlY6d29IFrd4CQbwclD1+52fL58PUJktao6F0tzi+0QUaN3qiR/elcSwI9VeRaqFS/8L5w9QKWPrOj+4+t4jKMQUbz0X6YebXREhEj9xCmGPSNzVFXeAkCNX5WlHaNkEVhHvFFn0ygOEfSypQjRYXlHKPY0N7ufqTa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ow6A2VlW; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ow6A2VlW"
Received: from github.com (hubbernetes-node-b43dc93.va3-iad.github.net [10.48.141.37])
	by smtp.github.com (Postfix) with ESMTPA id A3092E0C32
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 04:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1742211367;
	bh=Y7K/h4RAOflxip/5o5yPg9o3zUeC6y9w1YRJrYgh8GI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ow6A2VlW5BXZv5ifXwn5xj0xga4Rj5Q7ThwDPRm2ZWglEYqLHE9jY8kqaGgoPoif5
	 yO6STWwN41TjeAMQinusiDZ0S9rCh5jsRivAOmxy7/Mltwt/1fW6PEGbw0RmyF0rGF
	 8wQIDXrqHLW9Gr8E0koSloZ/XpWVgYYjAR8cGeOI=
Date: Mon, 17 Mar 2025 04:36:07 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.80/000000-26e03b@github.com>
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

  Branch: refs/tags/5.80
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
