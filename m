Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510040533x454108adgb8398d37324af631@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid patch
In-Reply-To: <1128373377.8472.44.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4060_6309862.1128429212132"
References: <e1effdeb05093011224be94d05@mail.gmail.com>
	 <1128160192.8555.6.camel@localhost.localdomain>
	 <e1effdeb051003070847e0d7ac@mail.gmail.com>
	 <1128373377.8472.44.camel@blade>
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
Date: Tue, 4 Oct 2005 09:33:32 -0300

------=_Part_4060_6309862.1128429212132
Content-Type: multipart/alternative;
	boundary="----=_Part_4061_17858956.1128429212132"

------=_Part_4061_17858956.1128429212132
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Your suggestions were done!
Regarding service_table_t, if we remove it, the logic will be based on
"if"and "else", see the HAL message filter function. In my opinion
service_table_t is more clear.

If you think that is really necessary remove the error handling and the
service_table_t I can do it in the next patch.

Regards,
Claudio.





On 10/3/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > I kept some log information, if you want remove it I can send another
> > patch. The error code definition was included. I am using "hciX" in
> > the path name until we receive a answer from dbus list. Services under
> > the path /org/bluez/Devices weren't implemented yet.
> >
> > Is there other changes in this patch?
>
> this thing looks quite good, but now we need to clean up some other
> parts of your constants and function naming. And please try to keep the
> BlueZ/kernel coding style.
>
> The overall BLUEZ_DBUS prefix looks like a good idea at the beginning,
> but I think we don't need it at all. So this should be enough:
>
> #define DEVICE_PATH "/org/bluez/Device"
> #define DEVICE_INTERFACE "org.bluez.Device"
>
> #define MANAGER_PATH "/org/bluez/Manager"
> #define MANAGER_INTERFACE "org.bluez.Manager"
>
> Please also stop to shortcut some names. For example DFT for DEFAULT.
> Simple write the full name, because then it is easy to read this code.
>
> The other thing is that I don't like the difference between *_REQ and
> *_SIG in the names/constants. Please don't use them.
>
> Also please don't include any RFCOMM, PAN, HID etc. related things,
> because they are not important right now and they make my life of
> merging the initial step into better D-Bus a lot harder.
>
> For the error part we will use org.bluez.Error and not EFailed or
> anything like this. Since all the error stuff is currently not used, I
> don't think it is a good idea to add it to the initial patch. Looking at
> HAL the use of org.bluez.NoSuchDevice, etc. seems to make sense, too.
>
> Do we really need that service_table_t thingy now? I think we should
> start without it.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_4061_17858956.1128429212132
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>Hi Marcel,<br>
<br>
Your suggestions were done!<br>
Regarding service_table_t, if we remove it, the logic will be based on
&quot;if&quot;and &quot;else&quot;, see the HAL message filter function. In=
 my opinion
service_table_t is more clear. <br>
<br>
If you think that is really necessary remove the error handling and the ser=
vice_table_t I can do it in the next patch.<br>
<br>
Regards,<br>
Claudio.<br>
<br>
<br>
<br>
<br>
<br><div><span class=3D"gmail_quote">On 10/3/05, <b class=3D"gmail_senderna=
me">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@h=
oltmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">
Hi Claudio,<br><br>&gt; I kept some log information, if you want remove it =
I can send another<br>&gt; patch. The error code definition was included. I=
 am using &quot;hciX&quot; in<br>&gt; the path name until we receive a answ=
er from dbus list. Services under
<br>&gt; the path /org/bluez/Devices weren't implemented yet.<br>&gt;<br>&g=
t; Is there other changes in this patch?<br><br>this thing looks quite good=
, but now we need to clean up some other<br>parts of your constants and fun=
ction naming. And please try to keep the
<br>BlueZ/kernel coding style.<br><br>The overall BLUEZ_DBUS prefix looks l=
ike a good idea at the beginning,<br>but I think we don't need it at all. S=
o this should be enough:<br><br>#define DEVICE_PATH&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;/org/bluez/Device&qu=
ot;
<br>#define DEVICE_INTERFACE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&quot;org.bluez.Device&quot;<br><br>#define MANAGER_PATH&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;/org/bluez/Mana=
ger&quot;<br>#define MANAGER_INTERFACE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;org.bluez.Manager&quot;<br><br>Please also stop to shortcut some name=
s. For example DFT for DEFAULT.
<br>Simple write the full name, because then it is easy to read this code.<=
br><br>The other thing is that I don't like the difference between *_REQ an=
d<br>*_SIG in the names/constants. Please don't use them.<br><br>Also pleas=
e don't include any RFCOMM, PAN, HID etc. related things,
<br>because they are not important right now and they make my life of<br>me=
rging the initial step into better D-Bus a lot harder.<br><br>For the error=
 part we will use org.bluez.Error and not EFailed or<br>anything like this.=
 Since all the error stuff is currently not used, I
<br>don't think it is a good idea to add it to the initial patch. Looking a=
t<br>HAL the use of org.bluez.NoSuchDevice, etc. seems to make sense, too.<=
br><br>Do we really need that service_table_t thingy now? I think we should
<br>start without it.<br><br>Regards<br><br>Marcel<br><br><br><br><br>-----=
--------------------------------------------------<br>This SF.Net email is =
sponsored by:<br>Power Architecture Resource Center: Free content, download=
s, discussions,
<br>and more. <a href=3D"http://solutions.newsforge.com/ibmarch.tmpl">http:=
//solutions.newsforge.com/ibmarch.tmpl</a><br>_____________________________=
__________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-d=
evel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br><br clear=3D"all"><br>-- <br=
>
---------------------------------------------------------<br>Claudio Takaha=
si<br>Nokia's Institute of Technology - INdT<br><a href=3D"mailto:claudio.t=
akahasi@indt.org.br">claudio.takahasi@indt.org.br</a><br>

------=_Part_4061_17858956.1128429212132--

------=_Part_4060_6309862.1128429212132
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment

<br>Hi Marcel,<br>
<br>
Your suggestions were done!<br>
Regarding service_table_t, if we remove it, the logic will be based on
&quot;if&quot;and &quot;else&quot;, see the HAL message filter function. In my opinion
service_table_t is more clear. <br>
<br>
If you want I <br>
<br>
Regards,<br>
Claudio.<br>
<br>
<br>
<br>
<br>
<br><div><span class="gmail_quote">On 10/3/05, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Claudio,<br><br>&gt; I kept some log information, if you want remove it I can send another<br>&gt; patch. The error code definition was included. I am using &quot;hciX&quot; in<br>&gt; the path name until we receive a answer from dbus list. Services under
<br>&gt; the path /org/bluez/Devices weren't implemented yet.<br>&gt;<br>&gt; Is there other changes in this patch?<br><br>this thing looks quite good, but now we need to clean up some other<br>parts of your constants and function naming. And please try to keep the
<br>BlueZ/kernel coding style.<br><br>The overall BLUEZ_DBUS prefix looks like a good idea at the beginning,<br>but I think we don't need it at all. So this should be enough:<br><br>#define DEVICE_PATH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;/org/bluez/Device&quot;
<br>#define DEVICE_INTERFACE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;org.bluez.Device&quot;<br><br>#define MANAGER_PATH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;/org/bluez/Manager&quot;<br>#define MANAGER_INTERFACE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;org.bluez.Manager&quot;<br><br>Please also stop to shortcut some names. For example DFT for DEFAULT.
<br>Simple write the full name, because then it is easy to read this code.<br><br>The other thing is that I don't like the difference between *_REQ and<br>*_SIG in the names/constants. Please don't use them.<br><br>Also please don't include any RFCOMM, PAN, HID etc. related things,
<br>because they are not important right now and they make my life of<br>merging the initial step into better D-Bus a lot harder.<br><br>For the error part we will use org.bluez.Error and not EFailed or<br>anything like this. Since all the error stuff is currently not used, I
<br>don't think it is a good idea to add it to the initial patch. Looking at<br>HAL the use of org.bluez.NoSuchDevice, etc. seems to make sense, too.<br><br>Do we really need that service_table_t thingy now? I think we should
<br>start without it.<br><br>Regards<br><br>Marcel<br><br><br><br><br>-------------------------------------------------------<br>This SF.Net email is sponsored by:<br>Power Architecture Resource Center: Free content, downloads, discussions,
<br>and more. <a href="http://solutions.newsforge.com/ibmarch.tmpl">http://solutions.newsforge.com/ibmarch.tmpl</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br><br clear="all"><br>-- <br>
---------------------------------------------------------<br>Claudio Takahasi<br>Nokia's Institute of Technology - INdT<br><a href="mailto:claudio.takahasi@indt.org.br">claudio.takahasi@indt.org.br</a><br>



------=_Part_4060_6309862.1128429212132--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
