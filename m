Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795451644;
	b=x/UOSeRfWkW4DMftGoUgWarXubptgNtCq5Xb685itRefQxL5W4cdwOmLyFwF4Z3xGAi/
	 lVqOBrBzjAd2SW7Na7bgeRjIEaRGzVgwomtf+Ug8XdWvSaeKGgmfmHKR68s5YkObiaVLD
	 gEZwkkUSvA5kCQag3MuQMNF7psnl4Ww6sj1Yx1y8hfGE9Ng1Q/DKhej0yZoMdBgM3KUm7
	 h7cFtzZEdUIQPGiZlQtOdk9/SkpnvN0ZWnFDK4gLQb276aP1xUJ5sbBq+HAq/2lEqLD7i
	 i4k2q6M2U6QwqcCVKT89KU+QB2Ae+O2kDwgGz46AExxH4VMbFIDLDNQMME2d91paNEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=AzKiAkOTTHX2gLj91Zr3SVsYjr5iGJFZNzEcUAwvW98=;
	b=yLIHtNNZHw8591MVzKdGs4oHEZdoxiWttaDbpdHz/qtgj0JpQ41Pq0U+QFDpGezSC1p6
	 GwxgEnyzSTiiR7BDHG63XKBE4fuxTZD/E5Rw1j1oLvs+cy6Ltic5+y+p89si7pMsLSnkI
	 VrziTbmwuUlR1t6hV0Qagd159IBZp/MeFJbwas5scfQaLSVc+qsOHSgsUdaMPNRx443aH
	 Y5rI+Ahds51fYDT81GBzuF+19L/hqoFdU1o9SP18wJNumRt9eiWUSdZausbC0wURuFLvZ
	 TfpKB9eD/H50TC0yyzaB6nOEflKr0MexG/gQxpNkm3W2aYi0yloLRSXMC8Zw3zwq2FA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wx+rA5Ps;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916DE606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 916DE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wx+rA5Ps
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c50cc7540b7so478565166b.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795451642; cv=none;
        d=google.com; s=arc-20260327;
        b=SLjjo5YM9DUjGB91JcKJzfyCplPk+pgGXIarF82vhmhEWbPrVrfUbl7tl3kmtnPcLj
         0y3eU7AW/PTlD+5iZG1mzZaiDfHJFbEgldv6T3DbUcUCaFJAdk8hQmKK0+KGHXJPaHy1
         KOBmGocAAyZrvAol/VEscv8kDNn7+ch8JIXiJaziab6sJJdv6Ri5i7ZDYuR67F8tkB9h
         lbKnDOuXZLmh9qOLdnSB1oNxcabcM5DO9yoJ0BRCfm3MaGE+CLZsAh7UZNR8LogG9pNI
         fWwz3O9DObpzutRWjxAOM5CyA+7stUQ8OCchiCjVTFGICudvZqBy+JTR2d6lQpphxaKP
         Ut0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AzKiAkOTTHX2gLj91Zr3SVsYjr5iGJFZNzEcUAwvW98=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=MIQYnV/vhBfzqdqO9uR9wOaRiPzh1KVmfNE6ewUvq/n6yL1EIdQZGMZn6m+d9Fd3kD
         OkTF7rk2HDa0T3+mOvZ7fFNY3FXhE+eOLRNybEOiTmNqlaxN4tOvlyaHYnN+I2ljwtXj
         eIsjTl8lDZJunIdT84lxcxgpTw/+ngbNlVW6/YuamPsnvjXxV41ZFzqIZ4JZDGgN/63X
         WYRrMCVmbDf/iK1bmX4S8CX2I05pa6dNXH349443MNC6Ic8/qNpMSW+746NjU2XCde2U
         82FwB3/jrn2v84quuMA4rFIE2dldu9mN656GqeRUP6Zs5nUWtnlWmPmzGS3QR29JLqj1
         +ZSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795451642; x=1796056442; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AzKiAkOTTHX2gLj91Zr3SVsYjr5iGJFZNzEcUAwvW98=;
        b=Wx+rA5Psr9fnSVwhsUbvrft1OFL4a9dAZw3NxUlwzgIvXEF4JLgRISNrJyWSbSFzZO
         cjpVR6hyjCyq+XYLIxBXv+kh3MAcn+bxaGJhk1PzNM6MoMSz8UXDCgGU0ScBbCPOvmel
         vDM1rMW9bKlkU0pNM/Ob0PEM6xSPZv3Srk5n32omnAyZXD9+q3XWx/cLgqghWijBlkcm
         ijHUxVJE9C6se488idIiYhuB9iMrMJE7mIpBLDfwYNkGuGKsfENqfgBEx7pF5dpUlpn8
         cN6Bcsp/Ng/Z6uDTAA2Wpn+DvSPC5plZJvJ+9+KhQ6/AB9ufBYSrM8sdht5zRsqxgDnl
         4U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795451642; x=1796056442;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzKiAkOTTHX2gLj91Zr3SVsYjr5iGJFZNzEcUAwvW98=;
        b=nD3TIyKS5ijHx/k/2Vf/C7s0y7V8pIxXGE7NHTuPYfd+vKtkHRWQgdSubbn81hKCE2
         BK1fNanOkU61smQU9VpJm3VcJS9HNBurWJBa1Q49Pj+O7TxxmlZ8u2Pihy7bQKgmf+0L
         sS2VXOukoU4fFF8Haoe75ELiiyfD9mwIAvzTj8LU2DmI3cB5cBYiLaoZ0qJdFysXpYWI
         93icQPJY+yHBcPH6VbZnGRBpe0fPk287QMdHzbmycGiCv/vhVzRIfX/0gLTw1BIZLgy/
         3jofyeNWlUnQR2pia0uob08Pk2uoAvM+TN3c7MsPl/ACGGP8B6KmuQT9N5HVV/5cKlyN
         3EdQ==
X-Gm-Message-State: APuU4Z9inaCS15bJ3sYC5eygiaCIegHVbS7dUPOj1ODwt8e29u+eGYe7
	PIpM2ZapwDoon6HTmKA0aIuGluveTPO5ULREr66Yyq/OrdyaNFHqR7BSIALM8U0BXOOtV2dYKkj
	hrpCYysqYjEi8/g20u5kb9yD4smNSjgwU4Vkl
X-Gm-Gg: AZFdTZdJNm1jEVbsKnYRnUo8eIrpJlyaPvP9TgLPTnchIj0aLiVSohE3mjHYbcgd5AV
	4zelgmDNhEwD8TbdRsz2EGvNWHzKugjbO8R36RSNCoU4tLGhhd0ygXqddKjHp/I1BkSXGKOpIhS
	p6k57H5bovXyVs7EDTNzkQ5J8pu5951Nk7eTwv0cfXO3OiJ8fqxP/PNYzafI9JrJIRTgX4R6iS2
	4/hqF8HsV+ZepORc/yxMB0YgdgjdnQ/oWVOwIA/Lul9BX2YQyhFkK25fd9A4DjyOs4pc2YnP76J
	323g80jJaCSqXEriDll0yKR4SDY29eYIDvIQwQpUrtlE+dQ0hQTNYGCjRMDDGhf6IxhjqBYdhtK
	AVASwSqe/O7n5L6jsggG+HrM+GrPTx2Eh8A==
X-Received: by 2002:a17:907:a88f:b0:c46:d493:501a with SMTP id
 a640c23a62f3a-c513a8410d9mr1057622866b.22.1795451641708; Mon, 23 Nov 2026
 08:34:01 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Sandeep Datta <datta.sandeep@gmail.com>
Date: Mon, 23 Nov 2026 22:03:49 +0530
X-Gm-Features: Aa3M54qkXXCOBbHEBYyQXcWQRxtyLx1Dd6MQqgiqg1iaj5QFTldYHZ9rWM1Y570
Message-ID: <CABMMkDOX1Q92yq98+Jhr9D+VgrC128bcY13cvA-KhC5r6x5ZNA@mail.gmail.com>
Subject: Incoming BR/EDR ACL links never get EDR packet types; A2DP stutters
 (MediaTek MT7922 0e8d:e025)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Note: this report was written with an AI assistant (Claude), which also did
the btmon analysis. I ran the tests on my hardware and confirmed the results
(the manual packet-type change fixed the stutter), but please treat the
kernel-code statement below as unverified.

A2DP to a neckband headset stutters badly when the headset opens the ACL
link (its normal auto-connect at power-on), and is perfect when the host
opens the link. The difference is the packet types the link may use.

Setup
  Kernel 7.0.0-43-generic (Ubuntu), BlueZ 5.72,
  PipeWire 1.0.5 / WirePlumber 0.4.17
  Controller: MediaTek 0e8d:e025 (btusb, btmtk), BT 5.x
  Remote: "Harmonics Z7" neckband earbuds; LMP features include
          EDR ACL 2 Mbps,
          3- and 5-slot EDR ACL; no 3 Mbps
  A2DP SBC 48 kHz joint stereo, bitpool 2..38, identical in both cases

Outgoing link (host-initiated, good)
  < HCI Command: Create Connection (0x01|0x0005)
          Packet type: 0xcc18   (DM1 DH1 DM3 DH3 DM5 DH5, EDR not excluded)
  > HCI Event: Connect Complete (0x03)  Status: Success
  > HCI Event: Max Slots Change (0x1b)  Max slots: 5
  > HCI Event: Connection Packet Type Changed (0x1d)
          Status: Success   Packet type: 0xee1c
          (2-DH1/3/5 allowed, 3-DH* not, BR DM/DH 1/3/5 allowed)

Incoming link (remote-initiated, bad)
  > HCI Event: Connect Request (0x04)
  < HCI Command: Accept Connection Request (0x01|0x0009)  Role: Central
  > HCI Event: Role Change (0x12)  Role: Central
  > HCI Event: Connect Complete (0x03)  Status: Success
  > HCI Event: Max Slots Change (0x1b)  Max slots: 5
  (no Change Connection Packet Type from the host, no 0x1d event)

A2DP media on each link, same stream, from btmon's Number of Completed
Packets latency and the TX timestamps of the media channel:

                                incoming link      outgoing link
  TX completion latency median  385 ms             14 ms
                        p95     677 ms             47 ms
                        max     912 ms             75 ms
  media packets/s               ~19 (gaps <=480ms)  ~54 (steady ~19 ms)

Test: on a stuttering incoming link, sending by hand

  hcitool cmd 0x01 0x000f <handle lo> <handle hi> 0x18 0xcc

(Change Connection Packet Type, same 0xcc18 mask the kernel uses for
outgoing connections) returns Command Status success and a 0x1d event with
0xee1c, and the stutter stops immediately with no reconnect. Doing this on
every incoming ACL Connection Complete (small userspace daemon on a raw HCI
socket) fixes the problem completely.

As far as I can tell, hci_conn_complete_evt() only sends Change Connection
Packet Type for incoming links when hdev->hci_ver < BLUETOOTH_VER_2_0, so on
modern controllers incoming links are left with whatever packet types the
controller picks by default, and this controller apparently doesn't enable
EDR there.

Questions:
  1. Is the host expected to set packet types on incoming links, or should
     the controller allow all supported types by default (i.e. is this a
     MediaTek firmware issue)?
  2. If the former, would dropping the hci_ver < 2.0 condition (always
     sending Change Connection Packet Type with conn->pkt_type for incoming
     ACL links) be acceptable? I can test a patch on this hardware.

I have a full btsnoop capture of both cases and can share the relevant parts
(link keys redacted) on request.

Thanks
Sandeep Datta
