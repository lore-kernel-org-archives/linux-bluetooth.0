Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B302857E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389672; cv=none; b=NE087g03Zb//buWzeaWTxkD0/m3JduAt0FciecrwE8fB9kAGYzMblmcsI156KO4GY3z4Q70kcEn+8Z46o/Equa9tRTJ69wxzQIIXg8J73675pnN8HNWNbPVVQYCdSJk5LicveBwy/X3kyI03keONdCPDT6f2AdjYPj41NPFr4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389672; c=relaxed/simple;
	bh=IgBAdlaoxXYzF156nEjHBOMZnKn5QinA+oFoEwIlrc0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tsCfKZ3jU4JTP0jCqhF6d9VT4qG+IhB7XkaaQ0EEXMEY8ivTejt1AsVvQ0ugFju1M2OwsHWoWXVKnsK1jVFtsmkowjBy+2tvKuFZachk5ldVBfyr8We5z70GFF8rtGx79wqPVUf8vNAOV1gltVqzbzVevnBGSo9uOzpE8KA4Akw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X5utMdlE; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X5utMdlE"
Received: from github.com (hubbernetes-node-2ab4973.ash1-iad.github.net [10.56.181.31])
	by smtp.github.com (Postfix) with ESMTPA id 7E1706011FA
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 13:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753389670;
	bh=UWpq+/v3KPEOPM1OgQmCLI+5RTJ6KPBmfOzSlSjAu/w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X5utMdlEumeQYtTY08GySqAyq+nW6VmgmfOugyxvYVjUf4tRvsZ9TcXEGaHzrVSIF
	 SHujs7vYaf6rPsICowqxMOHqawXPMZwg8/4+WfEGEAhl9R0oQV5630xrAS9EeXyQOD
	 4n18J4debtW760As0e2CxTN/BeMuLjgT5zLiAceo=
Date: Thu, 24 Jul 2025 13:41:10 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/983945/3d97ba-000000@github.com>
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

  Branch: refs/heads/983945
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
