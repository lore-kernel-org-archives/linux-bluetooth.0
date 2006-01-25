Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <6916dea20601251400g667d13edm@mail.gmail.com>
From: Alexandre Passito <alexandre.passito@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17614_31353637.1138226429459"
Subject: [Bluez-users] Problem trying to connect second PANU
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 25 Jan 2006 20:00:29 -0200

------=_Part_17614_31353637.1138226429459
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have 3 laptop computers running Debian Linux Kernel 2.6 and Bluez. My
scenario is as following:

PANU1------->GN<----------PANU2

I created the connection by:

GN:
pand --listen --role GN
ifconfig bnep0 10.0.0.1

PANU1
pand --connect <GN_ADDR>
ifconfig bnep0 10.0.0.2

This connection went well and I "pinged" both each other.

So, I tried to connect the PANU2 to GN by:
pand --connect <GN_ADDR>
ifconfig bnep0 10.0.0.3

But I could not ping GN (10.0.0.1) anymore from PANU2.
I tried to ifconfig bnep1 10.0.0.4 and ping it from PANU2 and no answer too=
.
So the second slave to the piconet is no established (the first one is ok
yet).

Can you help me?

Best regards,

Passito

--
Alexandre Passito - Estudante de Mestrado
Universidade Federal do Amazonas (UFAM)
Departamento de Ci=EAncia da Computa=E7=E3o (DCC)
E-mail: passito at dcc.ufam.edu.br
Web: www.dcc.ufam.edu.br/~passito
Manaus - AM - Brasil
--
Alexandre Passito - M.Sc. Student
Federal University of Amazonas (UFAM)
Computer Science Department (DCC)
E-mail: passito at dcc.ufam.edu.br/
Web: www.dcc.ufam.edu.br/~passito
Manaus - AM - Brazil

------=_Part_17614_31353637.1138226429459
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I have 3 laptop computers running Debian Linux Kernel 2.6 and Bluez. My sce=
nario is as following:<br>
<br>
PANU1-------&gt;GN&lt;----------PANU2<br>
<br>
I created the connection by:<br>
<br>
GN:<br>
pand --listen --role GN<br>
ifconfig bnep0 <a href=3D"http://10.0.0.1">10.0.0.1</a><br>
<br>
PANU1<br>
pand --connect &lt;GN_ADDR&gt;<br>
ifconfig bnep0 <a href=3D"http://10.0.0.2">10.0.0.2</a><br>
<br>
This connection went well and I &quot;pinged&quot; both each other.<br>
<br>
So, I tried to connect the PANU2 to GN by:<br>
pand --connect &lt;GN_ADDR&gt;<br>

ifconfig bnep0 <a href=3D"http://10.0.0.3">10.0.0.3</a><br>
<br>
But I could not ping GN (<a href=3D"http://10.0.0.1">10.0.0.1</a>) anymore =
from PANU2.<br>
I tried to ifconfig bnep1 <a href=3D"http://10.0.0.4">10.0.0.4</a> and ping=
 it from PANU2 and no answer too.<br>
So the second slave to the piconet is no established (the first one is ok y=
et).<br>
<br>
Can you help me?<br>
<br>
Best regards,<br>
<br>
Passito<br>
<br>-- <br>Alexandre Passito - Estudante de Mestrado<br>Universidade Federa=
l do Amazonas (UFAM)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>De=
partamento de Ci=EAncia da Computa=E7=E3o (DCC)&nbsp;&nbsp;<br>E-mail: pass=
ito at <a href=3D"http://dcc.ufam.edu.br">dcc.ufam.edu.br
</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>Web: <a href=3D"http://www.dcc=
.ufam.edu.br/~passito">www.dcc.ufam.edu.br/~passito</a>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>Manaus - AM - Brasil&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>--<br>Alexandre Passit=
o - M.Sc. Student&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>Federa=
l University of Amazonas (UFAM)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;
<br>Computer Science Department (DCC)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>E-mail: passito at <a href=3D"http:/=
/dcc.ufam.edu.br/">dcc.ufam.edu.br/</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 <br>Web: <a href=3D"http://www.dcc.ufam.edu.br/~passito">www.dcc.ufam.edu.=
br/~passito</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>Manaus - AM - Brazil&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>

------=_Part_17614_31353637.1138226429459--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
