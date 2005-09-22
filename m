Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05092209516bbcb31a@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid D-Bus patch
In-Reply-To: <1127398647.5344.24.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8734_11503243.1127407865649"
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127292701.495.11.camel@localhost.localdomain>
	 <e1effdeb05092105492fce2ff2@mail.gmail.com>
	 <1127398647.5344.24.camel@blade>
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
Date: Thu, 22 Sep 2005 13:51:05 -0300

------=_Part_8734_11503243.1127407865649
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Regarding the shared code I will analize the shared functions
and move to the common directory.


The D-Bus error is a message created based on a received message.
There are 4 message types:
1. method call message
2. method reply message
3. error message
4. signal

First of all you have to understand the difference bus name, path and
interface. Read http://dbus.freedesktop.org/doc/dbus-faq.html#id2778454
for more information. There is a FAQ with this topic.

In my opinion is better associate a "method" as a "service" this analogy
is more clear. They use method just to pass the idea of object oriented
programming. Where the object is the instance of a class that provides
several services and the method is just one service(function).

In a usage scenario, a client will request a service using a method
call message. The result (method reply or error message) will be
received only by the requestor because the reply or the error are
created based on the received message header infos.
It's possible send a method reply containing an argument with an error
code and ignore the usage of error messages. But this is not a good
programming practise because there are D-Bus functions to work with
error messages. These functions make possible compare the error NAME
without extract the other arguments embedded in the message.

After this discussion I would suggest the following structure:

>>> Message Error Names:
org.bluez.EFailed
org.bluez.ENoMemory
/* open to more error names */

>>>org.bluez.EFailed
This error message will have the signature(string+uint16+uint32).
Where the first argument is the error description. The second is
the error class and the third is the error code.
The error class can be system error, D-Bus error or HCI errors.
This structure mane possible return to the app clients any kind of
error. System error includes socket error, IO, ENODEV... D-Bus error
includes no service, no connection, security error and no method found.
HCI errors are listed in the bluetooth specification.

Maybe someone could ask why not bind the error to the profiles/bluez daemon
like org.bluez.hci.EFailed, org.bluez.sdp.EFailed, org.bluez.pan.EFailed.
Add an extra information(like the profile) in the message error
doesn't add relevant information because the error messages will be receive=
d
only by the requestor.

Regards,
Claudio


On 9/22/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > I will analize our comments.
> >
> > service_table_t and the function create_error_reply_message will be
> > shared by other profiles(pan, hid, rfcomm, ...)
> > this the reason to put in the dbus-internal.h file.
>
> if this is shared code then I like to have it in the common/ toplevel
> directory. We should create the files dbus.[ch] and then use them from
> there.
>
> > Regarding the Bluetooth error codes, we can add the code in the D-Bus
> > error messages as a argument. My proposal
> > is use a standard like this:
> >
> > org.bluez.hci.error.UnknowMethod
> > org.bluez.hci.error.WrongSignature
> > org.bluez.hci.error.WrongParam
> > org.bluez.hci.error.Failed /* here we can add the bluetooth error
> > code */
> > org.bluez.hci.error.Busy
> > org.bluez.hci.error.NoDevFound
> >
> > I will send a new path soon.
>
> So a D-Bus error is always a method? I would simply use a general error
> with an identifier number. Help me out here to understand what is the
> best way to represent the errors.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
> own Sony(tm)PSP. Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_8734_11503243.1127407865649
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
Regarding the shared code I will analize the shared functions<br>
and move to the common directory.<br>
<br>
<br>
The D-Bus error is a message created based on a received message.<br>
There are 4 message types:<br>
1. method call message<br>
2. method reply message<br>
3. error message<br>
4. signal<br>
<br>
First of all you have to understand the difference bus name, path and <br>
interface. Read <a href=3D"http://dbus.freedesktop.org/doc/dbus-faq.html#id=
2778454">http://dbus.freedesktop.org/doc/dbus-faq.html#id2778454</a><br>
for more information. There is a FAQ with this topic.<br>
<br>
In my opinion is better associate a &quot;method&quot; as a &quot;service&q=
uot; this analogy <br>
is more clear. They use method just to pass the idea of object oriented<br>
programming. Where the object is the instance of a class that provides <br>
several services and the method is just one service(function).<br>
<br>
In a usage scenario, a client will request a service using a method<br>
call message. The result (method reply or error message) will be <br>
received only by the requestor because the reply or the error are <br>
created based on the received message header infos.<br>
It's possible send a method reply containing an argument with an error<br>
code and ignore the usage of error messages. But this is not a good<br>
programming practise because there are D-Bus functions to work with<br>
error messages. These functions make possible compare the error NAME<br>
without extract the other arguments embedded in the message.<br>
<br>
After this discussion I would suggest the following structure:<br>
<br>
&gt;&gt;&gt; Message Error Names:<br>
org.bluez.EFailed<br>
org.bluez.ENoMemory<br>
/* open to more error names */<br>
<br>
&gt;&gt;&gt;org.bluez.EFailed<br>
This error message will have the signature(string+uint16+uint32).<br>
Where the first argument is the error description. The second is<br>
the error class and the third is the error code.<br>
The error class can be system error, D-Bus error or HCI errors.<br>
This structure mane possible return to the app clients any kind of <br>
error. System error includes socket error, IO, ENODEV... D-Bus error<br>
includes no service, no connection, security error and no method found.<br>
HCI errors are listed in the bluetooth specification.<br>
<br>
Maybe someone could ask why not bind the error to the profiles/bluez daemon=
<br>
like org.bluez.hci.EFailed, org.bluez.sdp.EFailed, org.bluez.pan.EFailed. <=
br>
Add an extra information(like the profile) in the message error <br>
doesn't add relevant information because the error messages will be receive=
d<br>
only by the requestor.<br>
<br>
Regards,<br>
Claudio<br>
<br><br><div><span class=3D"gmail_quote">On 9/22/05, <b class=3D"gmail_send=
ername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marc=
el@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
Hi Claudio,<br><br>&gt; I will analize our comments.<br>&gt;<br>&gt; servic=
e_table_t and the function create_error_reply_message will be<br>&gt; share=
d by other profiles(pan, hid, rfcomm, ...)<br>&gt; this the reason to put i=
n the=20
dbus-internal.h file.<br><br>if this is shared code then I like to have it =
in the common/ toplevel<br>directory. We should create the files dbus.[ch] =
and then use them from<br>there.<br><br>&gt; Regarding the Bluetooth error =
codes, we can add the code in the D-Bus
<br>&gt; error messages as a argument. My proposal<br>&gt; is use a standar=
d like this:<br>&gt;<br>&gt; org.bluez.hci.error.UnknowMethod<br>&gt; org.b=
luez.hci.error.WrongSignature<br>&gt; org.bluez.hci.error.WrongParam<br>
&gt; org.bluez.hci.error.Failed&nbsp;&nbsp;/* here we can add the bluetooth=
 error<br>&gt; code */<br>&gt; org.bluez.hci.error.Busy<br>&gt; org.bluez.h=
ci.error.NoDevFound<br>&gt;<br>&gt; I will send a new path soon.<br><br>So =
a D-Bus error is always a method? I would simply use a general error
<br>with an identifier number. Help me out here to understand what is the<b=
r>best way to represent the errors.<br><br>Regards<br><br>Marcel<br><br><br=
><br><br>-------------------------------------------------------<br>SF.Net
 email is sponsored by:<br>Tame your development challenges with Apache's G=
eronimo App Server.<br>Download it for free - -and be entered to win a 42&q=
uot; plasma tv or your very<br>own Sony(tm)PSP.&nbsp;&nbsp;Click here to pl=
ay: <a href=3D"http://sourceforge.net/geronimo.php">
http://sourceforge.net/geronimo.php</a><br>________________________________=
_______________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-deve=
l@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=
=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br>

------=_Part_8734_11503243.1127407865649--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
