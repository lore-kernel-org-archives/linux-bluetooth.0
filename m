Return-Path: <SRS0=pNHN=QB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E637C282C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 00:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF19218D3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jan 2019 00:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nX48F4Nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfAYANC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:13:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42224 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfAYANB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jan 2019 19:13:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so3656136plp.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jan 2019 16:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B2qbOwfaABSqBpeERv2H4hCD0lY4pVpTYgc+0fjiL7s=;
        b=nX48F4NkkfAdPI+Jh1GDRQ/ZLXRwonHLYlRA6rT+ZqK50TIcoKhNL1d84LG5smC4Au
         2WRLewodvMWdCw6U9fuO+EHtXB9brR6+dYfvrc7lSTI2qVd/JMaRXfHYBFIXPyV1nFtU
         m5xP/C0K7vT4qoQEJG4/KwAnPzt+ycQscRevQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B2qbOwfaABSqBpeERv2H4hCD0lY4pVpTYgc+0fjiL7s=;
        b=NJFime3RbnkTYw6+4k/4ji4/jtlrcMgeDEVZjDKcbalbeyWlocmS2S78up0fVb+IEj
         Sbb3RBffRHR/cnqNptVDQm5eWUQ2RfpdhRLDPZCskR8bPhI3JCC7HqTXdfHrsDB6qeqv
         ZA338CyB+f+mAk4nudOdP7GRo9QpQsJg/k+HGDVnyO1kA8NdvK6IsgNYxKVu+tWz0QCD
         495c5VdOk5K/gT6HPRMasN/105GMIBjE7JZGAOYDVmyTmtE9F3dRuIiUN/5dKEDV57xk
         UcbvfXfbIas+p/pK98b6ROREUFMH4ufXpVCif7yu8rx8RqreEc0KpDRA3kvqUCuYdlZz
         v1Zw==
X-Gm-Message-State: AJcUukcGEtUbOzLqAzFVF5ffBPJxt4w9qYojSu6PY3y2Sl6MfOxnwgS1
        /7GarF2yOhTXhqIbGeV2JKhrHA==
X-Google-Smtp-Source: ALg8bN7d3d+1eD3qzuGZ+x5YCQncngun3uHDkFjWHaIRMdyKU/t8VsGIXFsRqI97RnxvBd7V5GklbA==
X-Received: by 2002:a17:902:780c:: with SMTP id p12mr8452972pll.197.1548375181020;
        Thu, 24 Jan 2019 16:13:01 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a4sm24702452pgv.70.2019.01.24.16.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 16:13:00 -0800 (PST)
Date:   Thu, 24 Jan 2019 16:12:59 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 2/3] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190125001259.GB81583@google.com>
References: <20190124120808.8275-1-bgodavar@codeaurora.org>
 <20190124120808.8275-3-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124120808.8275-3-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Balakrishna,

On Thu, Jan 24, 2019 at 05:38:07PM +0530, Balakrishna Godavarthi wrote:
> This patch will help to stop frame reassembly errors while changing
> the baudrate. This is because host send a change baudrate request
> command to the chip with 115200 bps, Whereas chip will change their
> UART clocks to the enable for new baudrate and sends the response
> for the change request command with newer baudrate, On host side
> we are still operating in 115200 bps which results of reading garbage
> data. Here we are pulling RTS line, so that chip we will wait to send data
> to host until host change its baudrate.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v9:
>  * disabled flow control while setting the baudrate of HOST and chip.
> ---
>  drivers/bluetooth/hci_qca.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c08f4d105e73..6b5bcd44e24c 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -964,7 +964,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>  	struct qca_data *qca = hu->priv;
>  	struct sk_buff *skb;
> -	struct qca_serdev *qcadev;
>  	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
>  
>  	if (baudrate > QCA_BAUDRATE_3200000)
> @@ -978,13 +977,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  		return -ENOMEM;
>  	}
>  
> -	/* Disabling hardware flow control is mandatory while
> -	 * sending change baudrate request to wcn3990 SoC.
> -	 */
> -	qcadev = serdev_device_get_drvdata(hu->serdev);
> -	if (qcadev->btsoc_type == QCA_WCN3990)
> -		hci_uart_set_flow_control(hu, true);
> -
>  	/* Assign commands to change baudrate and packet type. */
>  	skb_put_data(skb, cmd, sizeof(cmd));
>  	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> @@ -1000,9 +992,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
>  	set_current_state(TASK_RUNNING);
>  
> -	if (qcadev->btsoc_type == QCA_WCN3990)
> -		hci_uart_set_flow_control(hu, false);
> -
>  	return 0;
>  }
>  
> @@ -1089,6 +1078,7 @@ static int qca_check_speeds(struct hci_uart *hu)
>  static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  {
>  	unsigned int speed, qca_baudrate;
> +	struct qca_serdev *qcadev;
>  	int ret;
>  
>  	if (speed_type == QCA_INIT_SPEED) {
> @@ -1100,6 +1090,15 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		if (!speed)
>  			return 0;
>  
> +		/* Deassert RTS while changing the baudrate of chip and host.
> +		 * This will prevent chip from transmitting its response with
> +		 * the new baudrate while the host port is still operating at
> +		 * the old speed.
> +		 */

It is not necessarily evident which action deasserts RTS, I suggest to
rephrase it to something like:

"Disable flow control for wcn3990 to deassert RTS while ... "

> +		qcadev = serdev_device_get_drvdata(hu->serdev);
> +		if (qcadev->btsoc_type == QCA_WCN3990)
> +			hci_uart_set_flow_control(hu, true);
> +
>  		qca_baudrate = qca_get_baudrate_value(speed);
>  		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
>  		ret = qca_set_baudrate(hu->hdev, qca_baudrate);

flow control should be re-enabled in the error path.

Cheers

Matthias
