Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60BE2BB04
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653436; cv=none; b=qToYqffDi9ioskUq+vueExWmav0x9PgQwLw5Vqp4LgRLw+eY/XW2mfko76ZXE+cM8WDi39m2U8t4kr4eCuT+z//0QSxF+/wRep7d1DFTOwwfbcYVFCCLAasWMaxN111Fvsa+Y0Yy9CQj6EUjYTfC5HL2OjuAzMLblzyxKfGDXic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653436; c=relaxed/simple;
	bh=W+9oHHJOPTQIeYoUJx67XT/Pezl+jUoEcHKiA96tdWs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qJTe5t5ERyfxR3YEnrpGetB1nqBJMj85xFZmEHLC59Wb62gjt/rOPoo31CzE6T5Yk/DNuNbE5VDQMMxgl7yd9OOECsxc3EhOOla0sp9UdUpZ7FAFWGBYztE8rSyteHO9HoYwW1ClvJHxzfa3ohlrfl+W4lxpZIkw7C8uTVTeqxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=exJsZ7F/; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="exJsZ7F/"
Received: from github.com (hubbernetes-node-7e508d7.ash1-iad.github.net [10.56.224.74])
	by smtp.github.com (Postfix) with ESMTPA id C9186921271
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749653433;
	bh=qzOpFgnZhxjG+UYbpeJiiFBpJ7CJol6dMHqzZi4CK/Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=exJsZ7F/FTvKgOiae2h0kCGIWCZHwACUHHS8DZf4tZInIH3Kzq1TEN1qKCsY86YzU
	 qVI+5Cc3YaluiCzsl2H3ucHFuibPUCuXLK4QQ2uPJgjIyWGpi7DVvsGNNH37WX+S8H
	 Em6TO4Lm7DuplJmRgeHfDpZa4eO3L8cW2Gqh2xEg=
Date: Wed, 11 Jun 2025 07:50:33 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970839/60476c-000000@github.com>
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

  Branch: refs/heads/970839
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
