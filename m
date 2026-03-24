Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A1531D375
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348455; cv=none; b=IDPA98yoYvLJhByz7QuNPOqrUlfBSPBIbvZQfhrLyO8bTyYcYFT6GAve/HSbJ1zBdXx9+xbziqN5jGmA2XRZjrXV+9MEJl36FNprXn48AwU7OOLNNpka9a5mgReS4gruRzLARaDkYUvd0Niqy/Hxmt7tSrpDtccz71s6mX11gfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348455; c=relaxed/simple;
	bh=4EORpH6WcBghCJ9QQEhWMcmuvoaRcOsHXVj0mgKRxLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S50zMv9iL2zur+hdXFWuq6BLiB3tbSfartsrh4U6NR+23dwPBl9DqvbdGgEBkqLomb5Uqs2+cnvPuJo8kzWtAgxfbtnBZlwoskOKRWPPtLyPPG0mzC2YSdBTjePCGJqrABNiqDpZK2T98cZRiTEV6zm2OtyReAuy/5Tq+3aZHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TM1ce5BY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TM1ce5BY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rhXjgygsHW88JiyJM+U49imFxvcs2LVXBM42uB0IxHo=; b=TM1ce5BYmxYSxrAOfde9Fe9QMV
	fAhV3KeeWL9DV8gB9eb+pn81YdNaa/l1IHZo5OlP4c0l8+mzlt0K94CvyORDuTdSRQ2nriqXujNF1
	WytbtcYk0v9EpEj2nPxUOkv1VUduGTRhIMDdXpEL2uvXH7DJlU6je5BHcntwPkp9t1pxXoG04bGF5
	9iYJgwE9eO901mX6uQ6ywK3+RXJXtpZiInXeFUz6/EaTFCnIrW4QnXptpCUJmzlz75BUmhKu6ZppD
	TsQBrGAm+2h1ilC7hkNKjyXjJ2XpU3VtY489OhA6XHzKf2lJU3eWImZgqifsg49+wmO7p01S0L/F4
	gXYY06ag==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w4z5O-005I4m-4s; Tue, 24 Mar 2026 11:34:10 +0100
Received: from berto by zeus.local with local (Exim 4.98.2)
	(envelope-from <berto@igalia.com>)
	id 1w4z5O-0000000059f-006e;
	Tue, 24 Mar 2026 11:34:10 +0100
From: Alberto Garcia <berto@igalia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alberto Garcia <berto@igalia.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [RFC PATCH 0/1] Bluetooth: btmtk: add USB autopm support to btmtk_usb_setup()
Date: Tue, 24 Mar 2026 11:34:03 +0100
Message-ID: <cover.1774348119.git.berto@igalia.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I've been having problems with the btmtk bluetooth driver for a long
time. What happens is a failure during initialization and the loading
of the firmware, with errors like these:

   kernel: Bluetooth: hci0: Failed to get device id (-108)
   kernel: Bluetooth: hci0: Failed to get fw version (-108)

The device is MediaTek MT7921 (0489:e0cd), there are more details in
this bug report:

   https://bugzilla.kernel.org/show_bug.cgi?id=217475

Passing btusb.enable_autosuspend=n seems to solve the problem for me.
My computer's hard drive is encrypted so it can take a long time
before the bluetooth firmware is loaded, so I interpret that this
causes the device to autosuspend during boot and that's why
initialization fails. Does that make sense?

I saw that commit 67dba2c28fe0 fixed similar errors during shutdown by
using usb_autopm_get_interface() so I tried the same approach for the
btusb_mtk_setup() function. I confirm that this solves the problem for
me and with this patch the bluetooth adapter works reliably.

I was also suggested to try the simpler approach of using setup_on_usb
instead:

        if (IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK) &&
            (id->driver_info & BTUSB_MEDIATEK)) {
-               hdev->setup = btusb_mtk_setup;
+               data->setup_on_usb = btusb_mtk_setup;
                hdev->shutdown = btusb_mtk_shutdown;
                hdev->manufacturer = 70;

However this does not solve the problem:

   kernel: usbcore: registered new interface driver btusb
   kernel: Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106151414
   kernel: Bluetooth: hci0: Execution of wmt command timed out
   kernel: Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
   kernel: Bluetooth: hci0: Failed to set up firmware (-110)

So I would like to know if a patch like the one I'm sending is a good
approach or if I should try something else.

Regards,

Berto

Alberto Garcia (1):
  Bluetooth: btmtk: add USB autopm support to btmtk_usb_setup()

 drivers/bluetooth/btmtk.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

-- 
2.47.3

