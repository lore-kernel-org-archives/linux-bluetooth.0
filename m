Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1307995091-4941-2-git-send-email-padovan@profusion.mobi>
References: <1307995091-4941-1-git-send-email-padovan@profusion.mobi>
	<1307995091-4941-2-git-send-email-padovan@profusion.mobi>
Date: Mon, 13 Jun 2011 20:33:19 -0400
Message-ID: <BANLkTimS7rZVD4ZQ2DpL=NsrCxpL-6imWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Use bit operations on conn_state
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Jun 13, 2011 at 3:58 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> @@ -3637,33 +3628,31 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
>        l2cap_drop_acked_frames(chan);
>
>        if (rx_control & L2CAP_CTRL_POLL) {
> -               chan->conn_state |= L2CAP_CONN_SEND_FBIT;
> -               if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
> -                       if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
> +               set_bit(CONN_SEND_FBIT, &chan->conn_state);
> +               if (test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
> +                       if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state) &&
>                                        (chan->unacked_frames > 0))
>                                __set_retrans_timer(chan);
>
> -                       chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
> +                       clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
>                        l2cap_send_srejtail(chan);
>                } else {
>                        l2cap_send_i_or_rr_or_rnr(chan);
>                }
>
>        } else if (rx_control & L2CAP_CTRL_FINAL) {
> -               chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
> +               clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
>
> -               if (chan->conn_state & L2CAP_CONN_REJ_ACT)
> -                       chan->conn_state &= ~L2CAP_CONN_REJ_ACT;
> -               else
> +               if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
>                        l2cap_retransmit_frames(chan);
>
>        } else {
> -               if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
> +               if ((test_bit(CONN_REMOTE_BUSY, &chan->conn_state)) &&

Unnecessary extra parenthesis.

>                                (chan->unacked_frames > 0))
>                        __set_retrans_timer(chan);
>
> -               chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
> -               if (chan->conn_state & L2CAP_CONN_SREJ_SENT)
> +               clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
> +               if (test_bit(CONN_SREJ_SENT, &chan->conn_state))
>                        l2cap_send_ack(chan);
>                else
>                        l2cap_ertm_send(chan);
> @@ -3676,21 +3665,19 @@ static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_c
>
>        BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
>
> -       chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
> +       clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
>
>        chan->expected_ack_seq = tx_seq;
>        l2cap_drop_acked_frames(chan);
>
>        if (rx_control & L2CAP_CTRL_FINAL) {
> -               if (chan->conn_state & L2CAP_CONN_REJ_ACT)
> -                       chan->conn_state &= ~L2CAP_CONN_REJ_ACT;
> -               else
> +               if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
>                        l2cap_retransmit_frames(chan);
>        } else {
>                l2cap_retransmit_frames(chan);
>
> -               if (chan->conn_state & L2CAP_CONN_WAIT_F)
> -                       chan->conn_state |= L2CAP_CONN_REJ_ACT;
> +               if (test_bit(CONN_WAIT_F, &chan->conn_state))
> +                       set_bit(CONN_REJ_ACT, &chan->conn_state);
>        }
>  }
>  static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_control)
> @@ -3699,32 +3686,32 @@ static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_
>
>        BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
>
> -       chan->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
> +       clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
>
>        if (rx_control & L2CAP_CTRL_POLL) {
>                chan->expected_ack_seq = tx_seq;
>                l2cap_drop_acked_frames(chan);
>
> -               chan->conn_state |= L2CAP_CONN_SEND_FBIT;
> +               set_bit(CONN_SEND_FBIT, &chan->conn_state);
>                l2cap_retransmit_one_frame(chan, tx_seq);
>
>                l2cap_ertm_send(chan);
>
> -               if (chan->conn_state & L2CAP_CONN_WAIT_F) {
> +               if (test_bit(CONN_WAIT_F, &chan->conn_state)) {
>                        chan->srej_save_reqseq = tx_seq;
> -                       chan->conn_state |= L2CAP_CONN_SREJ_ACT;
> +                       set_bit(CONN_SREJ_ACT, &chan->conn_state);
>                }
>        } else if (rx_control & L2CAP_CTRL_FINAL) {
> -               if ((chan->conn_state & L2CAP_CONN_SREJ_ACT) &&
> +               if ((test_bit(CONN_SREJ_ACT, &chan->conn_state)) &&

Unnecessary extra parenthesis.

>                                chan->srej_save_reqseq == tx_seq)
> -                       chan->conn_state &= ~L2CAP_CONN_SREJ_ACT;
> +                       clear_bit(CONN_SREJ_ACT, &chan->conn_state);
>                else
>                        l2cap_retransmit_one_frame(chan, tx_seq);
>        } else {
>                l2cap_retransmit_one_frame(chan, tx_seq);
> -               if (chan->conn_state & L2CAP_CONN_WAIT_F) {
> +               if (test_bit(CONN_WAIT_F, &chan->conn_state)) {
>                        chan->srej_save_reqseq = tx_seq;
> -                       chan->conn_state |= L2CAP_CONN_SREJ_ACT;
> +                       set_bit(CONN_SREJ_ACT, &chan->conn_state);
>                }
>        }
>  }
> @@ -3735,14 +3722,14 @@ static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_c
>
>        BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
>
> -       chan->conn_state |= L2CAP_CONN_REMOTE_BUSY;
> +       set_bit(CONN_REMOTE_BUSY, &chan->conn_state);
>        chan->expected_ack_seq = tx_seq;
>        l2cap_drop_acked_frames(chan);
>
>        if (rx_control & L2CAP_CTRL_POLL)
> -               chan->conn_state |= L2CAP_CONN_SEND_FBIT;
> +               set_bit(CONN_SEND_FBIT, &chan->conn_state);
>
> -       if (!(chan->conn_state & L2CAP_CONN_SREJ_SENT)) {
> +       if (!test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
>                __clear_retrans_timer(chan);
>                if (rx_control & L2CAP_CTRL_POLL)
>                        l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_FINAL);

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
