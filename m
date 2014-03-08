Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 03/20] android/handsfree: Add support for unknown AT commands
Date: Sat, 08 Mar 2014 13:29:31 +0100
Message-ID: <2194376.c82FdKPhVv@leonov>
In-Reply-To: <E54E58F0-0743-4000-883C-981E0B692728@holtmann.org>
References: <1394238004-15691-1-git-send-email-szymon.janc@tieto.com> <1394238004-15691-4-git-send-email-szymon.janc@tieto.com> <E54E58F0-0743-4000-883C-981E0B692728@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Friday 07 of March 2014 19:37:00 Marcel Holtmann wrote:
> Hi Szymon,
>=20
> > Those commands are passed to Framework without parsing.
> > ---
> > android/handsfree.c | 64
> > ++++++++++++++++++++++++++++++++++++++++++++--------- 1 file change=
d, 54
> > insertions(+), 10 deletions(-)
> >=20
> > diff --git a/android/handsfree.c b/android/handsfree.c
> > index c49a35b..e104c4a 100644
> > --- a/android/handsfree.c
> > +++ b/android/handsfree.c
> > @@ -161,19 +161,35 @@ static void device_cleanup(void)
> >=20
> > =09memset(&device, 0, sizeof(device));
> >=20
> > }
> >=20
> > -static void at_command_handler(const char *command, void *user_dat=
a)
> > +static void disconnect_watch(void *user_data)
> > {
> > -=09hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
> > +=09DBG("");
> >=20
> > -=09if (device.state !=3D HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED=
)
> > -=09=09hfp_gw_disconnect(device.gw);
> > +=09device_cleanup();
> > }
> >=20
> > -static void disconnect_watch(void *user_data)
> > +static void at_cmd_unknown(const char *command, void *user_data)
> > {
> > -=09DBG("");
> > +=09uint8_t buf[IPC_MTU];
> > +=09struct hal_ev_handsfree_unknown_at *ev =3D (void *) buf;
> >=20
> > -=09device_cleanup();
> > +=09if (device.state !=3D HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED=
) {
> > +=09=09hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
> > +=09=09hfp_gw_disconnect(device.gw);
> > +=09=09return;
> > +=09}
> > +
> > +=09/* copy while string including terminating NULL */
> > +=09ev->len =3D strlen(command) + 1;
> > +=09memcpy(ev->buf, command, ev->len);
> > +
> > +=09if (ev->len > IPC_MTU - sizeof(*ev)) {
> > +=09=09hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
> > +=09=09return;
> > +=09}
> > +
> > +=09ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
> > +=09=09=09HAL_EV_HANDSFREE_UNKNOWN_AT, sizeof(*ev) + ev->len, ev);
> > }
> >=20
> > static void at_cmd_vgs_vgm(struct hfp_gw_result *result,
> > @@ -674,7 +690,7 @@ static void connect_cb(GIOChannel *chan, GError=
 *err,
> > gpointer user_data)>=20
> > =09g_io_channel_set_close_on_unref(chan, FALSE);
> > =09
> > =09hfp_gw_set_close_on_unref(device.gw, true);
> >=20
> > -=09hfp_gw_set_command_handler(device.gw, at_command_handler, NULL,=
 NULL);
> > +=09hfp_gw_set_command_handler(device.gw, at_cmd_unknown, NULL, NUL=
L);
> >=20
> > =09hfp_gw_set_disconnect_handler(device.gw, disconnect_watch, NULL,=
=20
NULL);
> >=20
> > @@ -1147,19 +1163,47 @@ static void handle_cind(const void *buf, ui=
nt16_t
> > len)
> >=20
> > static void handle_formatted_at_resp(const void *buf, uint16_t len)=

> > {
> > +=09const struct hal_cmd_handsfree_formatted_at_response *cmd =3D b=
uf;
> > +=09char *at;
> > +
> >=20
> > =09DBG("");
> >=20
> > +=09if (len !=3D sizeof(*cmd) + cmd->len) {
> > +=09=09error("Invalid formatted AT response command, terminating");=

> > +=09=09raise(SIGTERM);
> > +=09=09return;
> > +=09}
> > +
> > +=09DBG("");
> > +
> > +=09at =3D g_malloc0(cmd->len + 1);
> > +
> > +=09memcpy(at, cmd->buf, cmd->len);
> > +
> > +=09hfp_gw_send_info(device.gw, "%s", at);
> > +
> > +=09g_free(at);
> > +
>=20
> is Android really passing AT commands around without \0 terminating t=
hem.
> That OS is really just plain silly.

This is due to how we currently send strings overs IPC. There is string=
 type=20
in our IPC doc, but not in hal-msg.h. I'll fix that.

>=20
> Anyway, using strndupa seems more appropriate here.
>=20
> I also wonder why not just using (.., =E2=80=9C%.*s=E2=80=9D, cmd->le=
n, cmd->buf) here.

I'll use that.

> Regards
>=20
> Marcel

--=20
BR
Szymon Janc
