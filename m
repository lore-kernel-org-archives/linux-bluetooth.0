Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158839463;
	Tue,  2 Jun 2026 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411737; cv=none; b=nXULpOlkW+ke0BefTngDjEPrMd2TK8sbI9MO0DJm/jio9hN82r9Rbh7hlWfui6zXzJiJeP4ONmQErQf0CwNiTrDCHrGsG4KNeaj4OfOHqWCW28tg2NUb2sDEcpkWJdH3zcKMQsDHxxv1X3xZWxjpWa+l8SUR3I5f4THw0xGxlug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411737; c=relaxed/simple;
	bh=2olCUkgc1hGvuuMd2u2zCKE5oeny8sMZRaUbFbk+qos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqGmRVq1wMpfVLbR+/iH5gvngGTS5r0qJpTh7K/SBVYm6gJRmhyEYAE/V9M5IAMedGYE3iZ26/o5dxmH5N0iLZshm710PFrqqmczTs88hQSog+xbgtWphE0t1tDoUAuPRhB4BYDg4JcCkmY+ijAqsQbe5VBiWZAlp/SwiHEtzG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DB0DD4C1A4E997;
	Tue, 02 Jun 2026 16:41:00 +0200 (CEST)
Message-ID: <fc5c142e-3187-42a2-af4d-9103858da93e@molgen.mpg.de>
Date: Tue, 2 Jun 2026 16:40:59 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_event: fix simultaneous discovery stuck
 in FINDING
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jiajia Liu <liujia6264@gmail.com>
References: <20260602070032.51248-1-liujiajia@kylinos.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260602070032.51248-1-liujiajia@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jiajia,


Thank you for your patch.

Am 02.06.26 um 09:00 schrieb Jiajia Liu:
> When hci_inquiry_complete_evt is called between le_scan_disable and
> le_set_scan_enable_complete and no remote name needs to be resolved,
> the interleaved discovery with SIMULTANEOUS quirk gets stuck in
> DISCOVERY_FINDING. le_set_scan_enable_complete does not check inquiry
> state. No one sets DISCOVERY_STOPPED in this process.
> 
> Add state check in le_set_scan_enable_complete and change state if
> the state is DISCOVERY_FINDING. Tested with AX201 (8087:0026) in Dell

… change state to DISCOVERY_STOPPED …

I’d add a new paragraph for the Tested part.

> Vostro 13. Discovering disabled MGMT Event below is reported when
> running into the above condition.

Thank you for sharing the test device. Could you please document how to 
get into this state exactly? Some Xiaomi device?

>   @ MGMT Command: Start Discovery (0x0023)    {0x0001} [hci0] 10885.970873
>           Address type: 0x07
>             BR/EDR
>             LE Public
>             LE Random
>   ...
>   < HCI Command: LE Set Extended Scan Enable    #38205 [hci0] 10886.131438
>           Extended scan: Enabled (0x01)
>           Filter duplicates: Enabled (0x01)
>           Duration: 0 msec (0x0000)
>           Period: 0.00 sec (0x0000)
>   > HCI Event: Command Complete (0x0e) plen 4   #38206 [hci0] 10886.133295
>         LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>           Status: Success (0x00)
>   @ MGMT Event: Discovering (0x0013) plen 2   {0x0001} [hci0] 10886.133414
>           Address type: 0x07
>             BR/EDR
>             LE Public
>             LE Random
>           Discovery: Enabled (0x01)
>   < HCI Command: Inquiry (0x01|0x0001) plen 5   #38207 [hci0] 10886.133528
>           Access code: 0x9e8b33 (General Inquiry)
>           Length: 10.24s (0x08)
>           Num responses: 0
>   > HCI Event: Command Status (0x0f) plen 4     #38208 [hci0] 10886.141333
>         Inquiry (0x01|0x0001) ncmd 2
>           Status: Success (0x00)
>   ...
>   < HCI Command: LE Set Extended Scan Enable    #38242 [hci0] 10896.381802
>           Extended scan: Disabled (0x00)
>           Filter duplicates: Disabled (0x00)
>           Duration: 0 msec (0x0000)
>           Period: 0.00 sec (0x0000)
>   > HCI Event: Inquiry Complete (0x01) plen 1   #38243 [hci0] 10896.383419
>           Status: Success (0x00)
>   > HCI Event: Command Complete (0x0e) plen 4   #38244 [hci0] 10896.394378
>         LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>           Status: Success (0x00)
>   @ MGMT Event: Device Found (0x0012) plen 22 {0x0001} [hci0] 10896.394497
>           LE Address: 88:12:AC:92:43:69
>           RSSI: -101 dBm (0x9b)
>           Flags: 0x00000004
>             Not Connectable
>           Data length: 8
>           Company: Xiaomi Inc. (911)
>             Data[0]:
>           16-bit Service UUIDs (complete): 1 entry
>             Xiaomi Inc. (0xfdaa)
>   @ MGMT Event: Discovering (0x0013) plen 2   {0x0001} [hci0] 10896.394506
>           Address type: 0x07
>             BR/EDR
>             LE Public
>             LE Random
>           Discovery: Disabled (0x00)
> 
> Fixes: 8ffde2a73f2c ("Bluetooth: Convert le_scan_disable timeout to hci_sync")
> Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> ---
> 
> Changes in v2:
> - move the handler to hci_event.c
> - remove unnecessary bt_dev_dbg
> - update commit message
> 
> ---
>   net/bluetooth/hci_event.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index eea2f810aafa..1cd5f97daafe 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1769,6 +1769,13 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
>   
>   		hci_dev_clear_flag(hdev, HCI_LE_SCAN);
>   
> +		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
> +		    hci_test_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY) &&
> +		    !test_bit(HCI_INQUIRY, &hdev->flags) &&
> +		    hdev->discovery.state == DISCOVERY_FINDING) {
> +			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +		}
> +
>   		/* The HCI_LE_SCAN_INTERRUPTED flag indicates that we
>   		 * interrupted scanning due to a connect request. Mark
>   		 * therefore discovery as stopped.


Kind regards,

Paul
