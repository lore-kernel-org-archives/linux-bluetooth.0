Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7FA24A04A
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620537; cv=none; b=S8ZSPRztjfCX4V3GHf0ZChzHg1pEfagQVQgqyZWtzY5Xc0vyXKwQ2M9hr3ENSd/PxcOfCD6WYTTZL3liNNL0CNrPCFnkjwCH6OcMGTxGy/GmIj6tR+vDulYDSSmwgZWjlmGz8iFX+0luh3oeLe6J/xetAA7CE3KewRKEf32Z2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620537; c=relaxed/simple;
	bh=O0UsfPhBe7xUMQiCHARQ1p6l9tBTF5/ZBAgdxZNfarE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hJ75oPJvwjgB9QfJ1H/NAgyRCEpm0sAwPcHTnWZef21dE7d5OUaBCPY3TpHYJmm7ko9HpSB2k6lRg0FPz8CN496NcHwEQeYgudrWE9qUrJvP3kLskRyBvdhSxqtobQ2+8Ixl7TQao+I0aKNZzCjj/C4LbHC3ZOGt/iqFiFNuyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EioGko9k; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EioGko9k"
Received: from github.com (hubbernetes-node-bbf1066.va3-iad.github.net [10.48.135.36])
	by smtp.github.com (Postfix) with ESMTPA id 81EAFE0C09
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757620535;
	bh=j/MH3w4ons/1zBEIKFDS80AvRIsV2H8IO5qLMEIsMuk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EioGko9karR36i5avPFA7bRVGWFkEBsnDq8MjOFqUo9aMe03bf9LRAneHf55WeF5Y
	 LwqKSn/a03BsVrt9UaQfE6kHDkabu6R+1ChPUBgkijsR8q+jZWqNI+CfKWIr+ragB2
	 BEkddPxC16iHfwL06UL9P9QnKR4118lbvff+vHy4=
Date: Thu, 11 Sep 2025 12:55:35 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1001420/bc59c8-000000@github.com>
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

  Branch: refs/heads/1001420
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
