Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3928DF3B
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750357129; cv=none; b=HifuHH33B5FcV7QiH3XiYplF6wbTu2TGcuj11i102rfeHRU96+osU/7+DRZ3FghBj6Q3MP8qxA+Th3OLSU45H8Q4fkbNbGPxz3rNK62RViOtntOHgN/Waj98KYwLyQF32jLOeJgXnfia5JBocQbZju707H7kLEo1bOGKFW8b1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750357129; c=relaxed/simple;
	bh=31HGYkLT/MFZcQ9FkGxGRMa02ntIwPw4OpTfucm7qTQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Qg0LYfpEARCZUfp3/RA51ch0/Qn/b8vEEPmZN8rWNLul6hHnHxq7MIM4ZBogzicLKkWm/KehpPuPgGuq7z1nl015vue/woONFQqKCn2cQzoxXKFT3kDKghSDsDG1Cyo4wzfuIxv8SUD06RpAwmwzE8qPq2THKtuKXG0YZHmydHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=j4AIAZow; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="j4AIAZow"
Received: from github.com (hubbernetes-node-926bc0d.ash1-iad.github.net [10.56.164.50])
	by smtp.github.com (Postfix) with ESMTPA id 1EDA0141216
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750357127;
	bh=M918KX5wnnlY8CaD0yAEda6BiizZtkCltf+xSIXVkoA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j4AIAZow58uI9IxVbnEVGXHHaigsfxlrXfg3ssvN6btNsKEFbv1utnfwHBCTd+deI
	 xal450OjyjCquOI4ZFKw2zxaLMj9dLl47y0yXtJOESzYKWEeEwR5pM2fz5E22BBUMq
	 Ngi+tmZtusnjVKJBnvbPmsNozFQJC5dCPZhRGlP8=
Date: Thu, 19 Jun 2025 11:18:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973550/5f1737-000000@github.com>
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

  Branch: refs/heads/973550
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
