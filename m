Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65A474276
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386256; cv=none; b=uqyU+TO2WNkWv+t4MUC0jQAAYoQOyIO9ZaZGQ+8mQgAknfILbYKn7MnMvflHa5sBPQcBLA0Kg3RBG0Ji6yZ411oEeqI1vX0pnSilxutA2G7C0+HBK19cyVk9YCY+aNHSIaMUszJHYRZwoQDqaitEDGRIL03+IynBS0gIu/Mb51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386256; c=relaxed/simple;
	bh=I5wYf2UfCqjJlZGBk/LVQAYOjkJTlGjJj+LnTjVAnuQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OrjCXs5PZzjIA5NZNYhQVT/wPT6/MKc3t+5s9cu82FGTPW2P/qOC4SQ7fClICCmzaZN087VuAIQ2HHIJn+yNg7am/cJ4yw+d0obzlbxapLG15faUrk9sW3oxgVttOHvENS+Z9e5e0CEsqUAcsxSEXBUH4EQRnwCHHpD+XqdDJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ua34nl4f; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua34nl4f"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso18318225e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789386253; x=1789991053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uZ16H6DakkGQVJDeU0DMETrrlOVhylLgGOXMPJp5UxU=;
        b=Ua34nl4feu+Siy+vp/4Ty4CiWOBKtu6sAlnwNdjToF90oMO2JvTZcMNIxwjc3FoOkr
         7YVeCufKsHsglQAJjZvYIxeIDJBuVtqbckldRXWpEwwqcXNfnX5FdDaJTCcDNWgqSbIs
         6aWrL50fPsxR4RV/zhbUdt+8ghdH+mYYeqDjVJFMgeYXL3ntUzl7GTf5p3TCWLTITYln
         2zd4Es+5LcZHKfdUw4uftVNOJlvirYyhjo72SVnLvesCyqRjpBxWO/HDMzSgkX1Xs7oo
         EuUVlAfngGetEZdrQVT5zSNLf2XcYr5fX77QQ3kPAdxYNHrx4a0pp6XamoseIFv5sOA8
         74Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789386253; x=1789991053;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uZ16H6DakkGQVJDeU0DMETrrlOVhylLgGOXMPJp5UxU=;
        b=WtM+cxgEMwcBEVJ4aZCNedn1DUOOSLo5SCnHWyVU196XCJOn6vA24h0hp2wqyOr6uk
         ijTlhpuoFKzc9fTYbcD1roRd+Io4gibB5xTwe1nUy5mhDN6E8MW/Q8TSYRBM6XHXHClL
         9zK+PrG/H6Izz0uHFQTdOJI1nL1zkYuke8eUWGbILrUeZGwIoa9KVx4g4HMYqn1xcefR
         edN2C6fTAzqNA9p9hg/KzAA45JdgHmrhvaHGGlv9Om2OejkElmKVlA2ddBbbUfiSjiT8
         WeEz59BRsuCs0/TVKSSm95BfmgcQ2St+c3Dd50lDg0FXbMJwFr9zHQWMGb4EPl2x2EvD
         g7Dg==
X-Forwarded-Encrypted: i=1; AKwUvByOs6ePmsN5wk4M3LdEkyaZMiaBvC8y2i05L3SNPyY1v6GfXxcSX6xFjOds5HD3Ghuh+s3UvnLjCdaM8TH578U=@vger.kernel.org
X-Gm-Message-State: AFuF++nSd5kAT/xfBXGcGsFOug0VVAcn3+PYd1eb3GVRJgOYf6EJbmg3
	wD0EsSX7oyuu4ddq38HmsIfGOx2/SKYQy8vNoQ3nhQqV3YsAYZl9Urnm6H2EP5O9jVw=
X-Gm-Gg: AYBFou3mZpmVD8csVOkRS+UugDdfOOxEPlSmwd1NrgzU1l7y4ncD+T2BC35CVUqSW2T
	bNwce10zOgXHlBSZdnfiy90Cru7qXr4BnvwRjOiPeI7UEaW9T8FxD/VOp6Yd6UVoSryeoezPXjN
	NQuFNr1+f1X21vBQ2Dutg/Ff6Wd95cv2IMVct1EmazLW3Ox5AD65tEoAIg+yNGpKNMizq1p0nEw
	YuS8spxF+hUy+BaJsGDD8JfmPLMtBvXJVgnPLmo+jjif+t6d7h4A6X+5fBBFZigOX+SkC4abGTe
	9BrL6Ljzz/Ug+btddaRaWSeCDqNZ8pgeJP3xc8XI9VWwsulKJY3/XVH780DRdgshTciJW9mdXMr
	WyLtkFTM4f/ceYw3krGkjPBjhmquLxrEdV1t+NQhmhuBkoo8Loy2xmoBrjJFNEOH6kH2aQ6nE4B
	bp1DwLYzy3BKgEkwuKREpsS7oQzaAu5XAiwkUQWpYk4+shdQKSe5Rmdqv8ls4mW35ok92fo+IzZ
	/pS5OHgi1fNhm1jzKqQ2pmte+aWfOjVwhWO31EuPkSouKQCVIjw9ME2nwTUf2eEeOfqn+on2ki9
	EpPjtYZXXZPuUMh+V3CdczxX23OE
X-Received: by 2002:a05:600c:34d3:b0:49e:7224:f1f8 with SMTP id 5b1f17b1804b1-49e7a666bf7mr18618225e9.13.1789386252295;
        Mon, 14 Sep 2026 04:44:12 -0700 (PDT)
Received: from ?IPV6:2003:fc:df06:7400:6598:1d43:be65:c503? (p200300fcdf06740065981d43be65c503.dip0.t-ipconnect.de. [2003:fc:df06:7400:6598:1d43:be65:c503])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e71e300f3sm216791875e9.7.2026.09.14.04.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 04:44:11 -0700 (PDT)
Message-ID: <9ac1c05b-e9f2-49e9-af63-9cd0e42115fc@gmail.com>
Date: Mon, 14 Sep 2026 13:44:10 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: en-GB, de-DE
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Christoph Zwerschke <cito@online.de>,
 Max Chou <max.chou@realtek.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 regressions@lists.linux.dev
From: "ra.prism" <ra.prism@gmail.com>
Subject: [REGRESSION] btusb: ASUS USB-BT540/BT600 IDs backported without,
 RTL8761CUV support, adapter re-enumerates endlessly (6.18.50, 6.12.109,,
 6.1.188, 5.15.221, 5.10.270)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

two btusb device-ID commits were backported to stable branches that lack
the btrtl support they depend on:

   980084de4d9b ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU")
   6f0624b4427e ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU")

Both set BTUSB_REALTEK for 0b05:1bef / 0b05:1d70, so the adapters now go
through btrtl setup. btrtl only learned about this chip in v6.19-rc1:

   4a23ce935f74 ("Bluetooth: btrtl: Add the support for RTL8761CUV")

Without it, setup fails and the adapter resets in a loop. Before the
backport the adapter bound via the generic Bluetooth class and did not
loop.

Affected, checked against the stable trees (btusb.c has 0x0b05/0x1bef,
btrtl.c has no rtl8761cu entry):

   released  6.18.50 (aa7b93fe98ba, bce588b4ca08), still in 6.18.51
             6.12.109 (f05baf6e0680, 32412aff8d11)
             6.1.188, 5.15.221, 5.10.270
   queued    queue-6.6

Not affected: 7.1.y (has 4a23ce935f74 but not the IDs) and 7.2.y (has
both).

Observed with an ASUS USB-BT540 (0b05:1bef, hci_rev 000e, lmp_subver
8761) on 6.18.50: 203 re-enumerations in 37 minutes, one every ~10.8 s,
independent of the USB port:

   [    8.008281] Bluetooth: hci0: RTL: examining hci_ver=0d 
hci_rev=000e lmp_ver=0d lmp_subver=8761
   [    8.008294] usb 5-2: USB disconnect, device number 3
   [   18.476022] Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)
   [   18.852034] usb 5-2: New USB device found, idVendor=0b05, 
idProduct=1bef, bcdDevice= 2.00
   [   18.875711] Bluetooth: hci0: RTL: examining hci_ver=0d 
hci_rev=000e lmp_ver=0d lmp_subver=8761
   [   18.886986] usb 5-2: USB disconnect, device number 4
   [   29.228274] Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)

Same machine and adapter on 7.2.5, which has both commits, works:

   [    7.816015] Bluetooth: hci0: RTL: examining hci_ver=0d 
hci_rev=000e lmp_ver=0d lmp_subver=8761
   [    7.820005] Bluetooth: hci0: RTL: rom_version status=0 version=1
   [    7.825030] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761cu_fw.bin
   [    7.826003] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761cu_config.bin
   [    7.840001] Bluetooth: hci0: RTL: fw version 0x7bf15762

6.18.48 (without the IDs) did not loop. The kernels were distribution
builds (CachyOS linux-cachyos-lts 6.18.50, linux-cachyos 7.2.5). I
checked the relevant btusb/btrtl lines against the vanilla stable trees
listed above. I only have the BT540 and only tested 6.18.y; the BT600 and
the other branches are untested but in the same situation.

Could you please:

   - drop both patches from queue-6.6, and
   - revert them in 6.18.y, 6.12.y, 6.1.y, 5.15.y and 5.10.y, or backport
     4a23ce935f74 (btrtl.c, +15/-1) where it applies. I have not checked
     whether it applies cleanly to any of these trees.

Thanks,
Ralf Ahlbrink

#regzbot introduced: v6.18.49..v6.18.50

#regzbot title: btusb: ASUS USB-BT540/BT600 IDs in stable without 
RTL8761CUV btrtl support cause endless re-enumeration

