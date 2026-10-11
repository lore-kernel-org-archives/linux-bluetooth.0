Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858062809;
	Sun, 11 Oct 2026 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725963; cv=none; b=BqUNSRudr9V2RF+LeIBdTbYxjF14oOsoYDlEwDsBLudPGIlC9i9Llk8ACKCrko4JextShPImivYVQ2K8JQw4OqBT3lpdjaMsfRHT4ytdccVAjY2M1UFBWXlt+JxSS0+0+H+XSP8C4BFJodVPRdK5+rvNq7gTPFXJcRy4LPdz5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725963; c=relaxed/simple;
	bh=70qJxYVOxwE1JwnQlmv9n+jRz+MtxM06nUJGVfLcQL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZen/gfm8v4XW95oB7YQk+cEhm39f42cgbI7s8rZpdr5CC5WiogBpEWpYkAl5KNHiGBxp3e2Dknxa3Q0H5GiU+jdXttDO/MP1DPqpo0aRwNxg5oorI+Wyd4US8HYiZhogRN+Pcx3MH8o3H/edto3z1fVr+STVdzJ4eGgs2aQM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muenchen-mail.de; spf=pass smtp.mailfrom=muenchen-mail.de; dkim=pass (2048-bit key) header.d=muenchen-mail.de header.i=@muenchen-mail.de header.b=0qV+POqP; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=muenchen-mail.de header.i=@muenchen-mail.de header.b="0qV+POqP"
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j2hXB2Yxtz1sRLM;
	Sun, 11 Oct 2026 15:39:06 +0200 (CEST)
DKIM-Signature: a=rsa-sha256; bh=XHaRzrcWnGBBJEk/8UCbSfHdRQxOX7rp7HismjlBhG8=;
        c=relaxed/relaxed; d=muenchen-mail.de;
        h=Date:From:To:Message-ID:Subject;
        s=r1; t=1791725946; v=1;
        b=0qV+POqPPmchVPibyAQ0QllyUA6rfYlJQuHF+sVvTjeFa3E3EQq6Qfypw+RP9zsp
         4WQYNAx6aRFoQMKi0QT8YaO9S9Zus+nzs6PJzyGQotkOjvAcibP5YCeO4UViZbGK
         qYNL37sZiaLJcZHBVPBXAS8/uxUwrrDCAVfcLmmy7aL81GadHgtqu7v+RfcF+QJi
         qYpUkMIzP+kDP3Y6fnmSE3e9orBY06zB0JX285/XsrHL67lJ1OzBPheOj5FkP9KL
         1Zi6guX34V/OuzzKgwPb6rmCIEx9R6aUPI2dLURNAhoc/1+yJjK2kb8vvGB7F5Uo
         mBOmPENc+CshHCHqHjDahQ==
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j2hX80cp0z1sR8b;
	Sun, 11 Oct 2026 15:39:04 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4j2hX80376z1qqlW;
	Sun, 11 Oct 2026 15:39:04 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id E9OEDt-NYzGT; Sun, 11 Oct 2026 15:39:01 +0200 (CEST)
X-Auth-Info: RWtFOPa2WPAAcoNvORZRjrjvz3yyE/RdyuxRfNfJkBn6yqWRhEJ0wED3jO+mdFff
Received: from wiesel.intern (aftr-62-216-206-149.dynamic.mnet-online.de [62.216.206.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sun, 11 Oct 2026 15:39:01 +0200 (CEST)
Received: from murmel.intern (unknown [IPv6:fdea:9b79:8984:1:c2df:628d:efc1:8817])
	by wiesel.intern (Postfix) with ESMTP id 1665179A036C;
	Sun, 11 Oct 2026 15:39:00 +0200 (CEST)
From: Thomas Gerner <thomas.gerner@muenchen-mail.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Thomas Gerner <thomas.gerner@muenchen-mail.de>
Subject: [PATCH 0/2] Enable bluetooth on BeagleV-Ahead
Date: Sun, 11 Oct 2026 15:37:57 +0200
Message-ID: <cover.1791720467.git.thomas.gerner@muenchen-mail.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The single board system BeagleV-Ahead uses a Ampak AP6203BM chip for wifi
and bluetooth. Wifi is already enabled for this board. The bluetooth
module of the chip connects by UART and PCM to the TH1520 SOC. The PCM
interface is currently not used because of missing I2S drivers for the
SOC.

This patch set enables bluetooth.

Thomas Gerner (2):
  riscv: dts: thead: Enable bluetooth on BeagleV-Ahead
  Bluetooth: btbcm: disable read tx power for BeagleV-Ahead

 drivers/bluetooth/btbcm.c                     | 19 +++-
 .../boot/dts/thead/th1520-beaglev-ahead.dts   | 89 +++++++++++++++++++
 2 files changed, 105 insertions(+), 3 deletions(-)

-- 
2.53.0

