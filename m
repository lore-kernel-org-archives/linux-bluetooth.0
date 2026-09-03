Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE54C6EF6
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447619; cv=none; b=HFjw3NhbjoaKLP9v8ptY6xo1H3DsgrgCFi/tFkQrBMt7akMz2yLxr9f+D/eEsdVfNlbNiGKw9Lqf+xtjyBuC4i04rZShaJ2v14w0tGXgp851+Im/La6zX6Ndk1B6P5+tELNdce8sV6CAUxK7jRK5qXA1Gpdy25nWnIXNRDbPs8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447619; c=relaxed/simple;
	bh=UNKVzJ1dndOhqLH10XF0VTAjFxbnqGfSlZPt5F6J+CQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IF3ctsv1q1qcIDfQvKBKnbaovy2EtbzrB2ypguYOvuE02Miqa5qTc4MX3hiAnH9HRgHmYYqselJeTweo/gRi6nfzKOnm9/Q6COLpXr3kOiCGPlxmTas+3wh5hyVOb1hp705UvbAs1ZDEgaDioajnDC7cTNBiSWVtzizfHNG1fBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l7zndam4; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l7zndam4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788447617;
	bh=Q5ZHuqKzJchaPvY/4zP0fA+TlwytLM0eapCr0X7ZfDE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l7zndam4L9Pd+aMCEzv2t4NBKg255WtGhvKWFjwvEkX89pS+1T+eE3Pbb37R8k1Az
	 VpZdwoJqh2O1jzAKnsqQ8e2rdDf2A2EoS/1eJq+D2Pg2tDPfg/3TyNMfihTES2UyPr
	 t4vRjk+sBedyoipzbjvAt4auhgJNtiBeMZoCOPJ4=
Received: from github.com (hubbernetes-node-7012fc0.va3-iad.github.net [10.48.183.52])
	by smtp.github.com (Postfix) with ESMTPA id 0ED0478147C
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 08:00:17 -0700 (PDT)
Date: Thu, 03 Sep 2026 08:00:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152198/e561a7-000000@github.com>
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

  Branch: refs/heads/1152198
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
