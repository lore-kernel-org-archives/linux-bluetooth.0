Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CCA25B0B3;
	Thu, 21 May 2026 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330413; cv=none; b=MessowMQ7lxHhvxztjzhGiU1/CatYN9foj8tEYmKvfiBtKo+LpY29LADki670N3Fk/YXH+ZTfn9vcPAHpuZKoUdwRNvaaaGW7+d3CZD56bCrWnLvJvuYoEskiHMFwvKJONa875LtcGo7deRBqAhgPZBD3zM6jvIM91XXRmVFBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330413; c=relaxed/simple;
	bh=E85d57C73jYXiLQOPXElfnFNfjH0CUP/rfz/C8lN9Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KytpDi7z1/lvOtvdihI49oBeExsYpqtSyNCPurp93OmsMA0+gA6kEQmd6Y9wTHc6Se7aQv4Lb6CZQxHsTJP+j7ROAwI1JSbqOQOTksi9IWxqH0fuzq/7zgnyORlIeFUoWtsQ4TcjoxxKt24WmOroX3T5z/aH8dm+kdxqWmpIkm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8002152854bc11f1aa26b74ffac11d73-20260521
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6f5e7ea0-7575-4e6b-8375-ed9e4b2265b3,IP:0,U
	RL:0,TC:0,Content:7,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:e7bac3a,CLOUDID:ff14f1f14e3304e428d1110e2a27a3bd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:4
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8002152854bc11f1aa26b74ffac11d73-20260521
X-User: liujiajia@kylinos.cn
Received: from nature [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1895931696; Thu, 21 May 2026 10:26:40 +0800
Date: Thu, 21 May 2026 10:26:37 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] Bluetooth: btmtk: remove extra copy in cmd array init
Message-ID: <ag5tXWHNMAxkonle@nature>
References: <20260520021500.13504-1-liujiajia@kylinos.cn>
 <CABBYNZLLNFNuSv0UBNQ7C2HTTg5W2m41hBTNpPw822GMAVNuhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLLNFNuSv0UBNQ7C2HTTg5W2m41hBTNpPw822GMAVNuhQ@mail.gmail.com>

On Wed, May 20, 2026 at 08:55:46AM -0400, Luiz Augusto von Dentz wrote:
> Hi Jiajia,
> 
> On Tue, May 19, 2026 at 10:15 PM Jiajia Liu <liujiajia@kylinos.cn> wrote:
> >
> > In btmtk_setup_firmware_79xx, the data length indicated by wmt_params.dlen
> > in the cmd buffer is MTK_SEC_MAP_NEED_SEND_SIZE + 1. Except for the first
> > byte, the remaining length is MTK_SEC_MAP_NEED_SEND_SIZE. memcpy copied one
> > more byte to cmd + 1 than the remaining length. Align the length passed to
> > memcpy to avoid exceeding current section map.
> >
> > Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> > ---
> >  drivers/bluetooth/btmtk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > index ea7a031000cd..53cba71cb07f 100644
> > --- a/drivers/bluetooth/btmtk.c
> > +++ b/drivers/bluetooth/btmtk.c
> > @@ -188,7 +188,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
> >                                        MTK_FW_ROM_PATCH_GD_SIZE +
> >                                        MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i +
> >                                        MTK_SEC_MAP_COMMON_SIZE,
> > -                                      MTK_SEC_MAP_NEED_SEND_SIZE + 1);
> > +                                      MTK_SEC_MAP_NEED_SEND_SIZE);
> >
> >                                 wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
> >                                 wmt_params.status = &status;
> > --
> > 2.53.0
> >
> 
> Have you tested this on the actual hardware? If not we need a Tested-by.

Yes, I have tested with MT7922 (0489:e0d8) on linux 7.1-rc4 applied this patch
and the following two.

Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
Bluetooth: btmtk: fix urb->setup_packet leak in error paths

setup log of boot and rfkill switch:

$ dmesg | grep hci0

[    6.108240] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
[    8.933508] Bluetooth: hci0: Device setup in 2765295 usecs
[    8.938846] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[   57.209143] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
[   57.366004] Bluetooth: hci0: Device setup in 160450 usecs
[   57.371248] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[  203.687643] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
[  203.844163] Bluetooth: hci0: Device setup in 158989 usecs
[  203.849426] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[  214.723250] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
[  214.879380] Bluetooth: hci0: Device setup in 155239 usecs
[  214.884644] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.

> 
> -- 
> Luiz Augusto von Dentz
