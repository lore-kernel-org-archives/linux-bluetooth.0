Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510190606x50364b25y52a5092847000105@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1959_15563838.1129727167974"
Subject: [Bluez-devel] Device Configuration D-Bus services
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
Date: Wed, 19 Oct 2005 11:06:07 -0200

------=_Part_1959_15563838.1129727167974
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

I would like to bring up the device configuration services before start
coding, I would like design how these services will work and receive
comments.

The services provided under these paths/interfaces will not be public. Only
an administrator group or a root will be allowed to send messages. We don't
need care about the configuration file rules now, it can be defined later.

In my opinion it's better use the same approach of the Manager. A main path
object "/org/bluez/Manager" (FALLBACK) should catch messages sent to
unregistered
paths and handle services like:
- DeviceList, displays UP/DOWN devices
- UP
- DOWN
- RESET

The device based paths can provide services like:
- SetProperty
- GetProperty
- Commands
- Features

Using SetProperty/GetProperty instead of define one method name for each
property is more clean. However it is important keep in mind that the
documentation of this service must be well-defined, because the method
call/method reply arguments will have different argument number and types.
In the method call, the first argument must be a byte(faster comparison)
indicating the command code instead of use a string to represent the
command.

Suggested paths and Interfaces:
*** Main path
path:
/org/bluez/Devices
interface: org.bluez.Devices

*** Device based
path:
/org/bluez/Devices/hciX
interface: org.bluez.Devices


Another point is the message handler function. Currently, there is only one
function responsible for handle the messages. In my opinion it will be
better
create other DBusObjectPathVTable to address Device messages for make the
logic more clear. For SetProperty/GetProperty will be required extract the
first argument to get the command code in the message handle function.


Is everything ok? Any comments?

Regards,
Claudio.

--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_1959_15563838.1129727167974
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,<br>
<br>
I would like to bring up the device configuration services before start <br=
>
coding, I would like design how these services will work and receive commen=
ts.<br>
<br>
The services provided under these paths/interfaces will not be public. Only=
 <br>
an administrator group or a root will be allowed to send messages. We don't=
 <br>
need care about the configuration file rules now, it can be defined later.<=
br>
<br>
In my opinion it's better use the same approach of the Manager. A main path=
 <br>
object &quot;/org/bluez/Manager&quot; (FALLBACK) should catch messages sent=
 to unregistered <br>
paths and handle services like:<br>
- DeviceList, displays UP/DOWN devices<br>
- UP<br>
- DOWN<br>
- RESET<br>
<br>
The device based paths can provide services like:<br>
- SetProperty<br>
- GetProperty<br>
- Commands<br>
- Features<br>
<br>
Using SetProperty/GetProperty instead of define one method name for each<br=
>
property is more clean. However it is important keep in mind that the <br>
documentation of this service must be well-defined, because the method <br>
call/method reply arguments will have different argument number and types.<=
br>
In the method call, the first argument must be a byte(faster comparison)<br=
>
indicating the command code instead of use a string to represent the comman=
d.<br>
<br>
Suggested paths and Interfaces:<br>
*** Main path<br>
path:<br>
/org/bluez/Devices<br>
interface: org.bluez.Devices<br>
<br>
*** Device based<br>
path:<br>
/org/bluez/Devices/hciX<br>
interface: org.bluez.Devices<br>
<br>
<br>
Another point is the message handler function. Currently, there is only one=
 <br>
function responsible for handle the messages. In my opinion it will be bett=
er<br>
create other DBusObjectPathVTable to address Device messages for make the <=
br>
logic more clear. For SetProperty/GetProperty will be required extract the<=
br>
first argument to get the command code in the message handle function.<br>
<br>
<br>
Is everything&nbsp; ok? Any comments?<br>
<br>
Regards,<br>
Claudio.<br clear=3D"all"><br>-- <br>--------------------------------------=
-------------------<br>Claudio Takahasi<br>Nokia's Institute of Technology =
- INdT<br><a href=3D"mailto:claudio.takahasi@indt.org.br">claudio.takahasi@=
indt.org.br
</a><br>

------=_Part_1959_15563838.1129727167974--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
