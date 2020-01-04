Return-Path: <SRS0=BHgP=2Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A82C2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 10:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED84215A4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 10:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgADKII convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:08:08 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38272 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgADKII (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jan 2020 05:08:08 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B1438CED13;
        Sat,  4 Jan 2020 11:17:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v5 1/2] bluetooth: add support to notify SCO air mode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191129121042.3311-1-sathish.narasimman@intel.com>
Date:   Sat, 4 Jan 2020 11:08:06 +0100
Cc:     BlueZ devel list <linux-bluetooth@vger.kernel.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D31F831A-84EE-4678-A1C6-421BEB8D1244@holtmann.org>
References: <20191129121042.3311-1-sathish.narasimman@intel.com>
To:     Sathish Narsimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Satish,

> notifying HCI_NOTIFY_CONN_ADD for SCO connection is generic in
> case of msbc audio. To differnetiate SCO air mode audio introducing
> HCI_NOTIFY_SCO_CVSD and HCI_NOTIFY_SCO_TRASP.
> 
> Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> ---
> include/net/bluetooth/hci.h      |  3 +++
> include/net/bluetooth/hci_core.h |  3 +++
> net/bluetooth/hci_conn.c         | 19 +++++++++++++++----
> net/bluetooth/hci_event.c        |  9 +++++++++
> 4 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 5bc1e30dedde..bfaaef1aa4d6 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -52,6 +52,9 @@
> #define HCI_NOTIFY_CONN_ADD		1
> #define HCI_NOTIFY_CONN_DEL		2
> #define HCI_NOTIFY_VOICE_SETTING	3
> +#define HCI_NOTIFY_ENABLE_SCO_CVSD	4
> +#define HCI_NOTIFY_ENABLE_SCO_TRANSP	5
> +#define HCI_NOTIFY_DISABLE_SCO		6
> 
> /* HCI bus types */
> #define HCI_VIRTUAL	0
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b689aceb636b..9258e19f8cc5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1604,4 +1604,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
> #define SCO_AIRMODE_CVSD       0x0000
> #define SCO_AIRMODE_TRANSP     0x0003
> 
> +#define SCO_CODED_CVSD         0x02
> +#define SCO_CODED_TRANSP       0x03
> +

why is this needed. And more important, what is wrong with SCO_AIRMODE_CVSD above?

> #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 87691404d0c6..097a179418d6 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -122,8 +122,13 @@ static void hci_conn_cleanup(struct hci_conn *conn)
> 
> 	hci_conn_hash_del(hdev, conn);
> 
> -	if (hdev->notify)
> -		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
> +	if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
> +		if (hdev->notify)
> +			hdev->notify(hdev, HCI_NOTIFY_DISABLE_SCO);
> +	} else {
> +		if (hdev->notify)
> +			hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
> +	}
> 
> 	hci_conn_del_sysfs(conn);
> 
> @@ -561,8 +566,14 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
> 	hci_dev_hold(hdev);
> 
> 	hci_conn_hash_add(hdev, conn);
> -	if (hdev->notify)
> -		hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
> +
> +	/* As HCI_NOTIFY_ENABLE_SCO_CVSD & HCI_NOTIFY_ENABLE_SCO_TRANSP is
> +	 * used to notify SCO connections during sync_conn_complete event
> +	 */
> +	if (conn->type != SCO_LINK && conn->type != ESCO_LINK) {
> +		if (hdev->notify)
> +			hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
> +	}
> 
> 	hci_conn_init_sysfs(conn);
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c1d3a303d97f..ecad696db139 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4231,6 +4231,15 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
> 		break;
> 	}
> 
> +	BT_DBG("sco connected with air mode: %02x", ev->air_mode);
> +	if (ev->air_mode == SCO_CODED_CVSD) {
> +		if (hdev->notify)
> +			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
> +	} else if (ev->air_mode == SCO_CODED_TRANSP) {
> +		if (hdev->notify)
> +			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
> +	}
> +

You are however forgetting the old hci_conn_complete for legacy SCO setup.

Regards

Marcel

