Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FFF38F926;
	Mon, 27 Jul 2026 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167874; cv=none; b=qUkigrgezkXxyb/90x4GKeWEhmbRfMgIDpHPB9tOdApzdkmFVK2Sw2UFgn+RlzxlPAWHA1gPSKOxD1WoDRaM8FXYB+3vEGTkUhXHyIA58Je3R9gUZE+mtqCqWjFVrai0xzog9gDzo/+AaH8qRjQ0gne5IIiCVG7TvFyqz9wKlaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167874; c=relaxed/simple;
	bh=r1pyYjYWM9je0zlQZ2arXiNcMXCvBlkttmhvuwKqH1A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ky/4nALcP1OsCTL7zYl36lvkHeM/73Bfu5+IXPueFw3ZJo14YtxrTZwSIyeEhbUgdi4D79zrZ88tw7MaC97D9kb9H8fVZ9WDtbjNthYlHR2Aoj1xO1ksTGWpgNksMtvOcJdf5p6J7gpbgqTN5RpxykRilur9VJ+uZPUsqOJyOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OUGJMPg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OUGJMPg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047F11F000E9;
	Mon, 27 Jul 2026 15:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785167872;
	bh=x+BqVmp9tMlOnrF/CUNQXTwV5ciCXV0wEAYVrd3+4k0=;
	h=From:Subject:Date:To:Cc;
	b=OUGJMPg8DQdCyO1SMMueUYZD+gIitl6T6VqZ0D8JpbHjXWrJQTS/p9zihrF9Y2w+l
	 7gZSfVM/46OqYriOAJlL2pEIdczIuhrOj/Eo2hoQi7o5u23B7L5gjUVsxFxM74UKJt
	 jrjE1maqzHjf/R5D2DZMTs2MRzhzAQpfLKe2ztu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/3] Bluetooth: fix short read errors in usb_control_msg()
Date: Mon, 27 Jul 2026 17:57:31 +0200
Message-Id: <20260727-bt-ctrl-v1-0-2e8650e9df01@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VfRubaakZVXkYvtODgS2kZqeXfD5
 a/+3xfBk2Py0GQRHJ3seVsTijwDnMw6kuA+GZRUtdRKCxsEBrcIU2qDpkSqqIBU744Gvr6ntvv
 tDzsThncO9/0AGbpygWsAAAA=
X-Change-ID: 20260727-bt-ctrl-a37aca3ce4e1
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=887;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=r1pyYjYWM9je0zlQZ2arXiNcMXCvBlkttmhvuwKqH1A=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFnp9V8uJJfFPnSpe+TGoqPdssNpyc+v7HZ2Bnxdlh9Dh
 LhbDvd3xLIwCDIxyIopsnzZxnN0f8UhRS9D29Mwc1iZQIYwcHEKwESmGTPMr194sIr1jtM7u5yY
 E5Pnqn3e8vtWFMN8V72cQLXdWT/d1j2Z2/dszcrZM8p+AAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

There are two drivers in the bluetooth stack that suffer from possible
"short reads" when sending USB control messages.  Fix that error up in
them which allows the error handling to become even simpler.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Greg Kroah-Hartman (3):
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_uhw_reg_read()
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_reg_read()
      Bluetooth: btusb: Fix short read errors in btusb_qca_send_vendor_req()

 drivers/bluetooth/btmtk.c | 86 ++++++++++++++++++++---------------------------
 drivers/bluetooth/btusb.c | 30 +++++------------
 2 files changed, 46 insertions(+), 70 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260727-bt-ctrl-a37aca3ce4e1

Best regards,
--  
Greg Kroah-Hartman <gregkh@linuxfoundation.org>

