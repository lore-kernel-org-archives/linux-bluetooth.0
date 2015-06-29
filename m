Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Jun 2015 14:13:41 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: =?UTF-8?B?SsO2cmc=?= Otte <jrg.otte@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, "bluez
 mailin list (linux-bluetooth@vger.kernel.org)"
 <linux-bluetooth@vger.kernel.org>, "inux Kernel Mailing List"
 <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [4.1.0-07254-gc13c810] Regression: Bluetooth not working.
Message-ID: <20150629141341.667823f1@tedd-fedora-vm>
In-Reply-To: <CADDKRnB6eXTSB6jCrDjLRqbJJsBkP0CqJDRd3V==N7tGiuYXtw@mail.gmail.com>
References: <CADDKRnA4-h61=Tp90Cgj7GsAOZhBX6Dr0ka_CncrCrHDbWLcvw@mail.gmail.com>
	<986DE56C-2E79-4CAD-9D32-89DAED9B449A@holtmann.org>
	<CADDKRnCAj1BrmZzO6ys3zXmPJgaFnppARjU6VvVJf9Aiox7+Ww@mail.gmail.com>
	<CADDKRnDchGURbrxt=herCnLiLfcqrRt=s_wMoBpuG25Ae32WYg@mail.gmail.com>
	<CADDKRnCx4AM9jnf5HfbkB0iNQqxsyLCTozCrasF2c8e7V2K_gw@mail.gmail.com>
	<20150628160930.GA1663@p183.telecom.by>
	<CADDKRnAfsqY-9fVs_TRvuJMRi5=ByrMGtbytKDJadSSckcQ-fw@mail.gmail.com>
	<CACVxJT9JLjghmayrkA+0X0Bi4iKmiyy6Xf58ABNjXSaOR+ZRDw@mail.gmail.com>
	<CADDKRnB6eXTSB6jCrDjLRqbJJsBkP0CqJDRd3V==N7tGiuYXtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jorg

On Mon, 29 Jun 2015 16:37:32 +0200
J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:

> 2015-06-29 12:30 GMT+02:00 Alexey Dobriyan <adobriyan@gmail.com>:
> > On Mon, Jun 29, 2015 at 12:00 PM, J=C3=B6rg Otte <jrg.otte@gmail.com> w=
rote:
> >> 2015-06-28 18:09 GMT+02:00 Alexey Dobriyan <adobriyan@gmail.com>:
> >>> On Sun, Jun 28, 2015 at 05:36:04PM +0200, J=C3=B6rg Otte wrote:
> >>>> 2015-06-26 16:28 GMT+02:00 J=C3=B6rg Otte <jrg.otte@gmail.com>:
> >>>> > 2015-06-26 12:03 GMT+02:00 J=C3=B6rg Otte <jrg.otte@gmail.com>:
> >>>> >> 2015-06-26 11:37 GMT+02:00 Marcel Holtmann <marcel@holtmann.org>:
> >>>> >>> Hi Joerg,
> >>>> >>>
> >>>> >>>> Bluetooth is inoperable in current Linus tree and the
> >>>> >>>> first bad commit is:
> >>>> >>>>
> >>>> >>>> 835a6a2f8603237a3e6cded5a6765090ecb06ea5 is the first bad commit
> >>>> >>>> commit 835a6a2f8603237a3e6cded5a6765090ecb06ea5
> >>>> >>>> Author: Alexey Dobriyan <adobriyan@gmail.com>
> >>>> >>>> Date:   Wed Jun 10 20:28:33 2015 +0300
> >>>> >>>>
> >>>> >>>>    Bluetooth: Stop sabotaging list poisoning
> >>>> >>>>
> >>>> >>>>    list_del() poisons pointers with special values, no need to =
overwrite them.
> >>>> >>>>
> >>>> >>>>    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >>>> >>>>    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >>>> >>>>
> >>>> >>>> My BT adapter is an intel 8087:07da
> >>>> >>>> I reverted that commit and this fixed the problem for me.
> >>>> >>>
> >>>> >>> today we had a patch from Tedd fixing the list initialization in=
 the HIDP code.
> >>>> >>>
> >>>> >>> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core=
.c
> >>>> >>> index 9070dfd6b4ad..f1a117f8cad2 100644
> >>>> >>> --- a/net/bluetooth/hidp/core.c
> >>>> >>> +++ b/net/bluetooth/hidp/core.c
> >>>> >>> @@ -915,6 +915,7 @@ static int hidp_session_new(struct hidp_sess=
ion **out, const bdaddr_t *bdaddr,
> >>>> >>>         session->conn =3D l2cap_conn_get(conn);
> >>>> >>>         session->user.probe =3D hidp_session_probe;
> >>>> >>>         session->user.remove =3D hidp_session_remove;
> >>>> >>> +       INIT_LIST_HEAD(&session->user.list);
> >>>> >>>         session->ctrl_sock =3D ctrl_sock;
> >>>> >>>         session->intr_sock =3D intr_sock;
> >>>> >>>         skb_queue_head_init(&session->ctrl_transmit);
> >>>> >>>
> >>>> >>> Could this be fixing it for you as well?
> >>>> >>>
> >>>> >> I will check this when I am at home in the
> >>>> >> afternoon.
> >>>> >>
> >>>> >
> >>>> > The patch works for me too.
> >>>> >
> >>>> Ok, this was a little bit hasty!
> >>>> I now see the following additional problems:
> >>>>
> >>>> - System freeze on resume (occures always).
> >>>> - System freeze on shutdown (occures sometimes)
> >>>> - System freeze when BT-mouse is connecting (occures sometimes).
> >>>>
> >>>> Then I can't do anything except power off.
> >>>>
> >>>> This happens only if Bluetooth AND BT-mouse is activated.
> >>>
> >>> OK, what happens if you just revert only list_del patch?
> >>
> >> I have applied this patch:
> >>
> >> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> >> index 9070dfd6b4ad..f1a117f8cad2 100644
> >> --- a/net/bluetooth/hidp/core.c
> >> +++ b/net/bluetooth/hidp/core.c
> >> @@ -915,6 +915,7 @@ static int hidp_session_new(struct hidp_session
> >> **out, const bdaddr_t *bdaddr,
> >>         session->conn =3D l2cap_conn_get(conn);
> >>         session->user.probe =3D hidp_session_probe;
> >>         session->user.remove =3D hidp_session_remove;
> >> +       INIT_LIST_HEAD(&session->user.list);
> >>         session->ctrl_sock =3D ctrl_sock;
> >>         session->intr_sock =3D intr_sock;
> >>         skb_queue_head_init(&session->ctrl_transmit);
> >>
> >> without this patch bluetooth doesn't work at all for me.
> >
> > Sure.
> >
> > Please drop this patch, and do
> >
> >   git-revert 835a6a2f8603237a3e6cded5a6765090ecb06ea5
> >
> > Maybe it's some other changes causing hangs.
>=20
> Looks good so far. The system freeze on resume is gone.
>=20
> Thanks, J=C3=B6rg

Regarding the system hang issue, it looks like the problem is caused by the=
 list_del().
According to the list.h, this macro puts the entry into invalid state and i=
t causes the device hang in the l2cap_core.c

    /**
     * list_del - deletes entry from list.
     * @entry: the element to delete from the list.
     * Note: list_empty() on entry does not return true after this, the ent=
ry is
     * in an undefined state.
     */
   =20
So, one way to fix this issue is using the list_del_init() instead.

Can you try this patch to see if it resolve the issue? No need to revert an=
y patch.
I ran a quick test with a different scenarios and it looks good to me so fa=
r.

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 51594fb..45fffa4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1634,7 +1634,7 @@ void l2cap_unregister_user(struct l2cap_conn *conn, s=
truct l2cap_user *user)
        if (list_empty(&user->list))
                goto out_unlock;
=20
-       list_del(&user->list);
+       list_del_init(&user->list);
        user->remove(conn, user);
=20
 out_unlock:
@@ -1648,7 +1648,7 @@ static void l2cap_unregister_all_users(struct l2cap_c=
onn *conn)
=20
        while (!list_empty(&conn->users)) {
                user =3D list_first_entry(&conn->users, struct l2cap_user, =
list);
-               list_del(&user->list);
+               list_del_init(&user->list);
                user->remove(conn, user);
        }
 }

Regards,
Tedd Ho-Jeong An
