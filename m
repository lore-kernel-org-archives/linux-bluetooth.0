Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD5286405;
	Fri,  6 Jun 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200809; cv=none; b=S2nMsfBr2BbyVzOY8eqhkHL513cuYuNnTuNMljr3Qzz5u0p7ub1ryfju6iAFmU9PZ/AN1zI5rQ7dZrtqrNjRIMz3yx4oiu9VzqsO/NXw7hrbh26UvdTOnd7eWSO8bOoCm0h9RtUUTa8YzGW+dKo9BVyYjdNW6H+9j7771ZV01Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200809; c=relaxed/simple;
	bh=eNv/JThv4c3Wa/4EhQSOmRM1QV49bq/aXcW7RcPAu80=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XOqxCyz3TMEHofLpI3F6qrHP7J57toz4Jk8miilB7P2JsmJ3RDK66PsiRbK5nOhcSTqvHdwF702RncAo16bY02x4YgpUmXGgMrMfHl5vRkjLDjYK2qDc++UpzDGDh9CePz4XhtnTGDkMW90olbiLIKeeiUqb2fsdAWFV9Mi7D34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sp+eVam+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sp+eVam+"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55696b0Y23110446, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749200797; bh=q1mC3JNv3IcOKl9K9mVU3UOkH0pwiubgwuDEaMF834E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=sp+eVam+tp6qlNNmzDWTEQ1vFTwOlzM45z6i2LzQOdnNE3fI5RU8FxWKPcS4bjuhF
	 iyCwtz29hpmyqddZKyp4C9fhUBaIakP2XrLpsXc8/v8OMrNhMdLN0ZAjKkUmjMOZef
	 w0MISpKYrC4HO1eQQInE2nsRPE4AMxOb6LBwIkFcd+Poig9RuZ5lCcivtC+OAj3FoY
	 CDN8BJz7HdnUrY/HY+eI9XtcqRIg51SiYJdE4lL6NrpmxLD1v3hSPDtlzhumwZjr4y
	 h3XQ7HAqLKNHiVL8WytYbqPyxuQ/b22xGautc7Bd68HAAaomqy0HBUtgdwDdQNRqWd
	 74fMBD72HIuLw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55696b0Y23110446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Jun 2025 17:06:37 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Jun 2025 17:06:37 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Jun
 2025 17:06:37 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.chou@realtek.com>,
        <alex_lu@realsil.com.cn>
Subject: [PATCH v2 0/2] Bluetooth: Add support for RTK firmware version 3 and enhanced ACL-based download acceleration
Date: Fri, 6 Jun 2025 17:05:57 +0800
Message-ID: <20250606090559.896242-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Dear Maintainers,

I am submitting a patch for the Bluetooth that introduces support for RTK
firmware version 3 and implements an enhanced download mechanism through
ACL to improve firmware loading times.

Patch Overview:

1. Bluetooth: btrtl: Firmware format v3 support
   - This addition ensures the latest RTK chipsets with firmware version 3
     are fully supported. It includes necessary modifications to
     accommodate new firmware structure changes.

2. Bluetooth: btrtl: Add enhanced download support
   - By leveraging ACL links for firmware transmission, the download
     process is significantly accelerated, reducing the overall time and
     enhancing performance.

Testing and Validation:

- The implementation has been tested on various RTK chipsets under Linux
  based distribution.

Impact and Benefits:

These enhancements are beneficial for future firmware v3 chips and
compatible with previous firmware versions. Users can expect shortened
initialization times.

Your feedback and suggestions are welcome to further refine these changes.
Thank you for considering these enhancements.

Best regards,
Hilda

---
Change in V2:
- Move structure to btrtl.h
- Fill in the missing symbols
- Fix build warnings

Hilda Wu (2):
  Bluetooth: btrtl: Firmware format v3 support
  Bluetooth: btrtl: Add enhanced download support

 drivers/bluetooth/btrtl.c | 857 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btrtl.h | 122 ++++++
 drivers/bluetooth/btusb.c |   3 +
 3 files changed, 974 insertions(+), 8 deletions(-)

-- 
2.34.1

