Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7693BF303
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900401; cv=none; b=hKVIVWAFcaLJI4LVLYSBvpqoSzgcPe+cxbvM03NrA3dgGgISkiCDhe0TsaAnydLrGhW842tBuB1MFJL1M8A6aDIG4r9LqehBiR2F1NPpL8RhMjNShgEGfqbToQ4P7MfIPFC/bZOAZGpejNfJirfbq55mv+UiCbR//yQclyRJSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900401; c=relaxed/simple;
	bh=hrCPTJNMNo/fQHVFhsoznBVkRwuqSOTPdvsrAwppV90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KonGRw/2JOJM5snUM1cyCgkvnlVH5x0anANsvdFhfhFokoKBoUIrnK6F0TJvQOH3FDmaRp3YK6Hdm16aXRaSV9dzWvmqIJPzel2e62h2sDQPy6tu8e39pU26C8SyC9JsPISSffe/jahowe1jcavLZyUA8Zn3WDWB2/iugQdcozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=charlie.cat; spf=pass smtp.mailfrom=charlie.cat; dkim=pass (2048-bit key) header.d=charlie.cat header.i=@charlie.cat header.b=DduB67w0; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=OBqdGQWT; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=charlie.cat
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charlie.cat
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charlie.cat header.i=@charlie.cat header.b="DduB67w0";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="OBqdGQWT"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=DduB67w0tfGzIeN1RfQgMf5Ey6hiiC5wyV0q6bnPgIQ+EucLbGyTFgvwd0ELG9Z4k6b0xYaxRklQuMkyy4q5OUCl7g3Lnkj+tfX8GZT9eGY8MaM58Cm4HbI7VD0FikYoE6oLnIYSc13VKrV6RjcOZFdov+uKPOq7PfwxPmWZIzOgWbUpfkwpZs5MTjikhAXDzKCoso1aeBh8+UeOJ1B/eL9rr84ZhhLXPe1MpFWphUM8TKzsEUkuMhQ6iDX+K6K71LrJUr+GkI0KGa1uqXb26ln2FMAvTY+5HtLULVYsekBSqBouQo6fF4RNSRv1yQVM2MKhTuR4sV83G/OQ64t+sA==; s=purelymail3; d=charlie.cat; v=1; bh=hrCPTJNMNo/fQHVFhsoznBVkRwuqSOTPdvsrAwppV90=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=OBqdGQWT3skfdWXYyGxbn2+RBe0JM0L8Mm1Q3AnMHBgQCD6fDzbwdYb9eui2v1b68e5xekF4nLZWRPJGhe+IBijqVwrfgx4rRU/DYtLI7jfEkbRhna6thoTwQP5FQs6/dIqSFGXybQFxB40tZttrHUANUc3HFWQHF8pPnwEqXwrh+wTTXgFQL9v3BNkQ9y26hGVnRSR2htsv4LMEoyoSTnPJavykLDQizj00UvqcXmxuqnJHwETwXzeOm7U2JCIEQiZsNZm1H9zkEOOgMYpvMUEzeBoxsqSsf+i8raSjEaAVXWuY2EKtZ9QrTRnb+D6BmUucY4YcWj7xnErauDY4Kw==; s=purelymail3; d=purelymail.com; v=1; bh=hrCPTJNMNo/fQHVFhsoznBVkRwuqSOTPdvsrAwppV90=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 8094:1928:null:purelymail
X-Pm-Original-To: linux-bluetooth@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 494728775;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 20 Jan 2026 09:13:07 +0000 (UTC)
From: Jacopo Scannella <code@charlie.cat>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	Jacopo Scannella <code@charlie.cat>
Subject: [PATCH] Bluetooth: btusb: Add device ID for Realtek RTL8761BU
Date: Tue, 20 Jan 2026 10:13:04 +0100
Message-ID: <20260120091304.6226-1-code@charlie.cat>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Add USB device ID 0x2c0a:0x8761 to the btusb driver fo the Realtek
RTL8761BU Bluetooth adapter.

Reference:
https://www.startech.com/en-us/networking-io/av53c1-usb-bluetooth

Signed-off-by: Jacopo Scannella <code@charlie.cat>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ded09e94d296..33dfed738c63 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -773,6 +773,7 @@ static const struct usb_device_id quirks_table[] =3D {
=20
 =09/* Additional Realtek 8723BU Bluetooth devices */
 =09{ USB_DEVICE(0x7392, 0xa611), .driver_info =3D BTUSB_REALTEK },
+=09{ USB_DEVICE(0x2c0a, 0x8761), .driver_info =3D BTUSB_REALTEK },
=20
 =09/* Additional Realtek 8723DE Bluetooth devices */
 =09{ USB_DEVICE(0x0bda, 0xb009), .driver_info =3D BTUSB_REALTEK },
--=20
2.43.0

