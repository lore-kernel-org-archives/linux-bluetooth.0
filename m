Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795711742;
	b=wrUmOu4wECmI+N4HSD6kuQJF9+CHU+IlVLxYXx/mNOPrY5Kzv+yDQB2EdirMqgVnLp0r
	 cbWV6c+w3mpCrkdZfeJmVX/X4drfkB92AyQmpXsC9ZTsoFhtKvea+C2npVL+ZkNpeJoq8
	 oy/zXFT+WxTjB0+IpU5L/GsOmrDz2Pi+xaxhbJyOpYRUOZY3PdEJua1qKswaK8m5AxZDM
	 wO7YUdpPMzHCUN2mu57VpNf2WjHzw47wTWWn2/5aTPcC1c+jcLjSANcc5E3IZ+MgCELvb
	 /QXfAdtK7G4jWpNmHaZSL9zr/6vu1iOwnudo1gjLAAiEmOTF4xZ2TaqbKX0dfAGjWGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=4gY/UuIx8X4kDzDA3uET14/OSNEJBfL504RFyUB8moY=;
	b=k+N1QGrTWRidmv9/LKqZqB0xSZh3SlwjwRiqDifNAuQGPb37ulgzotOPXJVl379svP5D
	 jUDYOGXI8JAjBalqBzYGqw4aJr11IoAAXkT6ZifXVFSAp138Ykb/2urQ47iR5Fd+JoQ3d
	 R6/HxmcolGrSz/lz8xhECC4UflzXWHoSa3RUc1xOF4g/wTI2canw/vR/ZDztpDpo+46lI
	 QxIIDbm5+YO9MxGnQbSvlJVtFKrEigKwHhRCxhKXzilxb1gO437nqD2GqmZD1xow2QoRX
	 vCyehsl8MRp71731VEt3x9MADxEy3kxRMwk7a2QcNeqVvixslDoYbL0n/xnQ64QsB/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f3zpdAqW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38B606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 16:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F38B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f3zpdAqW
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b4c685c751so63200287b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 08:49:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795711741; cv=none;
        d=google.com; s=arc-20260327;
        b=e7iE+nmt6+PDrZ6iSWjOrbmNRI7UKsbumNCIhe/YPZT1pC/tTKilkOyXgnzFqz9XA3
         hh+EZiBNcihafULet4ksKxtXMf1GEFRC++S/+cs1q+jH+IQLH+gNZvCiMn1TcPd8/By1
         VrsLHxiFlNhX8bykKqvZXbGHC3TxXbMFYh/Sw3jgBmEUDRUkAUYBNjIFFyBs8XZu3Trv
         BAJVEJilW5pDcqYCk6MSelFNLmbs4H+gkRyfyo1O8dQUPlAMA2pfYXdazGOAVNDeKN57
         enYT6zN8l16yASHKLrg0l5KJueHVslzIO97UD58D6Z3VK476ML9JfZ3yhzPWkNpcWhZ3
         M9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=4gY/UuIx8X4kDzDA3uET14/OSNEJBfL504RFyUB8moY=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=mx3haquD+YocohqGF3c+mMbeG9FjtewHc4oRaT6McFNc3ZtffiCufDgpgX2hGRI03s
         gouxICQmKv8LK10F5Zc57NGDoETKfX5QHu7DdUokidxoeIxtR3gJiqkCD/jy0NCF0SZU
         JBumuicIkogiAPTpZawOATd8MPcCgGxDUHhcbEUNUwOuGISjnakwu9x+BwpNZxscwLFl
         LA7OCo5VcE0rx3rVlGiiDVMF5ltYq5dY5FvRWHZnsGNT3aafXch0iCPNYIvlPSwzm1P1
         g/RnjV1lviY5aIF3+Wj7+yOiQcq5BnAOKcWFm2a+NZ6+U5By7frHseXwRVYIkQKQA88p
         JSMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795711741; x=1796316541; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4gY/UuIx8X4kDzDA3uET14/OSNEJBfL504RFyUB8moY=;
        b=f3zpdAqWzIkukp6FgTC9G6Q66Sv3ed7cYDvL/q/v33TftqvVwlc602QuoOMt9FbXYW
         4Hs8gzacM3QqWxbqrwii4v14xIfcQLgzPJzjlPXkf8i0l1BERH27dTNs4y2xLk8Wt4ba
         KiRvBKI7W2hT5PsoruWLm6J9ZEFvSvKWGWk0/Qm34hnvzvTtbqkV8d0iyU//b8b3IkfT
         tuHZ57ezpfGspYb9BzTjNDWRD+Hp+hLJwGLVQi5rTc3rlaqzocAzev8OiPn4f76h9f1F
         cJTFDIDtpT5QrW7A9WokOJxj3rxU+PT0cItgXiPGFzWD5dDqioglOBOBRlKEqFOJjOvq
         kPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795711741; x=1796316541;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4gY/UuIx8X4kDzDA3uET14/OSNEJBfL504RFyUB8moY=;
        b=nK+VT9XLKVhj6tMYPiJxguCP3Woah4oEpqlr8PE6StZ45TPGl4+2QEG9OdLyqWd5Es
         Ernx4xvWrsc+AD8SDyfB2Y+/Ncac3aw0OEmbzekafv1fDeuOOHicCsdiJYbnch85Dzh0
         3VEyxsw8kcB6yqUkdcJJOWQkAoApkr95JCZiTZRemllCK0d9GYCJgTwX1cdhHmmnkSl/
         Q4cP46WSwExquWgkquBFUSpojBsbWx+8NHhA13pRwO9PJ6Nrqg4kdnXkUg+NPaltYBPL
         QKVZcFuDO30wYZHT8/Ca5xJUSOo0b49LjVOcZ9+8VFyUL4fkVASTtJ0h4uGFqWVyb6vs
         X7XQ==
X-Gm-Message-State: APuU4Z+0Tl0McJDpk9ZQwv+vgxAgz7zL6Tfi8Q8kLJnc9ZKXrdG1/ee3
	k8OW/nQMWwR/c5OIiTvIbFVSOPyUgtv2wc8n4LNkN1xOrPkcc3D1kiaYXf5gZAP6WeR1IhVM7b3
	x9S3hqjqE0VP7unzkABRbihcc6I3NL6Q6JA==
X-Gm-Gg: AZFdTZeMGhYkO2uH5Cj3UyT0WEH3DD4p66lWZg/X+S/5J0RHKQ/xI8Jut05/6XXaYEO
	VmXQsMBg3sV+geKmRLqYDhpxASa00Tjuw7nB5rx2f2DP03oqBV3G15MCo45UeNF5I8MvuTGV98F
	WZsI5pofK/UHmmNg2mFD7GjSIw8xgDIlApsdag/a2MRx4lzrEVMLlEANrLg+I7qliuC6H6tq6Jf
	cf8LE+8I9D3kcZGk8cZcv6kkSTmYcv/mYiCce40DsnMrzMnfSVT/MpBEgap0BJ5gMUXi2BfKPbY
	PsRGWNfWPR6awMnWSQTt9hGgkCR1weyRWpqPestOTrePhxJ/La4UsyybHxLr5ISz5ddg5finNwR
	vAMNTNStDrPzd592nH29Lr5yysUb/aT1kJEoC
X-Received: by 2002:a05:690c:9201:b0:8b5:6a79:627b with SMTP id
 00721157ae682-8b56a79630amr21982687b3.25.1795711741066; Thu, 26 Nov 2026
 08:49:01 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 26 Nov 2026 10:49:00 -0600
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: dkl rozyccy <dkl.rozyccy@gmail.com>
Date: Thu, 26 Nov 2026 10:49:00 -0600
X-Gm-Features: Aa3M54rj8svRazozH1MRYePirjuM1Rk82CTLAupWjsZW9MvDjcnpK_LTs2nHo1k
Message-ID: <CABo4nEvLVN2W2hDaQJ20QjzpJf3AwsTVvra7=9wiZhG0fnbi3Q@mail.gmail.com>
Subject: RTL8761BU / TP-Link UB500 (2357:0604): persistent USB reset loop
 after warm reboot
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I can confirm a similar Bluetooth initialization failure on a TP-Link
UB500 adapter using the Realtek RTL8761BU chipset.

Environment:
- Debian 13, amd64
- Kernel: 7.3.4+deb13-amd64
- Kernel taint: 0
- BlueZ: 5.82-1.1
- firmware-realtek: 20260916-1~bpo13+1
- USB ID: 2357:0604
- Firmware version: 0xdfc6d922
- USB host controller: UHCI

The following errors repeatedly appear after a warm reboot:

Bluetooth: hci0: command 0xfc61 tx timeout
Bluetooth: hci0: RTL: Failed to generate devcoredump
Bluetooth: hci0: Resetting usb device.
Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)

The issue was reproduced during three controlled reboots. Physical
unplugging and reconnecting restored normal operation every time.

Unsuccessful workarounds:
- USB deauthorization and reauthorization.
- Disabling per-device USB autosuspend.
- Setting btusb enable_autosuspend=0.
- Explicitly powering down the Bluetooth controller through BlueZ
before system shutdown.

The final reboot confirmed that all power-management settings
persisted and BlueZ successfully powered down the controller before
shutdown. Nevertheless, the initialization failure recurred.

No previous working kernel version has been conclusively established.

I hope these additional observations help identify the underlying issue.

Kind regards
