Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BD43BD64D;
	Thu, 20 Aug 2026 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220064; cv=none; b=fFobSSgO4P1K7fiPGVJQjJL0B9Z3KC1tvQzYG+SKJwwin84xpIlWgtl1MiGjF4OPab+jGdjT76VIgFnz22Kc7FJAiWNM8nnciGARTtKUlZEgJhGZZyp97XNhObjYO0ZjFQbc3r31Gmg7eY8FXjUaLUaAsCQTj2ghyl2cP6LLlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220064; c=relaxed/simple;
	bh=7MSVi4Lq9HX/0Y9x8O7vaq4SQp5Vs0DGOHqHtHo/W/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku+6xGtOl8mMzb6AhlbnlAX4STnpa0z2/nYpC6JU4xb2VkVviNJpaZjpviwGxF5nhBV20F+rZ+mfMPdivx7RcC5Ig1vFECSBf7mJZ+p1dnZfel7v1aEkt0hoYbyQowVEgbdF2Y4Pm2e9rLrTIXxiUD5jd331ArfuwXZ+THCZMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 076e3ff69c7e11f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:766d5a45-013b-410e-97b0-5ef8d818dacd,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:ac774b139aef87384a1761c539b108d6,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|50
	,EDM:-3|-100,IP:nil,URL:11|94|82|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 076e3ff69c7e11f19a56ed5b684f684d-20260820
X-User: liujiajia@kylinos.cn
Received: from nature [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 16256110; Thu, 20 Aug 2026 18:00:52 +0800
Date: Thu, 20 Aug 2026 18:00:49 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Ying Hsu <yinghsu@chromium.org>,
	Archie Pusaka <apusaka@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jing Cai <jing.cai@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: mediatek: Fix leaked runtime PM
 reference in reset
Message-ID: <aobQUR1NXk5vHBrg@nature>
References: <ec23dae6c247005e8eccd312d326a626163ea491.1787132512.git.liujiajia@kylinos.cn>
 <CABBYNZ+Ow7XQTpM6gO_x2c9Z=jKewXk=dknxX6Ly9QZdezi4zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+Ow7XQTpM6gO_x2c9Z=jKewXk=dknxX6Ly9QZdezi4zA@mail.gmail.com>

On Wed, Aug 19, 2026 at 12:35:38PM -0400, Luiz Augusto von Dentz wrote:
> Hi Jiajia,
> 
> On Wed, Aug 19, 2026 at 5:52 AM Jiajia Liu <liujiajia@kylinos.cn> wrote:
> >
> > MT7925 on HP Pro Mini 260 sometimes timed out during reloading driver
> > and reset usb device. btusb_suspend is not called again after closing
> > bluetooth interface.
> >
> >  usbcore: registered new interface driver btusb
> >  Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260605184935
> >  Bluetooth: hci0: Execution of wmt command timed out
> >  Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
> >  Bluetooth: hci0: Failed to set up firmware (-110)
> >  usb 3-10: reset high-speed USB device number 4 using xhci_hcd
> >  Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260605184935
> >  Bluetooth: hci0: Device setup in 1856545 usecs
> >  Bluetooth: hci0: AOSP extensions version v1.00
> >  Bluetooth: hci0: AOSP quality report is supported
> >  Bluetooth: MGMT ver 1.23
> >
> > btusb_mtk_reset calls usb_autopm_get_interface to resume the device
> > before driving the hardware reset, but never calls the matching
> > usb_autopm_put_interface. Every hardware reset therefore leaks a PM
> > usage reference of the interface, preventing the device from being
> > runtime suspended again until it is unbound.
> >
> > Add BTUSB_USB_RESET_ACTIVE flag and set it before usb_queue_reset_device.
> > Release the PM reference in btusb_disconnect if this flag is set.
> >
> > Fixes: 25b6d7593a3a ("Bluetooth: btmtk: introduce btmtk reset work")
> > Assisted-by: Claude:qwen3.8-max
> > Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> > ---
> >
> > Changes in v2:
> > - Fix the race window (sashiko)
> >   Add and set BTUSB_USB_RESET_ACTIVE flag before usb_queue_reset_device.
> >   Release PM reference in btusb_disconnect if this flag is set.
> >
> > Changes in v1:
> > - add usb_autopm_put_interface after usb_queue_reset_device
> >
> > ---
> >  drivers/bluetooth/btusb.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 184e95c1625e..45a726bed0dd 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -957,6 +957,7 @@ struct qca_dump_info {
> >  #define BTUSB_USE_ALT3_FOR_WBS 15
> >  #define BTUSB_ALT6_CONTINUOUS_TX       16
> >  #define BTUSB_HW_SSR_ACTIVE    17
> > +#define BTUSB_USB_RESET_ACTIVE 18
> >
> >  struct btusb_data {
> >         struct hci_dev       *hdev;
> > @@ -2915,6 +2916,7 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
> >
> >         err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
> >
> > +       set_bit(BTUSB_USB_RESET_ACTIVE, &data->flags);
> >         usb_queue_reset_device(data->intf);
> >         clear_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags);
> >
> > @@ -4497,6 +4499,9 @@ static void btusb_disconnect(struct usb_interface *intf)
> >         if (data->reset_gpio)
> >                 gpiod_put(data->reset_gpio);
> >
> > +       if (test_bit(BTUSB_USB_RESET_ACTIVE, &data->flags))
> > +               usb_autopm_put_interface_no_suspend(data->intf);
> 
> Should this be test_and_clear_bit rather then just test_bit, otherwise
> it doesn't seem to be ever cleared? Sashiko also complains about the
> handling of multiple resets (is that really possible though?):

Will use test_and_clear_bit.

> 
> https://sashiko.dev/#/patchset/ec23dae6c247005e8eccd312d326a626163ea491.1787132512.git.liujiajia%40kylinos.cn
> 
> Or perhaps we should check if BTUSB_USB_RESET_ACTIVE (Id rename it to
> just BTUSB_RESET) and then don't queue a second time which perhaps is
> what sashiko is talking about when it refers to reference.

Sashiko concerns other PM usage references will leak if there are multiple
resets, since btusb_disconnect only drop one reference.

I am trying to use test_and_set_bit before usb_queue_reset_device. If flag
BTUSB_RESET_ACTIVE is already set, drop the reference it gets.

 @@ -2915,6 +2918,9 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 
         err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
 
 +       if (test_and_set_bit(BTUSB_RESET_ACTIVE, &data->flags))
 +               usb_autopm_put_interface_no_suspend(data->intf);
 +
         usb_queue_reset_device(data->intf);
         clear_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags);
 
 @@ -4497,6 +4503,9 @@ static void btusb_disconnect(struct usb_interface *intf)
         if (data->reset_gpio)
                 gpiod_put(data->reset_gpio);
 
 +       if (test_and_clear_bit(BTUSB_RESET_ACTIVE, &data->flags))
 +               usb_autopm_put_interface_no_suspend(data->intf);

And add btmtk_reset_sync before btmtk_setup_firmware_79xx to construct two
calls of btusb_mtk_reset for testing.

 [29641.975493] usbcore: deregistering interface driver btusb
 [29641.997490] btusb_close: hci0
 [29642.334308] usbcore: registered new interface driver btusb
 [29642.334794] called btmtk_reset_sync
 [29642.335654] Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260605184935
 [29643.559484] Bluetooth: hci0: adv larger than maximum supported
 [29643.569495] Bluetooth: hci0: adv larger than maximum supported
 [29647.472831] Bluetooth: hci0: adv larger than maximum supported
 [29648.920846] Bluetooth: hci0: adv larger than maximum supported
 [29652.577442] Bluetooth: hci0: Execution of wmt command timed out
 [29652.577450] Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
 [29652.577468] Bluetooth: hci0: Failed to set up firmware (-110)
 [29652.577470] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
 [29652.577475] btusb_close: hci0

Detect two calls.

 [29652.786083] btusb_mtk_reset: already set BTUSB_RESET_ACTIVE
 [29652.922030] usb 3-10: reset high-speed USB device number 4 using xhci_hcd
 [29653.069414] Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260605184935
 [29653.086161] Bluetooth: hci0: urb 00000000b24765f3 failed to resubmit (2)
 [29655.108547] Bluetooth: hci0: Device setup in 1993116 usecs
 [29655.108554] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
 [29657.121635] Bluetooth: hci0: Opcode 0x0c03 failed: -110
 [29659.137668] Bluetooth: hci0: Failed to read MSFT supported features (-110)
 [29661.153775] Bluetooth: hci0: AOSP get vendor capabilities (-110)
 [29661.154635] btusb_close: hci0
 [29661.290132] usb 3-10: reset high-speed USB device number 4 using xhci_hcd
 [29661.432184] Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260605184935
 [29661.934878] Bluetooth: hci0: Device setup in 492744 usecs
 [29661.934887] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
 [29662.020980] Bluetooth: hci0: AOSP extensions version v1.00
 [29662.021001] Bluetooth: hci0: AOSP quality report is supported
 [29662.021474] Bluetooth: MGMT ver 1.23

Close bluetooth on control panel. btusb_suspend is called after two seconds.

 [29674.033188] btusb_close: hci0
 [29676.530032] btusb_suspend: intf 0000000016fc024b
 [29676.530053] btusb_suspend: intf 000000009b822b1b

> 
> >         if (intf == data->intf) {
> >                 if (data->isoc)
> >                         usb_driver_release_interface(&btusb_driver, data->isoc);
> > --
> > 2.55.0
> >
> 
> 
> -- 
> Luiz Augusto von Dentz
