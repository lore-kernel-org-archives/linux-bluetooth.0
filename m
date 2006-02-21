Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9098730.1140507906477.JavaMail.tomcat@pne-ps5-sn2>
From: <ari.paavilainen@pp.inet.fi>
To: bluez-devel@lists.sourceforge.net
Subject: Vs: Re: [Bluez-devel] sdp_record_register()
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_36273_14229281.1140507906476"
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
Date: Tue, 21 Feb 2006 08:45:06 +0100 (MET)

------=_Part_36273_14229281.1140507906476
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

----Alkuper=C3=A4inen viesti----L=C3=A4hett=C3=A4j=C3=A4: ashuang@gmail.com=
P=C3=A4iv=C3=A4m=C3=A4=C3=A4r=C3=A4: Feb 20, 2006 5:18:33 PMVastaanottaja: =
bluez-devel@lists.sourceforge.netAihe: Re: [Bluez-devel] sdp_record_registe=
r()I found following thing in sdp_record_register():The comment in source c=
ode tells that the function returns non-null pointer onsuccess and -1 on fa=
ilure. I have investigated the code and found out that thefunction returns =
only 0 or -1:> what version of bluez are you using?  The latest versions do=
n't say this, in either sdp.h or sdp_lib.hThe version of bluez is 2.10 (the=
 one which you get when you google 'sdp_record_register').-Ari
------=_Part_36273_14229281.1140507906476
Content-Type: text/html;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br/><br/><blockquote><br/>----Alkuper=C3=A4inen viesti----<br/>L=C3=A4hett=
=C3=A4j=C3=A4: ashuang@gmail.com<br/>P=C3=A4iv=C3=A4m=C3=A4=C3=A4r=C3=A4: F=
eb 20, 2006 5:18:33 PM<br/>Vastaanottaja: bluez-devel@lists.sourceforge.net=
<br/>Aihe: Re: [Bluez-devel] sdp_record_register()<br/><br/><br/><br/><div>=
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I found following=
 thing in sdp_record_register():<br/><br/>The comment in source code tells =
that the function returns non-null pointer on<br/>success and -1 on failure=
. I have investigated the code and found out that the<br/>function returns =
only 0 or -1:</blockquote><div><br/><br/>> what version of bluez are you us=
ing?&nbsp; The latest versions don't say this, in either sdp.h or sdp_lib.h=
<br/><br/><br/>The version of bluez is 2.10 (the one which you get when you=
 google 'sdp_record_register').<br/><br/>-Ari
------=_Part_36273_14229281.1140507906476--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
