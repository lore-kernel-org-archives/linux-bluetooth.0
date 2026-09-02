Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D934B1AD
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315065; cv=pass; b=i63XraIpLYiijK22uNz1Xke0Q2A3CtQW45saMWx4niHiQXcOYLvWlh+pVGFFjNgFam1sGnto+e4IK6tUlrvICpJ4n/ReIvfoBNQL2QsgVKBnHuFESkfRyDA6PArlv2zd5CRP6mkGMSfVBWW1rrL7bLfDxp0bn2BnLRybgBjDOn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315065; c=relaxed/simple;
	bh=Wqi9+7wd5NnLZOWTg5e1HxhEYKd1pgkTsh1j+yGEUio=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IrkReUyoEv4jjrQsTRh9z8Qo8G0EF3x9gNcx4itowfPB57O2KnRgqhnZcSExdbXNjTXS4f3D5GoU6akhFOVt1Wl4P/jDAYeQHkMOKsZciGmKdF1SgHm1Pz7zGwgYzufwACup+ZAnsbBGiaRWxPYmrPETLltge8V3BqDDPzZlGjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEKtSy+6; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEKtSy+6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso3348375e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 19:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788315057; cv=none;
        d=google.com; s=arc-20260327;
        b=ai04nfOGVn7TLPRKdE7sBuYd7+LtdZ4b3mSAtN4V+OhsPtD7fV/BThh9+4Y7j8OOLX
         JgPx4hkPdPF6uvIOM4DvuJsbz+ZD2eindj6sOxMSsweCk0LDhp2MwfUSVPQDYBuaPwmj
         b2uVMQ2gP8CYu4vnbEUMqvbB3xw0TnHagm2NBqhBC4r8fvSnuIf+DbBDHE2TMepLq3cP
         F+HCyodkmN4gMh90K18oNmXG5gIX0lgHo0/2JNrdh3NgXSvLcVy2YRCnngpBz6yiAeEh
         RGymu5JE3s0Zj1l5jNBb7d4F07k4DzzrvE7uGzq61IjdvY/Bl1iDH/o/cRyOlxqS96C5
         CtqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=miRWNlrgJnkfFijXetq532ldKdfjhWdGeVzZOadUgfM=;
        fh=Ym7YLtscl/gkr8SJIPrMfBraFgWSnnIUx9nPuBfk5fA=;
        b=ploPcPZcbHRJmfKTMoAtRdMvVeSAdQ8E8snuzdD0d1j+Jk7Ifn4FVGBQR+XTzfJhl/
         foiuqahXeRyhjn62+naYmiNkcFjFjaX36Y1MmUd6rjYcqzOXQ9OjQH7aZM5fdIQ52kJ2
         A02nxXKMKlGVc0xngDQmRhz6tVO+WzNvUjL0gtPlq/Q1FJj1zMXvKXqDwRX0iNc96/xN
         62d0IG/WwRgPR3ZUl6wa/sD3wMjE2enV5SPy2G5kAG/PneVBOxue1A0Px+z4FBVzHzAs
         3+JWPAwpWeE49mD5qSIZ8YnZNK7k5Xbapu7CNVH5RdMVEU1tVVjTENkKZy01In5yL4NT
         2FAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788315057; x=1788919857; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=miRWNlrgJnkfFijXetq532ldKdfjhWdGeVzZOadUgfM=;
        b=nEKtSy+6LpmCdTyNs3tkNaHCU95DoaR5d1RLIDhBanxfRE6hdxNMrX5wkA3Q9satGe
         uZ1VmNgab/vKswXnM79zFI3lvaayb5Z+gfUfhBk0y5RXwSkOQo6AY3Ysw6Nm949F+CS4
         WTmulsdsOrRlE8TSUNrh7pZg2eyPTUqVuf3GY7fiTT6RwSKbL9AiaDI75mAQsslCnNmA
         OiaVAwQ39SaFwnmTP7DGPNGvgFqOWlVQ29rogh/MId6wla5SFotctQQdixwO7RGQP/e8
         J8qh46nCD4tG6I6fOqc+TmZ0fvOqc1/jX7vqFCDcAfYjRSxK3LPGoA+cvOB8fB76WK4g
         uroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788315057; x=1788919857;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=miRWNlrgJnkfFijXetq532ldKdfjhWdGeVzZOadUgfM=;
        b=jv9KGyM8Bzvx26gaDvGwEMzDU3wJJPg6WWQRgCKeSspdZCJKoRJYIaSlE/O3lCHjRg
         IrpistH070JzXbRd172d1ZROpDTnJFn1GLrAjvyAoLuRCMLrGuugGh5YBQ8RUrXSUADR
         Aogwqq9XJEwe3K3kCYfcnp95SUoNe4Ias0d35pE3GOyfpCEVyfZ18QVEcm+TbOImkeYV
         itAH+1hq1vf+0W02MYmktote+DBAb1o6qG5LqggPrrCq91PAlecb+rLitUK8zi0k3o/W
         x4ooeZosaIDYf+0P4NCsKa/TjmGHhP9Ak0EsD1atcPM2fVRwwokzbm/B1kBuTDJdyj9L
         lIZA==
X-Gm-Message-State: AFuF++lFIHA82AgQ0ljlOIFxpVjLh37KHKO63XR2DrDGcXlxBRjuogUX
	iabbizhS8f0HwexpDsqwm0Jo63EV6Ud8zFDEOTV+YzDG96uN7WB7rf5O7/AMhQ7yDXjqJf/fIrw
	LgXilsZvZVz+bCcfG9YvWoXmFl2+5syicwuVu7JUIlylcO08BeA==
X-Gm-Gg: AR+sD11Yeg9r+ShmICtGBCBLaY2+e5qZcIJmbTbWlrrMB4fgE/2NJt6QvmhlrpjiN2P
	9S2pyruWoJaNSl/Ig6YFH4qFdBGtOtU6vm/2/sy6ae7T4DmdiCJi7mBV7e9GD03LXEUXWqFEGTM
	0b4sBe3tEDF9e4h1w/PJsocu+Yp79G9KMTvsiHiafwa+ajJ5Bsu9PDN2rmDkFgHtz0fgM8Lg6qq
	RZ3c3s+HV7ARhAhxzBkMxsZQHMXNSYBh0rW78hbO92LH/FfQo5S5/MKL+gS9n9iw//JoAECzP2d
	ffqU2Owh4uEpHxEpFuk9r6y1oNWnWr2HTHFIE/IYM3Y=
X-Received: by 2002:a05:600c:354b:b0:499:51f0:a9b2 with SMTP id
 5b1f17b1804b1-49ce55f051dmr21559675e9.1.1788315057139; Tue, 01 Sep 2026
 19:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Qingyu Zhang <usupergate@gmail.com>
Date: Wed, 2 Sep 2026 10:10:45 +0800
X-Gm-Features: AcwNN1VZJvtFR2-aP1IaZVpF82vVv6SRFFNrJZSVY7OUOlEnX_AFIkDT1G5csAM
Message-ID: <CAPBHdanvQs_e29KUYjBn41fA-WBqLxDxUDb4Tv9Efh5pTm=8cw@mail.gmail.com>
Subject: [BUG] Bluetooth: ISO: listener sock leaked when iso_sock_alloc() fails
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

iso_conn_ready() leaks a reference on the ISO listening socket when
child allocation fails. A patch is attached.

Type: memory leak (sock reference)

* Summary

iso_get_sock() does sock_hold(parent). iso_conn_ready() then:

       lock_sock(parent);
       sk = iso_sock_alloc(..., GFP_ATOMIC, 0);
       if (!sk) {
               release_sock(parent);
               return;          /* missing sock_put(parent) */
       }

The success path and the "listener closed concurrently" path (after
560bef609fa5) both sock_put(parent). This failure path does not.

* Affected

Introduced with BTPROTO_ISO (ccf74f2390d6). Still present on
08dbfad3f504. Needs CONFIG_BT=m, CONFIG_BT_ISO, HCI_VHCI, kmemleak
and (for a reliable trigger) CONFIG_FAILSLAB.

* Reproduction

1. Boot with kmemleak=on and failslab.
2. Bring up a virtual controller (hci_vhci).
3. ISO socket: bind + BT_DEFER_SETUP + listen.
4. Inject HCI LE Enhanced Connection Complete, then LE CIS Request
  (subevent 0x1a) while failslab is armed for GFP_ATOMIC
  (ignore-gfp-wait=Y, probability=100, times=-1) so iso_sock_alloc()
  returns NULL.
5. close() the listen fd, then:

       echo scan > /sys/kernel/debug/kmemleak

kmemleak shows the listen sock (size 2048, iso_sock_create ->
iso_sock_alloc). rmmod bluetooth then fails with EBUSY.

PoC: poc/vhci_iso.c (the "#47 failslab GFP_ATOMIC window around
CIS_REQ" section). Full QEMU recipe is in poc/run.sh.

* Expected

iso_sock_alloc() failure drops the iso_get_sock() reference, same as
the other return paths in iso_conn_ready().

* Actual

sk_refcnt stays elevated. The listen sock is never freed.

Please consider the suggested patch.

Thanks.

Suggested patch:
```
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 75bfd5938b2e..4de332b8901f 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2289,6 +2289,7 @@ static void iso_conn_ready(struct iso_conn *conn)
                    BTPROTO_ISO, GFP_ATOMIC, 0);
        if (!sk) {
            release_sock(parent);
+            sock_put(parent);
            return;
        }
```
