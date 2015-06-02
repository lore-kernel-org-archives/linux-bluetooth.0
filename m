Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <449781348.237751431668266873.JavaMail.weblogic@ep2mlwas05d>
References: <449781348.237751431668266873.JavaMail.weblogic@ep2mlwas05d>
Date: Tue, 2 Jun 2015 13:58:18 +0530
Message-ID: <CAJzH+bqxTdtCsSy4hsU0OEh_iyjwPWmb3F_nwiJ_FMY6w=poOA@mail.gmail.com>
Subject: Re: Re: [PATCH] Bluetooth: Fix potential NULL dereference
From: Jaganath K <jaganath.k.os@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=f46d04428884758aff051784b99f
List-ID: <linux-bluetooth.vger.kernel.org>

--f46d04428884758aff051784b99f
Content-Type: text/plain; charset=UTF-8

Ping.


On Fri, May 15, 2015 at 11:07 AM, JAGANATH KANAKKASSERY <
jaganath.k@samsung.com> wrote:

> Hi Marcel,
>
> >>>> addr can be NULL and it should not be dereferenced before NULL
> checking.
> >>>>
> >>>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> >>>> ---
> >> >
> >> >if we start changing things here, then we better change the code into
> something that all the other socket handling code is doing anyway>y. So do
> the min comparison and copy the data into a local copy of the sockaddr_rc.
> >>>
> >>> And on a side note, I wonder if addr can actually be NULL. It might be
> interesting to check the generic socket code if this really can happe>n if
> you provide no address structure to the bind() system call or if this gets
> filtered out by the core socket code.
> >>
> >> I checked generic socket code and it looks like addr will never be NULL
> when user space calls bind.
> >> But this can be called from kernel_bind() also which I think will never
> be called for RFCOMM.
> >> So this patch is not required?
> >
> >that is what I thought. However converting it to the same handling using
> min and copying into local storage might be a good idea. The more pieces in
> HCI, L2CAP, SCO and RFCOMM sockets that are similar, the better.
>
> I have raised v1 with the changes you suggested, Plz check it.
>
> Thanks,
> Jaganath

--f46d04428884758aff051784b99f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Ping.<br></div></div></div><br></div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, May 15, 2015 at=
 11:07 AM, JAGANATH KANAKKASSERY <span dir=3D"ltr">&lt;<a href=3D"mailto:ja=
ganath.k@samsung.com" target=3D"_blank">jaganath.k@samsung.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">Hi Marcel,<br>
<span class=3D""><br>
&gt;&gt;&gt;&gt; addr can be NULL and it should not be dereferenced before =
NULL checking.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Jaganath Kanakkassery &lt;<a href=3D"mailto=
:jaganath.k@samsung.com">jaganath.k@samsung.com</a>&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt; &gt;<br>
</span>&gt;&gt; &gt;if we start changing things here, then we better change=
 the code into something that all the other socket handling code is doing a=
nyway&gt;y. So do the min comparison and copy the data into a local copy of=
 the sockaddr_rc.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; And on a side note, I wonder if addr can actually be NULL. It =
might be interesting to check the generic socket code if this really can ha=
ppe&gt;n if you provide no address structure to the bind() system call or i=
f this gets filtered out by the core socket code.<br>
&gt;&gt;<br>
&gt;&gt; I checked generic socket code and it looks like addr will never be=
 NULL when user space calls bind.<br>
&gt;&gt; But this can be called from kernel_bind() also which I think will =
never be called for RFCOMM.<br>
&gt;&gt; So this patch is not required?<br>
&gt;<br>
&gt;that is what I thought. However converting it to the same handling usin=
g min and copying into local storage might be a good idea. The more pieces =
in HCI, L2CAP, SCO and RFCOMM sockets that are similar, the better.<br>
<br>
I have raised v1 with the changes you suggested, Plz check it.<br>
<br>
Thanks,<br>
Jaganath</blockquote></div><br></div>

--f46d04428884758aff051784b99f--
