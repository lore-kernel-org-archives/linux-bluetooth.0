Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88612411671
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924879; cv=none; b=b8X9zmL/eU7PtoZEYkJ773w3GbuokrMYVUSSGzH3AEJLh5sya/uJzrRkaKO7TgSi8yBPu7db1pSoKsx0higgHgp7eFqRA31tHyzaMZ7U6BaBSNPptO9BwcWKjFDTNnF7U59wDcr2y0ThShFlfyj+Gz7Y1fVIKWmV8b4m9MQ+9Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924879; c=relaxed/simple;
	bh=LpUy2Y1w/G5Q3IxHxcSWocshtWJTMQsLmw8IXEWGS88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyeoXyFTF7Fh0PrVQZEdiMcYlHGXdKZFJQOT5jUmTWEdB7+jcHLbj8Bn/lPV43jPWhazUrWMAmRja7Cvhxk+DOlpHgicZV706Yj3HyMXsPNDMfLaSf90iA16L37U3Ch61Qq3rUHu8ichL7Tc0vfJ0bRLW66JGKtBeoitJDMwu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbbNHz7S; arc=none smtp.client-ip=74.125.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbbNHz7S"
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-48b0622cc90so1088195f8f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 00:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790924876; x=1791529676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lqdQB+3qbWBs9BdmeFMcXI7bQfwAeguI+SXZ5In6E8g=;
        b=FbbNHz7SpXi548wMWDsHOIc7RIAXt5QdgTwE5FHzMyMoAqZgvQjv/jw1AGeMMi8pEe
         QVSrQ8qd7m8CimCLs7sr2mR8or/uvbn7YbWeL4S35hEVNsGwxD0lFCe53Ud7MRwkWc6E
         cWyfbIgKY6xiw6j/F7FKKikcc+CbprDZ4Wq6209ydcT/s7oHc64Twovk4lxePKn/oi0S
         wDLGjKFDSAlQnNq67kTbnt6NSbGLnbwbRIlRyTTR8Y8ivRIUtK9xqkGHK3akJIhGMtjJ
         qCwNLE/3FNdeD0qp7tEkrVZdPpW9vixojpHzuRQDrPQCRK4L6nCjY6iBXf3uYyn2D2BB
         gJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924876; x=1791529676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lqdQB+3qbWBs9BdmeFMcXI7bQfwAeguI+SXZ5In6E8g=;
        b=Pyd4Jhp0mFTm0iQOP4ZvCjrpGYLldWioAVe+nA3AeFLJHViv8rBFecIphBBwLoKZVV
         O7oyopvDGlOhNg25VoXsKh2ujCRlg11L6MszbiPr90BAqTEGt5djYK38+SRf/ZIS7lDY
         9VSTWkvnze69ElciXCUk6eNUjwFzB6ba1qIVSyZmNthuR2qxe/oR91Fo6A4XfDAGPVzY
         IOGG9LJEQQKJAYNNbe5sVE+DBuMUgwFCAU6yZTGVo1vCdLNAGnOi2Fm9UxyTaaNHvqm0
         8xeEl/oc+r1HxxQxHtwdRE+t+kFAmwjslZpc6kCA3HC3pKhsbUhdFRyhW0FiAVqjP3gJ
         VDvw==
X-Gm-Message-State: AFq9FYLPYCiA3gMmM/hB/eJkzviHs7cW+vV7pvhoRnBjmmk7yOYAiXIU
	fix5yZR51Xh8h0Fclpj73R918SDoKEq+Isi0m+EYKr+D60jGzJPU0dok
X-Gm-Gg: AYBFou2hDjxF4b58Z/Wgozdz8zG0dQCE7iWd9bF7YtaKZgQfFTdf71O/FYViUP9mM6/
	wCB40kFhfOoitvvjuhJp2Q+enNc2vSYAY0S9WL+jDVPrSfjld7AFVekNLTtLDkd+gTZEdkdJr0H
	bAlFpQIVaKLUgQNw464YQv1HD9kbOjO/OOIeDNXL6MCEz7LB27grFIh7p5OwmDzrj90h11J1aGR
	NbkobBwnB+sofIy0epv9BgQjBlkTVVOERzmMM7zzdLWcaNeB0bKmZwoey9+mrx9x9md3ngl82YI
	38WUSazsIkI6NwzTFwug/LdQ4QL4x47UbIcLsskRY0FDCJ+hdFxBu1ORVEW7h3t5lGw/OEGSVKO
	59nkDx5lZjYMuO9ph3Q6wP8Yps5pJ88q7X2i/y3IYQRXH6OS4MT3st4Qs+5tNiC/MSeyw8ZWT9o
	ZBdenMS8v7nHM9w0XI9H/lLqItkbw2JEPsqXVnNMtNwIPAxL5s2lKtDbAMkeRHsHJSe9pA8ns2S
	D62IqeuMlk71JYTD/0OZGlrVreu80E3l5DhP2ZHLKv7ezkMMMuHBjKR4yzHLEKkzBmr8zu4k8AP
	GQ==
X-Received: by 2002:a5d:5e84:0:b0:48b:1ed:db34 with SMTP id ffacd0b85a97d-48b12747ac0mr2993279f8f.45.1790924875458;
        Fri, 02 Oct 2026 00:07:55 -0700 (PDT)
Received: from Raghu007.. (sgyl-44-b2-v4wan-174108-cust110.vm6.cable.virginm.net. [80.1.81.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b82253e6bsm3121772f8f.6.2026.10.02.00.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:07:54 -0700 (PDT)
From: Palla Raghunath <raghunathpalla.0209@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Gianluca Anzolin <gianluca@sottospazio.it>,
	Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	raghunathpalla.0209@gmail.com,
	syzbot+4a807caf7680652d53b6@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: Fix NULL tty_dev dereference in rfcomm_dev_shutdown
Date: Fri,  2 Oct 2026 08:07:52 +0100
Message-Id: <20261002070752.84486-1-raghunathpalla.0209@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot hit a NULL pointer dereference in rfcomm_dev_shutdown() when an
RFCOMM tty is closed.

rfcomm_dev_add() puts the new device on rfcomm_dev_list first and only
then registers the tty device and saves it in dev->tty_dev. If that
registration fails, dev->tty_dev is never set at all. The device can be
looked up in the meantime, so an open() of /dev/rfcommN gets through
rfcomm_tty_install() and attaches to it. When that tty is closed again,
rfcomm_dev_shutdown() uses dev->tty_dev without checking it:

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
  RIP: 0010:rfcomm_dev_shutdown+0x48/0xb0 net/bluetooth/rfcomm/tty.c:131
  Call Trace:
   tty_port_shutdown+0x1bf/0x220 drivers/tty/tty_port.c:372
   tty_port_close+0x4e/0x150 drivers/tty/tty_port.c:705
   tty_release+0x359/0x1670 drivers/tty/tty_io.c:1718
   __fput+0x418/0xa50 fs/file_table.c:512

rfcomm_dev_destruct() already copes with a NULL dev->tty_dev. Add the
same check to rfcomm_dev_shutdown(), so the tty device is only moved
when it was actually registered.

Fixes: cad348a17e17 ("Bluetooth: Implement .activate, .shutdown and .carrier_raised methods")
Reported-by: syzbot+4a807caf7680652d53b6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4a807caf7680652d53b6
Cc: stable@vger.kernel.org
Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>
---
I reproduced this on next-20261001 with a small program that creates and
releases rfcomm0 in a loop while two other threads keep opening and
closing /dev/rfcomm0, with a vhci controller up so the open gets as far
as rfcomm_dev_activate(). It crashed within about ten seconds every time.
With this patch applied it ran for five minutes without any problems.

 net/bluetooth/rfcomm/tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index dc3cdf614def..198c7dd1a95b 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -128,7 +128,7 @@ static void rfcomm_dev_shutdown(struct tty_port *port)
 {
 	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
 
-	if (dev->tty_dev->parent)
+	if (dev->tty_dev && dev->tty_dev->parent)
 		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
 
 	/* close the dlc */
-- 
2.34.1

