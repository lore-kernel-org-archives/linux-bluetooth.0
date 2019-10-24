Return-Path: <SRS0=pV4/=YR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7CCC47E49
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Oct 2019 13:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A369E21925
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Oct 2019 13:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502264AbfJXNBR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:01:17 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49947 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502258AbfJXNBQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Oct 2019 09:01:16 -0400
Received: from marcel-macpro.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 21FE7CECEF;
        Thu, 24 Oct 2019 15:10:15 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] Bluetooth: Always set scannable for Adv instance 0
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1571913139-6477-1-git-send-email-jaganath.kanakkassery@intel.com>
Date:   Thu, 24 Oct 2019 15:01:13 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <585F2A10-B16E-46BD-8EF6-4FD904A485AC@holtmann.org>
References: <1571913139-6477-1-git-send-email-jaganath.kanakkassery@intel.com>
To:     Jaganath Kanakkassery <jaganath.k.os@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jaganath,

> By default for instance 0, local name will be added for scan rsp
> data, but currently the property is set as non scannable and hence
> Set Adv parameter fails with Invalid parameter.

can you be a bit more specific why this is the correct behavior. We must have documented in mgmt-api.txt somewhere, right? Or is this something that used to be correct, but we broke it with adding extended advertising?

> < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
>        Handle: 0x00
>        Properties: 0x0010
>          Use legacy advertising PDUs: ADV_NONCONN_IND
>        Min advertising interval: 1280.000 msec (0x0800)
>        Max advertising interval: 1280.000 msec (0x0800)
>        Channel map: 37, 38, 39 (0x07)
>        Own address type: Random (0x01)
>        Peer address type: Public (0x00)
>        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
>        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
>        TX power: 127 dbm (0x7f)
>        Primary PHY: LE 1M (0x01)
>        Secondary max skip: 0x00
>        Secondary PHY: LE 1M (0x01)
>        SID: 0x00
>        Scan request notifications: Disabled (0x00)
>> HCI Event: Command Complete (0x0e) plen 5
>      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
>        Status: Success (0x00)
>        TX power (selected): 7 dbm (0x07)
> 
> < HCI Command: LE Set Extended Scan Response Data (0x08|0x0038) plen 35
>        Handle: 0x00
>        Operation: Complete scan response data (0x03)
>        Fragment preference: Minimize fragmentation (0x01)
>        Data length: 0x0d
>        Name (short): localhost.
>> HCI Event: Command Complete (0x0e) plen 4
>      LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
>        Status: Invalid HCI Command Parameters (0x12)
> 
> This patch makes the instance 0 scannable by default.
> 
> < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
>        Handle: 0x00
>        Properties: 0x0012
>          Scannable
>          Use legacy advertising PDUs: ADV_SCAN_IND
>        Min advertising interval: 1280.000 msec (0x0800)
>        Max advertising interval: 1280.000 msec (0x0800)
>        Channel map: 37, 38, 39 (0x07)
>        Own address type: Random (0x01)
>        Peer address type: Public (0x00)
>        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
>        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
>        TX power: 127 dbm (0x7f)
>        Primary PHY: LE 1M (0x01)
>        Secondary max skip: 0x00
>        Secondary PHY: LE 1M (0x01)
>        SID: 0x00
>        Scan request notifications: Disabled (0x00)
>> HCI Event: Command Complete (0x0e) plen 5
>      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
>        Status: Success (0x00)
>        TX power (selected): 7 dbm (0x07)
> 
> < HCI Command: LE Set Extended Scan Response Data (0x08|0x0038) plen 35
>        Handle: 0x00
>        Operation: Complete scan response data (0x03)
>        Fragment preference: Minimize fragmentation (0x01)
>        Data length: 0x0d
>        Name (short): localhost.
>> HCI Event: Command Complete (0x0e) plen 4
>      LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
>        Status: Success (0x00)
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
> ---
> net/bluetooth/hci_request.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 7f6a581..362b1ca 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1601,7 +1601,12 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
> 			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_CONN_IND);
> 		else
> 			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
> -	} else if (get_adv_instance_scan_rsp_len(hdev, instance)) {
> +	} else if (!instance || get_adv_instance_scan_rsp_len(hdev, instance)) {
> +		/* Always set scannable for instance 0, as scan rsp data will
> +		 * be set by default with local name. For other instances set
> +		 * scannable based on whether scan rsp data is there for the
> +		 * respective instance
> +		 */
> 		if (secondary_adv)
> 			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_SCAN_IND);

So this comment is at a wrong location. And I am not convinced that we would actually depend on if scan_rsp data is present. We might want to set scannable all the time if that is what we decided for instance 0.

Regards

Marcel

