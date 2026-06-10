Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8E376465
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119368; cv=none; b=bz2hRn11yGnA9hsVN3kcV6fm7tUwdDRu2vDGYXTdT0yap6DfMLsx1Tyb6owGAErZQJUXJhoYnYCjfJYrQNUbPo0jZFbYTLXXkEMit5kooHKY1G4yGxF/yBgaHiUBtgbG/5Ji+DKosV00dzG6LUhhTjZm6Dk7i77jT5FYKM0ZUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119368; c=relaxed/simple;
	bh=t848LIf7DK19/dAFJE6oPhipIB3kao0MF4qVUdE/EFA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XAJfUwsEilcICr4qluK/P+jDfFhU5FLZiAag+bU1IwxGbqyF40+cde/PcCvRP1nDx4ZjPptec8V1AgxjyHYqGJIgpwLLF4adfsntrz7yldiW+PsRfyfJ0fFmzHIn6BDAy33t+LQH0TIdI+8WiLcjroNnWofJp/YQJDstEpK3E4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a//9th1y; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a//9th1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781119366;
	bh=jzD9DbrAXgR0k70FGi4Mn02ulbx8kTqULa+1gsT1KxE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a//9th1yIqOzB8e//z0EfDw1heiD+dJvTfsVQcWX3lsB+vLvl9Kip466oLNpGqU1T
	 EL+O86+dN5SBE0hA+udn70AvLUAQhL5OPokvFMVHxLiW00sHcgJWHrDLrQ/e+sP4gQ
	 RrjnbWypE0CHHFuTs5E6ICnzknbeGqNzfdMz74hc=
Received: from github.com (hubbernetes-node-e3aac5a.ac4-iad.github.net [10.52.180.48])
	by smtp.github.com (Postfix) with ESMTPA id C3D6BA0536
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 12:22:46 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:22:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108786/3cc2dd-000000@github.com>
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

  Branch: refs/heads/1108786
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
