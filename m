Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05092607273355fded@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid D-Bus patch(Error Messages)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2219_11917895.1127744835678"
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
Date: Mon, 26 Sep 2005 11:27:15 -0300

------=_Part_2219_11917895.1127744835678
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Returning to error messages discussion. Some common errors like EIO(5), and
ENODEV(19) will conflict with Bluetooth failure error codes.
We have three possible solutions:

1. Define different error names. Like:
- org.bluez.HCIError signature: sq(string+uint16)
- org.bluez.DBusError signature: sq(string+uint16)
- org.bluez.SystemError signature: sq(string+uint32)
- org.bluez.ENoMemory(is it necessary? There isn't system code to indicate
it, but
we can consider it as a DBusError because it will be triggered by D-Bus
message
allocation)

2. Use error ranges
Define only one error message name(org.bluez.EFailed), signature: sq
- 0x0000 - 0x00FF Bluetooth error codes
- 0x0100 - 0x01FF D-Bus errors
- 0x0200 - 0x02FF System errors (0x0200 + system error value)
- 0x0300 - 0xFFFF reserved to future error classes

3. Use an extra parameter in the message to indicates the class
Define only one error message name(org.bluez.EFailed), signature: sqq.
But you didn't like this approach.

Please choose one of this alternative to finish this discussion. According
with the last email about errors, you suggested the second approach. But, d=
o
you
agree with this way of handle system errors?

Regards,
Claudio.

On 9/22/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > Regarding the shared code I will analize the shared functions
> > and move to the common directory.
> >
> >
> > The D-Bus error is a message created based on a received message.
> > There are 4 message types:
> > 1. method call message
> > 2. method reply message
> > 3. error message
> > 4. signal
> >
> > First of all you have to understand the difference bus name, path and
> > interface. Read
> > http://dbus.freedesktop.org/doc/dbus-faq.html#id2778454
> > for more information. There is a FAQ with this topic.
>
> this is one of my basic problems with D-Bus and object oriented
> programming in general. They try to abstract and solve everything and
> this is not working. The reality is always different. We now need to
> find a way to make it usable in a sane way.
>
> > After this discussion I would suggest the following structure:
> >
> > >>> Message Error Names:
> > org.bluez.EFailed
> > org.bluez.ENoMemory
> > /* open to more error names */
> >
> > >>>org.bluez.EFailed
> > This error message will have the signature(string+uint16+uint32).
> > Where the first argument is the error description. The second is
> > the error class and the third is the error code.
> > The error class can be system error, D-Bus error or HCI errors.
> > This structure mane possible return to the app clients any kind of
> > error. System error includes socket error, IO, ENODEV... D-Bus error
> > includes no service, no connection, security error and no method
> > found.
> > HCI errors are listed in the bluetooth specification.
>
> We have three different categories of errors. The Bluetooth errors
> defined in the specification. They are the same for the complete HCI.
> Then we have the Unix/Linux error codes (errno) and we will have
> additional codes defined by us. I don't like the idea of splitting the
> errors into classes. This is confusing and not a nice API. We should
> choose a base for the errors and these should be the Bluetooth error
> codes defined in the HCI part specification. So for my point of view an
> error org.bluez.error with string+uint16 is enough. The range 0x00-0xff
> will be used by the Bluetooth errors and we define the rest for specific
> errors that are currently not covered by the specification. This means
> we have to match the Unix/Linux error codes somehow, but I don't see any
> problems with that.
>
> Regards
>
> Marcel
>
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

------=_Part_2219_11917895.1127744835678
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
Returning to error messages discussion. Some common errors like EIO(5), and=
<br>
ENODEV(19) will conflict with Bluetooth failure error codes. <br>
We have three possible solutions:<br>
<br>
1. Define different error names. Like: <br>
&nbsp;&nbsp; - org.bluez.HCIError signature: sq(string+uint16) <br>
&nbsp;&nbsp; - org.bluez.DBusError signature: sq(string+uint16)<br>
&nbsp;&nbsp; - org.bluez.SystemError signature: sq(string+uint32)<br>
&nbsp;&nbsp; - org.bluez.ENoMemory(is it necessary? There isn't system code=
 to indicate it, but <br>
&nbsp;&nbsp;&nbsp;&nbsp; we can consider it as a DBusError because it will =
be triggered by D-Bus message <br>
&nbsp;&nbsp;&nbsp;&nbsp; allocation)<br>
<br>
2. Use error ranges<br>
&nbsp;&nbsp; Define only one error message name(org.bluez.EFailed), signatu=
re: sq<br>
&nbsp;&nbsp; - 0x0000 - 0x00FF Bluetooth error codes<br>
&nbsp;&nbsp; - 0x0100 - 0x01FF D-Bus errors<br>
&nbsp;&nbsp; - 0x0200 - 0x02FF System errors (0x0200 + system error value)<=
br>
&nbsp;&nbsp; - 0x0300 - 0xFFFF reserved to future error classes<br>
<br>
3. Use an extra parameter in the message to indicates the class<br>
&nbsp;&nbsp; Define only one error message name(org.bluez.EFailed), signatu=
re: sqq.<br>
&nbsp;&nbsp; But you didn't like this approach.<br>
<br>
Please choose one of this alternative to finish this discussion. According =
<br>
with the last email about errors, you suggested the second approach. But, d=
o you <br>
agree with this way of handle system errors?<br>
<br>
Regards,<br>
Claudio.<br><br><div><span class=3D"gmail_quote">On 9/22/05, <b class=3D"gm=
ail_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.o=
rg">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
Hi Claudio,<br><br>&gt; Regarding the shared code I will analize the shared=
 functions<br>&gt; and move to the common directory.<br>&gt;<br>&gt;<br>&gt=
; The D-Bus error is a message created based on a received message.<br>
&gt; There are 4 message types:<br>&gt; 1. method call message<br>&gt; 2. m=
ethod reply message<br>&gt; 3. error message<br>&gt; 4. signal<br>&gt;<br>&=
gt; First of all you have to understand the difference bus name, path and
<br>&gt; interface. Read<br>&gt; <a href=3D"http://dbus.freedesktop.org/doc=
/dbus-faq.html#id2778454">http://dbus.freedesktop.org/doc/dbus-faq.html#id2=
778454</a><br>&gt; for more information. There is a FAQ with this topic.<br=
>
<br>this is one of my basic problems with D-Bus and object oriented<br>prog=
ramming in general. They try to abstract and solve everything and<br>this i=
s not working. The reality is always different. We now need to<br>find a wa=
y to make it usable in a sane way.
<br><br>&gt; After this discussion I would suggest the following structure:=
<br>&gt;<br>&gt; &gt;&gt;&gt; Message Error Names:<br>&gt; org.bluez.EFaile=
d<br>&gt; org.bluez.ENoMemory<br>&gt; /* open to more error names */<br>
&gt;<br>&gt; &gt;&gt;&gt;org.bluez.EFailed<br>&gt; This error message will =
have the signature(string+uint16+uint32).<br>&gt; Where the first argument =
is the error description. The second is<br>&gt; the error class and the thi=
rd is the error code.
<br>&gt; The error class can be system error, D-Bus error or HCI errors.<br=
>&gt; This structure mane possible return to the app clients any kind of<br=
>&gt; error. System error includes socket error, IO, ENODEV... D-Bus error
<br>&gt; includes no service, no connection, security error and no method<b=
r>&gt; found.<br>&gt; HCI errors are listed in the bluetooth specification.=
<br><br>We have three different categories of errors. The Bluetooth errors
<br>defined in the specification. They are the same for the complete HCI.<b=
r>Then we have the Unix/Linux error codes (errno) and we will have<br>addit=
ional codes defined by us. I don't like the idea of splitting the<br>errors=
 into classes. This is confusing and not a nice API. We should
<br>choose a base for the errors and these should be the Bluetooth error<br=
>codes defined in the HCI part specification. So for my point of view an<br=
>error org.bluez.error with string+uint16 is enough. The range 0x00-0xff
<br>will be used by the Bluetooth errors and we define the rest for specifi=
c<br>errors that are currently not covered by the specification. This means=
<br>we have to match the Unix/Linux error codes somehow, but I don't see an=
y
<br>problems with that.<br><br>Regards<br><br>Marcel<br><br><br><br><br><br=
>-------------------------------------------------------<br>SF.Net email is=
 sponsored by:<br>Tame your development challenges with Apache's Geronimo A=
pp Server.
<br>Download it for free - -and be entered to win a 42&quot; plasma tv or y=
our very<br>own Sony(tm)PSP.&nbsp;&nbsp;Click here to play: <a href=3D"http=
://sourceforge.net/geronimo.php">http://sourceforge.net/geronimo.php</a><br=
>_______________________________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_2219_11917895.1127744835678--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
