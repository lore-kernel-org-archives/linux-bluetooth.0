Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3681EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 03:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjF0DtR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 23:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjF0Ds6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 23:48:58 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D501BFB
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 20:47:56 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb05.dynamic.kabel-deutschland.de [95.90.235.5])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3B02061E5FE01;
        Tue, 27 Jun 2023 05:47:47 +0200 (CEST)
Message-ID: <0d8ecb01-e998-e28d-1eb8-d286bdaccecd@molgen.mpg.de>
Date:   Tue, 27 Jun 2023 05:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5] Bluetooth: hci_event: Fix parsing of CIS Established
 Event
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20230627003142.2274828-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230627003142.2274828-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Luiz,


Thank you for your patch.

Am 27.06.23 um 02:31 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The ISO Interval on CIS Established Event uses 1.25 ms slots:
> 
>      BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
>      page 2304:
> 
>        Time = N * 1.25 ms
> 
> In addition to that this always update the QoS settings based on CIS
> Established Event.

update*s*

Does “always” mean, it wasn’t set for the master role before, and that 
is done now?


Kind regards,

Paul


> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_event.c | 45 ++++++++++++++++++++++++++++-----------
>   1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index b1aefe4bb751..77cbf13037b3 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6822,6 +6822,7 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
>   {
>   	struct hci_evt_le_cis_established *ev = data;
>   	struct hci_conn *conn;
> +	struct bt_iso_qos *qos;
>   	bool pending = false;
>   	u16 handle = __le16_to_cpu(ev->handle);
>   
> @@ -6846,21 +6847,39 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
>   
>   	pending = test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags);
>   
> -	if (conn->role == HCI_ROLE_SLAVE) {
> -		__le32 interval;
> +	qos = &conn->iso_qos;
>   
> -		memset(&interval, 0, sizeof(interval));
> +	/* Convert ISO Interval (1.25 ms slots) to SDU Interval (us) */
> +	qos->ucast.in.interval = le16_to_cpu(ev->interval) * 1250;
> +	qos->ucast.out.interval = qos->ucast.in.interval;
>   
> -		memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
> -		conn->iso_qos.ucast.in.interval = le32_to_cpu(interval);
> -		memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
> -		conn->iso_qos.ucast.out.interval = le32_to_cpu(interval);
> -		conn->iso_qos.ucast.in.latency = le16_to_cpu(ev->interval);
> -		conn->iso_qos.ucast.out.latency = le16_to_cpu(ev->interval);
> -		conn->iso_qos.ucast.in.sdu = le16_to_cpu(ev->c_mtu);
> -		conn->iso_qos.ucast.out.sdu = le16_to_cpu(ev->p_mtu);
> -		conn->iso_qos.ucast.in.phy = ev->c_phy;
> -		conn->iso_qos.ucast.out.phy = ev->p_phy;
> +	switch (conn->role) {
> +	case HCI_ROLE_SLAVE:
> +		/* Convert Transport Latency (us) to Latency (msec) */
> +		qos->ucast.in.latency =
> +			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->c_latency),
> +					  1000);
> +		qos->ucast.out.latency =
> +			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
> +					  1000);
> +		qos->ucast.in.sdu = le16_to_cpu(ev->c_mtu);
> +		qos->ucast.out.sdu = le16_to_cpu(ev->p_mtu);
> +		qos->ucast.in.phy = ev->c_phy;
> +		qos->ucast.out.phy = ev->p_phy;
> +		break;
> +	case HCI_ROLE_MASTER:
> +		/* Convert Transport Latency (us) to Latency (msec) */
> +		qos->ucast.out.latency =
> +			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->c_latency),
> +					  1000);
> +		qos->ucast.in.latency =
> +			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
> +					  1000);
> +		qos->ucast.out.sdu = le16_to_cpu(ev->c_mtu);
> +		qos->ucast.in.sdu = le16_to_cpu(ev->p_mtu);
> +		qos->ucast.out.phy = ev->c_phy;
> +		qos->ucast.in.phy = ev->p_phy;
> +		break;
>   	}
>   
>   	if (!ev->status) {
