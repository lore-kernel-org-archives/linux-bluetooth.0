Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Dec 2011 10:07:51 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] Bluetooth: Add structures for the new LTK exchange
 messages
Message-ID: <20111212130750.GA14194@samus>
References: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
 <1323218892-15785-2-git-send-email-vinicius.gomes@openbossa.org>
 <4EDFA4C6.4030201@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EDFA4C6.4030201@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 09:39 Wed 07 Dec, Brian Gix wrote:
> Hi Vinicius,
> 
> On 12/6/2011 4:48 PM, Vinicius Costa Gomes wrote:
> >This defines two in the kernel side of BlueZ two new messages, one
> >event that will inform userspace that a new Long Term Key was
> >exchanged and one that will allow userspace to load LTKs into
> >the kernel.
> >
> >Acked-by: Marcel Holtmann<marcel@holtmann.org>
> >Signed-off-by: Vinicius Costa Gomes<vinicius.gomes@openbossa.org>
> >---
> >  include/net/bluetooth/mgmt.h |   21 +++++++++++++++++++++
> >  1 files changed, 21 insertions(+), 0 deletions(-)
> >
> >diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> >index 3b68806..0f100fa9 100644
> >--- a/include/net/bluetooth/mgmt.h
> >+++ b/include/net/bluetooth/mgmt.h
> >@@ -264,6 +264,21 @@ struct mgmt_cp_user_passkey_neg_reply {
> >  	bdaddr_t bdaddr;
> >  } __packed;
> >
> >+struct mgmt_ltk_info {
> >+	bdaddr_t bdaddr;
> >+	__u8 pin_len;
> >+	__u8 enc_size;
> >+	__le16 ediv;
> >+	__u8 rand[8];
> >+	__u8 val[16];
> >+} __packed;
> 
> I think we definitely want to store the auth level (octet) that was
> used to generate this key and/or the sec_level. Some profiles may
> require MITM (high sec_level) and from this key definition, there is
> no way to tell if it is Medium (no MITM) or High.
> 

Yeah, I was thinking about infering the security level using the pin_len
field, but that assumption breaks once we have OOB. I will add this
field.

> This then needs to be used L2CAP to map the sock options, and
> potentially trigger a re-bonding.  Not that it is likely to happen,
> since devices are suppose to pair with the Highest security level
> they have available, but there could be malicious devices which
> could gain access to "High" security services without performing
> MITM authentication.
> 
> Also, I will harp once again that anything with an LE bdaddr should
> include the Public vs Random flag because the two address types are
> *not* interchangeable.  I would like to see Johan's "mgmt_addr_info"
> structure used in place of the bdaddr_t here.

Sounds reasonable. Will change this.

> 
> 
> >+
> >+#define MGMT_OP_LOAD_LONG_TERM_KEYS	0x0023
> >+struct mgmt_cp_load_long_term_keys {
> >+	__u16 key_count;
> >+	struct mgmt_ltk_info keys[0];
> >+} __packed;
> >+
> >  #define MGMT_EV_CMD_COMPLETE		0x0001
> >  struct mgmt_ev_cmd_complete {
> >  	__le16 opcode;
> >@@ -363,3 +378,9 @@ struct mgmt_ev_device_unblocked {
> >  struct mgmt_ev_user_passkey_request {
> >  	bdaddr_t bdaddr;
> >  } __packed;
> >+
> >+#define MGMT_EV_NEW_LONG_TERM_KEY	0x0018
> >+struct mgmt_ev_new_long_term_key {
> >+	__u8 store_hint;
> >+	struct mgmt_ltk_info key;
> >+} __packed;
> 
> 
> -- 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

Cheers,
-- 
Vinicius
