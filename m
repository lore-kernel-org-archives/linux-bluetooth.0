Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44ECF9CD.9010803@illokken.net>
Date: Thu, 24 Aug 2006 02:58:53 +0200
From: =?ISO-8859-1?Q?H=E5var_Nielsen?= <havar@illokken.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Logitech V270 mouse
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

The Logitech V270 is hard to connect. My experience says, authentication =

and encryption must be disabled. And connecting using hcitool seems =

impossible. It _sometimes_ connects, using 'hidd --search' or 'hidd =

--connect xx:xx:xx:xx:xx:xx'

These kind of devices should connect automatically (and about instantly) =

once you turn them on - within the range of the bluetooth device in the =

computer. So there should be some kind of daemon "listening" for the =

device and connecting it upon the event of discovery. This is also how =

it works under windows.

kubuntu dapper 6.06
linux 2.6.15-23-386
bluez-utils 2.24

Regards,
H=E5var Nielsen


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
