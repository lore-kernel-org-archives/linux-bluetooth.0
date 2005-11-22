Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7846f1440511221058lbfe6ff1g951ea529e4152af0@mail.gmail.com>
From: Arthur Chiu <arthurchiu@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_36243_2827856.1132685934398"
Subject: [Bluez-users] Create Services using BlueZ
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
Date: Tue, 22 Nov 2005 10:58:54 -0800

------=_Part_36243_2827856.1132685934398
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I am currently trying to create a server that will response to bluetooth
request. The client will be in Java. Since the client need to search for
devices and services before connecting, I need to create services on the
server side. I am trying to have the client sending "Hello World" to the
server.

My questions:
1) Can I create custom services like "hello world service" or it must be
from the list of services shown in sdptool? How can I do so?
2) Which test or sample tool contain example that handles service requests
(i saw sdptool only browses for services, not using them)
3) What kind of headers would I need to attach in front of data if I want t=
o
communicate with standard devices (like phones). I see in l2test.c that the
L2CAP format contains 4 bytes of sequence number and 2 bytes of data length=
.
What other information are there if I need to send things through SDP?
4) Does L2CAP data format (those headers) =3D ACL data format? If not, what=
's
the difference?

Thanks for spending time on all these questions.

Cheers,

Arthur

------=_Part_36243_2827856.1132685934398
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I am currently trying to create a server that will response to
bluetooth request. The client will be in Java. Since the client need to
search for devices and services before connecting, I need to create
services on the server side. I am trying to have the client sending
&quot;Hello World&quot; to the server.<br>
<br>
My questions:<br>
1) Can I create custom services like &quot;hello world service&quot; or it =
must
be from the list of services shown in sdptool? How can I do so?<br>
2) Which test or sample tool contain example that handles service
requests (i saw sdptool only browses for services, not using them)<br>
3) What kind of headers would I need to attach in front of data if I
want to communicate with standard devices (like phones). I see in
l2test.c that the L2CAP format contains 4 bytes of sequence number and
2 bytes of data length. What other information are there if I need to
send things through SDP? <br>
4) Does L2CAP data format (those headers) =3D ACL data format? If not, what=
's the difference? <br>
<br>
Thanks for spending time on all these questions. <br>
<br>
Cheers,<br>
<br>
&nbsp; Arthur<br>

------=_Part_36243_2827856.1132685934398--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
