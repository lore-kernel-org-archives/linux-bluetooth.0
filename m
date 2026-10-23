Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792791881;
	b=e4nUptFXj4ak+Nqt2Ol1QH0w41STm+S2XybGle7qrjO9edz5q9n3YKVII1W/tN0+fod5
	 IEmMYOyKi2w46P06IrOEnSp5xBxsNr98MikeIDj8AdjQ+DtY9VMH0NSQboxfRaxe2lxkC
	 KYQCrMqVVLuJZiWYfBF25HXc4Ae+Dz3Y7lw2d4xgIgPOa+BG0kqjUzYkJ0lGHLrC4YjjJ
	 /rCjkt2OUoh2H9Wtk0Pa1whHzhUOLVU7gyZxHyfFYcZseHwkaTqe8lrNnsdNPuPjADBz1
	 3qjQn2BYHgH9eyR1dg9Iv28in4SaiVYB4vtrIl7A7NaibOl810XNPkJj4RYSgdSWY1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=aHUQIKFoJii/FSQRQmymbt+dKQ3jDSCd6p1ZJwUL4XU=;
	b=p/tb15DAEWlUlCOvWkzB/8FShK5/5rWMS1CkaZ5w2gZmeF//LXUqicqhh2fjTy0K60p5
	 8i32eG554f/InmTq0JAIxCT2BXqYD+o/KhlYuwqxX+f0VNrzCalpi3CoFB4uyHKtngIDX
	 Bam35oaRqdCC6scrr1c8ODv61ndF85qvrtKbOlNLhZaSfSaiWuzbyjc29Txg6SCI3QB2v
	 ps+DzU8OHaIUD5DsBi1fnTVSvVJdY8mQkW12UaV73PgYLdQKgvEC7lPQJmFZEcsW9saXN
	 6A5Wxt0Fc6qjRm/2jA5YmjxlJSZUaUv7/2pBinty4dkcmmnxhN+lWCALTIM50QSNAXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oIpsV8CD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6A606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 21:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE6A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oIpsV8CD
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ab3dd966e1so8721761fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 14:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792791879; cv=none;
        d=google.com; s=arc-20260327;
        b=qjwNkvJAbe4iJc3uIJGcixQHakuYuTGlsTLAjpNAIsxJkBlsLEKkr4QHGjEz1sP4Wv
         6tounvQ1qbfmKS6dN6D2XeJUiBaUbSBiRjab+f5nX+jg0Z4G902mN4n1Se9eoNqPa4zm
         3CQf5Tb+FSZ8B1HW1ZHLLZ/PnV0T/ESXCd9tvU83vTzkfDnqG2PnqkfVW1dTzN3k+C3u
         vpjptcpI1pNtNrbqod9Z34DY3Wq4UcZfVsgIBI6RAlDpn/3/ICrcUQbPEKdZ2tSVtbOQ
         lk59clOROxL5lQCI2baH1ZfL+Yyeu3S8MeiTiQXCHxjpmpuwHFal9HUEJmlEPQn0JkiS
         9K7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=aHUQIKFoJii/FSQRQmymbt+dKQ3jDSCd6p1ZJwUL4XU=;
        fh=/aPkJZZurGpfQ3+jT1OUaEpH/LidMrwl7j1rm0gYr14=;
        b=WTJjwDNUHCl9jxUQEmJ/qg7nLgoPUp1QeVN/NCTTZLA52IdwGFyn2+EGqrIIrKfV/g
         PEwX6Qmep3mjbLvuZ6ELWinUVz4k0lYr0y6KDSKGv1D3HjDeTv7cDewUNlKTOU7ZinOd
         H3kSl9SewHqe8O2fPVPLfvZ152DWMJPjP64wlu4//xJEViLdJBOa0C7Mol5n4qSAeqrb
         Xy+HEpxXsTqncU7fdBoazxhL9XlJ/QeyDuqXFhRpnmeQkFAosdRc7ZksXEAWidakLZdt
         tMjUoEnfNFZe/8VH6C7D0uWpS9fJ1NLuZakVRmUAUxWzsFT8ZyVog9yYXWpAVEoBfFgd
         9E8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792791879; x=1793396679; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aHUQIKFoJii/FSQRQmymbt+dKQ3jDSCd6p1ZJwUL4XU=;
        b=oIpsV8CDQwW7nNx8myXhacHuj0n8EObdj59Umuk3xnf65TdrhOraz8gOrQBJrrFIel
         OhscCqMULIro3ASIM7YRPHHO78Aisyh3KEjgrIDB7scvi/cqYCZrBWiT6UHtmmTKAaLT
         qHlbiUDRIceK7mp9KWjwBZrXMBkWyPvJTNEY/Sgfn/HtuPuWIfoQ1a+Ug1HcbITNzjjs
         PA5yHhxpsY0vMw6NNwaFeHhkxAVNE9HhnQB3p0cYeDNsONw4UHr8LwP9HDctQe5zRs6P
         ilJ8xlrHB4Not/XCAZkFqnpHjMjjijt8SVqSViKdspc6+gIxAYuCB1bgFQPi+xCbyi64
         kkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792791879; x=1793396679;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aHUQIKFoJii/FSQRQmymbt+dKQ3jDSCd6p1ZJwUL4XU=;
        b=iLn0OQvuFyXAyeJvR46lJelD6nldSfZppHKTbvYJfvmWXQuyPDFPryiQdTEJqvDNPE
         Ka7c3VNYlVhNdgixRWLF/uE+zhyfZJKKXo9Fi6PgP1dFosjPDAIIIVbRIKIi+pc8qvk7
         /ENWC7E2uQixLgXeyXFjVdHrIIJbYwBJ8QiXLQ7Z0xLU/lHBVaYrNUxhO9RxvW/ildhE
         eYjVjNK0FS8WfFk6qnFCFFiPCLdBLsNMFQwfvY+XP8TrrcjFJGhZ/lMajlRqLNxqlm2G
         qp1uzS+qGZUHhrV6Lfyo2XlBs11ErIgYt/2oY3EgCOJ7TN4SRKLKscV14kJxsPxx7/s0
         mBcQ==
X-Gm-Message-State: AFq9FYIE1JcoVERbxC+bE2XPrTuwaLnpa0f2QYxOda7b3eH1fr4Xe0Ed
	Y8d5B5Xl8R/T/153DSHMdBeRKMpnKYEFtSucvhCG2AJGDDIl35qgF6WN2Op2e8n5XaGQ6THp7UQ
	4eyXq5epjclPwJrYnL22OnBKpCT1qex84knlARkreZg==
X-Gm-Gg: AYBFou0pZcxqdueTiAUbSyEbCofq3AlWDeMXLaTTJSyTvroclioU9RTHwEjjlFsOVyp
	Du+GyxlwNCyjxUEAcbkD1x0BL/yqrhpJnt7ElOjHUyrp/XHawpyH0XHpWmUnb5yO0xDOBl9VPK8
	e5cC4dAyHrzbIqYX1Ep5chA15Wi4NRkL+BfF1rHbeaDT4/g++SQbmYMzchDUjpBYM6c+eqw3TPp
	nWrUpTyB6+POQCDuyCeO/xXKWblXaf3d6vUrIro6ypAS6VhtZQTfyzowCGj4N0Cu+FjJoFq4FCO
	FF4Eo5xG/w9wwfH8ABBXMvN3wog4f1YoNPkoeBJS7e06MTzRECfphaskQYXxrQUzypt73wQO3mS
	J1HmIxi0lWIgJJiOTQr3hNcEnw1ON2qH1UG8u1k14FQGL+x+5xXqW01Eg3EPCIgiu/bqAixl+Sv
	MuNJpqSYBlloV8k0H/iDjMDWtHhP2mSbQjAZq0ngbYKsfx
X-Received: by 2002:a2e:9a04:0:b0:3a9:ddd6:d820 with SMTP id
 38308e7fff4ca-3ac6fd5eaa3mr1170331fa.29.1792791878431; Fri, 23 Oct 2026
 14:44:38 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Pavel Statsenko <past80@gmail.com>
Date: Sat, 24 Oct 2026 01:44:27 +0400
X-Gm-Features: AclHuK_QahKd74xQMs4vDd3xhWiohJboFOWjI8V0HN91bTkuHV9a5Du_U4cuIJo
Message-ID: <CAO+L2eoKQOemBKE+DpT+a5CsREhrmW16kGamN0CgtaRAAXM_ug@mail.gmail.com>
Subject: Bluetooth: L2CAP: MTUsig rejection breaks Huawei FreeBuds (regression)
To: linux-bluetooth@vger.kernel.org
Cc: michael.bommarito@gmail.com, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"

Hi,

commit dd214733544427587a95f66dbf3adff072568990 ("Bluetooth: L2CAP: reject
BR/EDR signaling packets over MTUsig") breaks Huawei FreeBuds 3, and very
likely other FreeBuds models: they can no longer complete a connection at
all.

I want to be clear up front that the commit is addressing a real problem and
that the amplification it describes is worth fixing. What follows is a
report of collateral damage, not an argument for a revert.

The earbuds send battery telemetry as a single 68-byte Echo Request on the
signalling channel, after the link is already encrypted:

  <--  L2CAP Echo Request    ident=129 len=64
       payload: "AT+HUAWEIBATTERY=6,2,100,3,0,4,100,5,0,6,35,7,0\r"
  -->  L2CAP Command Reject  reason=1 (Signalling MTU exceeded) max_mtu=48

Because the whole packet is now dropped before dispatch, the request never
reaches

  case L2CAP_ECHO_REQ:
          l2cap_send_cmd(conn, cmd->ident, L2CAP_ECHO_RSP, cmd_len, data);

and no response is sent. The device does go on to open AVDTP (PSM 0x19) and
AVCTP (PSM 0x17); the host accepts both and sends Config Requests. No Config
Response ever arrives and the remote terminates the ACL roughly 160 ms later:

  Connect Complete      status=0x00
  Link Key Request
  Auth Complete         status=0x00
  Encryption Change     status=0x00 enabled=1
  ...
  Disconnect Complete   status=0x00 reason=0x13 (Remote User Terminated)

Authentication and encryption succeed every time; the device simply gives
up. The cycle repeats every 3-4 seconds indefinitely - 36 attempts over four
minutes here, never converging. Audio hardware that worked before the stable
backport landed now never connects, with nothing in the UI to suggest why.

Raising L2CAP_SIG_MTU to 672 and rebuilding bluetooth.ko restores normal
operation: first-attempt connect, stable A2DP. That is what I am running
locally, and I am aware it reopens exactly the vector the commit closed, so
I am not proposing it as a fix.

What I would like to suggest instead comes from the difference between the
two cases. The amplification described in the commit message is a
pre-pairing one: "a Bluetooth BR/EDR peer within radio range, before
pairing, can force 168 ECHO_RSP frames from one 681-byte fixed-channel
signaling packet". The FreeBuds frame arrives after Encryption Change, from
a bonded peer, and is a single command rather than 168 packed ones. Both
properties are cheap to test:

  - enforce MTUsig strictly while the link is unauthenticated or
    unencrypted, and fall back to the previous lenient parsing once
    encryption is enabled; or

  - bound what actually causes the amplification - the number of commands
    dispatched per signalling packet, or the number of ECHO_RSP frames
    generated from one packet - rather than the packet size, which is only
    a proxy for it.

Either keeps the pre-pairing attack closed while letting a bonded device's
single oversized vendor command through.

If neither is acceptable, it would still help users a great deal if the
rejection were visible at info level rather than BT_DBG. Right now the only
symptom is a device that silently never connects, and the reject is
invisible unless you are already capturing HCI traffic.

I am happy to test patches against the real hardware.

A couple of notes on reproducing. btmon from bluez 5.72 aborts with a
fortify "buffer overflow detected" on every live capture on this system, so
the traces above were taken with tcpdump on bluetooth-monitor; that turned
out to be an unrelated bug in print_packet() and is filed as
https://github.com/bluez/bluez/issues/2704. Full traces, a decoder and the
analysis are at

  https://github.com/prostopasta/freebuds-l2cap-sig-mtu

Environment: Ubuntu 24.04, kernel 6.8.0-147-generic (the commit is present
via the stable backport), BlueZ 5.72, Intel AX201 (ibt-17-16-1, FW
155-35.23), Huawei FreeBuds 3. A JBL TUNE770NC on the same host is
unaffected, so this is specific to devices that use oversized signalling
frames.

Also filed against the Ubuntu kernel:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2172088

Related user reports, all closed without a diagnosis: bluez/bluez#2526,
#351, #745, #1011, #1646, #1743.

Thanks,
