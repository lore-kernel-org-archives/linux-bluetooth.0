Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333229;
	b=ufpNpsdWcGEb92bAvQhaqQwBGSJvcmGlkI7f5kKXFHjS8N1JfFfJq0C2NBcG/sHOECgM
	 brEeAxcxRnpzoS4ZQdgq/LC7ea9f4cA8oIruI2trWZVZoO4pAH0cblV7bDJEyb0agv8kl
	 1Vp4NRbYmH4VMagH9Hxfu25UAEiZoqzMfb84k0npNLYePwndrGnQtlt+1UbXAPusBSp8w
	 F8XzVjjNedxR7rwgQoYgQrFXhuLpCf8llH9mPQIr8pCi0X4BblgEFniRoQz8QD+gytgdz
	 5Gvap1pb8jI85o9q8CNJkm85gJl58XV0TMANZ98kkgruUdnwS66yvRYiYEWLN6/qm5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=S/qZucqkzx7qvX/YIWrg59XYaPpYXxILWqLaRuMZDDE=;
	b=LyREI3M8/qictQ2DwdzQxH262tQ0CHKYazO7CLYjvQmayBJJrCw/IWSSuufiStbGH/fB
	 /LloEwRtdHs67JLcirQXSburBf3mB4rX0WIz+LwJmHuc0WeaPPOdTFPd1zHahXhffZzDQ
	 1unMClWJBpaErnr/1UV4wMrvmdz5KtpLx10VTSsXwBSw/aB01XsJkfrZLJqWrwym50jJM
	 1c1ySCkU9Fyqni2alcv4lDCujn4jZxgDM8WCnK//0EHdAaJ5juMC0lc8RDtpn9U6Bkenh
	 jz7vk0sJnDBh6xpAvmamb4MEwa92ch2sEx5fN2fMUZhLJYaHHh5cb7l8Ehya17IHwsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=F81bdru5;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A270606A203
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 17:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A270606A203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=F81bdru5
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b3acec6677so3553675c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 09:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1794333225; x=1794938025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S/qZucqkzx7qvX/YIWrg59XYaPpYXxILWqLaRuMZDDE=;
        b=F81bdru5i5Uk13C1W73IUc5oYBUw0hva8q/A6WiRDjjevSNUfVxTfTWiD/EqXTe2Q/
         5px8Y88dTNUdrMIoSIdtvjWBC13tcpNh2ejssns0Xjsj1sBkHUZrIGQYIeP5h8mCTn7e
         cbjtwDFH1ql7TwTE/5AQ//Sq6V+4Q09CSI5EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333225; x=1794938025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S/qZucqkzx7qvX/YIWrg59XYaPpYXxILWqLaRuMZDDE=;
        b=IJNtAmNoBbyt9q2gK25ET658/kKVd1dgSonAJ5M+EM+ThWFREAWcOB0Ytr1yws0iL9
         qAuR78gA3kiAL6c4KLH7Qru/yN5E8Rs8Dx9e4lXv/e1cqVw3geeAD95V21IutNPlCDF6
         fLGgBKWkaDDn9l6MJtUY/OY8OOxT3+7nlpO1ZhzYrhc7/c6K5BPiYYaYxnZPP1iWPSq6
         ZkPw0RJ3uCEnZ52zyktmuvspiDzgxdr1gd9FQS7/j5rMOdjdGOK9hA2MrNVZwkcblUwt
         iMJ7s12swI+rkKPZ8Olbz5js62Mhus6pVvtUpfeyur/L8XoFAHguTwJhsY+wj6Oll/8i
         qkyw==
X-Gm-Message-State: APuU4Z+BPF5jL8xcEoR0wBOxMAJHyhpoZa46STdH9cAHjBIDgy2Zado/
	o3sPjbyNwHf5cKTtpWglxAy2mJSjmIhbstSu8fYMP4NRR0Ia2zqOBBaxbVEv2Iuql/A=
X-Gm-Gg: AYBFou1RXl3x5CXh9vq4lBXO/7hA/1gV6sd/REWdzF3qVifAC6a3u7tjlInOPksTAT6
	xo7U3949IjEPSLaCAjJlqNwvKcBcAouf0PlzSz8dByOw/eDLgFkD0Op1FlNF0QvMmOvMOXtv+AJ
	YsxX9fF4YCWsEe/U2gNxHBguU5LihlroNztRIsjvt0J6EOYSPlt3AhjLd2mXojL5taDo3K4sNkI
	PK11i30TpG3g41QSLtuzT4k4TyAsqu/tHXXjNp27EEyILeY1VtK03eS7ZgxnWqnbpS7ZCCSvynK
	r7b/QwQZnYVwklrgK/i9J4vV1N8ETsKCvO+IyY3W0JlRCTOCh3sGZlFkzH4m973Win+YU8i2u6q
	KUIOOuYNNSxMvATG107nyIAsG+ncrTYx5GmAGsQwqUUaL/q8kAsblS4X8O9/ebERLZ7r1eEs3Vf
	cLRbnIw3sRY7DNBmnkgh/w49WRa42Ak6ER1ggNOXLIyNf24Gs9WqRvG6wcs1kHYEL8Vfty5SMgM
	gTEVFY2rRXGdipyLh8GRsNrsdddb1Y7qYCGjVwXMy/8BgZmYfvIYqXvA/I5SCacK6y5tAikZM0p
	Sr8RgITsjjUcD3C53eq5LAi1nkz2NYz6aOKr1D/DYzl8rxKF+ajO/C8S6BibzmKpJtKBk6pdc7z
	hhZNHfjjDx/cBUKtdc99+VFra/uPX+84eufNpLswEOPJsPowLxbLEdjXwHvnn/WKW
X-Received: by 2002:a05:7022:ea8b:b0:143:8860:afa1 with SMTP id a92af1059eb24-1b3b619fde1mr4282234c88.46.1794333225326;
        Tue, 10 Nov 2026 09:53:45 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11150sm11875452c88.5.2026.11.10.09.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:53:44 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	Piyus Kedia <piyus@iiitd.ac.in>
Subject: [PATCH v2 0/1] Bluetooth: fix stack OOB write in the legacy adv data path
Date: Tue, 10 Nov 2026 23:23:33 +0530
Message-Id: <20261110175334.676816-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We would like to follow up on the stack out-of-bounds writes in
eir_create_adv_data() and eir_create_scan_rsp() we reported earlier.

The patch we suggested earlier bounded the copy in eir.c. As Luiz pointed
out, the stale advertising instance is the bug rather than the missing
bounds check, so this new patch unregisters instances that no longer fit
the controller's capability, at power-on, and reports them with
MGMT_EV_ADVERTISING_REMOVED. Userspace can add them again with the right
size.

Verified at runtime: with this patch applied, the reproducer completes
cleanly on both the adv_data and scan_rsp paths and the instance is
removed; without it KASAN reports a 220-byte write into the 31-byte
buffer at eir.c:303 and eir.c:360. The tree it was verified on has
net/bluetooth/eir.c and hci_powered_update_adv_sync() byte-identical to
this base.

Apologies for the form of our earlier submission: it was a bug report
that patchwork picked up as a patch, which is why the whole report ended
up as the commit message.

Link to v1: https://patchwork.kernel.org/series/1206772/

Thanks and regards,
Piyus Kedia
Kapil Vaswani

Piyus Kedia (1):
  Bluetooth: hci_sync: drop adv instances the controller cannot carry

 net/bluetooth/hci_sync.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.34.1

