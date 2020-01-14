Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A2AC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF46F24672
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 14:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgANOLR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:11:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35625 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgANOLR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 09:11:17 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id ABF98CECDE;
        Tue, 14 Jan 2020 15:20:32 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v2 01/10] Bluetooth: Add definitions for CIS connections
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200111022216.30842-2-luiz.dentz@gmail.com>
Date:   Tue, 14 Jan 2020 15:11:14 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7751BE94-A3D3-4E84-83A3-76B850A6AC19@holtmann.org>
References: <20200111022216.30842-1-luiz.dentz@gmail.com>
 <20200111022216.30842-2-luiz.dentz@gmail.com>
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
> include/net/bluetooth/hci.h | 157 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 157 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 07b6ecedc6ce..ba603f35c054 100644
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
> +	__u16 acl_mtu;
> +	__u8  acl_max_pkt;
> +	__u16 iso_mtu;

these need to be __le16 instead of __u16.

> +	__u8  iso_max_pkt;
> +} __attribute__ ((packed));
> +
> +#define HCI_OP_LE_READ_ISO_TX_SYNC		0x2061
> +struct hci_cp_le_read_iso_tx_sync {
> +	__u16 handle;
> +} __attribute__ ((packed));
> +
> +struct hci_rp_le_read_iso_tx_sync {
> +	__u8  status;
> +	__u16 handle;
> +	__u16 seq;
> +	__u32 timestamp;
> +	__u8  offset[3];
> +} __attribute__ ((packed));
> +
> +#define HCI_OP_LE_SET_CIG_PARAMS		0x2062

Is it CIG or CIS?

> +struct hci_cis_params {
> +	__u8  cis_id;
> +	__u16 m_sdu;
> +	__u16 s_sdu;
> +	__u8  m_phy;
> +	__u8  s_phy;
> +	__u8  m_rtn;
> +	__u8  s_rtn;
> +} __packed;
> +
> +struct hci_cp_le_set_cig_params {
> +	__u8  cig_id;
> +	__u8  m_interval[3];
> +	__u8  s_interval[3];
> +	__u8  sca;
> +	__u8  packing;
> +	__u8  framing;
> +	__u16 m_latency;
> +	__u16 s_latency;
> +	__u8  num_cis;
> +	struct hci_cis_params cis[0];
> +} __packed;
> +
> +struct hci_rp_le_set_cig_params {
> +	__u8  status;
> +	__u8  cig_id;
> +	__u8  num_handles;
> +	__u16 handle[0];
> +} __packed;
> +
> +#define HCI_OP_LE_CREATE_CIS			0x2064
> +struct hci_cis {
> +	__u16  cis_handle;
> +	__u16  acl_handle;
> +} __packed;
> +
> +struct hci_cp_le_create_cis {
> +	__u8  num_cis;
> +	struct hci_cis cis[0];
> +} __packed;
> +
> +#define HCI_OP_LE_REMOVE_CIG			0x2065
> +struct hci_cp_le_remove_cig {
> +	__u8  cig_id;
> +} __packed;
> +
> +#define HCI_OP_LE_ACCEPT_CIS			0x2066
> +struct hci_cp_le_accept_cis {
> +	__u16 handle;
> +} __packed;
> +
> +#define HCI_OP_LE_REJECT_CIS			0x2067
> +struct hci_cp_le_reject_cis {
> +	__u16 handle;
> +	__u8  reason;
> +} __packed;
> +
> /* ---- HCI Events ---- */
> #define HCI_EV_INQUIRY_COMPLETE		0x01
> 
> @@ -2234,6 +2328,34 @@ struct hci_evt_le_ext_adv_set_term {
> 	__u8	num_evts;
> } __packed;
> 
> +#define HCI_EVT_LE_CIS_ESTABLISHED	0x19
> +struct hci_evt_le_cis_established {
> +	__u8  status;
> +	__u16 handle;
> +	__u8  cig_sync_delay[3];
> +	__u8  cis_sync_delay[3];
> +	__u8  m_latency[3];
> +	__u8  s_latency[3];
> +	__u8  m_phy;
> +	__u8  s_phy;
> +	__u8  nse;
> +	__u8  m_bn;
> +	__u8  s_bn;
> +	__u8  m_ft;
> +	__u8  s_ft;
> +	__u16 m_mtu;
> +	__u16 s_mtu;
> +	__u16 interval;
> +} __packed;
> +
> +#define HCI_EVT_LE_CIS_REQ		0x1a

We use _REQUEST actually in HCI commands.

> +struct hci_evt_le_cis_req {
> +	__u16 acl_handle;
> +	__u16 cis_handle;
> +	__u8  cig_id;
> +	__u8  cis_id;
> +} __packed;
> +
> #define HCI_EV_VENDOR			0xff
> 
> /* Internal events generated by Bluetooth stack */
> @@ -2262,6 +2384,7 @@ struct hci_ev_si_security {
> #define HCI_EVENT_HDR_SIZE   2
> #define HCI_ACL_HDR_SIZE     4
> #define HCI_SCO_HDR_SIZE     3
> +#define HCI_ISO_HDR_SIZE     4
> 
> struct hci_command_hdr {
> 	__le16	opcode;		/* OCF & OGF */
> @@ -2283,6 +2406,30 @@ struct hci_sco_hdr {
> 	__u8	dlen;
> } __packed;
> 
> +struct hci_iso_hdr {
> +	__le16	handle;
> +	__le16	dlen;
> +	__u8	data[0];
> +} __packed;
> +
> +/* ISO data packet status flags */
> +#define HCI_ISO_STATUS_VALID	0x00
> +#define HCI_ISO_STATUS_INVALID	0x01
> +#define HCI_ISO_STATUS_NOP	0x02
> +
> +#define HCI_ISO_DATA_HDR_SIZE	4
> +struct hci_iso_data_hdr {
> +	__le16	sn;
> +	__le16	slen;
> +};
> +
> +#define HCI_ISO_TS_DATA_HDR_SIZE 8
> +struct hci_iso_ts_data_hdr {
> +	__le32	ts;
> +	__le16	sn;
> +	__le16	slen;
> +};
> +
> static inline struct hci_event_hdr *hci_event_hdr(const struct sk_buff *skb)
> {
> 	return (struct hci_event_hdr *) skb->data;
> @@ -2308,4 +2455,14 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
> #define hci_handle(h)		(h & 0x0fff)
> #define hci_flags(h)		(h >> 12)
> 
> +/* ISO handle and flags pack/unpack */
> +#define hci_iso_flags_pb(f)		(f & 0x0003)
> +#define hci_iso_flags_ts(f)		((f >> 2) & 0x0001)
> +#define hci_iso_flags_pack(pb, ts)	((pb & 0x03) | ((ts & 0x01) << 2))
> +
> +/* ISO data length and flags pack/unpack */
> +#define hci_iso_data_len_pack(h, f)	((__u16) ((h) | ((f) << 14)))
> +#define hci_iso_data_len(h)		((h) & 0x3fff)
> +#define hci_iso_data_flags(h)		((h) >> 14)

Regards

Marcel

