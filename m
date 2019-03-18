Return-Path: <SRS0=9Smc=RV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C68C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D861A205F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 17:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCRRCo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:02:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50869 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfCRRCo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 13:02:44 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1492CCF172;
        Mon, 18 Mar 2019 18:10:43 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Add support for LE ping feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1552905425-24048-1-git-send-email-spoorthix.k@intel.com>
Date:   Mon, 18 Mar 2019 18:02:42 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <453BE14F-26C1-481A-9FE1-F204DFE98468@holtmann.org>
References: <1552905425-24048-1-git-send-email-spoorthix.k@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

> Changes made to add HCI Write Authenticated Payload timeout
> command for LE Ping feature.
> As per the Core Specification 5.0 Volume 2 Part E Section 7.3.94,
> the following code changes implements
> HCI Write Authenticated Payload timeout command for LE Ping feature.
> 
> Signed-off-by: SpoorthiX <spoorthix.k@intel.com>

we prefer proper names and not some nicknames or abbreviations. So please configure your .gitconfig accordingly.

> ---
> include/net/bluetooth/hci.h |  7 +++++++
> net/bluetooth/hci_event.c   | 21 +++++++++++++++++++++
> 2 files changed, 28 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c36dc1e..ec37c19 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1130,6 +1130,13 @@ struct hci_cp_write_sc_support {
> 	__u8	support;
> } __packed;
> 
> +#define HCI_OP_WRITE_AUTH_PAYLOAD_TO    0x0c7c
> +struct hci_cp_write_auth_payload_to {
> +        __u16     conn_handle;
> +        __u16      timeout;
> +} __packed;
> +
> +

Please follow the coding style and not just randomly code things.

In addition please use proper endian notation.

> #define HCI_OP_READ_LOCAL_OOB_EXT_DATA	0x0c7d
> struct hci_rp_read_local_oob_ext_data {
> 	__u8     status;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 609fd68..ae14927 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -38,6 +38,7 @@
> 
> #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
> 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
> +#define AUTHENTICATED_PAYLOAD_TIMEOUT 0x0BB8

I am not even sure this is the right location for this constant. Since frankly there needs to be some default value configured in hci_dev and it might also need at least some debugfs setting to change it.

> 
> /* Handle HCI Event packets */
> 
> @@ -4815,6 +4816,22 @@ static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
> }
> #endif
> 
> +static void hci_write_auth_payload_to (struct hci_dev *hdev, struct hci_conn *conn)
> +{
> +        struct hci_cp_write_auth_payload_to cp;
> +
> +        /* Check for existing LE link established between local
> +         * and remote device, also check the controller capability
> +         * for LE Ping.
> +         */
> +        if ((conn->type == LE_LINK) && (lmp_ping_capable(hdev)))  {

No extra () needed here.

> +                cp.conn_handle = cpu_to_le16(conn->handle);
> +                cp.timeout = AUTHENTICATED_PAYLOAD_TIMEOUT;
> +                hci_send_cmd(conn->hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO,
> +			sizeof(cp), &cp);
> +        }
> +}
> +
> static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
> 			bdaddr_t *bdaddr, u8 bdaddr_type, u8 role, u16 handle,
> 			u16 interval, u16 latency, u16 supervision_timeout)
> @@ -4972,6 +4989,10 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
> 		}
> 	}
> 
> +         /* Set the default Authenticated Payload Timeout after
> +          * an LE Link is established.
> +          */
> +	hci_write_auth_payload_to (hdev, conn);

I am not sure just sending this value acceptable. We need to store a per hci_conn default and change it once this succeeds. So a lot more code is needed to make this clean and useful.

Also when an LE connection is complete, we need to ensure the right commands are send in the right order and status update to higher layers are only given once they complete.

> unlock:
> 	hci_update_background_scan(hdev);
> 	hci_dev_unlock(hdev);
> -- 
> 1.9.1
> 

Regards

Marcel

