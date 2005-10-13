Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510130606n474e5f9i4c66d99d245a388@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2737_9283381.1129208807115"
Subject: [Bluez-devel] [D-BUS] open questions
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
Date: Thu, 13 Oct 2005 10:06:47 -0300

------=_Part_2737_9283381.1129208807115
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,


I exchanged some ideas with Johan Hedberg yesterday and I would like receiv=
e
feedbacks from bluez-devel list. Johan, if I forget mention any subject or
wrote something wrong fix me :)


1. HCI signals
Currently, we have the fllowing signals:
- InquiryStart
- InquiryComplete
- InquiryResult
- RemoteName
These signals are being sent in the path /org/bluez/Manager/Controller, and
interface org.bluez.Manager.Controller

We have to keep in mind that we need define clean interfaces and paths to
the CLIENTS applications. The clients can define filters based on paths,
interfaces, message types, and member name(service name).

Johan suggested send the signals to device id based paths and remove local
BT address from the message argument t. eg:
/og/bluez/Manager/hci0/Controller



2. Object path
We didn't close this discussion. According with the D-Bus guys the characte=
r
":" is not allowed and the character "-" requires a unstable patch.

I would like define a hierarchical path approach, because it make possible
the parent level path handle messages sent to a unregistered child. eg the
/org/bluez/Manager can handle messages sent to
/org/bluez/Manager/hci2/Controller and return an error message to the clien=
t
instead of return unknown service.
Another aspect is: if we define an hierarchical paths, it's easier find
sub-paths and unregister them when we need. eg: unregistering all paths
related to the hci2 device. The D-Bus function
dbus_connection_list_registered can list the registered fallback handlers
and object path handlers at the given parent path, eg:
/org/bluez/Manager/hci2

The hci0, hci1, ... ids can change if you remove the dongle. Using the
device address like AA_BB_CC_DD_EE_FF we will not have this problem.
Remember that we are using the hci_dbus_data struct to store the device id,
It will not be necessary extract the BT address from the path for every
receive message. Therefore we can ignore this overhead.


3. DeviceList content
Johan Question:
If we device a bluetooth device address based path, which format we have to
use in the device address field of the DeviceList service? AA_BB_CC_DD_EE_F=
F
or AA:BB:CC:DD:EE:FF?

In my opinion we can keep the original Bluetooth address format if we
provide a method to list all registered paths to a given device.

4. Where return the registered paths?
We need define a service to get all registered paths. My initial idea was
provide a Introspect method that could return a XML description. However,
Marcel wrote that can be heavy parse the content. Another approach is
provide a simple service that return an array of strings containing the
registered paths. The input argument could be the parent path and the retur=
n
value will be all child paths.




Regards,
Claudio
--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_2737_9283381.1129208807115
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,<br>
<br>
<br>
I exchanged some ideas with Johan Hedberg yesterday and I would like
receive feedbacks from bluez-devel list. Johan, if I forget mention any
subject or wrote something wrong fix me :)<br>
<br>
<br>
1. HCI signals <br>
&nbsp;&nbsp; Currently, we have the fllowing signals:<br>
&nbsp;&nbsp; - InquiryStart<br>
&nbsp;&nbsp; - InquiryComplete<br>
&nbsp;&nbsp; - InquiryResult<br>
&nbsp;&nbsp; - RemoteName<br>
&nbsp;&nbsp; These signals are being sent in the path /org/bluez/Manager/Co=
ntroller, and interface org.bluez.Manager.Controller<br>
<br>
We have to keep in mind that we need define clean interfaces and paths
to the CLIENTS&nbsp; applications. The clients can define filters based
on paths, interfaces, message types, and member name(service name).<br>
<br>
Johan suggested send the signals to device id based paths and remove
local BT address from the message argument t. eg:
/og/bluez/Manager/hci0/Controller<br>
<br>
<br>
<br>
2. Object path<br>
&nbsp;&nbsp; We didn't close this discussion. According with the D-Bus
guys the character &quot;:&quot; is not allowed and the character &quot;-&q=
uot; requires a
unstable patch.<br>
<br>
I would like define a hierarchical path approach, because it make
possible the parent level path handle messages sent to a unregistered
child. eg the /org/bluez/Manager can handle messages sent to
/org/bluez/Manager/hci2/Controller and return an error message to the
client instead of return unknown service.<br>
Another aspect is: if we define an hierarchical paths, it's easier find
sub-paths and unregister them when we need. eg: unregistering all paths
related to the hci2 device. The D-Bus function
dbus_connection_list_registered can list the registered fallback
handlers and object path handlers at the given parent path, eg:
/org/bluez/Manager/hci2<br>
<br>
The hci0, hci1, ... ids can change if you remove the dongle. Using the
device address like AA_BB_CC_DD_EE_FF we will not have this problem. <br>
Remember that we are using the hci_dbus_data struct to store the device
id, It will not be necessary extract the BT address from the path for
every receive message. Therefore we can ignore this overhead.<br>
<br>
<br>
3. DeviceList content<br>
Johan Question:<br>
If we device a bluetooth device address based path, which format we
have to use in the device address field of the DeviceList service?
AA_BB_CC_DD_EE_FF or AA:BB:CC:DD:EE:FF?<br>
<br>
In my opinion we can keep the original Bluetooth address format if we
provide a method to list all registered paths to a given device.<br>
<br>
4. Where return the registered paths?<br>
We need define a service to get all registered paths. My initial idea
was provide a Introspect method that could return a XML description.
However, Marcel wrote that can be heavy parse the content. Another
approach is provide a simple service that return an array of strings
containing the registered paths. The input argument could be the parent
path and the return value will be all child paths.<br>
<br>
<br>
<br>
<br>
Regards,<br>
Claudio<br>-- <br>---------------------------------------------------------=
<br>Claudio Takahasi<br>Nokia's Institute of Technology - INdT<br><a href=
=3D"mailto:claudio.takahasi@indt.org.br">claudio.takahasi@indt.org.br</a><b=
r>

------=_Part_2737_9283381.1129208807115--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
