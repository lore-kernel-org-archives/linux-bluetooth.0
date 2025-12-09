Received: from mailout06.t-online.de (mailout06.t-online.de [194.25.134.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D93002B4
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313716; cv=none; b=iJGTsR79QpArJg7mRAyvhtWIF5k4V9ani8/bXcpIj533oHZO8+U6nCTQjtbw8rw1xezV/M13twUyQkh15BLujS7r9LLaLxT9PGHIurP2HG6LaQMnkSmdb0AXK4OCmtvbW5J/TDaTKllsJhcLw//tN4bEIUO39gHA9L924Me7w9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313716; c=relaxed/simple;
	bh=w4rbxTFE5nlp8aBm1gntPhA+wBimSRAL+KipVT6Kp9A=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=mU/CaSlRbENwwnVNG08PxW0P85p64cghnl12ehr/vQe/7NRZoSaatyvJUvvRnItH+LDoeKIrZ+GSZYpneVh1JGgQlGg7HKlQRrYXzZmizYne+9ZROMftvg+hfu/QKPz1YVVn1VI2wthCWgj5m0aTUW/1mgrwGRMFBXVlCYVcafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd76.aul.t-online.de (fwd76.aul.t-online.de [10.223.144.102])
	by mailout06.t-online.de (Postfix) with SMTP id C71BC1586
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 21:47:22 +0100 (CET)
Received: from [10.2.178.119] ([80.145.206.223]) by fwd76.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1vT4c8-2oExNJ0; Tue, 9 Dec 2025 21:47:16 +0100
Message-ID: <5b62963c833862dc522b219ff5f5619991eb958a.camel@t-online.de>
Subject: [REPORT] btusb: Missing ID for Quectel NCM865 (WCN7850) - 2c7c:0130
From: Frank Tornack <f-tornack@t-online.de>
Reply-To: f-tornack@t-online.de
To: linux-bluetooth@vger.kernel.org
Date: Tue, 09 Dec 2025 21:47:08 +0100
Autocrypt: addr=f-tornack@t-online.de; prefer-encrypt=mutual;
 keydata=mQINBGD6bpgBEAC2K1YdfGWeSkNKDFUatWHUenfQISnvzW6Za/EwXpsuFKZ8eg8tReM+L
 w7YlcWZNPbxtu37zRp9oxSr6dwPw1M+Qyuy8zHaKRcKUT4BFVFzI2i7qMMAPXYwqTm9nAQ0fSWHkZ
 d8lI2YC4TV7NV9+Dz6KV82FvdRA+rx3AHEzNixJnEQKcGbHCvq2/ipjAgFp53ExrAUxCLdU7tfaQY
 BIYtt68QevZJJCqN7NEaZSxWyPjiyJrabgVrnIPATZCwLqRJE6W82eUmFVm1RMJVAfR9LB5zLscR2
 taxP9TXL+utReukPcRrMqG2sYQPPBWo5Ixp7Q0RiuXQ9xmegXgdxz2RJ2cxevjfFWR23sOwjI+grD
 3CF7HF0nirHG/dMrmLvDJxMtwm6WHSmgaCsicrkIU4u/GXTPXVx1qBQbcqfQB2ULQHuZbmfVKMTsw
 KXe8SeBgeKdBF+eZ/2Ol4b8cCDRZnyeERFvFtyLOyjpREtQLIP/40X+LExPkmlVnOYZQwNYIN4Hjh
 Jm6+WVU3ejS1UbhsPq/nfD/TdW12Z9RzDn6JE8Dq0PR+9WOcItfZcIpTG0fGo4MlxqpiJ2tym/GO1
 wiroqvc1fc/DDlUEd4NHiBejaP5T20/j+dYH1BAAjLwZKMVDdEOMiFkAQ7/VaVNyR306dWeNOR8hY
 2rCXcasxT4njwARAQABiQJOBCABCAA4FiEEUq2xkWJh1uZ9Xmrq92m9vmmDMMoFAmD6ckcaHQFFcn
 JvciB3aGlsZSBhZGRpbmcgcGhvdG8ACgkQ92m9vmmDMMqC0g/8Di2Rf9Q+7xA3cHznsmGukanyxVb
 iwcZpO62UM/iKCS4pIHe3OUqukOpXgDKC3HUCfzkZ99SxUioMyGPmfa7u6/Pf7yuEMFWyhgYVJmZR
 N7kgQRW1IKIaFaCYJ7bS4De6BSSGFLv1qphdrSHrLG1Yg36r4tz/qtS7Yl0REEVB2xelY6mE3U+e5
 kIAabG67vLVT5NqqKowSzRuiLLJd2GO6oSczSH688YSa/CQIF5zPh4pMn1bao8h5USpjrH5U6iWDE
 mQu1iEWgG/x6LQDdRG3+O0iSi3+xJBzxTV2w0qdMoMYU2fX86VhuZnu57E513PI6tNe+ny6BZCTet
 IlHpDNbIgCjUYTCqbAqj73nSjcoMKCNCRvd+kKPrKPbryLIc0PFxs1kgZNCZ77ZzO4FdhQhJt+l8C
 vbvsOg8Jy0d/TW2jNXOEnSZJ89QBxwm5tsOUNT4vcZnbueHTBbD7Lnr8uf7MdKKYR0jB4RPKXt86Q
 EJWSbcX9ohyQJVeiuArNP3D4jXO/5mRTapP4GgcJGkuk7ol7caPEi5eTA3vn5Q7nZpPv8YxLi/2gy
 Y42jxwf2LedCujmJMOikPqc7VRQTtQTMmQXqmh5vtjJEoberYut6QSPDemKrPZ56dl60Osc9Kn3Qs
 WJz7UZSfDZSqfTuxwJsdJdBoZ1UO2XzQraXoAAIa0b0ZyYW5rIFRvcm5hY2sgKFNjaGzDvHNzZWwg
 ZXJzdGVsbHQgYW0gMjMuMDcuMjAyMSB1bSBhbGxlIGFsdGVuIFNjaGzDvHNzZWwgenUgZXJzZXR6Z
 W4uKSA8Zi10b3JuYWNrQHQtb25saW5lLmRlPokCVAQTAQgAPhYhBFKtsZFiYdbmfV5q6vdpvb5pgz
 DKBQJg+m6YAhsDBQkB4VgIBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEPdpvb5pgzDKJxkP/i5
 eoYg4Vy5dJ06HCME+yVxAwY86tKvaMkRU6oHGwY4PhgCQJsdbymRzxzZL5Mn92BgK7hSDAPOel3eN
 S9ATUAn0RiIwqAwoxpaWLeXuAPLj5unAHsaqYIxuSQAho5W6ERUSi3k+nsZvhAC+9W2GHICYycUdh
 s7FZLzEHhT8WXZXKNmMH1FwMnsaUdWaHUA085bCIY2NwPRqWKr1wis1k8mG36boBq1MBLjFQ77Jno
 PfT5oACRYXrE5+1X/KmeSshWY9DtnJa27OxhLdD5pmPbdI5uonDh2aWREneOFH/6kx/ihlgW5TF73
 S2Mck2fLsCrBYKryF4Ghu1Qq7z26gOnib1o+3vLDLl1Ur4wkIz6KqEhTVwpLCEHPITepfECGFrrlg
 vUu9q+53mo2Qc84RBcIsYWxAw2xVx52vtHZXl3BBowabJJoziWQahwU1GtNBGYLBaULA5yTS10GqW
 K+NsEBZV7i0vR27b5dUlTxFcLTjqkE/KEXbPU5WAzCarz2uuvwzgoIlgIcKxJXEJ6Ggm6VaO/pP7E
 d8Hi3c1AZ1xrEI+pw/34tVidQDruOeu0VQG5jFd82OxNlRR1w4i0IhbItr1RNE3AzXYBPmLJkZ7A/
 N3MKC5cpa0wmp7LE7maCViqYCczdSqf0CEeEefhLtNhkmVwUTVxavgISv4DM3LKj3mDMEYPp0PBYJ
 KwYBBAHaRw8BAQdA9MoQWxT+PljXoionhEHpIAuLlhUME07Jht42EmJS9/K0f0ZyYW5rIEVja2hhc
 mQgVG9ybmFjayAodGhpcyBrZXkgaXMgdXNlZCBhZnRlciAyMy4wNy4yMDIxLiBBbiBhdHRlbXB0IH
 dhcyBtYWRlIHRvIGludmFsaWRhdGUgb3RoZXIga2V5cykgPGYtdG9ybmFja0B0LW9ubGluZS5kZT6
 JAoYEExYIAi4CGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4ACGQFEFIAAAAAAEAArcHJvb2ZAYXJp
 YWRuZS5pZGh0dHBzOi8vdHViZS50Y2huY3MuZGUvYS9ib2xsZXJ3YWdlbnBpY2FyZC9iFIAAAAAAE
 gBHcHJvb2ZAbWV0YWNvZGUuYml6aHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vZnJhbmtlbnN0ZWluOT
 EvOGE2ZmEwNmMxM2ZiY2VlZjhhMjRmZDFiNmRlNzIyYmFFFIAAAAAAEgAqcHJvb2ZAbWV0YWNvZGU
 uYml6aHR0cHM6Ly9tYXN0b2RvbnRlY2guZGUvQEJvbGxlcndhZ2VuUGljYXJkqhSAAAAAABIAj3By
 b29mQG1ldGFjb2RlLmJpem1hdHJpeDp1L0Bib2xsZXJ3YWdlbnBpY2FyZDp0Y2huY3MuZGU/b3JnL
 mtleW94aWRlLnI9IWRCZlFaeENvR1ZtU1R1amZpdjptYXRyaXgub3JnJm9yZy5rZXlveGlkZS5lPS
 RjWGVqcnQ3dWJ1RUF5aTNsaFVDeWFEUUlBa0lnRktHMnF3TF8yTXl6MDY0UxSAAAAAABIAOHByb29
 mQG1ldGFjb2RlLmJpemh0dHBzOi8vZ2l0LmdnYy1wcm9qZWN0LmRlL0JvbGxlcndhZ2VuUGljYXJk
 L2dpdGVhX3Byb29mFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAmiMmowFCQhajfQACgkQVa3qmdMF6
 s2uHgD/dxJ2cY3dVn5DJCkCNdr0wxz0rL5MZtqXfRxGOlH6GZQBALoRq4LFNYIeiuJjVi6iNBjKQg
 0AbjOnM/UCVTAGjAYEtFBGcmFua2Vuc3RlaW45MSAoRGllcyBpc3QgbWVpbmUgU3BhbSBFLU1haWw
 pIDxmcmFua2Vuc3RlaW45MS5pbmZvQGdvb2dsZW1haWwuY29tPojQBBMWCAB4AhsDBQsJCAcCBhUK
 CQgLAgQWAgMBAh4BAheAORSAAAAAABIAHnByb29mQG1ldGFjb2RlLmJpemh0dHBzOi8vbGljaGVzc
 y5vcmcvQC9NVExGcmFuaxYhBIqzlkn93enweqtxJlWt6pnTBerNBQJojJqSBQkIWo30AAoJEFWt6p
 nTBerNeMsBAILdFx36go3uOgLVukgeD+bWu2q38wY29u4icMiCfadsAP9nngHM3BIiY4r0RWWrY8E
 KFcNM+DfPF2j+BCmkpu/LD7RMRnJhbmtlbnN0ZWluOTEgPGZyYW5rZW5zdGVpbjkxLmluZm9AZ21h
 aWwuY29tPiAoc2hvcnQgdmVyc2lvbiBvZiBHb29nbGVtYWlsKYiWBBMWCAA+AhsDBQsJCAcCBhUKC
 QgLAgQWAgMBAh4BAheAFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAmiMmpIFCQhajfQACgkQVa3qmd
 MF6s3pOgD/ZEnhUZ7GUWlcuWReqZNI5YX6ZvfiBf/c/Z8Tb+M3kZQA/29ktoeEe78tMiFtBp9nhbK
 sopm1fvM5aaGDn4nXSnMJ
Organization: Privat
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Z4ytX2Ub9BRXMsn0+T3E"
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TOI-EXPURGATEID: 150726::1765313236-227FA4B6-6578F901/0/0 CLEAN NORMAL
X-TOI-MSGID: d6568575-7d37-4a24-a2f9-5e66556c17bd


--=-Z4ytX2Ub9BRXMsn0+T3E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I would like to report a missing device ID in the btusb driver for a
Quectel NCM865 module. This module appears to be a repackaged Qualcomm
WCN785x (FastConnect 7800).

The Problem: The device is currently not recognized by btqca / btusb.
It falls back to the legacy "Rome" identifier (0x190200) and tries to
load rampatch_usb_00190200.bin. This results in missing features (like
ISO/LE Audio) and potential timeouts when trying to force the correct
"Hamilton" firmware via symlinks, as the driver logic does not match
the actual hardware capabilities.

Hardware Info:
 - Device: Quectel NCM865 (WCN785x based)
 - USB ID: 2c7c:0130 (Vendor: Quectel, Product: NCM865?)
 - System: Arch Linux, Kernel 6.17.x

```
% sudo lsusb -v -d 2c7c:0130                                               =
                                   [21:21]

Bus 003 Device 005: ID 2c7c:0130 Quectel Wireless Solutions Co., Ltd.=20
Negotiated speed: Full Speed (12Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x2c7c Quectel Wireless Solutions Co., Ltd.
  idProduct          0x0130=20
  bcdDevice            0.01
  iManufacturer           0=20
  iProduct                0=20
  iSerial                 0=20
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00df
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       6
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x003f  1x 63 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x003f  1x 63 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       7
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0041  1x 65 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0041  1x 65 bytes
        bInterval               1
Device Status:     0x0001
  Self Powered
```

the output of dmesg:
```
% sudo dmesg | grep -iE "btqca|Bluetooth"                                  =
                                   [21:21]
[    5.432336] Bluetooth: Core ver 2.22
[    5.432357] NET: Registered PF_BLUETOOTH protocol family
[    5.432358] Bluetooth: HCI device and connection manager initialized
[    5.432362] Bluetooth: HCI socket layer initialized
[    5.432364] Bluetooth: L2CAP socket layer initialized
[    5.432367] Bluetooth: SCO socket layer initialized
[    5.461019] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00190=
200.bin
[    5.461022] Bluetooth: hci0: QCA: patch rome 0x190200 build 0x43fc, firm=
ware rome 0x190200 build 0x43fb
[    5.862663] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.862665] Bluetooth: BNEP filters: protocol multicast
[    5.862668] Bluetooth: BNEP socket layer initialized
[    6.098821] Bluetooth: hci0: using NVM file: qca/nvm_usb_00190200.bin
[    6.234023] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.
[    6.478241] Bluetooth: hci0: event memdump size(589824)
[    8.290957] Bluetooth: hci0: Opcode 0x0c03 failed: -110
[   10.338077] Bluetooth: hci0: Failed to read MSFT supported features (-11=
0)
```

It seems this device needs to be added to the `qca_device_info` table
in `drivers/bluetooth/btusb.c` with the `BTUSB_QCOM_WCN6855` flag,
similar to other WCN785x derivatives.

I am unable to compile and test the patch myself right now due to
travel, but wanted to report the ID so it can be added.

Best regards

PS: resend... because I was not aware that HTML mails are dropped


--=20
Frank Tornack <f-tornack@t-online.de>
Privat


--=-Z4ytX2Ub9BRXMsn0+T3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSKs5ZJ/d3p8HqrcSZVreqZ0wXqzQUCaTiKzQAKCRBVreqZ0wXq
zb0+AQCBknJHpsRdsbrU7kSz2hljb6dZksCSVnvuJkNfZDNlvQEApNQXIMQW+p2G
QWSH8buYJviDLSpCiCArkDe1mFtlrw4=
=yeRi
-----END PGP SIGNATURE-----

--=-Z4ytX2Ub9BRXMsn0+T3E--
