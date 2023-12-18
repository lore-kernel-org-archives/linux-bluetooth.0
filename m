Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C973465
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Rpp72DC2"
Received: from github.com (hubbernetes-node-db3dc29.va3-iad.github.net [10.48.131.39])
	by smtp.github.com (Postfix) with ESMTPA id 55D0B8C0802
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 13:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1702933952;
	bh=EdnnsM+W9i1JRIRvABO1tLW58WS4S6OxbdjzYIbfklA=;
	h=Date:From:To:Subject:From;
	b=Rpp72DC2TAlr/6RnLhUPuhu2SwxgK/i0/izs/keQKFKlvA9CyEfQQdUaad7qXqtAU
	 Oxr8brYP+9AuAw/noHo0Yc/mohNKyKD2RxiyYxJsziC2hfJeFixgKM+RuLFKTEpCXn
	 H9i6Z2FS2JXbAtnpgYbb+BCETN3J2zCilhrHu2D0=
Date: Mon, 18 Dec 2023 13:12:32 -0800
From: maheshtalewad <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e01208-eb07ec@github.com>
Subject: [bluez/bluez] c89ebb: uuid: Add AICS UUIDs
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: c89ebba80f27e412d5222737c32b2ed81a6fc80c
      https://github.com/bluez/bluez/commit/c89ebba80f27e412d5222737c32b2ed81a6fc80c
  Author: Mahesh Talewad <mahesh.talewad@nxp.com>
  Date:   2023-12-18 (Mon, 18 Dec 2023)

  Changed paths:
    M lib/uuid.h

  Log Message:
  -----------
  uuid: Add AICS UUIDs

This adds AISCS related UUIDs.


  Commit: 172948d0d6f6330baedec6276c32b07b2b8b69da
      https://github.com/bluez/bluez/commit/172948d0d6f6330baedec6276c32b07b2b8b69da
  Author: Mahesh Talewad <mahesh.talewad@nxp.com>
  Date:   2023-12-18 (Mon, 18 Dec 2023)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: Implement AICS service

This implements AICS service as referred in AICS_v1.0.pdf.


  Commit: eb07ec1f6ffb57f41edbedaeb0da9eb1bd11be28
      https://github.com/bluez/bluez/commit/eb07ec1f6ffb57f41edbedaeb0da9eb1bd11be28
  Author: Mahesh Talewad <mahesh.talewad@nxp.com>
  Date:   2023-12-18 (Mon, 18 Dec 2023)

  Changed paths:
    M unit/test-vcp.c

  Log Message:
  -----------
  unit/test-vcp.c: Add AICS unit tests

This implements the following test:

Test Summary
------------
AICS/SR/SGGIT/CHA/BV-01-C                            Passed
AICS/SR/SGGIT/CHA/BV-02-C                            Passed
AICS/SR/SGGIT/CHA/BV-03-C                            Passed
AICS/SR/SGGIT/CHA/BV-04-C                            Passed
AICS/SR/SGGIT/CHA/BV-05-C                            Passed
AICS/SR/SGGIT/CHA/BV-06-C                            Passed
AICS/SR/SGGIT/CP/BI-01-C                             Passed
AICS/SR/SGGIT/CP/BI-02-C                             Passed
AICS/SR/CP/BV-01-C                                   Passed
AICS/SR/SPE/BI-01-C                                  Passed
Total: 10, Passed: 10 (100.0%), Failed: 0, Not Run: 0


Compare: https://github.com/bluez/bluez/compare/e01208dac67f...eb07ec1f6ffb
