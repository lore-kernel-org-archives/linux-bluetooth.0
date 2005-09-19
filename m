Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05091907316665534d@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05091607426f824afa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4231_21257557.1127140294946"
References: <e1effdeb05091607426f824afa@mail.gmail.com>
Subject: [Bluez-devel] Re: hcid D-Bus patch (RSSI question)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 19 Sep 2005 11:31:34 -0300

------=_Part_4231_21257557.1127140294946
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

What are the requirements to use inquiry with rssi? My=20
kernel version is 2.6.10 with bluez-utils.2.21.

Why it is not working? The periodic inquiry is working, but without
return an inquiry with rssi event.

Regards,
Claudio

if((dev_id =3D hci_get_route(NULL)) < 0) {
syslog(LOG_ERR, "Bluetooth device is not available");
result =3D RESULT_ADAPTER_NOT_FOUND;
goto cleanup;
}

if((sock =3D hci_open_dev(dev_id)) < 0) {
syslog(LOG_ERR, "HCI device open failed");
result =3D RESULT_ADAPTER_NOT_FOUND;
goto cleanup;
}

...

inq_mode.mode =3D 1; //INQUIRY_WITH_RSSI;

if (hci_send_cmd(sock, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE,
WRITE_INQUIRY_MODE_CP_SIZE, &inq_mode) < 0) {
syslog(LOG_ERR, "Can't set inquiry mode:%s.", strerror(errno));
goto cleanup;
}

if (hci_send_cmd(sock, OGF_LINK_CTL, OCF_PERIODIC_INQUIRY,
PERIODIC_INQUIRY_CP_SIZE, &inq_param) < 0) {
syslog(LOG_ERR, "Can't send HCI commands:%s.", strerror(errno));
goto cleanup;
}
...



On 9/16/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>=20
> Hi Marcel,
>=20
> I am sending the initial patch that implementing the skeleton
> of the hcid D-Bus services.
>=20
> Run hcid with a non-daemon option to see the output
>=20
> Send the following messages to see the message handling.
>=20
> dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/hci=
=20
> org.bluez.hci.PeriodicInqReq byte:1 byte:2 byte:3
> dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/hci=
=20
> org.bluez.hci.CancelPeriodicInqReq
> dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/hci=
=20
> org.bluez.hci.InquiryReq byte:1
> dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/hci=
=20
> org.bluez.hci.RoleSwitchReq string:panu byte:1
>=20
> Suggestions are welcome!
>=20
> Regards,
> Claudio.
>=20
>

------=_Part_4231_21257557.1127140294946
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
What are the requirements to use inquiry with rssi? My <br>
kernel version is 2.6.10 with bluez-utils.2.21.<br>
<br>
Why it is not working? The periodic inquiry is working, but without<br>
return an inquiry with rssi event.<br>
<br>
Regards,<br>
Claudio<br>
<br>
if((dev_id =3D hci_get_route(NULL)) &lt; 0) {<br>
&nbsp;&nbsp;&nbsp; syslog(LOG_ERR, &quot;Bluetooth device is not available&=
quot;);<br>
&nbsp;&nbsp;&nbsp; result =3D RESULT_ADAPTER_NOT_FOUND;<br>
&nbsp;&nbsp;&nbsp; goto cleanup;<br>
}<br>
<br>
if((sock =3D hci_open_dev(dev_id)) &lt; 0) {<br>
&nbsp;&nbsp;&nbsp; syslog(LOG_ERR, &quot;HCI device open failed&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D RESULT_ADAPTER_NOT_FO=
UND;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto cleanup;<br>
}<br>
<br>
...<br>
<br>
inq_mode.mode =3D 1; //INQUIRY_WITH_RSSI;<br>
<br>
if (hci_send_cmd(sock, OGF_HOST_CTL, OCF_WRITE_INQUIRY_MODE,<br>
&nbsp;&nbsp;&nbsp; WRITE_INQUIRY_MODE_CP_SIZE, &amp;inq_mode) &lt; 0) {<br>
&nbsp;&nbsp;&nbsp; syslog(LOG_ERR, &quot;Can't set inquiry mode:%s.&quot;, =
strerror(errno));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto cleanup;<br>
}<br>
<br>
if (hci_send_cmd(sock, OGF_LINK_CTL, OCF_PERIODIC_INQUIRY,<br>
&nbsp;&nbsp;&nbsp; PERIODIC_INQUIRY_CP_SIZE, &amp;inq_param) &lt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; syslog(LOG_ERR, &quot;Can't send=
 HCI commands:%s.&quot;, strerror(errno));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto cleanup;<br>
}<br>
...<br>
<br>
<br><br><div><span class=3D"gmail_quote">On 9/16/05, <b class=3D"gmail_send=
ername">Claudio Takahasi</b> &lt;<a href=3D"mailto:cktakahasi@gmail.com">ck=
takahasi@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
Hi Marcel,<br>
<br>
I am sending the initial patch that implementing the skeleton<br>
of the hcid D-Bus services.<br>
<br>
Run hcid with a non-daemon option to see the output<br>
<br>
Send the following messages to see the message handling.<br>
<br>
dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/hci o=
rg.bluez.hci.PeriodicInqReq byte:1 byte:2 byte:3<br>
dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/hci o=
rg.bluez.hci.CancelPeriodicInqReq<br>
dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/hci o=
rg.bluez.hci.InquiryReq byte:1<br>
dbus-send --system --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/hci o=
rg.bluez.hci.RoleSwitchReq string:panu byte:1<br>
<br>
Suggestions are welcome!<br>
<br>
Regards,<br><span class=3D"sg">
Claudio.<br>

</span><br clear=3D"all"></blockquote></div><br>

------=_Part_4231_21257557.1127140294946--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
