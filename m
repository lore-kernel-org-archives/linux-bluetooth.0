Return-Path: <SRS0=rkTY=PG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C733AC43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 07:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955392070D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Dec 2018 07:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbeL2HdL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:33:11 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54829 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbeL2HdK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Dec 2018 02:33:10 -0500
Received: from [172.20.12.43] (unknown [213.61.67.157])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2B7D6CF358;
        Sat, 29 Dec 2018 08:40:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] LE Ping: Changes implement LE Ping feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1545970554-2316-1-git-send-email-spoorthix.k@intel.com>
Date:   Sat, 29 Dec 2018 08:33:07 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A06EFCA4-24CB-46B3-BCD5-AF7781B82E04@holtmann.org>
References: <1545970554-2316-1-git-send-email-spoorthix.k@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

> As per the Core Specification 5.0, Volume 2, Part E, Section 7.3.94
> the following code changes implements HCI Write Authenticated Payload Timeout
> command for LE Ping feature.
> 
> Signed-off-by: SpoorthiX <spoorthix.k@intel.com>
> ---
> include/net/bluetooth/hci.h  |  6 +++
> include/net/bluetooth/mgmt.h |  9 +++++
> net/bluetooth/hci_event.c    | 28 ++++++++++++++
> net/bluetooth/mgmt.c         | 92 ++++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 135 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c36dc1e..c2a8080 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1130,6 +1130,12 @@ struct hci_cp_write_sc_support {
> 	__u8	support;
> } __packed;
> 
> +#define HCI_OP_WRITE_AUTH_PAYLOAD_TO    0x0c7c
> +struct hci_cp_write_auth_payload_to {
> +        __u16	conn_handle;
> +        __u16   timeout;
> +} __packed;
> +
> #define HCI_OP_READ_LOCAL_OOB_EXT_DATA	0x0c7d
> struct hci_rp_read_local_oob_ext_data {
> 	__u8     status;
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 9cee7dd..22c3052 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -654,6 +654,15 @@ struct mgmt_cp_set_phy_confguration {
> } __packed;
> #define MGMT_SET_PHY_CONFIGURATION_SIZE	4
> 
> +
> +#define MGMT_OP_WRITE_AUTH_PAYLOAD_TO   0x0046
> +struct mgmt_cp_write_auth_payload_to {
> +       __le16  conn_handle;
> +       __le16  auth_to;
> +} __packed;
> +#define MGMT_OP_WRITE_AUTH_PAYLOAD_TO_SIZE  4

there is no benefit for this kind of pass-through MGMT -> HCI. If you want to provide a default auth timeout that then gets programmed to every connection, fine, but this is of no use. bluetoothd will not track a connection and then change the auth timeout. And even if we would provide an API for that, then it would be done through the L2CAP socket that has an underlying HCI connection.

Regards

Marcel

