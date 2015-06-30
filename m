Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jun 2015 11:47:26 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: =?UTF-8?B?SsO2cmc=?= Otte <jrg.otte@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, "bluez
 mailin list (linux-bluetooth@vger.kernel.org)"
 <linux-bluetooth@vger.kernel.org>, inux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [4.1.0-07254-gc13c810] Regression: Bluetooth not working.
Message-ID: <20150630114726.1f21fbb6@tedd-fedora-vm>
In-Reply-To: <CADDKRnBoXfBLMQYqdnJfAahDxSai7FQqGojv5LhWoAGdSKQLzA@mail.gmail.com>
References: <CADDKRnA4-h61=Tp90Cgj7GsAOZhBX6Dr0ka_CncrCrHDbWLcvw@mail.gmail.com>
	<986DE56C-2E79-4CAD-9D32-89DAED9B449A@holtmann.org>
	<CADDKRnCAj1BrmZzO6ys3zXmPJgaFnppARjU6VvVJf9Aiox7+Ww@mail.gmail.com>
	<CADDKRnDchGURbrxt=herCnLiLfcqrRt=s_wMoBpuG25Ae32WYg@mail.gmail.com>
	<CADDKRnCx4AM9jnf5HfbkB0iNQqxsyLCTozCrasF2c8e7V2K_gw@mail.gmail.com>
	<20150628160930.GA1663@p183.telecom.by>
	<CADDKRnAfsqY-9fVs_TRvuJMRi5=ByrMGtbytKDJadSSckcQ-fw@mail.gmail.com>
	<CACVxJT9JLjghmayrkA+0X0Bi4iKmiyy6Xf58ABNjXSaOR+ZRDw@mail.gmail.com>
	<CADDKRnB6eXTSB6jCrDjLRqbJJsBkP0CqJDRd3V==N7tGiuYXtw@mail.gmail.com>
	<20150629141341.667823f1@tedd-fedora-vm>
	<CADDKRnBoXfBLMQYqdnJfAahDxSai7FQqGojv5LhWoAGdSKQLzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi J=C3=B6rg

On Tue, 30 Jun 2015 16:58:13 +0200
J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:

> > Regarding the system hang issue, it looks like the problem is caused by=
 the list_del().
> > According to the list.h, this macro puts the entry into invalid state a=
nd it causes the device hang in the l2cap_core.c
> >
> >     /**
> >      * list_del - deletes entry from list.
> >      * @entry: the element to delete from the list.
> >      * Note: list_empty() on entry does not return true after this, the=
 entry is
> >      * in an undefined state.
> >      */
> >
> > So, one way to fix this issue is using the list_del_init() instead.
> >
> > Can you try this patch to see if it resolve the issue? No need to rever=
t any patch.
> > I ran a quick test with a different scenarios and it looks good to me s=
o far.
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 51594fb..45fffa4 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1634,7 +1634,7 @@ void l2cap_unregister_user(struct l2cap_conn *con=
n, struct l2cap_user *user)
> >         if (list_empty(&user->list))
> >                 goto out_unlock;
> >
> > -       list_del(&user->list);
> > +       list_del_init(&user->list);
> >         user->remove(conn, user);
> >
> >  out_unlock:
> > @@ -1648,7 +1648,7 @@ static void l2cap_unregister_all_users(struct l2c=
ap_conn *conn)
> >
> >         while (!list_empty(&conn->users)) {
> >                 user =3D list_first_entry(&conn->users, struct l2cap_us=
er, list);
> > -               list_del(&user->list);
> > +               list_del_init(&user->list);
> >                 user->remove(conn, user);
> >         }
> >  }
> >
> > Regards,
> > Tedd Ho-Jeong An
>=20
> I now have both patche applied and no revert. Looks good so far.
>=20
> Thanks, J=C3=B6rg

Thanks for testing the patch. I submitted the patch just in case.
Now, I am tossing the ball to Marcel. :)

Regards,
Tedd
