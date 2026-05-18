Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0397F38A701
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127473; cv=none; b=ZJfZ0d6TxGaMJLFKtLCvGQJ9Bzh9rXClyrMQig2YJo4DcAGaihxNAjr49CiVUXPawvau3/kcyu1cG9+AFmg4UX7W7jEypRFzm8E7p9Q89emJayOk5Ag+PkGzm3rczb7DyILmExbOIdEGwyehkBi0pWevKxuhIqxfAG/La1XJrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127473; c=relaxed/simple;
	bh=OtzjOe5xlkvxXRxm6VujD4SoIvdnXQ85fTfwiNubo+0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uiyR3pRdt+zADuqsu/T/FFM0rqkgiYjrilwyHXlIiFDxBZbdHGMksHHJtTRtyoiUcBLZWqlKWgdakUjVSAFNarFc1g24TgbFnyp7jm/nQX1KmL/IZdp1IeJBgD+j8hUhgUidNj4vY+fQ2fhMswbJz6lRUljl1AA+Cz9amPOWVGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZavdoJKp; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZavdoJKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779127471;
	bh=8Kuh037FBwz5FDgTcYN7xF/OKL5HghZJvjoH1n33x74=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZavdoJKpRy7gcbguR4Psz5GQ6nQ9WsQkihaJxRRqaDEhkvUZ1ZP5PnxlUFydTFSsA
	 3ktTeSVxP7g5BoU7MHRSr/e9Z3TwnGZFMWNxsbmJwy4v/u67JYzfYh5h/FHh+Q5hfl
	 0v0lDHHzWgrcuo07ht5mEltNTasKykxo/koxSs4A=
Received: from github.com (hubbernetes-node-eb2c624.ash1-iad.github.net [10.56.175.19])
	by smtp.github.com (Postfix) with ESMTPA id 3074760106C
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 11:04:31 -0700 (PDT)
Date: Mon, 18 May 2026 11:04:31 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082814/68f99e-000000@github.com>
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

  Branch: refs/heads/1082814
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
