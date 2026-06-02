Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB7357D17;
	Tue,  2 Jun 2026 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367041; cv=none; b=TCyvKNdAbgzhFcINtfhUPS/EwRgsSjB1U3zML8zCEnOLjH7KJyl6bKXMmgvQfsBaVjJqThOQy+Tj8z/6OvkuZ+9dBrb0m6fhGPY3f2SkY6VR5mCWveDnuMM3YisBZh1AXf5Ez7x83GWNbqZRn5oSL+qlMr1CmJ3X/txsPHanu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367041; c=relaxed/simple;
	bh=WOOGqH8D8e02R2V7GOQbXreDGjBSQCb/xrucied4zYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnguZYQvx5QHrajQfnF4ZWPJAOE50VB4Yz9pxkrvHoWHzP3lNimxAjxYifMW/aVut9PJKRPRlsuMtKLz3TIgs4xhEMndF1LJfTFfTOcMju7fpmKgKVWk/I4/Grm365FyZW7hTT7zaeRUT2E+jzGA8p1Ss/YQJdcfDrYL9X/efhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1a3a68045e2a11f1aa26b74ffac11d73-20260602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d9f56ed5-f9ab-46b8-8453-e2a865611146,IP:0,U
	RL:0,TC:0,Content:7,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:e7bac3a,CLOUDID:b24648a32a46980296da2f78c9090eb4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:4
	|15|50,EDM:-3,IP:nil,URL:54|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1a3a68045e2a11f1aa26b74ffac11d73-20260602
X-User: liujiajia@kylinos.cn
Received: from nature [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1288870245; Tue, 02 Jun 2026 10:23:54 +0800
Date: Tue, 2 Jun 2026 10:23:52 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Brian Gix <brian.gix@intel.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_sync: fix simultaneous discovery stuck in
 FINDING
Message-ID: <ah4-uDGdgFkb7otY@nature>
References: <20260601012620.11764-1-liujiajia@kylinos.cn>
 <CABBYNZJ2Bm1Zw40hVEKQYuXjOLvLv8V+CrTugm4_1sbFdUw=Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJ2Bm1Zw40hVEKQYuXjOLvLv8V+CrTugm4_1sbFdUw=Kg@mail.gmail.com>

On Mon, Jun 01, 2026 at 09:32:38AM -0400, Luiz Augusto von Dentz wrote:
> Hi Jiajia,
> 
> On Sun, May 31, 2026 at 9:26 PM Jiajia Liu <liujiajia@kylinos.cn> wrote:
> >
> > When hci_inquiry_complete_evt is called between le_scan_disable and
> > le_set_scan_enable_complete and no remote name needs to be resolved,
> > the interleaved discovery with SIMULTANEOUS quirk gets stuck in
> > DISCOVERY_FINDING. le_set_scan_enable_complete does not check inquiry
> > state. No one sets DISCOVERY_STOPPED in this process.
> >
> >   < HCI Command: LE Set Extended Scan Enable  #1764 [hci0] 608.610392
> >           Extended scan: Disabled (0x00)
> >           Filter duplicates: Disabled (0x00)
> >           Duration: 0 msec (0x0000)
> >           Period: 0.00 sec (0x0000)
> >   > HCI Event: Inquiry Complete (0x01)        #1765 [hci0] 608.610548
> >           Status: Success (0x00)
> >   > HCI Event: Command Complete (0x0e)        #1766 [hci0] 608.611589
> >         LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
> >           Status: Success (0x00)
> 
> This isn't enough, though, where are the MGMT commands?

It was the last output where the scan was stuck in finding state during
scan test. No Discovering: Disabled MGMT Event report.

complete reproduction log is at
https://drive.google.com/file/d/1dsCtntVdh0zFK6QsbxW26UWjJQE_1xMS/view?usp=sharing

The summary of this last scan including Start Discovery.

@ MGMT Command: Start Discovery (0x0023) plen 1                                  {0x0001} [hci0] 598.347552
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
...
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6                     #1741 [hci0] 598.357554
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                         #1742 [hci0] 598.359436
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Discovering (0x0013) plen 2                                        {0x0001} [hci0] 598.359535
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Enabled (0x01)
< HCI Command: Inquiry (0x01|0x0001) plen 5                                         #1743 [hci0] 598.359568
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                                           #1744 [hci0] 598.361410
      Inquiry (0x01|0x0001) ncmd 2
        Status: Success (0x00)
...

> 
> > Add scan_disable_complete to check state and stop discovery if stuck.
> > Tested with bluetooth AX201 (8087:0026) in Dell Vostro 13 laptop.
> >
> >   [4517.963204] hci0: state 0 -> 1
> >   [4518.096858] hci0: state 1 -> 2
> >   [4528.353765] hci0: state 2 -> 0
> >   [4528.353776] hci0: state finding to stopped
> >   [4533.966844] hci0: state 0 -> 1
> >   [4534.097702] hci0: state 1 -> 2
> >   [4544.478600] hci0: state 2 -> 0
> >
> > Fixes: 8ffde2a73f2c ("Bluetooth: Convert le_scan_disable timeout to hci_sync")
> > Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> > ---
> >  net/bluetooth/hci_sync.c | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index aff8562a8690..4cb1c82cc3f0 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -361,6 +361,28 @@ static int interleaved_inquiry_sync(struct hci_dev *hdev, void *data)
> >         return hci_inquiry_sync(hdev, DISCOV_INTERLEAVED_INQUIRY_LEN, 0);
> >  }
> >
> > +static void scan_disable_complete(struct hci_dev *hdev, void *data, int err)
> > +{
> > +       if (err)
> > +               return;
> > +
> > +       hci_dev_lock(hdev);
> > +
> > +       if (hdev->discovery.type != DISCOV_TYPE_INTERLEAVED)
> > +               goto unlock;
> > +
> > +       if (hci_test_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY)) {
> > +               if (!test_bit(HCI_INQUIRY, &hdev->flags) &&
> > +                   hdev->discovery.state == DISCOVERY_FINDING) {
> > +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> > +                       bt_dev_dbg(hdev, "state finding to stopped");
> 
> hci_discovery_set_state already prints the state so printing it again
> is probably unnecessary. Also, this probably needs to be handled via
> hci_event.c since it is not necessarily le_scan_disable that would
> cause scan to be disabled, hci_scan_disable_sync can cause it as well.

will move to le_set_scan_enable_complete

> 
> > +               }
> > +       }
> > +
> > +unlock:
> > +       hci_dev_unlock(hdev);
> > +}
> > +
> >  static void le_scan_disable(struct work_struct *work)
> >  {
> >         struct hci_dev *hdev = container_of(work, struct hci_dev,
> > @@ -373,7 +395,8 @@ static void le_scan_disable(struct work_struct *work)
> >         if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
> >                 goto _return;
> >
> > -       status = hci_cmd_sync_queue(hdev, scan_disable_sync, NULL, NULL);
> > +       status = hci_cmd_sync_queue(hdev, scan_disable_sync, NULL,
> > +                                   scan_disable_complete);
> >         if (status) {
> >                 bt_dev_err(hdev, "failed to disable LE scan: %d", status);
> >                 goto _return;
> > --
> > 2.53.0
> >
> 
> 
> -- 
> Luiz Augusto von Dentz
