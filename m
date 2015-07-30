Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
References: <55B83614.8090702@gmail.com> <BC4DBE9E-8369-4B20-BBE5-F175DD4C5626@holtmann.org>
 <55BA16BA.5060302@gmail.com> <F5B83C8F-6BD0-49C8-96C9-F13DF68CEECE@holtmann.org>
 <55BA2290.8090308@gmail.com> <2C03C1D8-0784-4DA4-93AF-FC8A1C874681@holtmann.org>
In-Reply-To: <2C03C1D8-0784-4DA4-93AF-FC8A1C874681@holtmann.org>
From: Adam Moore <aj8.devcom@gmail.com>
Date: Thu, 30 Jul 2015 16:22:50 +0000
Message-ID: <CADtekAJAoP+F_NE3QTjH2uAN4boref3eZ=9MHZ4RvraLi7oz6g@mail.gmail.com>
Subject: Re: Problems with incoming connection request on Nexus 4
To: Marcel Holtmann <marcel@holtmann.org>, Florian Grandel <fgrandel@gmail.com>
Cc: Szymon Janc <Szymon.Janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a113a5656ea08a7051c1a1dfa
List-ID: <linux-bluetooth.vger.kernel.org>

--001a113a5656ea08a7051c1a1dfa
Content-Type: text/plain; charset=UTF-8

That problem sounds familiar - I think I've heard of that happening if the
BR/EDR Not Supported bit is cleared in your advertising data's flags. Maybe
it just needs to be set.
On Thu, Jul 30, 2015 at 09:10 Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Florian,
>
> >>>>> Symptoms:
> >>>>> - The connection request times out.
> >>>>> - bt_io_accept() is being called but the accept_cb (=connect_cb)
> only gets called when the request times out.
> >>>>> - the device is stuck in the CONNECT READY state and never reaches
> the CONNECTED state
> >>>>>
> >>>>>
> >>>>> Any ideas how I could analyze/solve that problem? I'm stuck on this
> for many hours already...
> >>>>
> >>>> what does btmon actually tell you about what is going on with HCI.
> >>>
> >>> = New Index: 10:68:3F:56:AD:35 (BR/EDR,UNKNOWN,hci0)            [hci0]
> 0.629837
> >>> @ Advertising Added: 1
> >>> < HCI Command: LE Set Advertising Para.. (0x08|0x0006) plen 15  [hci0]
> 4.398493
> >>>        Min advertising interval: 1280.000 msec (0x0800)
> >>>        Max advertising interval: 1280.000 msec (0x0800)
> >>>        Type: Connectable undirected - ADV_IND (0x00)
> >>>        Own address type: Public (0x00)
> >>>        Direct address type: Public (0x00)
> >>>        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
> >>>        Channel map: 37, 38, 39 (0x07)
> >>>        Filter policy: Allow Scan Request from Any, Allow Connect
> Request from Any (0x00)
> >>>> HCI Event: Command Complete (0x0e) plen 4                     [hci0]
> 4.401392
> >>>      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
> >>>        Status: Success (0x00)
> >>> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1     [hci0]
> 4.401484
> >>>        Advertising: Enabled (0x01)
> >>>> HCI Event: Command Complete (0x0e) plen 4                     [hci0]
> 4.402277
> >>>      LE Set Advertise Enable (0x08|0x000a) ncmd 1
> >>>        Status: Success (0x00)
> >>>
> >>> There is no connection related HCI activity going on at all on the
> Nexus 4 side. You can see from the debug logs that I sent before, that the
> connection is being initiated correctly. The bt_io_accept() call does
> return without error, just the accept callback never gets called. To me it
> seems as if the Nexus4 was not responding to the incoming connect request.
> >>
> >> we are advertising now. If the HCI traffic stays this way, then we are
> basically waiting for the central to connect to us. It is up to your Nexus
> 4 to connect.
> >>
> >> If it would connect, then you would see an LE Connect Complete event
> indicated that the connection has been established.
> >
> > Sorry, I left out the actual connection part the first time. Here it is:
> >
> > = New Index: 10:68:3F:56:AD:35 (BR/EDR,UNKNOWN,hci0)            [hci0]
> 0.248759
> > > HCI Event: Connect Request (0x04) plen 10                     [hci0]
> 9.147279
> >        Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)
> >        Class: 0x5a020c
> >          Major class: Phone (cellular, cordless, payphone, modem)
> >          Minor class: Smart phone
> >          Networking (LAN, Ad hoc)
> >          Capturing (Scanner, Microphone)
> >          Object Transfer (v-Inbox, v-Folder)
> >          Telephony (Cordless telephony, Modem, Headset)
> >        Link type: ACL (0x01)
>
> this is a BR/EDR connection. So it seems even while it sees you advertise
> on LE, it then connects using BR/EDR. Since Bluetooth 4.0 did not allow
> BR/EDR and LE at the same time. Only Bluetooth 4.1 relaxed this.
>
> But it is hilarious that your phone stack sees an LE advertising and then
> connects to you over BR/EDR.
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a113a5656ea08a7051c1a1dfa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

That problem sounds familiar - I think I&#39;ve heard of that happening if =
the BR/EDR Not Supported bit is cleared in your advertising data&#39;s flag=
s.  Maybe it just needs to be set.<br><div class=3D"gmail_quote">On Thu, Ju=
l 30, 2015 at 09:10 Marcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.o=
rg">marcel@holtmann.org</a>&gt; wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi=
 Florian,<br>
<br>
&gt;&gt;&gt;&gt;&gt; Symptoms:<br>
&gt;&gt;&gt;&gt;&gt; - The connection request times out.<br>
&gt;&gt;&gt;&gt;&gt; - bt_io_accept() is being called but the accept_cb (=
=3Dconnect_cb) only gets called when the request times out.<br>
&gt;&gt;&gt;&gt;&gt; - the device is stuck in the CONNECT READY state and n=
ever reaches the CONNECTED state<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Any ideas how I could analyze/solve that problem? I&#3=
9;m stuck on this for many hours already...<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; what does btmon actually tell you about what is going on w=
ith HCI.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =3D New Index: 10:68:3F:56:AD:35 (BR/EDR,UNKNOWN,hci0)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [hci0] 0.629837<br>
&gt;&gt;&gt; @ Advertising Added: 1<br>
&gt;&gt;&gt; &lt; HCI Command: LE Set Advertising Para.. (0x08|0x0006) plen=
 15=C2=A0 [hci0] 4.398493<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Min advertising interval: 1280.000 =
msec (0x0800)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Max advertising interval: 1280.000 =
msec (0x0800)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Type: Connectable undirected - ADV_=
IND (0x00)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Own address type: Public (0x00)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Direct address type: Public (0x00)<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Direct address: 00:00:00:00:00:00 (=
OUI 00-00-00)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Channel map: 37, 38, 39 (0x07)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Filter policy: Allow Scan Request f=
rom Any, Allow Connect Request from Any (0x00)<br>
&gt;&gt;&gt;&gt; HCI Event: Command Complete (0x0e) plen 4=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 4.401392<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 LE Set Advertising Parameters (0x08|0x0006=
) ncmd 1<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)<br>
&gt;&gt;&gt; &lt; HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1=
=C2=A0 =C2=A0 =C2=A0[hci0] 4.401484<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Advertising: Enabled (0x01)<br>
&gt;&gt;&gt;&gt; HCI Event: Command Complete (0x0e) plen 4=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 4.402277<=
br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 LE Set Advertise Enable (0x08|0x000a) ncmd=
 1<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; There is no connection related HCI activity going on at all on=
 the Nexus 4 side. You can see from the debug logs that I sent before, that=
 the connection is being initiated correctly. The bt_io_accept() call does =
return without error, just the accept callback never gets called. To me it =
seems as if the Nexus4 was not responding to the incoming connect request.<=
br>
&gt;&gt;<br>
&gt;&gt; we are advertising now. If the HCI traffic stays this way, then we=
 are basically waiting for the central to connect to us. It is up to your N=
exus 4 to connect.<br>
&gt;&gt;<br>
&gt;&gt; If it would connect, then you would see an LE Connect Complete eve=
nt indicated that the connection has been established.<br>
&gt;<br>
&gt; Sorry, I left out the actual connection part the first time. Here it i=
s:<br>
&gt;<br>
&gt; =3D New Index: 10:68:3F:56:AD:35 (BR/EDR,UNKNOWN,hci0)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [hci0] 0.248759<br>
&gt; &gt; HCI Event: Connect Request (0x04) plen 10=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[hci0] 9.147279<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Address: 94:01:C2:AB:46:05 (OUI 94-01-C2)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Class: 0x5a020c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Major class: Phone (cellular, cordle=
ss, payphone, modem)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Minor class: Smart phone<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Networking (LAN, Ad hoc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capturing (Scanner, Microphone)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Object Transfer (v-Inbox, v-Folder)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Telephony (Cordless telephony, Modem=
, Headset)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Link type: ACL (0x01)<br>
<br>
this is a BR/EDR connection. So it seems even while it sees you advertise o=
n LE, it then connects using BR/EDR. Since Bluetooth 4.0 did not allow BR/E=
DR and LE at the same time. Only Bluetooth 4.1 relaxed this.<br>
<br>
But it is hilarious that your phone stack sees an LE advertising and then c=
onnects to you over BR/EDR.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-blueto=
oth&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org" targe=
t=3D"_blank">majordomo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/majord=
omo-info.html</a><br>
</blockquote></div>

--001a113a5656ea08a7051c1a1dfa--
