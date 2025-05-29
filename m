Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664B1AAA1E;
	Thu, 29 May 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522915; cv=none; b=iORBy9A82URJw7dGvsa9xWmVwI8RBv0lkocT8B1duVWVMx84V36AJuTjpldXcN1rLMQoHGZM10QIspiArt2mFCRFf2KBKAkCMQk47sBYWWpw1IPwQFLzprmf275WNo252iU75dy31G83gb1nb1olKMWbtVrbu2kmNwAsXrLQ5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522915; c=relaxed/simple;
	bh=EkOjDiJqp7bgZqfwMuQBEMhV9BdRvI212Oqa8uR7MR8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b3mUNUNRoVXVXntvkgM/+gGDhd/T7KosHHOi8fnMfveKEBL3/3LsJuFr8xTITXszhyxEDhG0F88/4HXKJ/TyiPgekajtOQ3uJ6An5pvxAekmDbqZ4YWmWAKMdnrrnaSKAFaI3L/yecFcux2BoTqziTj+sLfIeyizisFOhHpGYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YFI8TjEt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YFI8TjEt"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54TCmNW611428904, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748522903; bh=IcZcHV+H3hSA05dZW49D/moT4cc8nYBTH69gzkx5uFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=YFI8TjEt6ZeQocAWNBuAy59gwcg3ATQyFTr40+1jEem4z5DZO13PfKc6kDjAzX4+z
	 TRZTBB5KKWH/j7A+tDz5GKATFHkX5E36acF8NQ4+czxNPfMWFEr6f65xPLJsObtbef
	 0+g+Cfi0vc8jkbkZ1ioRYXk42x4eDbmFjSEC0DdLS8q7CZg2c1ocW+W24CTkmcQ8qp
	 zMS5Yd3fgGgAN+xBpStjTrisJLiOINHFdjoAdaNIzhVmmHfEmNplIoczy0AmCfMzUG
	 xXXWEMka6TPM0cRoDGCsmAsCxNFSJsY4WdOXTjKrSbPBMjJf/0KgphopmMlN7gpziP
	 Po6+ZWmz0g9nw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54TCmNW611428904
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 20:48:23 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 May 2025 20:48:23 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 May
 2025 20:48:23 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.chou@realtek.com>,
        <alex_lu@realsil.com.cn>
Subject: [PATCH 0/2] Bluetooth: Add support for RTK firmware version 3 and enhanced ACL-based download acceleration
Date: Thu, 29 May 2025 20:48:14 +0800
Message-ID: <20250529124816.4186320-1-hildawu@realtek.com>
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

Hilda Wu (2):
  Bluetooth: btrtl: Firmware format v3 support
  Bluetooth: btrtl: Add enhanced download support

 drivers/bluetooth/btrtl.c | 871 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btrtl.h | 102 +++++
 drivers/bluetooth/btusb.c |   3 +
 3 files changed, 968 insertions(+), 8 deletions(-)

-- 
2.34.1

