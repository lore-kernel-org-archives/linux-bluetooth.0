Return-Path: <beaufort.francois@gmail.com>
MIME-Version: 1.0
In-Reply-To: <9F8DCC04-EF7A-499D-A39E-2C04C906C056@holtmann.org>
References: <CAEZxfGNdtXFznY_D-HLnkFBtQsHaqGbn65ZhmcKkgoh9em5L3g@mail.gmail.com>
 <9F8DCC04-EF7A-499D-A39E-2C04C906C056@holtmann.org>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Fri, 24 Jun 2016 14:50:36 +0200
Message-ID: <CAEZxfGMpmGmif7zj00ynRpyiaU2kkO4Q3Y4Fyo+XFH6L3LXqKA@mail.gmail.com>
Subject: Re: Caching device name in different connectable state
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=089e0122777ad2b5cc0536059e65
List-ID: <linux-bluetooth.vger.kernel.org>

--089e0122777ad2b5cc0536059e65
Content-Type: text/plain; charset=UTF-8

Thank your Marcel for the clarification.

As Luiz mentioned previously though, as random static addresses can be used
by other devices, it may makes sense to avoid caching their name. Would you
agree?

On Thu, Jun 23, 2016 at 3:29 PM Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Francois,
>
> > I have a bluetooth beacon device that advertises a name depending on
> > its configuration (connectable or not).
> > Sadly, in Bluez, the first time it sees it while advertising its name,
> > it caches it which is nice for future discovery.
> > Except it doesn't because I don't want to see this name while it
> > advertises in non-connectable state as it is "not" the same device
> > anymore (sort of).
> > I guess what I'm asking is if we can make Device name aware of the
> > connectable state and only use it if it matches state when it was
> > cached.
>
> yikes, this is super tricky. If the device uses the same address, then it
> is the same device. If it is not the same device, then it should use two
> different addresses (sort of a dual personality).
>
> Please keep in mind that a lot of device identity is based around either
> the public address or the static random address. We even clarified that as
> identity address in the latest specification. The mode has nothing to do
> with it. It makes it even more complicated since a device can be in
> broadcaster and peripheral role at the same time. It is just a matter of
> instantiating a second link layer state machine. However even in that case
> my advise is two use two different addresses if they are independent.
>
> Regards
>
> Marcel
>
>

--089e0122777ad2b5cc0536059e65
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank your Marcel for the clarification.<div><br></div><di=
v>As Luiz mentioned previously though, as random static addresses can be us=
ed by other devices, it may makes sense to avoid caching their name. Would =
you agree?<div><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Thu, Jun 23, 2016 at 3:29 PM Marcel Holtmann &lt;<a href=3D"mailto:marce=
l@holtmann.org" target=3D"_blank">marcel@holtmann.org</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Francois,<br>
<br>
&gt; I have a bluetooth beacon device that advertises a name depending on<b=
r>
&gt; its configuration (connectable or not).<br>
&gt; Sadly, in Bluez, the first time it sees it while advertising its name,=
<br>
&gt; it caches it which is nice for future discovery.<br>
&gt; Except it doesn&#39;t because I don&#39;t want to see this name while =
it<br>
&gt; advertises in non-connectable state as it is &quot;not&quot; the same =
device<br>
&gt; anymore (sort of).<br>
&gt; I guess what I&#39;m asking is if we can make Device name aware of the=
<br>
&gt; connectable state and only use it if it matches state when it was<br>
&gt; cached.<br>
<br>
yikes, this is super tricky. If the device uses the same address, then it i=
s the same device. If it is not the same device, then it should use two dif=
ferent addresses (sort of a dual personality).<br>
<br>
Please keep in mind that a lot of device identity is based around either th=
e public address or the static random address. We even clarified that as id=
entity address in the latest specification. The mode has nothing to do with=
 it. It makes it even more complicated since a device can be in broadcaster=
 and peripheral role at the same time. It is just a matter of instantiating=
 a second link layer state machine. However even in that case my advise is =
two use two different addresses if they are independent.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
</blockquote></div></div>

--089e0122777ad2b5cc0536059e65--
