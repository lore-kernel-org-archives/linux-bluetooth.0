Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
References: <CANzaTi7NSBf8iuTC41jBA=732PCZUYkzw_ZTywGM-xNQt68qbw@mail.gmail.com>
 <670FEC00-5331-47B5-8434-7642D67779DC@holtmann.org>
In-Reply-To: <670FEC00-5331-47B5-8434-7642D67779DC@holtmann.org>
From: dogan yazar <doganyazar@gmail.com>
Date: Mon, 22 Jun 2015 12:49:43 +0000
Message-ID: <CANzaTi7wCW0xBLtsn=kqZUTr6zY0iYBDPeY1=bKdwgCjhcJwfg@mail.gmail.com>
Subject: Re: BLE Advertise and Scan at the same time?
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a1133a672daf7c805191ab5aa
List-ID: <linux-bluetooth.vger.kernel.org>

--001a1133a672daf7c805191ab5aa
Content-Type: text/plain; charset=UTF-8

Thanks for the answer. I tried this by enabling advertisement (hciconfig
hci0 leadv) and then "btmgmt find" but then hci adapter got into some weird
state. Was not possible to disable scanning anymore. Same problem when I
did bluetoothctl scan on. Probably my chip does not support it.

I also tried "btmgmt advertising on" rather than hciconfig leadv but it did
not do anything at all. Is "hciconfig hci0 leadv" only way to enable
advertising until we move to kernel 4.1 and do it via DBUS api?

And lastly, still I seem to need hcitool to be able to set the
advertisement data otherwise android ble clients refuse to connect (they
think it is a classic bluetooth I think). It is no longer a issue after I
set GAP_ADTYPE_FLAGS_BREDR_NOT_SUPPORTED via hcitool cmd
i.e. hcitool -i hci0 cmd 0x08 0x0008 3 02 01 05

On Mon, Jun 22, 2015 at 12:22 PM Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Dogan,
>
> > Is it possible to advertise (leadv) and scan (scan on) using the same
> > ble adaper?
> > The moment that I enable scanning (scan on) with bluetoothctl, leadv
> > is disabled.
>
> that depends on the Bluetooth chip you are using. Inside the kernel we
> currently play it safe and disable one when we start the other. It will be
> however re-enabled when the scan finished. You need to use btmgmt and not
> hcitool. Using hcitool messes with raw HCI packets. The kernel logic will
> always overwrite these as it sees fit.
>
> To allow simultaneous states, someone would have to work on that and
> figure out which chips support what. Once that is done, there is no problem
> in lifting some of the restrictions we imposed.
>
> > The reason I want is to have a GATT client and server at the same time.
>
> Actually that has never been a problem. You can have a GATT client and
> server at the same time and most likely you do already anyway. The question
> you are asking is if you can be in central and peripheral role at the same
> time.
>
> Regards
>
> Marcel
>
>

--001a1133a672daf7c805191ab5aa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the answer. I tried this by enabling advertisem=
ent (hciconfig hci0 leadv) and then &quot;btmgmt find&quot; but then hci ad=
apter got into some weird state. Was not possible to disable scanning anymo=
re. Same problem when I did bluetoothctl scan on. Probably my chip does not=
 support it.=C2=A0<div><br><div>I also tried &quot;btmgmt advertising on&qu=
ot; rather than hciconfig leadv but it did not do anything at all. Is &quot=
;hciconfig hci0 leadv&quot; only way to enable advertising until we move to=
 kernel 4.1 and do it via DBUS api?</div><div><br></div><div>And lastly, st=
ill I seem to need hcitool to be able to set the advertisement data otherwi=
se android ble clients refuse to connect (they think it is a classic blueto=
oth I think). It is no longer a issue after I set=C2=A0GAP_ADTYPE_FLAGS_BRE=
DR_NOT_SUPPORTED via hcitool cmd</div><div>i.e.=C2=A0hcitool -i hci0 cmd 0x=
08 0x0008 3 02 01 05</div><div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr">On Mon, Jun 22, 2015 at 12:22 PM Marcel Holtmann &lt;<a href=3D"mailto:=
marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">Hi Dogan,<br>
<br>
&gt; Is it possible to advertise (leadv) and scan (scan on) using the same<=
br>
&gt; ble adaper?<br>
&gt; The moment that I enable scanning (scan on) with bluetoothctl, leadv<b=
r>
&gt; is disabled.<br>
<br>
that depends on the Bluetooth chip you are using. Inside the kernel we curr=
ently play it safe and disable one when we start the other. It will be howe=
ver re-enabled when the scan finished. You need to use btmgmt and not hcito=
ol. Using hcitool messes with raw HCI packets. The kernel logic will always=
 overwrite these as it sees fit.<br>
<br>
To allow simultaneous states, someone would have to work on that and figure=
 out which chips support what. Once that is done, there is no problem in li=
fting some of the restrictions we imposed.<br>
<br>
&gt; The reason I want is to have a GATT client and server at the same time=
.<br>
<br>
Actually that has never been a problem. You can have a GATT client and serv=
er at the same time and most likely you do already anyway. The question you=
 are asking is if you can be in central and peripheral role at the same tim=
e.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
</blockquote></div></div></div></div>

--001a1133a672daf7c805191ab5aa--
