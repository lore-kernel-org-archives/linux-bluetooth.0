Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75442400DF5
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374382; cv=none; b=Q+smAuVoVAw4uf+FqWpHYKcAL6VrfPKrfBuKmqabsTzA3998DANyw3oB0XLH08shH3sGPVdTtdLXrrLYxQDJcjGQw6T7Bh+3l2l4IhbX57ibK66+wnbk8U+xWefIx7pGgQi/nlb6wB6nIuhFVAbES9n7QeB5Lz9+vGdgYoUQVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374382; c=relaxed/simple;
	bh=gtzqZWqT1cKCvK+qq8J1L+OIWL7m2Fl5zSNNUbS+Bms=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bHgm57Pi/QlcBqs28EAxupjNODJV/TBJLHvFSEL6CFe3WiFoCaIYSS1lpp+S6iiKRMJccIYKnelprEeug6f3W8X7atMHsCN9TKuEs1p7PiCYcbNozcDijis7tHmHbcYTnSAffVjtbr27WlPKIoBhvscztghw7u+3ItNn9JHstqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kX1v9XkO; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kX1v9XkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779374380;
	bh=p784gbcv//MSrx92/cDRglS+zspVQqmbCuDi+OWg6F4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kX1v9XkOhrx0WdHcktxikzUuvcz5YAc8qWEAJc4wUr7yIdG1cD0U3J+F2QWflrwfU
	 wFK177BwXogc78Y4wBDVoj5kSKJKrz3UbDHAQYTQNNsp33yQ91wRX9M5ntLH3+9VZz
	 mfcSaCFD8ziLUleq9TbVj/GAirPsSuWhzP5ATmj0=
Received: from github.com (hubbernetes-node-caab336.va3-iad.github.net [10.48.205.53])
	by smtp.github.com (Postfix) with ESMTPA id A43A75010ED
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 07:39:40 -0700 (PDT)
Date: Thu, 21 May 2026 07:39:40 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1096181/0ea80f-000000@github.com>
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

  Branch: refs/heads/1096181
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
