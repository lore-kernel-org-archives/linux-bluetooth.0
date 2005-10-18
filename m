Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510180522l33037a86rbd0231a3ba1b7201@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7645_28697545.1129638166900"
Subject: [Bluez-devel] kernel/userspace communication interface
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
Date: Tue, 18 Oct 2005 10:22:46 -0200

------=_Part_7645_28697545.1129638166900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

You wrote in an old email that a new communication interface between
the kernel and the userspace has been developed.

Could you give us more information about that? What is the status, how
it will work...

We are facing some problems related to blocking operations(eg: remote
name request and inquiry.) in the BlueZ D-Bus services.

The hcid D-Bus main loop can't be blocked and we wouldn't like open
another hci raw socket.

Regards,
Claudio.

--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_7645_28697545.1129638166900
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
You wrote in an old email that a new communication interface between <br>
the kernel and the userspace has been developed. <br>
<br>
Could you give us more information about that? What is the status, how <br>
it will work...<br>
<br>
We are facing some problems related to blocking operations(eg: remote <br>
name request and inquiry.) in the BlueZ D-Bus services.<br>
<br>
The hcid D-Bus main loop can't be blocked and we wouldn't like open <br>
another hci raw socket.<br>
<br>
Regards,<br>
Claudio.<br>
<br>-- <br>---------------------------------------------------------<br>Cla=
udio Takahasi<br>Nokia's Institute of Technology - INdT<br><a href=3D"mailt=
o:claudio.takahasi@indt.org.br">claudio.takahasi@indt.org.br</a><br>

------=_Part_7645_28697545.1129638166900--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
