Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173B416131
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349627; cv=none; b=jy3DpvzL5ZgslaR7XS3VUmsTXtq7ZYaecGfQN7QiH36U+978OL+xM39ipw6IM+jmgZ5MZ/Ctg0aerL3byfHx6ReS5FFEWIufA44nhugeG+Rg1noHHA9SZ+UYoVL0SDhWb+geqgb6eUbAq/PZ/Q4Cyy48TrwvBDzHktia1OjvewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349627; c=relaxed/simple;
	bh=GUkyk/4FJ+l7g40rHdo7hpp51HEwukBFxiiyIWeaPf0=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=XNV/OVXITdb1CYuHF3mUvoB6/AMtoD7R/BJ2QXr1Xo2Ik+DzqCRGXvBhTj0dxCdSu6Ov2pACBP90uCzvi6f0K/ippK95FHkEmDudVykW8GSfpNeCRRPmrUDEssjpjBBY23sJDzRMrl9gXMFPg2/m06cEOnmDj+H4mElvYq+zXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=OPHaaWS/; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=FQTyH4+p; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="OPHaaWS/";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="FQTyH4+p"
DKIM-Signature: a=rsa-sha256; b=OPHaaWS/h1hJ0iUeP8n30+fHAUp9db2Ut/nSah4+HsvX2bSjsyAmHK1ZjlchIKnq3+29MIgLIk08YMluoB2E59KNLzrJ1Y2adLp7XbJOvMOuvJC921AhN8CAVarGzUkHYdjv7LrmSsl8f4apCGJbYzY5WEmfuq++zmWl4YkMskQ3z+itWE9tdZG3vuV0V4iWRwvwR8Be6yoUb3ebqK7iMEKkl0SlSrvnA3CRgK3k0KzI8D0J1xO3GMwsb2GzVWHPCdIIIMNhLZfYOfDtKmNhfrA8ejoysKVxmx4iddCx6JE9IDqyIiduEZPgDtLJ0u/iQi8PpZGL2XnopXhGtD1V2g==; s=purelymail3; d=rcpassos.me; v=1; bh=GUkyk/4FJ+l7g40rHdo7hpp51HEwukBFxiiyIWeaPf0=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=FQTyH4+plKzkKO3IEcpfytstiws8fLmw1tmp9kkBmVX+9R0BtnlIaH26Uf1z8FqnmdPYIxa5O0UK/6R1TGTz4t2s9DhBZ8UyHdHEiqkbVZcdmZTg8OxYEH4xVfOyVOp90ycOcb3mEmxgv+4Jy5vYYRw2wAPIxnFb4/8Xj/SbbPFLk22GcTtkiLkRqs7Z16P2RSL8yJAv1cU4cZFh2ajJwA85PBlp8kcU35gjt5Kpeyv9QqOR8W3+3jdCwhnCojX1hhI7C5b59LSe/Ngglo5Y4K2U50DSKgUtD3UkYxQBxQph/M7l6oAbyRwd9pTfb8zlJs11Rj21jCGxtCu9EHErhQ==; s=purelymail3; d=purelymail.com; v=1; bh=GUkyk/4FJ+l7g40rHdo7hpp51HEwukBFxiiyIWeaPf0=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-bluetooth@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2012387389;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 14:53:19 +0000 (UTC)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 11:53:17 -0300
Message-Id: <DJRKO72HWZOI.QJYJUAC45QOJ@rcpassos.me>
Subject: Re: [PATCH v2] Bluetooth: Properly disable remote wakeup for
 MT7922/MT7925 on Ryzen platform
Cc: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
 =?utf-8?b?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 =?utf-8?b?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
 =?utf-8?b?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
 <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Rong Zhang" <i@rong.moe>, "Marcel Holtmann" <marcel@holtmann.org>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>, "Matthias Brugger"
 <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0
References: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>
In-Reply-To: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>

I was having issues with Bluetooth on the ASRock B850M with MT7925.
I tested this and other patches in my investigation process.
My issue was a platform bug causing a failure in USB enumeration
before the driver path (unrelated to the patch).

I can confirm this patch does not introduce regressions on this platform.
I tested system power cycling and suspension,
and also BT/Wifi adapter enable/disable.
Patch applied on top of mailine (7.2 rc1).

Tested-by: Rafael Passos <rafael@rcpassos.me>

Thanks,
Rafael Passos
