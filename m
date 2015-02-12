Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201412241941.56927@pali>
References: <201412241815.12922@pali>
	<201412241932.27264@pali>
	<20141224183737.GA21428@t440s.P-661HNU-DI-F1>
	<201412241941.56927@pali>
Date: Thu, 12 Feb 2015 19:22:42 +0800
Message-ID: <CAAAJ3CKFJ38pZF6WSD495W8JQmxBs1NcBDnag1q4qWhUE2_5qQ@mail.gmail.com>
Subject: Re: 3.19-rc1 refuse connection from bluetooth headset
From: Ethan <ethancsge@gmail.com>
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a1139cfa8a9bc0d050ee25663
List-ID: <linux-bluetooth.vger.kernel.org>

--001a1139cfa8a9bc0d050ee25663
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Johan,

I met similar issue in kernel 3.10 for Chromebook smart lock feature, I
have merged your patch but issue still happened.

Also, issue was unable to reproduce once I remove the code as below, thanks=
.

#if 0
        /* Require HCI_CONNECTABLE or a whitelist entry to accept the
         * connection. These features are only touched through mgmt so
         * only do the checks if HCI_MGMT is set.
         */
        if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
            !test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
            !hci_bdaddr_list_lookup(&hdev->whitelist, &ev->bdaddr,
                                    BDADDR_BREDR)) {
                    hci_reject_conn(hdev, &ev->bdaddr);
                    return;
        }

#endif

> HCI Event: Connect Request (0x04) plen 10                                =
                                                        [hci0] 109.033033
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
< HCI Command: Reject Connection Request (0x01|0x000a) plen 7
                                                            [hci0]
109.033253
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Reason: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                        [hci0] 109.034026
      Reject Connection Request (0x01|0x000a) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                               =
                                                        [hci0] 109.116034
        Status: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
        Handle: 65535
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
> HCI Event: Connect Request (0x04) plen 10                                =
                                                        [hci0] 110.159024
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
< HCI Command: Reject Connection Request (0x01|0x000a) plen 7
                                                            [hci0]
110.159079
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Reason: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                        [hci0] 110.160018
      Reject Connection Request (0x01|0x000a) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                               =
                                                        [hci0] 110.248103
        Status: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
        Handle: 65535
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)

Ethan

2014-12-25 2:41 GMT+08:00 Pali Roh=C3=A1r <pali.rohar@gmail.com>:

> On Wednesday 24 December 2014 19:37:37 Johan Hedberg wrote:
> > Hi Pali,
> >
> > On Wed, Dec 24, 2014, Pali Roh=C3=A1r wrote:
> > > > Could you try the attached patch? I think the reason might
> > > > be the dependence on the HCI_CONNECTABLE flag that's only
> > > > set if the page scan was enabled through mgmt (which
> > > > wouldn't be the case with BlueZ 4.98).
> > > >
> > > > Johan
> > >
> > > Hi Johan! Thanks for quick reply. Your patch fixes my
> > > problem and auto-connection of my bluetooth headset is
> > > working again. Will you forward patch to mainline kernel?
> >
> > Yes, we'll tag it from 3.17.x onwards where this was
> > introduced.
> >
> > Johan
>
> Ok, you can add my Tested-by line to patch.
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
>

--001a1139cfa8a9bc0d050ee25663
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi Johan,<br><br></div>I met similar issue in ke=
rnel 3.10 for Chromebook smart lock feature, I have merged your patch but i=
ssue still happened.<br><br></div>Also, issue was unable to reproduce once =
I remove the code as below, thanks.<br><div><br></div><div>#if 0<br></div><=
div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Require HCI_CONNECTABLE o=
r a whitelist entry to accept the<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * connection. These features are only touched through mgmt so<=
br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * only do the checks if=
 HCI_MGMT is set.<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */<br=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_bit(HCI_MGMT, &amp;hde=
v-&gt;dev_flags) &amp;&amp;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 !test_bit(HCI_CONNECTABLE, &amp;hdev-&gt;dev_flags=
) &amp;&amp;<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 !hci_bdaddr_list_lookup(&amp;hdev-&gt;whitelist, &amp;ev-&gt;bdad=
dr,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDADD=
R_BREDR)) {<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hci_reject_conn(hdev=
, &amp;ev-&gt;bdaddr);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<=
br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br><br></div><div>#endif<br=
></div><div><br><pre style=3D"color:rgb(0,0,0)">&gt; HCI Event: Connect Req=
uest (0x04) plen 10                                                        =
                                [hci0] 109.033033
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
&lt; HCI Command: Reject Connection Request (0x01|0x000a) plen 7           =
                                                           [hci0] 109.03325=
3
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Reason: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
&gt; HCI Event: Command Status (0x0f) plen 4                               =
                                                           [hci0] 109.03402=
6
      Reject Connection Request (0x01|0x000a) ncmd 1
        Status: Success (0x00)
&gt; HCI Event: Connect Complete (0x03) plen 11                            =
                                                           [hci0] 109.11603=
4
        Status: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
        Handle: 65535
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
&gt; HCI Event: Connect Request (0x04) plen 10                             =
                                                           [hci0] 110.15902=
4
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
&lt; HCI Command: Reject Connection Request (0x01|0x000a) plen 7           =
                                                           [hci0] 110.15907=
9
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Reason: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
&gt; HCI Event: Command Status (0x0f) plen 4                               =
                                                           [hci0] 110.16001=
8
      Reject Connection Request (0x01|0x000a) ncmd 1
        Status: Success (0x00)
&gt; HCI Event: Connect Complete (0x03) plen 11                            =
                                                           [hci0] 110.24810=
3
        Status: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
        Handle: 65535
        Address: BC:F5:AC:70:16:D3 (OUI BC-F5-AC)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)</pre>Ethan<br></div></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">2014-12-25 2:41 GMT+08:00 Pali=
 Roh=C3=A1r <span dir=3D"ltr">&lt;<a href=3D"mailto:pali.rohar@gmail.com" t=
arget=3D"_blank">pali.rohar@gmail.com</a>&gt;</span>:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">On Wednesday 24 December 2014 19:37:37 Johan=
 Hedberg wrote:<br>
&gt; Hi Pali,<br>
&gt;<br>
&gt; On Wed, Dec 24, 2014, Pali Roh=C3=A1r wrote:<br>
&gt; &gt; &gt; Could you try the attached patch? I think the reason might<b=
r>
&gt; &gt; &gt; be the dependence on the HCI_CONNECTABLE flag that&#39;s onl=
y<br>
&gt; &gt; &gt; set if the page scan was enabled through mgmt (which<br>
&gt; &gt; &gt; wouldn&#39;t be the case with BlueZ 4.98).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Johan<br>
&gt; &gt;<br>
&gt; &gt; Hi Johan! Thanks for quick reply. Your patch fixes my<br>
&gt; &gt; problem and auto-connection of my bluetooth headset is<br>
&gt; &gt; working again. Will you forward patch to mainline kernel?<br>
&gt;<br>
&gt; Yes, we&#39;ll tag it from 3.17.x onwards where this was<br>
&gt; introduced.<br>
&gt;<br>
&gt; Johan<br>
<br>
</span>Ok, you can add my Tested-by line to patch.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Pali Roh=C3=A1r<br>
<a href=3D"mailto:pali.rohar@gmail.com">pali.rohar@gmail.com</a><br>
</font></span></blockquote></div><br></div>

--001a1139cfa8a9bc0d050ee25663--
