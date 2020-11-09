Return-Path: <SRS0=/O/j=EP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC4C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 12:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB2B207BC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 12:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgKIMph convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:45:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54909 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIMph (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 07:45:37 -0500
Received: from marcel-macbook.fritz.box (p4fefcf0f.dip0.t-ipconnect.de [79.239.207.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id AD92ACECC5;
        Mon,  9 Nov 2020 13:52:43 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Bluetooth: hci_qca: resolve various warnings
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201101025215.GA4828@fedora-project>
Date:   Mon, 9 Nov 2020 13:45:34 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BB6BEAED-CFED-4092-AB9A-A98A064676EE@holtmann.org>
References: <20201101025215.GA4828@fedora-project>
To:     Nigel Christian <nigel.l.christian@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nigel,

> Use template string as opposed to function name. Add a blank
> line after declaration to improve readability. Replace symbolic
> permissions with octal values. Use usleep_range for small msec
> values due to the fact that msleep() less than 20ms may have
> unexpected behavior/sleep longer. This patch removes all
> checkpatch warnings.
> 
> - https://lkml.org/lkml/2016/8/2/1945
> - Documentation/timers/timers-howto.rst
> 
> Signed-off-by: Nigel Christian <nigel.l.christian@gmail.com>
> ---
> drivers/bluetooth/hci_qca.c | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 2d3f1f179a1e..22da59d8f471 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -555,7 +555,7 @@ static int qca_open(struct hci_uart *hu)
> 	struct qca_serdev *qcadev;
> 	struct qca_data *qca;
> 
> -	BT_DBG("hu %p qca_open", hu);
> +	BT_DBG("hu %p %s", hu, __func__);

please clean up your patch before submitting it. This change does not belong
here.

> 	if (!hci_uart_has_flow_control(hu))
> 		return -EOPNOTSUPP;
> @@ -631,7 +631,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
> 	ibs_dir = debugfs_create_dir("ibs", hdev->debugfs);
> 
> 	/* read only */
> -	mode = S_IRUGO;
> +	mode = 0444;
> 	debugfs_create_u8("tx_ibs_state", mode, ibs_dir, &qca->tx_ibs_state);
> 	debugfs_create_u8("rx_ibs_state", mode, ibs_dir, &qca->rx_ibs_state);
> 	debugfs_create_u64("ibs_sent_sleeps", mode, ibs_dir,
> @@ -658,7 +658,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
> 	debugfs_create_u32("vote_off_ms", mode, ibs_dir, &qca->vote_off_ms);
> 
> 	/* read/write */
> -	mode = S_IRUGO | S_IWUSR;
> +	mode = 0644;
> 	debugfs_create_u32("wake_retrans", mode, ibs_dir, &qca->wake_retrans);
> 	debugfs_create_u32("tx_idle_delay", mode, ibs_dir,
> 			   &qca->tx_idle_delay);
> @@ -1215,6 +1215,7 @@ static int qca_recv(struct hci_uart *hu, const void *data, int count)
> 				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
> 	if (IS_ERR(qca->rx_skb)) {
> 		int err = PTR_ERR(qca->rx_skb);
> +

This omitted empty line was intentional btw.

> 		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
> 		qca->rx_skb = NULL;
> 		return err;
> @@ -1302,7 +1303,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
> 
> 	/* Give the controller time to process the request */
> 	if (qca_is_wcn399x(qca_soc_type(hu)))
> -		msleep(10);
> +		usleep_range(1000, 10000);
> 	else
> 		msleep(300);
> 
> @@ -1350,7 +1351,7 @@ static int qca_send_power_pulse(struct hci_uart *hu, bool on)
> 	if (on)
> 		msleep(100);
> 	else
> -		msleep(10);
> +		usleep_range(1000, 10000);

Regards

Marcel

