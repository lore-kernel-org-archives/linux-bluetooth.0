Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3443090D7;
	Sat, 25 Apr 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777135132; cv=none; b=aB2Ze+IFqc6/zkeCszT8vbbjT9crscnswhmgTwdDJv0ZNDzVpzTDhTlfupjFy/MW9BnuNB/749dj2tFnv45rAbj572ZXtz6p0l7vnnrmecLpq2PA+Cjbe9IO3U/akYtG+s5iENnBHi0aVIKUMav+ypY9mDwx1AqujhJCS6HdHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777135132; c=relaxed/simple;
	bh=bNkVIzw0ahvft8xV/mHBztEcIVbGle+vJcyZDYMBDAk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sZG1gz1tPlvSzn+TXJDNZfr4bAC1S5JcOttdq/JGSfNwRPAUlHJqq78t7LQjlazu/J7e3OpuVUUqdydrhgE53Z9y+4jUDFqwYfjcYpNf4WIc9jo8GOlkx8NEkZt0yXLYQK07KwXMt0ERnx9/LkYPmrLV4FHfM5o/pjxJj+an6pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=Y/JSqk5a; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Y/JSqk5a"
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4g2wWS18Xkz9wPk;
	Sat, 25 Apr 2026 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1777135124; bh=c9tCVmxU8vBP8gDvmTjuMIdSheyhQt3yEBsIRxSOwPk=;
	h=Date:From:To:Subject:From;
	b=Y/JSqk5aaQXVLbFTtEFIG4e61D8F+DEpUv/wwncXBWQHwTp78J2EJfD+Jd6zk9thK
	 9tBqcQX2zJsDi+xp4E2v/BvZXeXM3YRufO37aUoKZTEUx/RGMTAknF1CneHMAPS+KH
	 k51vSA4e57Ex0AyiJYE7J0Xp6+b5KRJdwqXY2Ugg=
X-Riseup-User-ID: E588A17BF2C5D3B27C07A2B696FD88909E371CD1D0410A947224EF397B039D34
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4g2wWR0fvcz22Mw;
	Sat, 25 Apr 2026 16:38:42 +0000 (UTC)
Date: Sat, 25 Apr 2026 17:38:30 +0100
From: Alonso Garrigues <agarrigues@riseup.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: bluetooth: fix uninitialized scalar variable
Message-ID: <aezuBuQca26r4a7l@lal>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There is a path where the variable is read uninitialized,
in case RTL_PATCH_SECURITY_HEADER and !key_id

Signed-off-by: Alonso Garrigues <agarrigues@riseup.net>
---
 drivers/bluetooth/btrtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 62f9d4df3a4f..aa0d5af26b5f 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -543,7 +543,7 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 				   unsigned char **_buf)
 {
 	struct rtl_epatch_header_v2 *hdr;
-	int rc;
+	int rc = 0;
 	u8 key_id;
 	u32 num_sections;
 	struct rtl_section *section;
-- 
2.53.0

