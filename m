Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510250505k4dd1cae6r3d7994c4d106c15f@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Device Configuration D-Bus services
In-Reply-To: <1130189692.7840.21.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5307_2220572.1130241940854"
References: <e1effdeb0510190606x50364b25y52a5092847000105@mail.gmail.com>
	 <3013cac80510241400k2b71125ao7b8b4dfe5077a300@mail.gmail.com>
	 <1130189692.7840.21.camel@blade>
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
Date: Tue, 25 Oct 2005 10:05:40 -0200

------=_Part_5307_2220572.1130241940854
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Basically the services under the path "/org/bluez/Devices" will
provide a way to userspace applications setup the devices, a similar
functionality provided by hciconfig. The security issues will be handled by
the D-Bus configuration file.

Regarding the SetProperty/GetProperty...
There are a lot of commands that we intend provide: up, down, reset, rstat,
auth, noauth, encrypt, ....
My initial suggestion was divide the services into TWO groups:
* Device independant, path: /org/bluez/Devices, interface: path:
org.bluez.Devices
Services:
- Up
- Down
- Reset

* Device Based services, path: /org/bluez/Devices/hciX, interface: path:
org.bluez.Devices
Services:
- auth
- noauth
- encrypt
- noencrypt
- secmgr
- nosecmgr
- piscan
- noscan
- iscan
- pscan
...

In order to make the API more clean, the device based services will use the
method
name(SerProperty/GetProperty), where the first message argument is the
command
identification (auth, noauth, encrypt,...)

The question is: if we use an String representation of the command the
client coding
will be more "legible" by other hand the hcid message argument
extracting/comparison
will be more expensive than extract a byte or a integer. Which approach do
you prefer?

Regards,
Claudio



On 10/24/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Eduardo,
>
> > here is the initial patch regarding /org/bluez/Devices. I keep it
> > really simple so we can improve it in small steps. I've merged the
> > Claudio's code for register and unregister a new path for a device in
> > two funcions as this code is used in 3 different parts of the code.
>
> call it *register_device() and *register_manager().
>
> > For now I've leaved the syslog call to register and unregister
> > operations so we can see if every thing is going ok.
>
> I think it is a good idea to introduce some DBG() defines.
>
> > My next step is to provide a list of registed devices (not only the
> > devices that are up) through /org/bluez/Devices path.
>
> Feel free to send another patch on top of this one.
>
> > One question: the SetProperty and GetProperty will use an interger or
> > a string constant to determing which operation will be used?
>
> You need to explain to me what you are talking about.


Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training Course
> Free Certification Exam for All Training Attendees Through End of 2005
> Visit http://www.jboss.com/services/certification for more information
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_5307_2220572.1130241940854
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>

<br>

Basically the services under the path &quot;/org/bluez/Devices&quot; will<b=
r>

provide a way to userspace applications setup the devices, a similar <br>
functionality provided by hciconfig. The security issues will be handled by=
 <br>
the D-Bus configuration file.<br>
<br>
Regarding the SetProperty/GetProperty... <br>
There are a lot of commands that we intend provide: up, down, reset, rstat,=
 auth, noauth, encrypt, ....<br>
My initial suggestion was divide the services into TWO groups:<br>
* Device independant, path: /org/bluez/Devices, interface: path: org.bluez.=
Devices<br>
&nbsp;&nbsp; Services:<br>
&nbsp;&nbsp;&nbsp; - Up<br>
&nbsp;&nbsp;&nbsp; - Down<br>
&nbsp;&nbsp;&nbsp; - Reset<br>
<br>
* Device Based services, path: /org/bluez/Devices/hciX, interface: path: or=
g.bluez.Devices<br>
&nbsp; Services:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - auth<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - noauth<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - encrypt<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - noencrypt<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - secmgr<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - nosecmgr<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - piscan <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - noscan<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - iscan<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - pscan<br>
&nbsp;...<br>
<br>
In order to make the API more clean, the device based services will use the=
 method <br>
name(SerProperty/GetProperty), where the first message argument is the comm=
and <br>
identification (auth, noauth, encrypt,...)<br>
<br>
The question is: if we use an String representation of the command the clie=
nt coding <br>
will be more &quot;legible&quot; by other hand the hcid message argument ex=
tracting/comparison<br>
will be more expensive than extract a byte or a integer. Which approach do =
you prefer?<br>
<br>
Regards,<br>
Claudio<br>
<br>
<br>
<br><div><span class=3D"gmail_quote">On 10/24/05, <b class=3D"gmail_sendern=
ame">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@=
holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Hi Eduardo,<br><br>&gt; here is the initial patch regarding /org/bluez/Devi=
ces. I keep it<br>&gt; really simple so we can improve it in small steps. I=
've merged the<br>&gt; Claudio's code for register and unregister a new pat=
h for a device in
<br>&gt; two funcions as this code is used in 3 different parts of the code=
.<br><br>call it *register_device() and *register_manager().<br><br>&gt; Fo=
r now I've leaved the syslog call to register and unregister<br>&gt; operat=
ions so we can see if every thing is going ok.
<br><br>I think it is a good idea to introduce some DBG() defines.<br><br>&=
gt; My next step is to provide a list of registed devices (not only the<br>=
&gt; devices that are up) through /org/bluez/Devices path.<br><br>Feel free=
 to send another patch on top of this one.
<br><br>&gt; One question: the SetProperty and GetProperty will use an inte=
rger or<br>&gt; a string constant to determing which operation will be used=
?<br><br>You need to explain to me what you are talking about.</blockquote>
<div>&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left=
: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1e=
x;">Regards<br>
  <br>
Marcel<br>
<br><br><br><br>-------------------------------------------------------<br>=
This SF.Net email is sponsored by the JBoss Inc.<br>Get Certified Today * R=
egister for a JBoss Training Course<br>Free Certification Exam for All Trai=
ning Attendees Through End of 2005
<br>Visit <a href=3D"http://www.jboss.com/services/certification">http://ww=
w.jboss.com/services/certification</a> for more information<br>____________=
___________________________________<br>Bluez-devel mailing list<br><a href=
=3D"mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br><br clear=3D"all"><br>-- <br=
>
---------------------------------------------------------<br>Claudio Takaha=
si<br>Instituto Nokia de Tecnologia - INdT

------=_Part_5307_2220572.1130241940854--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
