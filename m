Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix reporting incorrect EIR in device found mgmt event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1442427714-27726-2-git-send-email-szymon.janc@gmail.com>
Date: Fri, 18 Sep 2015 09:58:21 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Szymon Janc <ext.szymon.janc@tieto.com>
Message-Id: <7E80C983-0499-4DD7-89A7-C0E990EB065B@holtmann.org>
References: <1442427714-27726-1-git-send-email-szymon.janc@gmail.com> <1442427714-27726-2-git-send-email-szymon.janc@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Some remote devices (ie Gigaset G-Tag) misbehave with ADV data length.
> This can lead to incorrect EIR format in device found event when
> ADV_DATA and SCAN_RSP are merged (terminator field before SCAN_RSP
> part).
> 
> Fix this by inspecting ADV_DATA and correct its length if terminator
> is found.
> 
>> HCI Event: LE Meta Event (0x3e) plen 42              [hci0] 32.172182
>      LE Advertising Report (0x02)
>        Num reports: 1
>        Event type: Connectable undirected - ADV_IND (0x00)
>        Address type: Public (0x00)
>        Address: 7C:2F:80:94:97:5A (Gigaset Communications GmbH)
>        Data length: 30
>        Flags: 0x06
>          LE General Discoverable Mode
>          BR/EDR Not Supported
>        Company: Gigaset Communications GmbH (384)
>          Data: 021512348094975abbc5
>        16-bit Service UUIDs (partial): 1 entry
>          Battery Service (0x180f)
>        RSSI: -65 dBm (0xbf)
>> HCI Event: LE Meta Event (0x3e) plen 27              [hci0] 32.172191
>      LE Advertising Report (0x02)
>        Num reports: 1
>        Event type: Scan response - SCAN_RSP (0x04)
>        Address type: Public (0x00)
>        Address: 7C:2F:80:94:97:5A (Gigaset Communications GmbH)
>        Data length: 15
>        Name (complete): Gigaset G-tag
>        RSSI: -59 dBm (0xc5)
> 
> Note "Data length: 30" in ADV_DATA which results in 9 extra zero bytes
> after Battery Service UUID. Terminator field present in the middle of
> EIR in Device Found event resulted in userspace stop parsing EIR and
> skipping device name.
> 
> @ Device Found: 7C:2F:80:94:97:5A (1) rssi -59 flags 0x0000
>      02 01 06 0d ff 80 01 02 15 12 34 80 94 97 5a bb  ..........4...Z.
>      c5 03 02 0f 18 00 00 00 00 00 00 00 00 00 0e 09  ................
>      47 69 67 61 73 65 74 20 47 2d 74 61 67           Gigaset G-tag
> 
> With this fix EIR with merged ADV_DATA and SCAN_RSP in device found
> event is properly formatted:
> 
> @ Device Found: 7C:2F:80:94:97:5A (1) rssi -59 flags 0x0000
>      02 01 06 0d ff 80 01 02 15 12 34 80 94 97 5a bb  ..........4...Z.
>      c5 03 02 0f 18 0e 09 47 69 67 61 73 65 74 20 47  .......Gigaset G
>      2d 74 61 67                                      -tag
> 
> Signed-off-by: Szymon Janc <ext.szymon.janc@tieto.com>
> ---
> net/bluetooth/hci_event.c | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

