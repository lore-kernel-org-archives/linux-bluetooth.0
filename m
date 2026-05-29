Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16172338906
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062222; cv=none; b=toqQcb+qT05ha4REsYv9Sj/y57Bxup2jkYpcqDjtx5Tr8L7HD7/631SyEWBuUmjrgxd9to5OpkUkTaiH+gqbykr0xiPoT05MV7gWN6XF25DjlBM7T9U4wdo7SnbwPN07TjGqH9WTpmSgJ8rovbZxaAzChI+zC4Ivpg8xDZMrinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062222; c=relaxed/simple;
	bh=BGK072g3b4OPcHMzLPmWdGEE1jACAz5Luen3ivkgf1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ku9w6giqi9YIByD32zRL053YkT5cvp5QxZzjXakS2XaOUQwm3bd3PZe4nHkiYA8Qbo3llJAC5NhYnBHPrlLO7cHIHGuVHqcUry5oQbR1bf14VLp1B745xNbPFCF9Tdxcz5TZ3j4xAuUPkBGyvIE2eEfS+QvhOPENr/6kSlEGw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=nils.helmig@web.de header.b=hD5Lfa/z; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=nils.helmig@web.de header.b="hD5Lfa/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780062217; x=1780667017; i=nils.helmig@web.de;
	bh=BGK072g3b4OPcHMzLPmWdGEE1jACAz5Luen3ivkgf1w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hD5Lfa/zI5MvUtF80b5CvNvMVklDjQcETPmImTjpMRQos71qPeVhGNUSTRphyRed
	 kQqPjsQ2fx13Fc73zTBKM9dFx4FqmVDAp/Zn+8RY/UL36G8MtbMn9L1M1vUBkuulw
	 eiKwpDrDZRkRqrqWXJMZixIg9OpZOSor9LI6o+JurCyiYq/JedWgdOwdN7RwlXBFL
	 e7prsHV0wjAJ6S1MtvcSC0PvsJfrIA/QiyrV0j6PXGFjO2dfK7dgVYKB8hEOhWhVL
	 URe3OMMXmKo+d3LGrpwA/u6UErWpccnNo3zv0RG+BYvMKwFcCraiYzEq0gYGTAi9X
	 V2/W4/lVOw1mg/K63g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmyr7-1xCDjj45JP-00jI4E; Fri, 29
 May 2026 15:38:25 +0200
From: Nils Helmig <nils.helmig@web.de>
To: bluez.test.bot@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	nils.helmig@web.de
Subject: RE: [v2] Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV
Date: Fri, 29 May 2026 15:38:24 +0200
Message-ID: <20260529133824.5835-1-nils.helmig@web.de>
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
X-Provags-ID: V03:K1:e0t3b5iTjrDmw7HIcJRBFIaKr3Kc3we6kIDyipMSmsFVlN3yPQt
 ee0dadQ6y/beHT5v/ARt38sqsDeoU9Mo8Q+siLX+qzR51Mfk58Tqu8GwhDXfeteBEsiUFH2
 d/GsPw+WG3Rif+ie9KHbYkuXwbQwiPKUGFbHdM+sPabKl7sAHbpUcWRE5QHckv0fztuvgnF
 Ay3L9ru8IYD962+SBY6LA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KJE4R4qMn9c=;53BvGBs8f69JFJbLnVaRjfaQwY5
 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
 h9bYWXYdC9L6spgYHb6D1h8WLZK0eay0g==

I saw that the merge request https://github.com/bluez/bluetooth-next/pull/127 is closed. Any news on this patch? Is there anything I should do?

Regards,
Nils Helmig
