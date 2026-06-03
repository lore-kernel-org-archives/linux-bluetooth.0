Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C522032D;
	Wed,  3 Jun 2026 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454764; cv=none; b=GTIwXWRr9tBwnRn8cz4LPc++9gowf49AN7Oc6K5yIjMDIQe17UvnbP6NJjr09KSNGAGKfIfBxVecaYMDKBIw5dOhugJGz4NsCxoNBDtWB/W4i79XyUHgGnYPZsSyiW7IyqMVzGaS7UNR4vGH4b9z3ZhvhjojXQSAfnry3Gz5r6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454764; c=relaxed/simple;
	bh=ICo8lMYVakV6Ta7fv6iuDA34hXiG6u5KtUYup6JaJes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igmuahNLzQEZs61gtDYr4K0QGMhC+Py8wq96DgtjExaGSIT8Y7H2NRO2rfSGPwXmI0bup8kBjP+iNVEb+ZwK4hPf3x/a0UALKlq9tMlH0c0RC/Cp/NzRqgnIPhs9f11aaHM3pmL7qpZMDK53HMkaBeSStnSx1kN3Pgil/XxDu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 582130a45ef611f1aa26b74ffac11d73-20260603
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7049767b-854b-46ef-aae0-c73364a6f954,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:ba5301e009c589663605536515002ee7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 582130a45ef611f1aa26b74ffac11d73-20260603
X-User: liujiajia@kylinos.cn
Received: from nature [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 179738225; Wed, 03 Jun 2026 10:45:55 +0800
Date: Wed, 3 Jun 2026 10:45:52 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiajia Liu <liujia6264@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_event: fix simultaneous discovery
 stuck in FINDING
Message-ID: <ah-VYK0LqpG8ft7g@nature>
References: <20260602070032.51248-1-liujiajia@kylinos.cn>
 <fc5c142e-3187-42a2-af4d-9103858da93e@molgen.mpg.de>
 <CABBYNZK1GLGu+xdKng3O4b=NrNwxB6ZAyfXSn8DE4WptXN=5CQ@mail.gmail.com>
 <95453e74-636d-4a9f-91c0-189366423180@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95453e74-636d-4a9f-91c0-189366423180@molgen.mpg.de>

On Tue, Jun 02, 2026 at 11:53:29PM +0200, Paul Menzel wrote:
> [Cc: -brian.gix@intel.com (bouncing)]
> 
> Dear Luiz,
> 
> 
> Am 02.06.26 um 18:43 schrieb Luiz Augusto von Dentz:
> 
> > On Tue, Jun 2, 2026 at 10:41 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> 
> > > Am 02.06.26 um 09:00 schrieb Jiajia Liu:
> > > > When hci_inquiry_complete_evt is called between le_scan_disable and
> > > > le_set_scan_enable_complete and no remote name needs to be resolved,
> > > > the interleaved discovery with SIMULTANEOUS quirk gets stuck in
> > > > DISCOVERY_FINDING. le_set_scan_enable_complete does not check inquiry
> > > > state. No one sets DISCOVERY_STOPPED in this process.
> > > > 
> > > > Add state check in le_set_scan_enable_complete and change state if
> > > > the state is DISCOVERY_FINDING. Tested with AX201 (8087:0026) in Dell
> > > 
> > > … change state to DISCOVERY_STOPPED …
> > > 
> > > I’d add a new paragraph for the Tested part.
> > > 
> > > > Vostro 13. Discovering disabled MGMT Event below is reported when
> > > > running into the above condition.
> > > 
> > > Thank you for sharing the test device. Could you please document how to
> > > get into this state exactly? Some Xiaomi device?
> > 
> > What are you talking about here by saying Xiaomi device? He literally
> > said Dell Vostro 13, a laptop, and this is a local only procedure,
> > there is no remote device involved here.
> 
> In the trace below a Xiaomi device shows up, if I am not mistaken.

There should be no requirements for Bluetooth devices. To keep the serial
number of packet continuous, I didn't remove the Device Found MGMT Event.
It looks like someone's TV device.

The producer is Open the bluetooth panel of gnome-control-center and wait.
If the device list on the pannel is not flushed again and becomes empty,
it probably gets into this state. btmon or dynamic debug of
hci_discovery_set_state can confirm the state.

It think it depends on the timing of Inquiry Complete Event. There is a
very small time slot between disabling LE scan and disabling completion.
If Inquiry Complete Event arrives in the slot, there is a chance to hit
the state.

> 
> > > >    @ MGMT Command: Start Discovery (0x0023)    {0x0001} [hci0] 10885.970873
> > > >            Address type: 0x07
> > > >              BR/EDR
> > > >              LE Public
> > > >              LE Random
> > > >    ...
> > > >    < HCI Command: LE Set Extended Scan Enable    #38205 [hci0] 10886.131438
> > > >            Extended scan: Enabled (0x01)
> > > >            Filter duplicates: Enabled (0x01)
> > > >            Duration: 0 msec (0x0000)
> > > >            Period: 0.00 sec (0x0000)
> > > >    > HCI Event: Command Complete (0x0e) plen 4   #38206 [hci0] 10886.133295
> > > >          LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
> > > >            Status: Success (0x00)
> > > >    @ MGMT Event: Discovering (0x0013) plen 2   {0x0001} [hci0] 10886.133414
> > > >            Address type: 0x07
> > > >              BR/EDR
> > > >              LE Public
> > > >              LE Random
> > > >            Discovery: Enabled (0x01)
> > > >    < HCI Command: Inquiry (0x01|0x0001) plen 5   #38207 [hci0] 10886.133528
> > > >            Access code: 0x9e8b33 (General Inquiry)
> > > >            Length: 10.24s (0x08)
> > > >            Num responses: 0
> > > >    > HCI Event: Command Status (0x0f) plen 4     #38208 [hci0] 10886.141333
> > > >          Inquiry (0x01|0x0001) ncmd 2
> > > >            Status: Success (0x00)
> > > >    ...
> > > >    < HCI Command: LE Set Extended Scan Enable    #38242 [hci0] 10896.381802
> > > >            Extended scan: Disabled (0x00)
> > > >            Filter duplicates: Disabled (0x00)
> > > >            Duration: 0 msec (0x0000)
> > > >            Period: 0.00 sec (0x0000)
> > > >    > HCI Event: Inquiry Complete (0x01) plen 1   #38243 [hci0] 10896.383419
> > > >            Status: Success (0x00)
> > > >    > HCI Event: Command Complete (0x0e) plen 4   #38244 [hci0] 10896.394378
> > > >          LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
> > > >            Status: Success (0x00)
> > > >    @ MGMT Event: Device Found (0x0012) plen 22 {0x0001} [hci0] 10896.394497
> > > >            LE Address: 88:12:AC:92:43:69
> > > >            RSSI: -101 dBm (0x9b)
> > > >            Flags: 0x00000004
> > > >              Not Connectable
> > > >            Data length: 8
> > > >            Company: Xiaomi Inc. (911)
> > > >              Data[0]:
> > > >            16-bit Service UUIDs (complete): 1 entry
> > > >              Xiaomi Inc. (0xfdaa)
> > > >    @ MGMT Event: Discovering (0x0013) plen 2   {0x0001} [hci0] 10896.394506
> > > >            Address type: 0x07
> > > >              BR/EDR
> > > >              LE Public
> > > >              LE Random
> > > >            Discovery: Disabled (0x00)
> > > > 
> > > > Fixes: 8ffde2a73f2c ("Bluetooth: Convert le_scan_disable timeout to hci_sync")
> > > > Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> > > > ---
> > > > 
> > > > Changes in v2:
> > > > - move the handler to hci_event.c
> > > > - remove unnecessary bt_dev_dbg
> > > > - update commit message
> > > > 
> > > > ---
> > > >    net/bluetooth/hci_event.c | 7 +++++++
> > > >    1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > > index eea2f810aafa..1cd5f97daafe 100644
> > > > --- a/net/bluetooth/hci_event.c
> > > > +++ b/net/bluetooth/hci_event.c
> > > > @@ -1769,6 +1769,13 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
> > > > 
> > > >                hci_dev_clear_flag(hdev, HCI_LE_SCAN);
> > > > 
> > > > +             if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
> > > > +                 hci_test_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY) &&
> > > > +                 !test_bit(HCI_INQUIRY, &hdev->flags) &&
> > > > +                 hdev->discovery.state == DISCOVERY_FINDING) {
> > > > +                     hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> > > > +             }
> > > > +
> > > >                /* The HCI_LE_SCAN_INTERRUPTED flag indicates that we
> > > >                 * interrupted scanning due to a connect request. Mark
> > > >                 * therefore discovery as stopped.
> 
> 
> Kind regards,
> 
> Paul
