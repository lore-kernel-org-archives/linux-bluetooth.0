Return-Path: <cyrus@holtmann.org>
Message-ID: <8f5c4ad0802110348m6e4da93aw2d227f909e9a6adf@mail.gmail.com>
Date: Mon, 11 Feb 2008 17:18:48 +0530
From: "george keane" <chemvell@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Unknown HCI packet type 00
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1654188098=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1654188098==
Content-Type: multipart/alternative;
	boundary="----=_Part_28100_2316223.1202730528186"

------=_Part_28100_2316223.1202730528186
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  Hi all,
   I am using bluez with an ARM platform...my BT module is connected through
the UART...when I call

hciattach ttyS1 any 115200...the output is something like this...

hci_uart_tty_open: tty c1e5c800
hci_uart_tty_ioctl:
hci_uart_register_dev:
h4_recv: Unknown HCI packet type 00

           " hciconfig " says device is DOWN and "hciconfig hci0 up "fails
and says "Cant init device Connection timed out'
 Can somebody help me out??/

Thanks in advance....
Warm Regards,
G.K.

------=_Part_28100_2316223.1202730528186
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&nbsp; Hi all,<br>&nbsp;&nbsp; I am using bluez with an ARM platform...my BT module is connected through the UART...when I call<br><br>hciattach ttyS1 any 115200...the output is something like this...<br><br>hci_uart_tty_open: tty c1e5c800<br>
hci_uart_tty_ioctl:<br>hci_uart_register_dev:<br>h4_recv: Unknown HCI packet type 00<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; hciconfig &quot; says device is DOWN and &quot;hciconfig hci0 up &quot;fails and says &quot;Cant init device Connection timed out&#39; <br>
&nbsp;Can somebody help me out??/<br><br>Thanks in advance....<br>Warm Regards,<br>G.K.<br><br><br>

------=_Part_28100_2316223.1202730528186--


--===============1654188098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1654188098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1654188098==--
