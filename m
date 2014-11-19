Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ACB402E679F3454EAE433BF5E93F4EAA01663F45@shsmsx102.ccr.corp.intel.com>
References: <ACB402E679F3454EAE433BF5E93F4EAA01663F45@shsmsx102.ccr.corp.intel.com>
Date: Wed, 19 Nov 2014 16:36:26 +0200
Message-ID: <CABBYNZLWkYcbpMsaTJ6h93UcbtihVB2GkZdZb9XPQ0_3Xjcujg@mail.gmail.com>
Subject: Re: Does obexd support Multi-User
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Wu, JiangboX" <jiangbox.wu@intel.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 19, 2014 at 3:17 PM, Wu, JiangboX <jiangbox.wu@intel.com> wrote=
:
> Hi Marcel,
>
>          As I know the bluetoothd is running on root privilege level, obe=
xd
> is running on app privilege level. The obexd is running on app privilege
> level to support user can only transfer the user=E2=80=99s own file. Mayb=
e it has
> other reasons.
>
> And if the OS has many users can run at the same time. For example. User =
A
> named =E2=80=98blob=E2=80=99, User B named =E2=80=98Alice=E2=80=99, and t=
he root. The three user run on OS
> at the time. As mentioned before, can I say that =E2=80=98blob=E2=80=99 a=
nd =E2=80=98Alice=E2=80=99 will
> have its owner obexd daemon? That I mean multi-user. And does it be able =
to
> use independent?
>
>          For example, =E2=80=98blob=E2=80=99 use BlueZ to pair device A, =
and =E2=80=98Alice=E2=80=99 use
> BlueZ to pair device B. Dose =E2=80=98blob=E2=80=99 can send/receive file=
 from device A? and
> =E2=80=98Alice=E2=80=99 can send/receive file form device B? I test the u=
sage case, and the
> result is that, =E2=80=98blob=E2=80=99 and =E2=80=98Alice=E2=80=99 can se=
nd file to device A and Device B
> simultaneously. But it=E2=80=99s have difference behavior in turn. Only o=
ne obexd
> can receive the OPP request, another will never get the OPP request.
>
>          Do you have any idea to support multi-user case by running
> different obexd daemon in the different users? If obexd don=E2=80=99t sup=
port
> multi-user, can you give me some sugguestions? Thanks. J

Yes obexd is capable of doing multi-user/multi-instance setups, what
is not able to do is multi-seat if you need server role since there
could be only 1 socket listening in the same channel/psm, for the
client APIs there is no problem if user A connects to device X and
user B to device Y they both can be connected simultaneously.

In terms of device management however you do have a problem, because
in Bluetooth there is only one link-key per device and that is
associated to the adapter, there is no user association and it makes
no sense to do so because the remote device also generates a link-key
as well, so if you want to restrict access of devices per user you
need to do so before it reaches obexd using perhaps a D-Bus daemon
hook to call a process that does keep track of which devices the user
can access.

--=20
Luiz Augusto von Dentz
