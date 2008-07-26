Return-Path: <cyrus@holtmann.org>
Message-ID: <eba8281a0807260826w7e695b6elfeeee5f7c4c3ec47@mail.gmail.com>
Date: Sat, 26 Jul 2008 16:26:34 +0100
From: "Valerio Valerio" <vdv100@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] PassKey Agent question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0793585248=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0793585248==
Content-Type: multipart/alternative;
	boundary="----=_Part_11785_10370883.1217085994227"

------=_Part_11785_10370883.1217085994227
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm doing a program that use bluetooth for  the OpenMoko phones, I need a
passkey agent to allow paring from some devices that resquest that, after I
wrote the a passKey agent I notice that by default the hcid.conf file in th=
e
OpenMoko file system have the security mode set to "auto", so my passkey
agent don't get called, if I change it to "user" everything works fine.
After some search I found a lot of confusing information so my questions ar=
e
:

- the Bluez-pin helper in no longer supported right ?
- By default the security mode is set to "auto" ?
- Is possible to change it with some bluez util or command ?

Thanks in advance.

Cheers,

--=20
Val=E9rio Val=E9rio

http://www.valeriovalerio.org

------=_Part_11785_10370883.1217085994227
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div dir=3D"ltr">Hi,<br><br>I&#39;m doing a program that use bluetooth for&=
nbsp; the OpenMoko phones, I need a passkey agent to allow paring from some=
 devices that resquest that, after I wrote the a passKey agent I notice tha=
t by default the hcid.conf file in the OpenMoko file system have the securi=
ty mode set to &quot;auto&quot;, so my passkey agent don&#39;t get called, =
if I change it to &quot;user&quot; everything works fine.<br>
After some search I found a lot of confusing information so my questions ar=
e :<br><br>- the Bluez-pin helper in no longer supported right ?<br>- By de=
fault the security mode is set to &quot;auto&quot; ?<br>- Is possible to ch=
ange it with some bluez util or command ?<br>
<br>Thanks in advance.<br><br>Cheers, <br clear=3D"all"><br>-- <br>Val=E9ri=
o Val=E9rio<br><br><a href=3D"http://www.valeriovalerio.org">http://www.val=
eriovalerio.org</a><br>
</div>

------=_Part_11785_10370883.1217085994227--


--===============0793585248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0793585248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0793585248==--
