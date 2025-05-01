Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB222618F
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118729; cv=none; b=dxCEPjJTo6e/ODAWJd6Vb3Xa29WdzzlHPxaxEG31tFCWN57zf8DZ79KcEzw2f8HegF2UHPwVff92CM4xCkzfszLjphXZI9y3wdPijMhbFdNTn/y8+gCWBkKGCj7kcNWSi/CVyA3cTTIOota3Esnph5oBpMvNvCE5b4KS/3TdsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118729; c=relaxed/simple;
	bh=4H5rfpXxQEhoI+4zgqdu9qd4MD6CJ040Xs211WSRhhY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ovpY4Rjxz69RAWipEGdOupQzaEQaEGcbQEZJ9AjBIZuiALlKIu6uyA3kiGA/lHHDs+4bf+9JMq/0s1PYo890tiGjHtWS1h+WKVwftIkKBdwy3oXCbaAiZ4Fdhm9f2E00/MV4S09iZGA0u056wNbN3LmWl5vTWIwoKBRdJ6CsKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gQrFcmp6; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gQrFcmp6"
Received: from github.com (hubbernetes-node-2a8fc77.ash1-iad.github.net [10.56.161.63])
	by smtp.github.com (Postfix) with ESMTPA id CE89A9211FF
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746118726;
	bh=UgcKfZZEsuxi384oepgG5jTCZd/s7d7Xz9m5f0GAuA8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gQrFcmp6zbQ/6/YtB1P96eOYYS28Uo2dT/O+ET+85LlyWIZKDAYKOfOMqWIfku/ri
	 I9U2LUBMhUCyvY0aIohQiTRH+3UxnomUBUUW7W3GMF/7wyKBZtt5wyQSX2dTJzNXA/
	 pa9X7aHZPths810p8rFTiaKrg0wtDyxI3TaK3jJk=
Date: Thu, 01 May 2025 09:58:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958549/37aeb6-000000@github.com>
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

  Branch: refs/heads/958549
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
