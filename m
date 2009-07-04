Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <1246693308-26084-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1246693308-26084-1-git-send-email-gustavo@las.ic.unicamp.br>
Date: Sat, 4 Jul 2009 05:28:53 -0300
Message-ID: <6b53b1990907040128t72f820d4v8c86dc9cdf81d9fb@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: add support to configure ERTM and Streaming
	mode
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jul 4, 2009 at 4:41 AM, Gustavo F.
Padovan<gustavo@las.ic.unicamp.br> wrote:
> Add code to config_req and config_rsp to configure ERTM and Streaming
> mode. If the remote devices specifies ERTM or Streaming Mode, we propose
> the same mode received. Otherwise we propose ERTM or Basic Mode.
> And if we are a state 2 device the remote should propose the same mode
> that we sent, if not, the channel is disconnected.
>
> Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
> ---
> =A0include/net/bluetooth/l2cap.h | =A0 28 +++-
> =A0net/bluetooth/l2cap.c =A0 =A0 =A0 =A0 | =A0284 +++++++++++++++++++++++=
++++++++++++------
> =A02 files changed, 268 insertions(+), 44 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 06b072f..6fc7698 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -27,8 +27,9 @@
>
> =A0/* L2CAP defaults */
> =A0#define L2CAP_DEFAULT_MTU =A0 =A0 =A0 =A0 =A0 =A0 =A0672
> +#define L2CAP_DEFAULT_MIN_MTU =A0 =A0 =A0 =A0 =A048
> =A0#define L2CAP_DEFAULT_FLUSH_TO =A0 =A0 =A0 =A0 0xffff
> -#define L2CAP_DEFAULT_RX_WINDOW =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> +#define L2CAP_DEFAULT_TX_WINDOW =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> =A0#define L2CAP_DEFAULT_MAX_RECEIVE =A0 =A0 =A01
> =A0#define L2CAP_DEFAULT_RETRANS_TO =A0 =A0 =A0 300 =A0 =A0/* 300 millise=
conds */
> =A0#define L2CAP_DEFAULT_MONITOR_TO =A0 =A0 =A0 1000 =A0 /* 1 second */
> @@ -272,6 +273,9 @@ struct l2cap_pinfo {
> =A0 =A0 =A0 =A0__u16 =A0 =A0 =A0 =A0 =A0 omtu;
> =A0 =A0 =A0 =A0__u16 =A0 =A0 =A0 =A0 =A0 flush_to;
> =A0 =A0 =A0 =A0__u8 =A0 =A0 =A0 =A0 =A0 =A0mode;
> + =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0num_conf_req;
> + =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0num_conf_rsp;
> +
> =A0 =A0 =A0 =A0__u8 =A0 =A0 =A0 =A0 =A0 =A0fcs;
> =A0 =A0 =A0 =A0__u8 =A0 =A0 =A0 =A0 =A0 =A0sec_level;
> =A0 =A0 =A0 =A0__u8 =A0 =A0 =A0 =A0 =A0 =A0role_switch;
> @@ -280,10 +284,15 @@ struct l2cap_pinfo {
> =A0 =A0 =A0 =A0__u8 =A0 =A0 =A0 =A0 =A0 =A0conf_req[64];
> =A0 =A0 =A0 =A0__u8 =A0 =A0 =A0 =A0 =A0 =A0conf_len;
> =A0 =A0 =A0 =A0__u8 =A0 =A0 =A0 =A0 =A0 =A0conf_state;
> - =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0conf_retry;
>
> =A0 =A0 =A0 =A0__u8 =A0 =A0 =A0 =A0 =A0 =A0ident;
>
> + =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0remote_tx_win;
> + =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0remote_max_tx;
> + =A0 =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 retrans_timeout;
> + =A0 =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 monitor_timeout;
> + =A0 =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 max_pdu_size;
> +
> =A0 =A0 =A0 =A0__le16 =A0 =A0 =A0 =A0 =A0sport;
>
> =A0 =A0 =A0 =A0struct l2cap_conn =A0 =A0 =A0 *conn;
> @@ -291,12 +300,17 @@ struct l2cap_pinfo {
> =A0 =A0 =A0 =A0struct sock =A0 =A0 =A0 =A0 =A0 =A0 *prev_c;
> =A0};
>
> -#define L2CAP_CONF_REQ_SENT =A0 =A00x01
> -#define L2CAP_CONF_INPUT_DONE =A00x02
> -#define L2CAP_CONF_OUTPUT_DONE 0x04
> -#define L2CAP_CONF_CONNECT_PEND =A0 =A0 =A0 =A00x80
> +#define L2CAP_CONF_REQ_SENT =A0 =A0 =A0 0x01
> +#define L2CAP_CONF_INPUT_DONE =A0 =A0 0x02
> +#define L2CAP_CONF_OUTPUT_DONE =A0 =A00x04
> +#define L2CAP_CONF_MTU_DONE =A0 =A0 =A0 0x08
> +#define L2CAP_CONF_MODE_DONE =A0 =A0 =A00x10
> +#define L2CAP_CONF_CONNECT_PEND =A0 0x20
> +#define L2CAP_CONF_STATE2_DEVICE =A00x80
> +
> +#define L2CAP_CONF_MAX_CONF_REQ 2
> +#define L2CAP_CONF_MAX_CONF_RSP 2
>
> -#define L2CAP_CONF_MAX_RETRIES 2
>
> =A0void l2cap_load(void);
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 7ce1a24..a78277a 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -966,6 +966,7 @@ static int l2cap_sock_connect(struct socket *sock, st=
ruct sockaddr *addr, int al
> =A0 =A0 =A0 =A0case L2CAP_MODE_BASIC:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case L2CAP_MODE_ERTM:
> + =A0 =A0 =A0 case L2CAP_MODE_STREAMING:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (enable_ertm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
> @@ -1029,6 +1030,7 @@ static int l2cap_sock_listen(struct socket *sock, i=
nt backlog)
> =A0 =A0 =A0 =A0case L2CAP_MODE_BASIC:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case L2CAP_MODE_ERTM:
> + =A0 =A0 =A0 case L2CAP_MODE_STREAMING:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (enable_ertm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
> @@ -1739,15 +1741,65 @@ static void l2cap_add_conf_opt(void **ptr, u8 typ=
e, u8 len, unsigned long val)
> =A0 =A0 =A0 =A0*ptr +=3D L2CAP_CONF_OPT_SIZE + len;
> =A0}
>
> -static int l2cap_build_conf_req(struct sock *sk, void *data)
> +static int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
> +{
> + =A0 =A0 =A0 u32 local_feat_mask =3D l2cap_feat_mask;
> + =A0 =A0 =A0 if (enable_ertm)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_feat_mask |=3D L2CAP_FEAT_ERTM;
> +
> + =A0 =A0 =A0 switch (mode) {
> + =A0 =A0 =A0 case L2CAP_MODE_ERTM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return L2CAP_FEAT_ERTM & feat_mask & local_=
feat_mask;
> + =A0 =A0 =A0 case L2CAP_MODE_STREAMING:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return L2CAP_FEAT_STREAMING & feat_mask & l=
ocal_feat_mask;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0x00;
> + =A0 =A0 =A0 }
> +}
> +
> +static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
> +{
> + =A0 =A0 =A0 switch (mode) {
> + =A0 =A0 =A0 case L2CAP_MODE_STREAMING:
> + =A0 =A0 =A0 case L2CAP_MODE_ERTM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (l2cap_mode_supported(mode, remote_feat_=
mask))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mode;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fall through */
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return L2CAP_MODE_BASIC;
> + =A0 =A0 =A0 }
> +}
> +
> +static int l2cap_build_conf_req(struct sock *sk, struct l2cap_conn *conn=
, void *data)
> =A0{
> =A0 =A0 =A0 =A0struct l2cap_pinfo *pi =3D l2cap_pi(sk);
> =A0 =A0 =A0 =A0struct l2cap_conf_req *req =3D data;
> - =A0 =A0 =A0 struct l2cap_conf_rfc rfc =3D { .mode =3D L2CAP_MODE_BASIC =
};
> + =A0 =A0 =A0 struct l2cap_conf_rfc rfc =3D { .mode =3D L2CAP_MODE_ERTM }=
;
> =A0 =A0 =A0 =A0void *ptr =3D req->data;
>
> =A0 =A0 =A0 =A0BT_DBG("sk %p", sk);
>
> + =A0 =A0 =A0 if (pi->num_conf_req || pi->num_conf_rsp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> +
> + =A0 =A0 =A0 switch (pi->mode) {
> + =A0 =A0 =A0 case L2CAP_MODE_STREAMING:
> + =A0 =A0 =A0 case L2CAP_MODE_ERTM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->conf_state |=3D L2CAP_CONF_STATE2_DEVIC=
E;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!l2cap_mode_supported(pi->mode, conn->f=
eat_mask)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct l2cap_disconn_req re=
q;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req.dcid =3D cpu_to_le16(pi=
->dcid);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req.scid =3D cpu_to_le16(pi=
->scid);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_send_cmd(conn, l2cap_=
get_ident(conn),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 L2CAP_DISCO=
NN_REQ, sizeof(req), &req);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->mode =3D l2cap_select_mode(rfc.mode, co=
nn->feat_mask);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> +done:
> =A0 =A0 =A0 =A0switch (pi->mode) {
> =A0 =A0 =A0 =A0case L2CAP_MODE_BASIC:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pi->imtu !=3D L2CAP_DEFAULT_MTU)
> @@ -1756,14 +1808,26 @@ static int l2cap_build_conf_req(struct sock *sk, =
void *data)
>
> =A0 =A0 =A0 =A0case L2CAP_MODE_ERTM:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rfc.mode =A0 =A0 =A0 =A0 =A0 =A0=3D L2CAP_=
MODE_ERTM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.txwin_size =A0 =A0 =A0=3D L2CAP_DEFAULT=
_RX_WINDOW;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.txwin_size =A0 =A0 =A0=3D L2CAP_DEFAULT=
_TX_WINDOW;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rfc.max_transmit =A0 =A0=3D L2CAP_DEFAULT_=
MAX_RECEIVE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.retrans_timeout =3D cpu_to_le16(L2CAP_D=
EFAULT_RETRANS_TO);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.monitor_timeout =3D cpu_to_le16(L2CAP_D=
EFAULT_MONITOR_TO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.retrans_timeout =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.monitor_timeout =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rfc.max_pdu_size =A0 =A0=3D cpu_to_le16(L2=
CAP_DEFAULT_MAX_RX_APDU);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 sizeof(rfc), (unsigned long) &rfc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, si=
zeof(rfc),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned l=
ong) &rfc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case L2CAP_MODE_STREAMING:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.mode =A0 =A0 =A0 =A0 =A0 =A0=3D L2CAP_M=
ODE_STREAMING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.txwin_size =A0 =A0 =A0=3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.max_transmit =A0 =A0=3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.retrans_timeout =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.monitor_timeout =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.max_pdu_size =A0 =A0=3D cpu_to_le16(L2C=
AP_DEFAULT_MAX_RX_APDU);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, si=
zeof(rfc),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned l=
ong) &rfc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> @@ -1777,7 +1841,7 @@ static int l2cap_build_conf_req(struct sock *sk, vo=
id *data)
> =A0 =A0 =A0 =A0return ptr - data;
> =A0}
>
> -static int l2cap_parse_conf_req(struct sock *sk, void *data)
> +static int l2cap_parse_conf_req(struct sock *sk, struct l2cap_conn *conn=
, void *data, int *disconnect)


I noted that l2cap_parse_conf_req and l2cap_parse_conf_rsp never
return negative values ( ptr - data is always positive), so I think we
can add a return -Eerror(ECONNREFUSED?) to raise disconnect request.
That way we don't need the extra parameter disconnect.


> =A0{
> =A0 =A0 =A0 =A0struct l2cap_pinfo *pi =3D l2cap_pi(sk);
> =A0 =A0 =A0 =A0struct l2cap_conf_rsp *rsp =3D data;
> @@ -1825,30 +1889,83 @@ static int l2cap_parse_conf_req(struct sock *sk, =
void *data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (pi->num_conf_rsp || pi->num_conf_req)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> +
> + =A0 =A0 =A0 switch (pi->mode) {
> + =A0 =A0 =A0 case L2CAP_MODE_STREAMING:
> + =A0 =A0 =A0 case L2CAP_MODE_ERTM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->conf_state |=3D L2CAP_CONF_STATE2_DEVIC=
E;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!l2cap_mode_supported(pi->mode, conn->f=
eat_mask))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *disconnect =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->mode =3D l2cap_select_mode(rfc.mode, co=
nn->feat_mask);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> +done:
> + =A0 =A0 =A0 if (pi->mode !=3D rfc.mode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D L2CAP_CONF_UNACCEPT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.mode =3D pi->mode;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pi->num_conf_rsp =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *disconnect =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2=
CAP_CONF_RFC,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(rfc)=
, (unsigned long) &rfc);
> + =A0 =A0 =A0 }
> +
> +
> =A0 =A0 =A0 =A0if (result =3D=3D L2CAP_CONF_SUCCESS) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Configure output options and let the ot=
her side know
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * which ones we don't like. */
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rfc.mode =3D=3D L2CAP_MODE_BASIC) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mtu < pi->omtu)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D =
L2CAP_CONF_UNACCEPT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->omtu =
=3D mtu;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->conf_st=
ate |=3D L2CAP_CONF_OUTPUT_DONE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mtu < L2CAP_DEFAULT_MIN_MTU)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D L2CAP_CONF_UNACC=
EPT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->omtu =3D mtu;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->conf_state |=3D L2CAP_C=
ONF_MTU_DONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2,=
 pi->omtu);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2=
CAP_CONF_MTU, 2, pi->omtu);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (rfc.mode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case L2CAP_MODE_BASIC:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->fcs =3D L2CAP_FCS_NONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->conf_state |=3D L2CAP_C=
ONF_MODE_DONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case L2CAP_MODE_ERTM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->remote_tx_win =3D rfc.t=
xwin_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->remote_max_tx =3D rfc.m=
ax_transmit;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->max_pdu_size =3D rfc.ma=
x_pdu_size;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.retrans_timeout =3D L2C=
AP_DEFAULT_RETRANS_TO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.monitor_timeout =3D L2C=
AP_DEFAULT_MONITOR_TO;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->conf_state |=3D L2CAP_C=
ONF_MODE_DONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case L2CAP_MODE_STREAMING:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->remote_tx_win =3D rfc.t=
xwin_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->max_pdu_size =3D rfc.ma=
x_pdu_size;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->conf_state |=3D L2CAP_C=
ONF_MODE_DONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D L2CAP_CONF_UNAC=
CEPT;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(&rfc, 0, sizeof(rfc=
));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.mode =3D L2CAP_MODE_BAS=
IC;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2=
CAP_CONF_RFC,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 sizeof(rfc), (unsigned long) &rfc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.mode =3D pi->mode;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 }
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(rfc)=
, (unsigned long) &rfc);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result =3D=3D L2CAP_CONF_SUCCESS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->conf_state |=3D L2CAP_C=
ONF_OUTPUT_DONE;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0rsp->scid =A0 =3D cpu_to_le16(pi->dcid);
> =A0 =A0 =A0 =A0rsp->result =3D cpu_to_le16(result);
> =A0 =A0 =A0 =A0rsp->flags =A0=3D cpu_to_le16(0x0000);
> @@ -1856,6 +1973,73 @@ static int l2cap_parse_conf_req(struct sock *sk, v=
oid *data)
> =A0 =A0 =A0 =A0return ptr - data;
> =A0}
>
> +static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, voi=
d *data, u16 *result, int *disconnect)
> +{
> + =A0 =A0 =A0 struct l2cap_pinfo *pi =3D l2cap_pi(sk);
> + =A0 =A0 =A0 struct l2cap_conf_req *req =3D data;
> + =A0 =A0 =A0 void *ptr =3D req->data;
> + =A0 =A0 =A0 int type, olen;
> + =A0 =A0 =A0 unsigned long val;
> + =A0 =A0 =A0 struct l2cap_conf_rfc rfc;
> +
> + =A0 =A0 =A0 BT_DBG("sk %p, rsp %p, len %d, req %p", sk, rsp, len, data)=
;
> +
> + =A0 =A0 =A0 while (len >=3D L2CAP_CONF_OPT_SIZE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D l2cap_get_conf_opt(&rsp, &type, &o=
len, &val);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (type) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case L2CAP_CONF_MTU:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val < L2CAP_DEFAULT_MIN=
_MTU) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *result =3D=
 L2CAP_CONF_UNACCEPT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->omtu =
=3D L2CAP_DEFAULT_MIN_MTU;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->omtu =
=3D val;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2=
CAP_CONF_MTU, 2, pi->omtu);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case L2CAP_CONF_FLUSH_TO:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->flush_to =3D val;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2=
CAP_CONF_FLUSH_TO, 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 pi->flush_to);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case L2CAP_CONF_RFC:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (olen =3D=3D sizeof(rfc)=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&rfc=
, (void *)val, olen);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rfc.mode !=3D pi->mode =
&&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pi->conf_s=
tate & L2CAP_CONF_STATE2_DEVICE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *disconnect=
 =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->mode =3D rfc.mode;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->fcs =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2=
CAP_CONF_RFC,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(rfc)=
, (unsigned long) &rfc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (*result =3D=3D L2CAP_CONF_SUCCESS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (rfc.mode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case L2CAP_MODE_ERTM:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->remote_tx_win =A0 =3D r=
fc.txwin_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->retrans_timeout =3D rfc=
.retrans_timeout;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->monitor_timeout =3D rfc=
.monitor_timeout;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->max_pdu_size =A0 =A0=3D=
 le16_to_cpu(rfc.max_pdu_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case L2CAP_MODE_STREAMING:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi->max_pdu_size =A0 =A0=3D=
 le16_to_cpu(rfc.max_pdu_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 req->dcid =A0 =3D cpu_to_le16(pi->dcid);
> + =A0 =A0 =A0 req->flags =A0=3D cpu_to_le16(0x0000);
> +
> + =A0 =A0 =A0 return ptr - data;
> +}
> +
> =A0static int l2cap_build_conf_rsp(struct sock *sk, void *data, u16 resul=
t, u16 flags)
> =A0{
> =A0 =A0 =A0 =A0struct l2cap_conf_rsp *rsp =3D data;
> @@ -2041,7 +2225,8 @@ static inline int l2cap_connect_rsp(struct l2cap_co=
nn *conn, struct l2cap_cmd_hd
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_pi(sk)->conf_state &=3D ~L2CAP_CONF_=
CONNECT_PEND;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_send_cmd(conn, l2cap_get_ident(conn)=
, L2CAP_CONF_REQ,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 l2cap_build_conf_req(sk, req), req);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 l2cap_build_conf_req(sk, conn, req), req);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->num_conf_req++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case L2CAP_CR_PEND:
> @@ -2063,7 +2248,7 @@ static inline int l2cap_config_req(struct l2cap_con=
n *conn, struct l2cap_cmd_hdr
> =A0 =A0 =A0 =A0u16 dcid, flags;
> =A0 =A0 =A0 =A0u8 rsp[64];
> =A0 =A0 =A0 =A0struct sock *sk;
> - =A0 =A0 =A0 int len;
> + =A0 =A0 =A0 int len, disconn =3D 0;
>
> =A0 =A0 =A0 =A0dcid =A0=3D __le16_to_cpu(req->dcid);
> =A0 =A0 =A0 =A0flags =3D __le16_to_cpu(req->flags);
> @@ -2099,11 +2284,21 @@ static inline int l2cap_config_req(struct l2cap_c=
onn *conn, struct l2cap_cmd_hdr
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Complete config. */
> - =A0 =A0 =A0 len =3D l2cap_parse_conf_req(sk, rsp);
> + =A0 =A0 =A0 len =3D l2cap_parse_conf_req(sk, conn, rsp, &disconn);
> =A0 =A0 =A0 =A0if (len < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unlock;
>
> - =A0 =A0 =A0 l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP, len, rsp);
> + =A0 =A0 =A0 if (disconn) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct l2cap_disconn_req req;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req.dcid =3D cpu_to_le16(l2cap_pi(sk)->dcid=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req.scid =3D cpu_to_le16(l2cap_pi(sk)->scid=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_send_cmd(conn, l2cap_get_ident(conn),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 L2CAP_DISCO=
NN_REQ, sizeof(req), &req);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF=
_RSP, len, rsp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->num_conf_rsp++;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Reset config buffer. */
> =A0 =A0 =A0 =A0l2cap_pi(sk)->conf_len =3D 0;
> @@ -2120,7 +2315,8 @@ static inline int l2cap_config_req(struct l2cap_con=
n *conn, struct l2cap_cmd_hdr
> =A0 =A0 =A0 =A0if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u8 buf[64];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l2cap_send_cmd(conn, l2cap_get_ident(conn)=
, L2CAP_CONF_REQ,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 l2cap_build_conf_req(sk, buf), buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 l2cap_build_conf_req(sk, conn, buf), buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->num_conf_req++;
> =A0 =A0 =A0 =A0}
>
> =A0unlock:
> @@ -2133,6 +2329,7 @@ static inline int l2cap_config_rsp(struct l2cap_con=
n *conn, struct l2cap_cmd_hdr
> =A0 =A0 =A0 =A0struct l2cap_conf_rsp *rsp =3D (struct l2cap_conf_rsp *)da=
ta;
> =A0 =A0 =A0 =A0u16 scid, flags, result;
> =A0 =A0 =A0 =A0struct sock *sk;
> + =A0 =A0 =A0 int disconn =3D 0;
>
> =A0 =A0 =A0 =A0scid =A0 =3D __le16_to_cpu(rsp->scid);
> =A0 =A0 =A0 =A0flags =A0=3D __le16_to_cpu(rsp->flags);
> @@ -2150,16 +2347,29 @@ static inline int l2cap_config_rsp(struct l2cap_c=
onn *conn, struct l2cap_cmd_hdr
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case L2CAP_CONF_UNACCEPT:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (++l2cap_pi(sk)->conf_retry < L2CAP_CONF=
_MAX_RETRIES) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char req[128];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* It does not make sense t=
o adjust L2CAP parameters
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* that are currently def=
ined in the spec. We simply
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* resend config request =
that we sent earlier. It is
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* stupid, but it helps q=
ualification testing which
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* expects at least some =
response from us. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_send_cmd(conn, l2cap_=
get_ident(conn), L2CAP_CONF_REQ,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 l2cap_build_conf_req(sk, req), req);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (l2cap_pi(sk)->num_conf_rsp <=3D L2CAP_C=
ONF_MAX_CONF_RSP) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int len =3D cmd->len - size=
of(*rsp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char req[64];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* throw out any old conf r=
equests we stored */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D L2CAP_CONF_SUCCE=
SS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D l2cap_parse_conf_rs=
p(sk, rsp->data, len, req,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &result, &disconn);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (disconn) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct l2ca=
p_disconn_req req;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req.dcid =
=3D cpu_to_le16(l2cap_pi(sk)->dcid);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req.scid =
=3D cpu_to_le16(l2cap_pi(sk)->scid);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_send_=
cmd(conn, l2cap_get_ident(conn),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 L2CAP_DISCONN_REQ, sizeof(req), &req);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_send_cmd(conn, l2cap_=
get_ident(conn),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 L2CAP_CONF_REQ, len, req);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->num_conf_req+=
+;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result !=3D L2CAP_CONF_=
SUCCESS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0default:
> --
> 1.6.0.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Gustavo F. Padovan
http://padovan.org
