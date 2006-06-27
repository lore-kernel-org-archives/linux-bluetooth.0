Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606270505v511be476t247bcfc16d451833@mail.gmail.com>
Date: Tue, 27 Jun 2006 17:35:54 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] Cross Compiling openobex
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1591956925=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1591956925==
Content-Type: multipart/alternative;
	boundary="----=_Part_26865_5798108.1151409954870"

------=_Part_26865_5798108.1151409954870
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am able to cross compile openobex-1.0.1 and openobex-apps-1.0.0 for ARM.
But when I try to compile the application ussp-push, I get the following
errors:

arm-linux-gcc -I/usr/local/include
-I/usr/include/glib-1.2-I/usr/lib/glib/include -c obex_main.c -o
obex_main.o
arm-linux-gcc -I/usr/local/include
-I/usr/include/glib-1.2-I/usr/lib/glib/include -c obex_socket.c -o
obex_socket.o
arm-linux-gcc obex_main.o obex_socket.o -L/usr/lib -lglib -L/usr/local/lib
/usr/local/arm/2.95.3/arm-linux/lib/libopenobex.a -o ussp-push
/usr/lib/libglib.so: could not read symbols: Invalid operation
collect2: ld returned 1 exit status


Does this mean that I have to compile glib also for ARM?

Thanks.
Regards,
Mayank

------=_Part_26865_5798108.1151409954870
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I am able to cross compile openobex-1.0.1 and openobex-apps-1.0.0 for ARM.</div>
<div>But when I try to compile the application ussp-push, I get the following errors:</div>
<div>&nbsp;</div>
<div>arm-linux-gcc -I/usr/local/include -I/usr/include/glib-1.2 -I/usr/lib/glib/include -c obex_main.c -o obex_main.o<br>arm-linux-gcc -I/usr/local/include -I/usr/include/glib-1.2 -I/usr/lib/glib/include -c obex_socket.c -o obex_socket.o
<br>arm-linux-gcc obex_main.o obex_socket.o -L/usr/lib -lglib -L/usr/local/lib /usr/local/arm/2.95.3/arm-linux/lib/libopenobex.a -o ussp-push<br>/usr/lib/libglib.so: could not read symbols: Invalid operation<br>collect2: ld returned 1 exit status
<br>&nbsp;</div>
<div>&nbsp;</div>
<div>Does this mean that I have to compile glib also for ARM?</div>
<div>&nbsp;</div>
<div>Thanks.</div>
<div>Regards,</div>
<div>Mayank</div>

------=_Part_26865_5798108.1151409954870--


--===============1591956925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1591956925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1591956925==--
