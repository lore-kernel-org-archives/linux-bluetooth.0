Received: from out-37.smtp.github.com (out-37.smtp.github.com [192.30.252.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAC22ACFA
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970694; cv=none; b=mCJgLvoO2MqX3xizIrsPbw9z778zBGNri2dpVkJcgeLjjzYlcOWgD+3oiIt8L+tjtIh9n8fpRVIHTMJmowt8/qyXuU6mPNGumIoSw+VDNhnYWOZoxsd4g64E/QQNtpZE32+hjEbIFs5prvmYdBe1sfTHsO1zEpzlTv/ZbZrihCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970694; c=relaxed/simple;
	bh=0FwUkpa8lxrkAgvq742h/0o4oOuS7j4gqFVzbOIB2oI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AE7u857w8XioAgOeR2zD8c9R2S5ddgK+KGolvDuKOM2U5ThkVx22SpnMTXHkiMEG2IndTQ8KS0ghNFWBM8XvCVP1HetWcpB3D5CVmjQ8zqjQDfzzg0aWDenYHG0sSURPkyiAos0g+b2TIMVNeBfdfCBSsao4oPgFiuqUqqgiflM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HkTIk7Js; arc=none smtp.client-ip=192.30.252.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HkTIk7Js"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782970692;
	bh=TxPZxgoo5/SCmcoYs/X9X0pFbKs7kP2lrdtSi+ueJfo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HkTIk7JsRsjMa56hg4ryAeJSfyGgFW5/1DNS1DLy9uD9PHZOG3zseBpryZ46vtm/n
	 TPhjMXI11oUf1dv0Q5sst7S32ZKLoQiikML2Bky3zvQNV+PgZ+f1tEP/U7z2Ua0bIy
	 2GSRwzVWQ5B4hi+V8Q/h8K7Q/6ikLjitwv3TNp9k=
Received: from github.com (hubbernetes-node-5d8cf9f.ash1-iad.github.net [10.56.202.60])
	by smtp.github.com (Postfix) with ESMTPA id 57633921224
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 22:38:12 -0700 (PDT)
Date: Wed, 01 Jul 2026 22:38:12 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1104327/1b39ef-000000@github.com>
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

  Branch: refs/heads/1104327
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
