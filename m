Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61728313E
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590320; cv=none; b=EKI0vTo4qw7a1JEV9ElMC+ES4lnfDlBYwFXXTwa3nsQyO8Ck83hyreHM6Y4Ug4ucEkRcto8g54CHj+j9lwpd1hJNQ4M17Cg//oyCfZL6gDFi38dZQDUumuEsbtliLupDP0vqwg1LISLfu91XsLG/AFiNX8WMum7O+Mgq63OqPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590320; c=relaxed/simple;
	bh=6VqSdzNOot2d0yZeqqUXBCGRY5YhxhI/DJvs/popZ6A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oPkwxPEN5HDZI8q++wcXW90dUx/qX428ZqbR8y1NSX4QpFZ66SnYyl0VF4SV1TQcXjgXfhcjDQfALB1pcKbrbbrBIy4zJXkGwB3014Z0ZX7dpzIgt4KHY0CPI70/abvkdAdVUSJofJ2NbEnh5dGhRiSU9Er6a5v+0fg32vv9ZzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QzU6XS8r; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QzU6XS8r"
Received: from github.com (hubbernetes-node-04a6b15.ash1-iad.github.net [10.56.183.30])
	by smtp.github.com (Postfix) with ESMTPA id 5E319140AA4
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 14:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749590318;
	bh=O5eRYzJ8UHAbzTxgjjnqmbxHf2D81+VZdz3keCkGPWk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QzU6XS8rihgkWtTeOisYcpiKuGkNQbhzHfPs0vpOr2gh9maTPgkZ8B8LZRuLgAH8z
	 Vob15DiDNmXgBz6I6CF6Cj/CT9w69Yeiv00nBDV65qMS4cMY0fMzEblJGwVfkFJn3v
	 JO+bXGUJaLfXIvrN481wadMsUELKsourn7h6yvRg=
Date: Tue, 10 Jun 2025 14:18:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970499/fccec9-000000@github.com>
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

  Branch: refs/heads/970499
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
