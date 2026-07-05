Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06521E98E3;
	Sun,  5 Jul 2026 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783244514; cv=none; b=J2ga7Gn9X3Zu2ExDAlCs11be6RPT5DuPinl5+vZHy0VZk03LqeOoxoPDNW+rCu6AccuI5CTREEuhI2XB1F9Sy9jq6T+qYcYq/FYrmJHfT9aG4sEp3pRD0P8gIpUYWh3pM61FZEOLlZLe70r0mFsipwXYxCcKT+2ZJRkArVNszqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783244514; c=relaxed/simple;
	bh=o3PMuQUuU13l6fMz1haB1pi/YwgPoQPgYhVcQoaDZ1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeofwGt3iYSsP77cSMkexzHvY+jtmG16qMHTW4txi3X+8wX2tQ0TVodpnOyItonJtqibUsP5k7nDtQ1qQLT/E+eJteeAS8E2YjVc5AM+s4BUShFFHE0awtj4pVVp055YrJDqjKQxpXIcwaZw2o8ogw9++IVEHCLQ+z7nILyIK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=cito@online.de header.b=A1/iey2u; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=cito@online.de header.b="A1/iey2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1783244511; x=1783849311; i=cito@online.de;
	bh=YHuloi6q1OTIJYzLPEIVpABKRpjLGu7Z/vzt/jDfr88=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A1/iey2uTj+T/mcE0lCmZtgxOpDzzjGVeLKfBwNHQbVupfIxfGS1649SHvqzl+kB
	 kkU2o5gy+aKxCJ6nV/YYTyt0ZRKSMFoWON+lVWT7yDACCzShvqk9f991ApdQ1WM2S
	 UAM1J/VF29Gaqikum00cXv99Ffv/D/OR93N/CrD9WUpQ7V0NfTYWM4CRe7+CR7Iog
	 jh7BvkvKtwsWlET3pf3XMymWuxuXh4XnK4JCqFRA4U+n6eZMWurlIlOSr+VzmrF3O
	 OEhIAwROdcC3lOBVgBSWmz4UqL3MT54NflN3m+sA1fOEfyWDtlVq1NAMoeo7AEWdu
	 /A04zux0ZB/ovCNVjg==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Md6V1-1xFMf13mvD-00hyWe; Sun, 05
 Jul 2026 11:29:01 +0200
From: cito@online.de
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Christoph Zwerschke <cito@online.de>
Subject: [PATCH v2 0/2] Bluetooth: btusb: Add ASUS USB-BT540 and USB-BT600 for Realtek 8761CU
Date: Sun,  5 Jul 2026 11:28:55 +0200
Message-ID: <20260705092857.27050-1-cito@online.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704231312.340274-1-cito@online.de>
References: <20260704231312.340274-1-cito@online.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ydi8+VgAdmTB3KODhqDNPAa2/iHefYeiv9Tav/MjEmPiMmceslb
 tPsUzB8ni6EPYYogLRbnc5zObvlyMqD0p1UX2DxMnufMNbr02ez3duJ2GLnE3M2wF8oHOpB
 xnBPJHLupWHZuU+SUdNndUK7JFvnAOa/0eiyvlKSkntbK/ag5oJ00jX7Z5qeQtIRG9DFLej
 e/3nAF5Xl/zc/WpDWDiUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9eyHHvs7QEI=;IcSTX1bq3N3n6bDKllGwe8fUHKK
 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
 NsT0yfGw==

From: Christoph Zwerschke <cito@online.de>

Dear Paul,

thank you for reviewing.

As you recommended, the change is now split into one patch per adapter.

Patch 1 introduces the new "Realtek 8761CU" section (the header comment pl=
us
the USB-BT540 entry), patch 2 adds the USB-BT600 entry to that section.

Changes in v2:
 - Split the single patch into one patch per adapter, as recommended by
   Paul Menzel.

Christoph Zwerschke (2):
  Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU
  Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU

 drivers/bluetooth/btusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

=2D-=20
2.55.0

