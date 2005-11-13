Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <de37400f0511131010jd4ad2e1ucfcd2a70c69cf11f@mail.gmail.com>
From: Tomasz Urbanowicz <tomasz.urbanowicz@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8170_9946787.1131905433040"
Subject: [Bluez-devel] hci_usb.c - Reading SCO Data
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
Date: Sun, 13 Nov 2005 19:10:33 +0100

------=_Part_8170_9946787.1131905433040
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
 In the usb driver in the function hci_usb_open the
hci_usb_isoc_rx_submit<http://fxr.watson.org/fxr/ident?v=3Dlinux-2.6.9;i=3D=
hci_usb_isoc_rx_submit>function
is called
HCI_MAX_ISOC_RX<http://fxr.watson.org/fxr/ident?v=3Dlinux-2.6.9;i=3DHCI_MAX=
_ISOC_RX>times.
The latter function is responsible for submitting an URB to the
driver. In that function the request is made to read
mtu<http://fxr.watson.org/fxr/ident?v=3Dlinux-2.6.9;i=3Dmtu>*
HCI_MAX_ISOC_FRAMES<http://fxr.watson.org/fxr/ident?v=3Dlinux-2.6.9;i=3DHCI=
_MAX_ISOC_FRAMES>bytes
from the device where mtu is the usb packet size and equals 17.
HCI_MAX_ISOC_RX eaquals 2 and HCI_MAX_ISOC_FRAMES is set to 10. So summing
up in hci_usb_open two URBs are built and submitted each requesting 170
bytes from the device. Later they're resubmitted after completion. My
question is where did the values for HCI_MAX_ISOC_RX and HCI_MAX_ISOC_FRAME=
S
came from ? is there any special reason ? or would other values (e.g. three
URBs each requesting 51 bytes (3 bytes header + 48 bytes payload)) be
suitable as well.
 Thanks,
Tomasz

------=_Part_8170_9946787.1131905433040
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>In the usb driver in the function hci_usb_open the <a href=3D"http://f=
xr.watson.org/fxr/ident?v=3Dlinux-2.6.9;i=3Dhci_usb_isoc_rx_submit">hci_usb=
_isoc_rx_submit</a>&nbsp;function is called <a href=3D"http://fxr.watson.or=
g/fxr/ident?v=3Dlinux-2.6.9;i=3DHCI_MAX_ISOC_RX">
HCI_MAX_ISOC_RX</a>&nbsp;times. The latter function is responsible for subm=
itting an URB to the driver. In that function the request is made to&nbsp;r=
ead&nbsp;&nbsp;<a href=3D"http://fxr.watson.org/fxr/ident?v=3Dlinux-2.6.9;i=
=3Dmtu">mtu</a> * <a href=3D"http://fxr.watson.org/fxr/ident?v=3Dlinux-2.6.=
9;i=3DHCI_MAX_ISOC_FRAMES">
HCI_MAX_ISOC_FRAMES</a>&nbsp;bytes&nbsp;from the device where mtu is the us=
b&nbsp;packet size and equals 17.&nbsp;HCI_MAX_ISOC_RX&nbsp;eaquals 2 and H=
CI_MAX_ISOC_FRAMES is set to 10. So summing up&nbsp;in hci_usb_open two URB=
s are built and submitted&nbsp;each requesting 170 bytes from the device. L=
ater they're resubmitted after completion. My question is where did the val=
ues for&nbsp;&nbsp;&nbsp;HCI_MAX_ISOC_RX&nbsp; and&nbsp; HCI_MAX_ISOC_FRAME=
S came from ? is there any special reason ? or&nbsp; would other values (
e.g. three URBs each requesting 51 bytes (3 bytes header + 48 bytes payload=
)) be suitable as well.</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Tomasz</div>

------=_Part_8170_9946787.1131905433040--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
