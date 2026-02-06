Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23959279DB6
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Feb 2026 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368754; cv=none; b=KyJ85HQNGG7sI+Jf3d2mF3WnQw0wdBvCZ9uBZ4gx8YYabX6IJyaIdk5yp6Yn6ov6S/UDg+VPGC2yKzBpAHsBo3eNt4JBkhLgK44B2TsLxdbhIKuIHNM78XwBdXo0/2DpAHJwB63XAjs+Uas3tqQj7xVrbGRgUDTBYf6fSdoa8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368754; c=relaxed/simple;
	bh=E+QbVJF7IWJ7Wd2u3EGeHkclrwe56wizSI/4wkREck8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XU0ijG4bvPgt2ZO6enPML/EfQrLgYhjOGL7tyVHHAJrBE7vukvtPgAvrrUggINPO6wWcRCWiZOeQlJiEn6yhIDjryssF0kYLQxS4STBrUNrih8MYUC1XpUGukWv5B4/KBoRr0jTZgCIWXVCn6ai6ecILx5xmYUWxw8isrbXlDxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=g6Cyk9Xm; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="g6Cyk9Xm"
Received: from github.com (hubbernetes-node-d35ecd1.ash1-iad.github.net [10.56.153.29])
	by smtp.github.com (Postfix) with ESMTPA id 4CE8914125B
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Feb 2026 01:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770368753;
	bh=TgUjtu0EAeROfkREZcw/9vW03ZakXeSHqchLB4qhdmQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=g6Cyk9Xmoqi6Ob/Gy19sJxSkp3Vx2sGxwpsVlUVdljZzYDLdoJpPzK24kzMGhiSQq
	 6onf8GmFXRExzH9mFtf7RrRqbejBBiz7nBiLrtvpIKAJFroz0iRFiEHh+fFpBmNHXj
	 uFgKZcftqFOdKU98saP5XmHN7oqoBUzYLvuowGSE=
Date: Fri, 06 Feb 2026 01:05:53 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1039291/31b82c-000000@github.com>
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

  Branch: refs/heads/1039291
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
