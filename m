Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314711625.2232.21.camel@THOR>
References: <1313764878-3091-1-git-send-email-dh.herrmann@googlemail.com>
	<1314711625.2232.21.camel@THOR>
Date: Tue, 30 Aug 2011 16:13:26 +0200
Message-ID: <CANq1E4RsmrwV8RbyhSURZim-XPE5WmPuOQPNWNuihoKMSoV7KQ@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: hidp: Check for valid ACL connection
From: David Herrmann <dh.herrmann@googlemail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>, "marcel@holtmann.org" <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter

On Tue, Aug 30, 2011 at 3:40 PM, Peter Hurley <peter@hurleysoftware.com> wr=
ote:
> Hi David,
>
> On Fri, 2011-08-19 at 10:41 -0400, David Herrmann wrote:
>> Also I think it would make the code nicer when calling hidp_get_device()=
 in
>> hidp_add_connection and hidp_setup_input/hid just retrieves the parent-d=
evice
>> from session->conn.
>
> What about something like this instead?
>
> This:
> 1. moves the hidp_get_device out into hidp_add_connection
> 2. renames hidp_get_device to hidp_find_connection
> 3. checks for null connection value return
> 4. performs the connection list access with device lock held
> 5. bumps the hci connection device hold with device lock held
>
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index e02c6a2..f6db935 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -97,8 +97,6 @@ static void __hidp_link_session(struct hidp_session *se=
ssion)
> =A0{
> =A0 =A0 =A0 =A0__module_get(THIS_MODULE);
> =A0 =A0 =A0 =A0list_add(&session->list, &hidp_session_list);
> -
> - =A0 =A0 =A0 hci_conn_hold_device(session->conn);
> =A0}
>
> =A0static void __hidp_unlink_session(struct hidp_session *session)
> @@ -763,24 +761,26 @@ static int hidp_session(void *arg)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static struct device *hidp_get_device(struct hidp_session *session)
> +static struct hci_conn *hidp_find_connection(struct hidp_session *sessio=
n)
> =A0{
> =A0 =A0 =A0 =A0bdaddr_t *src =3D &bt_sk(session->ctrl_sock->sk)->src;
> =A0 =A0 =A0 =A0bdaddr_t *dst =3D &bt_sk(session->ctrl_sock->sk)->dst;
> - =A0 =A0 =A0 struct device *device =3D NULL;
> + =A0 =A0 =A0 struct hci_conn *conn;
> =A0 =A0 =A0 =A0struct hci_dev *hdev;
>
> =A0 =A0 =A0 =A0hdev =3D hci_get_route(dst, src);
> =A0 =A0 =A0 =A0if (!hdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> - =A0 =A0 =A0 session->conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, d=
st);
> - =A0 =A0 =A0 if (session->conn)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 device =3D &session->conn->dev;
> + =A0 =A0 =A0 hci_dev_lock_bh(hdev);
> + =A0 =A0 =A0 conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
> + =A0 =A0 =A0 if (conn)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_hold_device(conn);
> + =A0 =A0 =A0 hci_dev_unlock_bh(hdev);
>
> =A0 =A0 =A0 =A0hci_dev_put(hdev);
>
> - =A0 =A0 =A0 return device;
> + =A0 =A0 =A0 return conn;
> =A0}
>
> =A0static int hidp_setup_input(struct hidp_session *session,
> @@ -830,7 +830,7 @@ static int hidp_setup_input(struct hidp_session *sess=
ion,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input->relbit[0] |=3D BIT_MASK(REL_WHEEL);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 input->dev.parent =3D hidp_get_device(session);
> + =A0 =A0 =A0 input->dev.parent =3D &session->conn->dev;
>
> =A0 =A0 =A0 =A0input->event =3D hidp_input_event;
>
> @@ -934,7 +934,7 @@ static int hidp_setup_hid(struct hidp_session *sessio=
n,
> =A0 =A0 =A0 =A0strncpy(hid->phys, batostr(&bt_sk(session->ctrl_sock->sk)-=
>src), 64);
> =A0 =A0 =A0 =A0strncpy(hid->uniq, batostr(&bt_sk(session->ctrl_sock->sk)-=
>dst), 64);
>
> - =A0 =A0 =A0 hid->dev.parent =3D hidp_get_device(session);
> + =A0 =A0 =A0 hid->dev.parent =3D &session->conn->dev;
> =A0 =A0 =A0 =A0hid->ll_driver =3D &hidp_hid_driver;
>
> =A0 =A0 =A0 =A0hid->hid_get_raw_report =3D hidp_get_raw_report;
> @@ -975,6 +975,10 @@ int hidp_add_connection(struct hidp_connadd_req *req=
, struct socket *ctrl_sock,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto failed;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 session->conn =3D hidp_find_connection(session);
> + =A0 =A0 =A0 if (!session->conn)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed;
> +
> =A0 =A0 =A0 =A0bacpy(&session->bdaddr, &bt_sk(ctrl_sock->sk)->dst);
>
> =A0 =A0 =A0 =A0session->ctrl_mtu =3D min_t(uint, l2cap_pi(ctrl_sock->sk)-=
>chan->omtu,
> @@ -1000,6 +1004,8 @@ int hidp_add_connection(struct hidp_connadd_req *re=
q, struct socket *ctrl_sock,
> =A0 =A0 =A0 =A0session->flags =A0 =3D req->flags & (1 << HIDP_BLUETOOTH_V=
ENDOR_ID);
> =A0 =A0 =A0 =A0session->idle_to =3D req->idle_to;
>
> + =A0 =A0 =A0 __hidp_link_session(session);
> +
> =A0 =A0 =A0 =A0if (req->rd_size > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D hidp_setup_hid(session, req);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err && err !=3D -ENODEV)
> @@ -1012,8 +1018,6 @@ int hidp_add_connection(struct hidp_connadd_req *re=
q, struct socket *ctrl_sock,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto purge;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 __hidp_link_session(session);
> -
> =A0 =A0 =A0 =A0hidp_set_timer(session);
>
> =A0 =A0 =A0 =A0if (session->hid) {
> @@ -1062,8 +1066,6 @@ int hidp_add_connection(struct hidp_connadd_req *re=
q, struct socket *ctrl_sock,
> =A0unlink:
> =A0 =A0 =A0 =A0hidp_del_timer(session);
>
> - =A0 =A0 =A0 __hidp_unlink_session(session);
> -
> =A0 =A0 =A0 =A0if (session->input) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_unregister_device(session->input);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0session->input =3D NULL;
> @@ -1076,6 +1078,8 @@ unlink:
> =A0 =A0 =A0 =A0session->rd_data =3D NULL;
>
> =A0purge:
> + =A0 =A0 =A0 __hidp_unlink_session(session);
> +
> =A0 =A0 =A0 =A0skb_queue_purge(&session->ctrl_transmit);
> =A0 =A0 =A0 =A0skb_queue_purge(&session->intr_transmit);
>
> --

Great! This fixes the race-condition I mentioned earlier,
error-recovery also seems fine here. Thanks!
After Marcel or Gustavo commented on that, can you resend it with a
proper commit-message? Or should I resend it?
I am fine with you doing that, here's my signed-off line anyway:

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>

> Regards,
> Peter Hurley

Regards
David
