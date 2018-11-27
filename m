Return-Path: <SRS0=erFC=OG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B519C43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 00:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F1F208E7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 00:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aMD6j6wL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F1F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeK0LFr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:05:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42076 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeK0LFr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Nov 2018 06:05:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so7391529pfr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Nov 2018 16:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b27HU6+9HgMck5TrOvzjalvbT1Wd+sf+FoQEMzkXYq8=;
        b=aMD6j6wLMjiJsT/aHF/fxzXCx+gItvW40J0rvztLXvgEwXXZRYODc4QZowzF584Pfw
         3I4aym8FI/RZY2aLabWgGAKG+f/Kn/7rmgaUah9dOqSmRpfUG4aM60D4GP+2/6l2R04T
         IXaD6JW7B/7Q6v01lQv1qRj79KJPEPLG+nsec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b27HU6+9HgMck5TrOvzjalvbT1Wd+sf+FoQEMzkXYq8=;
        b=HCQE867VPjfIk0dNbDV7SNe4+2xNhh5FsTzOGgvdhkOmm5l2a2j1SLZ7YluSS23ake
         W0/ztYngsdHZIjWc2FWPzOs4D3bKpYk5Iaw4cadssnIzk0t84uJNgDltZigbtiDzBQAn
         P7D/zmaotjcf4p/FO/TljRJ3ku1ia3JKmpDK3JUf7e+KeOAAl5UorbFPfnu+hjlKXujF
         3ZdQ0swN54Eryg1roI6AhnDCzU+5pRlo9gDzu5i7H9lwMZ93lCFGHD8XAntN65kBPT4l
         6R7UAokugo6rHXCgQe+aOR5phWTiXXkWU+XCcgU7q5L5EGtqXO/S4eiaBfo5aaeSTB1C
         YSYw==
X-Gm-Message-State: AGRZ1gKaDzmCE6oOHzYvy/zLNLCRhirPh9Hhyc+QN3Qa9Q/vZZLUE+ty
        mOABV1ocBHIzLW60m1Yd5ONZhA==
X-Google-Smtp-Source: AJdET5ciFA8h6WursoI3Pb8eIl+j1gK7FHImed10uhbZIlR5lQYaIPuxKhOvLGku8CZzEDuxJMzAgA==
X-Received: by 2002:a62:2cf:: with SMTP id 198mr29633287pfc.67.1543277392019;
        Mon, 26 Nov 2018 16:09:52 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id t4-v6sm1782846pfh.21.2018.11.26.16.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 16:09:51 -0800 (PST)
Date:   Mon, 26 Nov 2018 16:09:50 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_qca: Fix frame reassembly errors
 for wcn3990
Message-ID: <20181127000950.GY22824@google.com>
References: <20181122121512.13136-1-bgodavar@codeaurora.org>
 <20181122121512.13136-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181122121512.13136-4-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Nov 22, 2018 at 05:45:12PM +0530, Balakrishna Godavarthi wrote:
> During initalization of wcn3990, we observed UART is reading some
> stray bytes on the Rx line. This is logging Frame reassembly errors
> on the serial console. This could be because of tristate of Tx line
> of wcn3990 during boot up.
> 
> [  176.929612] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> [  176.945734] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> [  176.953298] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> [  177.010660] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> [  177.067633] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
> 
> Now we enable a flag during bootup to stop executing proto receive
> function and clear it back once the initialization is done.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> v2:
>  * Updated commit text & comments.
> v1: 
>  * initial patch
> ---
>  drivers/bluetooth/hci_qca.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index ed905ea1c58a..2f3d9e16ba5a 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -56,6 +56,7 @@
>  
>  /* Controller states */
>  #define STATE_IN_BAND_SLEEP_ENABLED	1
> +#define STATE_DISCARD_RX		2
>  
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
> @@ -511,6 +512,7 @@ static int qca_open(struct hci_uart *hu)
>  		} else {
>  			hu->init_speed = qcadev->init_speed;
>  			hu->oper_speed = qcadev->oper_speed;
> +			set_bit(STATE_DISCARD_RX, &qca->flags);
>  			ret = qca_power_setup(hu, true);
>  			if (ret) {
>  				destroy_workqueue(qca->workqueue);
> @@ -903,6 +905,13 @@ static int qca_recv(struct hci_uart *hu, const void *data, int count)
>  	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
>  		return -EUNATCH;
>  
> +	/* We discard Rx data received while device is in booting
> +	 * stage, This is because of BT chip Tx line is in tristate.
> +	 * Due to this we read some garbage data on UART Rx.
> +	 */
> +	if (test_bit(STATE_DISCARD_RX, &qca->flags))
> +		return 0;
> +
>  	qca->rx_skb = h4_recv_buf(hu->hdev, qca->rx_skb, data, count,
>  				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
>  	if (IS_ERR(qca->rx_skb)) {
> @@ -1193,6 +1202,7 @@ static int qca_setup(struct hci_uart *hu)
>  		if (ret)
>  			return ret;
>  
> +		clear_bit(STATE_DISCARD_RX, &qca->flags);
>  		ret = qca_read_soc_version(hdev, &soc_ver);
>  		if (ret)
>  			return ret;
> @@ -1269,6 +1279,14 @@ static const struct qca_vreg_data qca_soc_data = {
>  
>  static void qca_power_shutdown(struct hci_uart *hu)
>  {
> +	struct qca_data *qca = hu->priv;
> +
> +	/* From this point we go into power off state,
> +	 * disable IBS and discard all the queued data.
> +	 */
> +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);

Is IBS actually related to the frame reassembly errors or is this
addressing a different issue? In 100 iteratios of 'hciconfig up/down'
without clearing the flag I didn't observe any frame reassembly
errors.

> +	set_bit(STATE_DISCARD_RX, &qca->flags);
> +	qca_flush(hu);
>  	host_set_baudrate(hu, 2400);
>  	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
>  	qca_power_setup(hu, false);
