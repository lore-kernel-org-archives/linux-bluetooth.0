Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973EF3CB54F;
	Thu, 20 Aug 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217570; cv=none; b=dzqwBCkoQfAX7WavRj/sv2uLhc/iE8jwyV7WNK1/ekxzIl7NmMxKAqEPIWNdZdrQ5yiAKEY/tDv4WGDyFom3rtJ4gfB1xUON3+ADzyhwVoUSLjVOEuzK4DOEOQyS2L466btgW0uLIuLqLAuoIiSfmmlItn15tANCxCyncN+/XRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217570; c=relaxed/simple;
	bh=WyBQbLfCNrcMCl0T9SEkXSGR/mbLC8Jntm69FisHEGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uq/fe4HUYJVjYaCCxweAU15Q2/yfpbWwrvlE6DIi/AoO/BI8MuJbakvGDiYnY3TBZha1oj3QEbuWUHt9AMqfY+SEaHsMRsKpLcHsocMOpwiCdEvHyJb0LfgEKIqtINz3mMJuNHaVY87wbrmKTFai5NwWtbZTznYBmpZ7CIUWLkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Os1XRbUe; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Os1XRbUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787217523;
	bh=m9dRFr0gSZMb9PUp2QeGhCguWum2T9Q0APjTwS2HACA=;
	h=From:Subject:Date:Message-Id:MIME-Version:To;
	b=Os1XRbUenstKAkVzG/Pv7j/aJTLWMqbwrXArTsvo+h/lxZFYYQwzPCF72T9ysGuKU
	 4P1bscNnNjMK6hPTxaz2p2LGMNUVunMzq3xDjBnGr4AFGAR/PmmzUT4LTjC+R4ADEg
	 wrqcD+8k0Nh8/C1ITrRdIDJd+k67LGWAtmC3cyHs=
X-QQ-mid: zesmtpgz4t1787217517t5d04bcbe
X-QQ-Originating-IP: kyR/hbJns1UwGf6a48DniBSde62LERlHC2QR8R8tk64=
Received: from [10.10.7.64] ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Aug 2026 17:18:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15561535035589293789
From: ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH 0/3] Bluetooth: btintel_pcie: Fix array bounds of
 device-controlled indices
Date: Thu, 20 Aug 2026 17:17:37 +0800
Message-Id: <20260820-btintel_pcie_bounds_fixes-v1-0-c9dcd1ac8bf6@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADHGhmoC/x3LSwqEMBBF0a1IjTsQ4wfprUgTonnRgiZKSkUQ9
 25weLjciwSJIfQtLko4WHiJGeWnoHF2cYJin01Gm1Z3Rqth47jhb9eRYYdlj15s4BOi6sZ1LoT
 Ko2op/2vCG/Le/+77AY7t/H9rAAAA
X-Change-ID: 20260820-btintel_pcie_bounds_fixes-45a8aff3de36
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Marcel Holtmann <marcel@holtmann.org>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NSXtYWcyD5KOFPlseZotpyuzqXD8UYnvJNk7UyVDo4WHwdaHtFpT8I14
	DIYSelu18PpPdA/sw+nUwC0CXP0EA6t2N+r3Tpl76MHCHo4pOO+xrjPR1hO4UkAlAx2NURH
	mCmp3cmt+MhDfWTBGO+u1mgUsMD4RsHcMz8htJMQB3h5PfVkzm9Vgg1wA283OYtHtjl6j7p
	w3zcJmdY25YqXU7utRgl2KkIJtXpAIfKC8cPGf/NKzrcAnavLLkIJ93s//cLb4HcF3rZ4k3
	CUSAMTvN8LpXXblvBE79MMYWCDageL2YGoe2SiDWv66a9nZoLcFmgZ7qVEV8DD8xjCdxO4A
	VbrAtGqtur4Nr4HqGBVl0IrFzm0SztIcQZuKyAO8kDe45wRVELGrtJsZYA+fOMKoGfuoeZD
	IcCeyTwpMgXWKOJ5R3O6H/jpwvgY1aYIqHf5Kj7cDSjVG3WDu2/v9Hvli5bIKeF+spWf9Ef
	K2Lh+XsLmFFKTBJyHwNt37hh8J381UP4gnFS4hMKK9H0gPDP0OG4kfncAHDlU15oS1tu2/9
	NDKCqikqNuQj54P2z3JUCKQ7JkHRndbAiOQiEI5Lsi1fjNkMx858Wh5xhXS/lq3KWGY/K1S
	SYVnTuH3wRxmd5J4g4DxSPZrn+VZlT5SOVN6ZJvq/1vLiDoJ/buRFlnJkuuPMl3KNMgduCs
	apNp37CaoHQUAMlDhIVNKNCdNl54abCF9N/6kYinCiI5ImW38rU8+QAXwUz70XFrLg7PZgP
	vdMmfHcSYac/jbWsavtpY4J2xl333Pw8jyr19UjDtRDLws8YuThLuxLj2rvkdSmzOvXliuW
	682xEGG1gThrgl8+eHHWVA+lfOsMANQjca6I9+M701CDcc6iXyj44REVmPmTvlrihn9YB2j
	7zPeoO4+9ZPjJIgz/MZcVVZJznsrMaw7ySkBrzZ/PVsYXOcRYvFeUUczbZw2dDX6ilqLPYL
	UF5H4TORGUZmHUg+g3wdEQPDT0pCLMW04DabdIYeoSZ1D97z3pjvtl9q349Vu8tRefUDgpL
	tytU7cCIXz/dapAi7ZnmMNg1sMgj847RZca9DFtw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

This series fixes four array bounds issues in the Intel BT PCIe driver
where device-controlled indices from shared DMA memory are used to
index fixed-size arrays without proper validation.

Link: https://lore.kernel.org/all/1217891c-bf57-4c1a-9963-27400f60a5cd@molgen.mpg.de/

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
ZhaoJinming (3):
      Bluetooth: btintel_pcie: Fix off-by-one bounds checks in synchronous paths
      Bluetooth: btintel_pcie: Fix bounds checks in TX completion handler
      Bluetooth: btintel_pcie: Fix bounds checks in RX completion handler

 drivers/bluetooth/btintel_pcie.c | 78 ++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 11 deletions(-)
---
base-commit: a4ff2be345d0abc943da8dd8da98151843b750dc
change-id: 20260820-btintel_pcie_bounds_fixes-45a8aff3de36

Best regards,
-- 
ZhaoJinming <zhaojinming@uniontech.com>

