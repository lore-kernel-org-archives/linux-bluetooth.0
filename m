Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA23469838
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593917; cv=none; b=Uu5v6V8C3ruDNAvHcScqjNIP18TrFKsPKRuWp/t7JzS6vPpE3JNDmLesGYnqVLDyOpongWOD4EssQ4NlLJYOx8tiIWuZJ09zvnmQvSrpFJvVyUU6g2LZQYjkanVMpNDa0dHjqOO9mpOtumMw8c7TKu8jxvGoUyuMPBxdUX5l9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593917; c=relaxed/simple;
	bh=7dTfWszPSHZDcSzxI3BbF99VG86wbvC91aSHK22XB2I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=f+3OG7uj3eZQZbd4wEr+3UXTg627esmGeNBHlr/UBkFLuqjd5g4xLDU69wIauzEw///LQ2ypxmMFZspUoXqKybKuNqZIRxwgeJg603aGxsd6A9HFwb8fIwqa0DLjEkWNYCPJc05rFmTTrw6JRvvxkOIMq9qWEkcq2vj6ImuaS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZDtGfkWR; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZDtGfkWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789593892;
	bh=qtnKZilTgbXz0MSsBYjDFtpW5v2CgTAQtybv2PhZqsg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZDtGfkWR6YSSjDuA7yfAyvC1TcX+CCcKyUTFR0qXOjjALxyQxE2QymEr9ucmPKoCZ
	 EHtgaRGUNXAoNoA1QwvU5axcOrI87qHiJqnS2foPplFwcYIp8Zte7a1jgOzDO7/W+E
	 P4z33oWPya4CKARiOuKw3JLWjJviUX4Nf9D/KgMc=
Received: from github.com (hubbernetes-node-7ad03ad.ash1-iad.github.net [10.56.81.27])
	by smtp.github.com (Postfix) with ESMTPA id 75FEB36085B
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 14:24:52 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:24:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1165941/ccee9e-000000@github.com>
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

  Branch: refs/heads/1165941
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
