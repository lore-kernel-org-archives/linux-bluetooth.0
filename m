Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526F449EA1
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925305; cv=none; b=XqoK6trHl6/amlD/0UGBMsoME24Ea7Gsm53p8Kq1vCzCaZRlTZ3sY0VV3g6nWox4mGxrL1NX8ZzPERULZ0tAYtZ2CLsJ62pfpNJhoWQKteZ3Y2NTFLTOPfvsujfClWACjt0gMFIbLcZRDhF6BEfm9oHe991+06PTAQabN5daQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925305; c=relaxed/simple;
	bh=ALD1dcdcAderv8d96eTks99pj/Q42q2b1gzLIgPWtok=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E+DEhGVdX3af5JDNJ814s5BsNgz2/bmXN2o3U5e6wAoh0a679MCUq5vhfeYZSUBOCNupfcP8zdY+tAc5vTzG7LZpza8BkdHG9uYLgHSVlf7CxA34XOkO/H3P+ZkS9KIGk1CckRxjKy0u8+5Otpn5dznLxo0RAaxI+dPBMed4ilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F8204436A
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:08:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 0/7] Port text docs to RST
Date: Tue, 20 Jan 2026 17:05:46 +0100
Message-ID: <20260120160811.3394320-1-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepteeuhfeigffgfeeuuedvvdfhudfhvdfgvdeiudfgkedvudegleehleelveeuheeinecuffhomhgrihhnpehgihhthhhusgdrihhonecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepvdfhkedvtdeggeefieetpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean
X-GND-Score: 49

So they can be integrated into our upcoming HTML docs. See:
https://hadess.github.io/bluez/

for a preview.

Bastien Nocera (7):
  doc: Port assigned-numbers.txt to RST
  doc: Port thermometer-api.txt to RST
  doc: Port security-bugs.txt to RST
  doc: Port coding-style.txt to RST
  doc: Port sap-api.txt to RST
  doc: Port maintainer-guidelines.txt to RST
  doc: Port health-api.txt to RST

 Makefile.am                                   |  30 +-
 doc/assigned-numbers.rst                      |  29 ++
 doc/assigned-numbers.txt                      |  26 --
 doc/coding-style.rst                          | 349 ++++++++++++++++++
 doc/coding-style.txt                          | 279 --------------
 doc/health-api.txt                            | 152 --------
 ...idelines.txt => maintainer-guidelines.rst} |  61 +--
 doc/org.bluez.HealthChannel.rst               |  72 ++++
 doc/org.bluez.HealthDevice.rst                |  94 +++++
 doc/org.bluez.HealthManager.rst               |  68 ++++
 doc/org.bluez.SimAccess.rst                   |  40 ++
 doc/org.bluez.Thermometer.rst                 |  51 +++
 doc/org.bluez.ThermometerManager.rst          |  64 ++++
 doc/org.bluez.ThermometerWatcher.rst          |  79 ++++
 doc/sap-api.txt                               |  20 -
 doc/{security-bugs.txt => security-bugs.rst}  |   1 +
 doc/thermometer-api.txt                       | 134 -------
 17 files changed, 909 insertions(+), 640 deletions(-)
 create mode 100644 doc/assigned-numbers.rst
 delete mode 100644 doc/assigned-numbers.txt
 create mode 100644 doc/coding-style.rst
 delete mode 100644 doc/coding-style.txt
 delete mode 100644 doc/health-api.txt
 rename doc/{maintainer-guidelines.txt => maintainer-guidelines.rst} (65%)
 create mode 100644 doc/org.bluez.HealthChannel.rst
 create mode 100644 doc/org.bluez.HealthDevice.rst
 create mode 100644 doc/org.bluez.HealthManager.rst
 create mode 100644 doc/org.bluez.SimAccess.rst
 create mode 100644 doc/org.bluez.Thermometer.rst
 create mode 100644 doc/org.bluez.ThermometerManager.rst
 create mode 100644 doc/org.bluez.ThermometerWatcher.rst
 delete mode 100644 doc/sap-api.txt
 rename doc/{security-bugs.txt => security-bugs.rst} (99%)
 delete mode 100644 doc/thermometer-api.txt

-- 
2.52.0

