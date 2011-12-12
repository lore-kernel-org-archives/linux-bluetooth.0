Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Dec 2011 10:17:54 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Hemant Gupta <hemantgupta.ste@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] Bluetooth: Add structures for the new LTK exchange
 messages
Message-ID: <20111212131754.GB14194@samus>
References: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
 <1323218892-15785-2-git-send-email-vinicius.gomes@openbossa.org>
 <CACj007=upX95SED9XSqu=JU2CMig8TCBj5fAO1epe-m-T7xaeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CACj007=upX95SED9XSqu=JU2CMig8TCBj5fAO1epe-m-T7xaeA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 21:14 Wed 07 Dec, Hemant Gupta wrote:
> Hi Vinicius,
> 
> On Wed, Dec 7, 2011 at 6:18 AM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > This defines two in the kernel side of BlueZ two new messages, one
> > event that will inform userspace that a new Long Term Key was
> > exchanged and one that will allow userspace to load LTKs into
> > the kernel.
> 
> The commit message has some issue, rewording is required.

Could you please be more specific on what needs rewording, I will gladly
fix it.

> 
> > Acked-by: Marcel Holtmann <marcel@holtmann.org>
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  include/net/bluetooth/mgmt.h |   21 +++++++++++++++++++++
> >  1 files changed, 21 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> > index 3b68806..0f100fa9 100644
> > --- a/include/net/bluetooth/mgmt.h
> > +++ b/include/net/bluetooth/mgmt.h
> > @@ -264,6 +264,21 @@ struct mgmt_cp_user_passkey_neg_reply {
> >        bdaddr_t bdaddr;
> >  } __packed;
> >
> > +struct mgmt_ltk_info {
> > +       bdaddr_t bdaddr;
> > +       __u8 pin_len;
> > +       __u8 enc_size;
> > +       __le16 ediv;
> > +       __u8 rand[8];
> > +       __u8 val[16];
> > +} __packed;
> > +
> > +#define MGMT_OP_LOAD_LONG_TERM_KEYS    0x0023
> > +struct mgmt_cp_load_long_term_keys {
> > +       __u16 key_count;
> > +       struct mgmt_ltk_info keys[0];
> > +} __packed;
> > +
> >  #define MGMT_EV_CMD_COMPLETE           0x0001
> >  struct mgmt_ev_cmd_complete {
> >        __le16 opcode;
> > @@ -363,3 +378,9 @@ struct mgmt_ev_device_unblocked {
> >  struct mgmt_ev_user_passkey_request {
> >        bdaddr_t bdaddr;
> >  } __packed;
> > +
> > +#define MGMT_EV_NEW_LONG_TERM_KEY      0x0018
> > +struct mgmt_ev_new_long_term_key {
> > +       __u8 store_hint;
> > +       struct mgmt_ltk_info key;
> > +} __packed;
> > --
> > 1.7.8
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Best Regards
> Hemant Gupta
> ST-Ericsson India

Cheers,
-- 
Vinicius
