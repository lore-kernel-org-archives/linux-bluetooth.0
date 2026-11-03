Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706119;
	b=VPZoiPY4aYc+pZQM5RdHYOjwXF9a7H9yPV2oNblokehLOHAXQdY/Fwi+N//WZD/REue8
	 WSpSduqjO/l40hqzm3DphGw3H8RJIDlA779pAWlA4WyN53QcScZbn/NrXSxTtxKt82tSi
	 aQvKr9hTA7IrBDQD8iEAzdY4uXjNivWy+++6Tn8k4+QWU+D8/sVTvby2uISvW21bpzMO+
	 tX0t8FSH5H+Y9sgZaI/X6qU9UX1Z2cdzl3aLH9THzU0JMsVVjgqKlOjoDMVjAwo+oKvEh
	 kuQjyMzzeN2TgMbZAXmk/IEarWgIy4r/2xo4o42F62S0eRmFpGb9o6i4tphWry7SzXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706119;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=ENk5SyDbftTYbD5uW6iaa1Q6vZlyK2LjOT5m0xsgNcM=;
	b=mY0IoYJ25eE5AGkyzNlD2++IULDzn7FNs7K6yQ2BnOInsN7H+77KHBP+XnsU9oDBW50/
	 snRxQgfwd4c4zWxGJWOewHSHYiGSeywqcmuUJ+R2YcZybfm6flqHMsruwBglwUNNkjCY5
	 ZP6lDlJKHvUH2ZAxf7+4YExRFjEvrCZA2b1DmCvHOnv7NSaUZDBXDGhiORdBgdV3jdGDD
	 OqjMWxzmHGGAGuwDSGYQnsIRe15NmqbwyhQ32yrGt6pMoEPtWSXH1fGQ+tQNghIwu7KFU
	 gohGOq6ixfKAujs3aJMqRmbLtSrmfgK0sruEdCdi0EJpukDCc/85PSJ46AX6G9bpSZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b="ZVGeDG//";
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA2A6083612;
	Tue,  3 Nov 2026 11:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA2A6083612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=ZVGeDG//
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706094;
	bh=ENk5SyDbftTYbD5uW6iaa1Q6vZlyK2LjOT5m0xsgNcM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ZVGeDG//Z7eQT5jqhlLHGozPOQ19wKhfAjiRJzZiKRH1o9f5k4SCIS0f8a0Nhiu28
	 BIgc72tmErf1v23AgD8399nl116WC+Z9Z+S/ZRdowFY2u/6y1GHI/XQ2JH/mvX21gS
	 h4y25m6DR0eG1KByG3p72kYvCcGpaun0tyUTKgK4=
X-QQ-mid: zesmtpip2t1793706089t42376647
X-QQ-Originating-IP: rs/FEwKJBbXtW+3d7f3tQAQRUeaRJ8AsG67TGOUkIU8=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2264155925313795611
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kiran K <kiran.k@intel.com>,
	Vijay Satija <vijay.satija@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: validate the BRDS domain packages
Date: Tue,  3 Nov 2026 19:41:27 +0800
Message-Id: <20261103114127.75143-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NChuY+V9daHbTr9h6Jn1ViXBf0aDgCi4YRuFpqnNjDQOZYYzRLhgEhnG
	x4NUQHSCI+qKONakqm+BXwMU/rUFnUtmeygwgnQRpT6UPXkXNG/xmu97rzvGbevaoWZyIWv
	MHpLJV1T2rT9e4PMSoGyaDk2aEUi1kiNWjukZ3MhwUBTrl5ay+XVzIm/oBaRVxZQOE+4sgo
	9WCekioLrl8WPxQWuP0z38PmnE13zU5IudVUgOIqrlbCMW5bdKuC5T3GL8g0hqPs1fOlvcK
	i+PcMQlRcBQeHU9pfkPwBnGlaaYpqnskQVTFwrXLa7qXETSHMHT4HoaESb2dendnvbs9+h3
	a/3efAiVDFu9kH8Yn888tT9etuIo10ozb9LtmQPd6tM6oefil8i2PYrNE7V12VTd3GpqJ78
	u6eLnbHiXo9XZ6flps673XpLeMVWfDp0IvrZBddna1IbBSamSmeBTBS5DHviISZr0HhPuik
	CxP6K9gSCmSoACfb+Kumrv/BQ61RNT8HisQ+SRpyMURaWAvdNJbki+CxCeDa1EduhW1uBIp
	fxN3CpO1ubU4tNQgoaG0hoVPwXQ2s170/gAKkbSh4R7pcnoIFECjRoF/XzMNV6TkYNXV6xG
	iYqqg3jAN/046mIVTKsNIyHuhM/KENlO7KxWnK4gAf2geEkaa8/1fn9wpiTgV+YcoCB35+J
	RKQrfhshJd46sFF6uGEe0Z1UjYYQR1+gws9Um5wGwjf0eagkEFCIpbNwYn92Ryj8a8d+UA1
	OOHioVS4/K+CrUZPoyx2x7uBMU/FL6q+yTukbAM2XliRVLcAc2gl9jHr3J1cKqgWqs8m+35
	JLoAEP3pWCqcMo6WloV8l4EqAj8j/PhPLH2+BVe6bXhrVtB1i6kct30m8zJZo6p3rTQvyYp
	ZByZfwQwyKJtOEPPFS5/yn7leVxiKga9KZMVTlxHHN36T6M/yg8FeN86MaxxwWpovsFEVCt
	jZ2ZtXCN7poYvrjDJ0ivhGpKX9kMTXUcq+rROyaoakFf8MEY7emge5ofQbMOUDTPlpYKGep
	9EgS2Uod57aiHts/Zl30CVrArm1HGnT3FHlgXOgdGOJXdZqqns
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

btintel_acpi_get_bt_pkg() treats every element after the revision as a
package and reads its first element without checking the element type
or count.  An integer element makes package.elements alias the integer
value and dereferences a firmware-chosen pointer; a short string or
buffer element reads past its allocation.  The function is called for
BRDS during Intel SAR setup.

Skip elements that are not non-empty packages.

Fixes: e036afb1fe44 ("Bluetooth: btintel: Add support to configure TX power")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 drivers/bluetooth/btintel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0709fb3212f9..16745b58bde4 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3042,6 +3042,10 @@ static union acpi_object *btintel_acpi_get_bt_pkg(union acpi_object *buffer)
 
 	for (i = 1; i < buffer->package.count; i++) {
 		bt_pkg = &buffer->package.elements[i];
+		if (bt_pkg->type != ACPI_TYPE_PACKAGE ||
+		    bt_pkg->package.count < 1)
+			continue;
+
 		domain = &bt_pkg->package.elements[0];
 		if (domain->type == ACPI_TYPE_INTEGER &&
 		    domain->integer.value == BTINTEL_BT_DOMAIN)
-- 
2.34.1

