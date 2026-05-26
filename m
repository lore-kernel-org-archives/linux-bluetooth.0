Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64C537702A
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822216; cv=none; b=JZoUqUrUxSv976iL0e8YY/yeDccT2DZnwXEZzJXrKGX7QdbsFTVDbWt9kLsZuafojDAf7StA4+9eC/HN+Y8CddVuO3w0VceefQ2KohJd9nFSMBrq7CApuUIq7EVJSnmxYLEDU8ZGzO0FyczDsj/VcdJqn+1IgnWuzJ9SEyDayzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822216; c=relaxed/simple;
	bh=xPH2YOTkTCxfT4iz0W+VOKRckU0swvCdzZz0ye2y5xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXrXD4lInjAfcH0/mNt58YuYqVusSk8BZStA5nqsk9d3JcnMZhzyaZpzHeZb39XfXStR1+s7FMNx3xQKbBeigU6d64Wg3bduE6PlEVZCny4ntazEWDYAL6sTDuztdkK4i8lPDvEtc44enL5itxyeQIcUu2jLxtRmfUEHUaKu3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=nils.helmig@web.de header.b=ghPOisFd; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=nils.helmig@web.de header.b="ghPOisFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779822206; x=1780427006; i=nils.helmig@web.de;
	bh=xPH2YOTkTCxfT4iz0W+VOKRckU0swvCdzZz0ye2y5xY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ghPOisFdv4OQhkCbwJ580i2GSPaI117mu5i0wk779bm9bwVmnA+suhW9Hjc4ie6H
	 DGCuPI669+OP71Gl5bvvOIpQmfVCX+xCfv3HeS7eAGeUfo1a2AJRUd2BMBIUwzP28
	 nehbvVv+Tl1Y03WzCDP6Fn+Mhn5FEY1YJo6Yr5RUFPa1zpxmYXuVkt7L8rJKtUCXg
	 12he1kU9IzGnIWjEZSX5K6t62WVVh6k/o93e9apYHqmS52J79xv5jjEuQXdVN2dkz
	 ThIkK0BwFnwDCl6P2JqjHTAyiZ12JaRMydwK7QquQCKyPJH6P92E0MNxbVYdn77rk
	 BCdPeDPuW3e65sW5vQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPaIK-1wfe9f44p8-00MLck; Tue, 26
 May 2026 21:03:26 +0200
From: Nils Helmig <nils.helmig@web.de>
To: bluez.test.bot@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	nils.helmig@web.de
Subject: RE: [v2] Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV
Date: Tue, 26 May 2026 21:03:23 +0200
Message-ID: <20260526190323.5930-1-nils.helmig@web.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <69ed185e.050a0220.107d78.67fa@mx.google.com>
References: <69ed185e.050a0220.107d78.67fa@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZlIgM22HJ0Rq5lBE24sCLvt3VRvzXkeEVBdyseP3boj4pTS3ZD5
 i2UvTkotJSZy3gXlWCOXxAojMNAml0/KjNd6Os/vOfxk02N9FN1cWJH5wNdLFZozZJgJ3ui
 Fw6lHtpNl6DjyHcdgNrWGyfS5rQAgCkgCQluFNUtQuxGiqBicqlDs7V68UMF8wlvK6DqJog
 /VPmZmolsEv2YX0jXMAUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pk+tU/plWJY=;A0v+j2+rMR1U9U9fj63RgzDXLhc
 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
 MWXWaiSZ1f4edXBU6GSFqDew==

From: nils.helmig@web.de

I saw that the merge request https://github.com/bluez/bluetooth-next/pull/127 is closed. Any news on this patch? Is there something I should do?

Regards,
Nils Helmig
