Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28003A16BA
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342996; cv=pass; b=QzILxSw5iT6PwAQpAE3onjAzqWg/T8vDYY03kXRXa2aFkyznqREZ43oOnWyI7p8WHMUjebClqDwPe76NbMd31mNd1cclEMErFUXp1QlTdOFNZPJRl3x12u/NqZiF5X/m/FHU86iFpfo8SVzZbFLySktAsoYQ94mf+d7cZn5b9ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342996; c=relaxed/simple;
	bh=xcvf0kIvzPLoRVFHot1Xi40Ic3XG0NDQShILzUYjGPQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mX/B+XRw2erWnGyhJCmQEVQw7TzX+Sy1z4kM9wS4iZN1ltEbvf3zGY79GHanLkz/mrijb/tGg+/7hy/eVQa8Ml6cLc2ppiwF519CBkE/V3/kBWOZwc3ga6E5rUpwRkuvcpApazP5vS9jvM+FgbMV4RZtuCxuZa37hpUFMzGCu5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9gu6Mob; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9gu6Mob"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66dbce0b639so602786d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 02:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788342994; cv=none;
        d=google.com; s=arc-20260327;
        b=ZpJNoumRYWVg+6wQZ0WUILGw8AZj2np9Ed7xyLFWx/YGtPolh5IDq4toI18PJuASRN
         DesOLt2Szd+KCQ+ICZyRs5fqILTeU0739ftCmEjym8C3CiSwNLa8EU68UXhvV4SSWKWm
         7p000dzyKukUaL349b5Kf6vuABdHJ0piNI/tEFQ2TbB/wjLKNiKTIr6yrGdZclzObA8L
         K1ZGVmLhdShxDVLbsjVWeWbSNxcnhzi7ZS6DxpNTy2bBX1orUIfjmGRfVT8MR9JgSLMy
         BtMxjWYcfsVDV18Jd0YyLWbCuDh+792xCxofHgiIZIHk9yyQi18wCCPMZMZVyXM7YuPz
         ckaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FPaUMKJFmZ/Klb51lvUfeKuKy5tQapGhS9vAbBGWjK0=;
        fh=BYmJYYrzNkcsHw//JR1Bfw3zo6Y5IQv28VtVshOmLU0=;
        b=BOsC63d1NnJir2jzkVCkKgCtwshHdiUR28oZEyFP0unJtRe+0kgH/7VpoYeYoBJoHS
         BMaXzR3Jq7LV7fwILZ+t25bsii6Sly1TWR37T+dd05mkrA81Rvvacai5WmC93qE543Q0
         HJPslDjwTLTsAboCBuJLC2Fx84bA8748n64ILXaJsydAbR/sgKDK17FYU9CXAPlCkRkn
         uwZFyUpMwZR6/l0BciUx8AcfG8PnrZ4yJf+8gOsqnS8iBPfYJqczl0dlWSsU5IYA3rGb
         0sd31aL9MO4eNQVtRKZRzLG/uonGpJNIrCY9YKFK8Gd1QQ1IjZ//vOQSb7dIP0HfBSDE
         1LQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788342994; x=1788947794; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPaUMKJFmZ/Klb51lvUfeKuKy5tQapGhS9vAbBGWjK0=;
        b=k9gu6Mob+kWC5lYH2rp3nBRpfxAp5dAInOyMf0cj9mnjIpWFelqWns90RRaLPeP0xU
         NBvm79AXYg4zoMvbM/5h3B94ifBVQSHOVP50l8imAI+plCQS+bBbDlU5DbKJzJpkOKb9
         /FW6oPu+P90H1L96JH0eYUbndgZAA8ernU+QgkINCGhpSflshXHOzpCzBTu4Y5Hl9kO4
         YZnpWIYOE+Q2YdbR2GOkaR/H9yfRS74e+VS3qHtRZ02wMlWqK0C7vWtcqEVEF+wqwma9
         1TJADqhInS5zapFmhYy6bokn7PMTg9bqWLS8r+AySsqo+iYpcDW4aHT/JJXN7I3b+NEj
         Gd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788342994; x=1788947794;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FPaUMKJFmZ/Klb51lvUfeKuKy5tQapGhS9vAbBGWjK0=;
        b=d75xSWvKrrKjqh8zg9Ayk0bsO7lr5m+jkbHtJWZUjtfgfd0KY9lW+S635QkjKBEOq1
         Ttmek6+/lH8sn8VGXiC/sNHkk+O/dXiucAAS8hR+3TJBMxMWKreMOA2gLbS85CS/aBf4
         2hcMFiwxjxSOCHGkwbOvAtA5kTBmBwRn6Jc4G6+jmfK8WJ9H+P1R+EW0vcMQNOjQMsad
         AaOX0bf7x9XaC5B3LeekqqrYrC4rj7L4Jflu3q/qG+OQuZGdYXfmZkQVuFP/nOEiIb+J
         PKdgn3LiuyOs2ae7OxEZR5SA7H8Jly3Dh8I68HR8P7ifQLqway/rum8Mhpkpi0OtRgQY
         19vg==
X-Gm-Message-State: AFuF++kGB8hkbAlqztGl2hy451bw7u+7rV2vt2QNUNhzGEnPRHoAJML/
	qfoi2EF0dBM2cNqXAAFf6D1ytN7kh0eRe/8L7WWUuRCh4Bv8KAUF58Hj7l8pCyD8GxIWIfx2CWN
	pkUjbJoYbsGqJyo8GnEbFQ8ONWz7IRwo1t4DnsnU=
X-Gm-Gg: AYBFou0es+c8EjVslaVgJ9dULQKbT7wLjDKxTMsEIhwDys679glmD0YHp24IPF16B2b
	8R//N+y2F5LttFJKusZTriEl9vuppcu19vLH+MtVz6Ssa97LcW0IBPi0arA4V/TDY2wsVVjtxJj
	BIa0IZHmRKqpvBt342lD1usanJSFh+hnH3B5me4/RvkKcSHMYWT1XyORSfTceoYydyTwX1Q/M2I
	gt2GOAiVSnRFy40XEd6yj5TTGJJ39/MBh+PGTUsopYF7uBd6cu0Q9J1eIlvIMGH4LgBT8LQxgRE
	rYIpCVwM7zoiFCvMZFEAZXgW2TXj/i3WMOuUMVo8S6/MVQyI7BbsvM9j1cx8ccQ7yUOaA15BkuI
	IEjJpG0AjnEyC0teIPgkuZT5S
X-Received: by 2002:a53:c705:0:b0:66d:ca8:bed2 with SMTP id
 956f58d0204a3-66f9bc07bfemr861324d50.40.1788342993615; Wed, 02 Sep 2026
 02:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nicolas Thibert <nithibert@gmail.com>
Date: Wed, 2 Sep 2026 11:56:23 +0200
X-Gm-Features: AcwNN1V3OHW5Kwebsi3QyXmS91G9NYSuKgePmxZp1EJZKgjdD70auGIuB5BHLWE
Message-ID: <CAKA8V_90tN2ncH6gAoa_cML4TfCe=21EoJ8RU-v_oQ6gAMT1uQ@mail.gmail.com>
Subject: [PATCH] Bluetooth: btusb: fix NXP IW610 composite device handling
To: marcel@holtmann.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The NXP IW610 module exposes itself as a composite USB device
(0471:0215) with three interfaces: two real Bluetooth HCI interfaces
(class 0xe0) and one vendor-specific WiFi interface (class 0xff) used
by mwifiex-nxp.

The composite device's whole USB descriptor reports class 0xe0/01/01
(Bluetooth), so btusb_table's generic USB_DEVICE_INFO(0xe0, 0x01, 0x01)
entry matches every interface, not just the two real HCI ones -- btusb
ends up binding the WiFi interface too, and mwifiex-nxp never gets it.

Fix:
1. In btusb_table (the table the USB core actually matches against),
 explicitly ignore the WiFi interface via BTUSB_IGNORE, ahead of the
 generic entry.
2. In quirks_table, scope the existing BTUSB_MARVELL entry to the BT
 interface class instead of matching the whole device by VID/PID
 (harmless either way since quirks_table isn't consulted for initial
 binding, but keep it correct).

Not upstream anywhere: checked NXP's own i.MX kernel fork
(nxp-imx/linux-imx), no IW610 references in btusb.c on any branch --
their reference designs wire this chip differently (WiFi over SDIO
per their release notes), so they never hit this.

Signed-off-by: Nicolas Thibert <nithibert@gmail.com>
Cc: stable@vger.kernel.org
---
drivers/bluetooth/btusb.c | 22 ++++++++++++++++++++++
1 file changed, 22 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -71,6 +71,15 @@ static struct usb_driver btusb_driver;
#define BTUSB_BROKEN_EXT_SCAN                BIT(29)

static const struct usb_device_id btusb_table[] = {
+     /*
+      * NXP IW610 (0471:0215): the composite device reports Bluetooth
+      * would also match this WiFi vendor interface. Ignore it here
+      * first so mwifiex-nxp can bind it instead.
+      */
+     { USB_DEVICE_AND_INTERFACE_INFO(0x0471, 0x0215, 0xff, 0xff, 0xff),
+       .driver_info = BTUSB_IGNORE },
+
/* Generic Bluetooth USB device */
{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },

@@ -477,6 +486,14 @@ static const struct usb_device_id quirks
{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },

+     /*
+      * NXP IW610 BT interfaces (Marvell-lineage silicon, same quirk as
+      * the 0x1286 entries above). Scoped to the BT interface class,
+      * not just VID/PID -- see the btusb_table entry above.
+      */
+     { USB_DEVICE_AND_INTERFACE_INFO(0x0471, 0x0215, 0xe0, 0x01, 0x01),
+       .driver_info = BTUSB_MARVELL },
+
/* Intel Bluetooth devices */
{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED },
{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED },
--
2.34.1
