Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85C1EF39E
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601650; cv=none; b=rCww6Mp69Syn+2dZk5Wlw41tQ5Oz5flIJrVawwr5JXIlGzSEWy8ZNZXjtSjG7GSt6fSwjvG5M53NzDfWe5Lo3OrfhGfroRSEajwcbKkoQk+kTjL59S8WZwK7DAw4AnGOHiocbbX8MtNqs+LgcZ+X5dloWgYM5t2bu3qcFWArwcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601650; c=relaxed/simple;
	bh=rGao1sfH54MuoZXjFuIZBndHzcbFm43UJsbv7Ks6OVw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nRpdw51gcLFOe3jfPOMK9tRQgwm+0nk9CYivRhopct+CBZDCnFaP4DIH/SSdohi18FaBa6CpxJuCzjVTbFaYTNJO+reQCQBoffEAZcSc0XJSXNRjLw5FqioXsZoJzotw0dExbsI64BAM79UHUT7CUOzeCnVAF6vfwqSN8lHR8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dbnH8H19; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dbnH8H19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780601649;
	bh=ZF5BoHWbENysXdUcuDo79jX53uY4VIg9tiOIUjpAGPY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dbnH8H19zVgeScCPYcH/lHOEl21FyKpgPCDCSZADPo1wAvRh9pS4TX3ZwRCsnS/Zq
	 p+B259DhmwCuQJkt3V9TyOwt7HvVqLj3AnO/2VmzGIkNgGEJTrSRAsUCkABlEpKZdG
	 CJ9YfDzaXXk2+BESPKiMjzccJkiJ360TPpfeAt90=
Received: from github.com (hubbernetes-node-b758b4a.ash1-iad.github.net [10.56.149.32])
	by smtp.github.com (Postfix) with ESMTPA id 1DB88521242
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 12:34:09 -0700 (PDT)
Date: Thu, 04 Jun 2026 12:34:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1106123/ffc843-000000@github.com>
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

  Branch: refs/heads/1106123
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
