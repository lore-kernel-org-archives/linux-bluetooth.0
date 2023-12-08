Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EKrPqFYP"
Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826A4198C
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 07:17:59 -0800 (PST)
Received: from github.com (hubbernetes-node-6557e6c.ac4-iad.github.net [10.52.136.14])
	by smtp.github.com (Postfix) with ESMTPA id 7BD3F5E0D17
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 07:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1702048678;
	bh=DkckIt3BIkp+zbrYQRXHZt6Rq+5FWw0bxEt9UZ1aUUU=;
	h=Date:From:To:Subject:From;
	b=EKrPqFYPo71gXHbihMuhQbMmx3HtT3PjbXNsYAr/yQUnE8i+8YtAkH9IoUrx2l2DQ
	 xE0yZzLJYhW9+8bknuqkTqEKXfmE2xUk7AEZFqp9Dmz3dPofFjiPONAosbBRcm6VW6
	 i5B1RXUS0NvpcfUGkWg+7xZ6mv2rQtddXliDr4C4=
Date: Fri, 08 Dec 2023 07:17:58 -0800
From: SebastianForslund <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8980f4-b0656c@github.com>
Subject: [bluez/bluez] 71188e: test-vcp: Fix CCC value endianness
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
  Commit: 71188eb0e752d26fe372fd06c20698aea89e3446
      https://github.com/bluez/bluez/commit/71188eb0e752d26fe372fd06c20698aea89e3446
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-06 (Wed, 06 Dec 2023)

  Changed paths:
    M unit/test-vcp.c

  Log Message:
  -----------
  test-vcp: Fix CCC value endianness

CCC value is 2 octects long so it needs to be converted using
cpu_to_le16 in order to not fail in Big Endian architectures.


  Commit: b0656c2cf14da4b43ee7a446bfa9c5f1d3c044b0
      https://github.com/bluez/bluez/commit/b0656c2cf14da4b43ee7a446bfa9c5f1d3c044b0
  Author: Sebastian Forslund <sebastian.david.forslund@gmail.com>
  Date:   2023-12-08 (Fri, 08 Dec 2023)

  Changed paths:
    M src/shared/ad.c

  Log Message:
  -----------
  Pattern match on service- and manufacturer data

When advertisement monitoring, manufacturer data and service data was
not being matched against. This made it so that advertisement monitoring
with or_patterns did not work that type of data.

We must start matching against the data in the manufacturer_data and
service_data queues. Run a different match-function depending on the
type of monitor that is being matched against.

Closes: https://github.com/bluez/bluez/issues/652


Compare: https://github.com/bluez/bluez/compare/8980f4f1f730...b0656c2cf14d
