Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E74C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 20:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590FF222C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 20:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAOUZ3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:25:29 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49116 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOUZ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 15:25:28 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1D624CECF2;
        Wed, 15 Jan 2020 21:34:45 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v4 01/11] Bluetooth: Add definitions for CIS connections
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200115063523.32127-2-luiz.dentz@gmail.com>
Date:   Wed, 15 Jan 2020 21:25:26 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B1512A1E-875A-4B2C-94BE-24386C18FB82@holtmann.org>
References: <20200115063523.32127-1-luiz.dentz@gmail.com>
 <20200115063523.32127-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> These adds the HCI definitions for handling CIS connections along with
> ISO data packets.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci.h | 159 +++++++++++++++++++++++++++++++++++-
> 1 file changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 07b6ecedc6ce..bd6ed800de85 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -27,6 +27,7 @@
> 
> #define HCI_MAX_ACL_SIZE	1024
> #define HCI_MAX_SCO_SIZE	255
> +#define HCI_MAX_ISO_SIZE	251
> #define HCI_MAX_EVENT_SIZE	260
> #define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
> 
> @@ -303,6 +304,7 @@ enum {
> #define HCI_ACLDATA_PKT		0x02
> #define HCI_SCODATA_PKT		0x03
> #define HCI_EVENT_PKT		0x04
> +#define HCI_ISODATA_PKT		0x05
> #define HCI_DIAG_PKT		0xf0
> #define HCI_VENDOR_PKT		0xff
> 
> @@ -352,6 +354,15 @@ enum {
> #define ACL_ACTIVE_BCAST	0x04
> #define ACL_PICO_BCAST		0x08
> 
> +/* ISO PB flags */
> +#define ISO_START		0x00
> +#define ISO_CONT		0x01
> +#define ISO_SINGLE		0x02
> +#define ISO_END			0x03
> +
> +/* ISO TS flags */
> +#define ISO_TS			0x01
> +
> /* Baseband links */
> #define SCO_LINK	0x00
> #define ACL_LINK	0x01
> @@ -359,6 +370,7 @@ enum {
> /* Low Energy links do not have defined link type. Use invented one */
> #define LE_LINK		0x80
> #define AMP_LINK	0x81
> +#define ISO_LINK	0x82
> #define INVALID_LINK	0xff
> 
> /* LMP features */
> @@ -440,6 +452,8 @@ enum {
> #define HCI_LE_PHY_2M			0x01
> #define HCI_LE_PHY_CODED		0x08
> #define HCI_LE_CHAN_SEL_ALG2		0x40
> +#define HCI_LE_CIS_MASTER		0x10
> +#define HCI_LE_CIS_SLAVE		0x20
> 
> /* Connection modes */
> #define HCI_CM_ACTIVE	0x0000
> @@ -1718,6 +1732,86 @@ struct hci_cp_le_set_adv_set_rand_addr {
> 	bdaddr_t  bdaddr;
> } __packed;
> 
> +#define HCI_OP_LE_READ_BUFFER_SIZE_V2	0x2060
> +struct hci_rp_le_read_buffer_size_v2 {
> +	__u8  status;
> +	__le16 acl_mtu;
> +	__u8  acl_max_pkt;
> +	__le16 iso_mtu;
> +	__u8  iso_max_pkt;
> +} __attribute__ ((packed));

please continue the whitespace spacing between the type and variable name as we do it for all the others.

And actually the kernel used __packed. I missed that the first times around.

Regards

Marcel

