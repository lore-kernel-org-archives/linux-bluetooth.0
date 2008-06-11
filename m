Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0806110010v2d5db37di201da69e956e2194@mail.gmail.com>
Date: Wed, 11 Jun 2008 09:10:03 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] hidd and hidp
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0967257455=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0967257455==
Content-Type: multipart/alternative;
	boundary="----=_Part_12837_22042981.1213168203612"

------=_Part_12837_22042981.1213168203612
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!

is it right that the two components hidd (the daemon) and the kernel module
hidp (found in net/bluetooth/) work together in order to provide support for
Bluetooth Keyboards and other HID devices?
As far as I know hidd has been replaced, if yes with what?
And which role plays the Input service which is also an own folder in the
bluez-utils?

Anyway, the two components hidd and hidp provide HID support?
I took a look at hidd and hidp and found out that hidd listends for incoming
connections, if it gets one it forwards this connection to the kernel
modules hidp which adds it to its handlers. From there the kernel module
serves the connection and uses the well known input function input_event to
get the scancodes into the input system of linux.

So for a basic support of keyboards I only need hidd and hidp running?

Thanks...



-- 
Regards,
--Codefritz

------=_Part_12837_22042981.1213168203612
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!<br><br>is it right that the two components hidd (the daemon) and the kernel module hidp (found in net/bluetooth/) work together in order to provide support for Bluetooth Keyboards and other HID devices?<br>As far as I know hidd has been replaced, if yes with what?<br>
And which role plays the Input service which is also an own folder in the bluez-utils?<br><br>Anyway, the two components hidd and hidp provide HID support?  <br>I took a look at hidd and hidp and found out that hidd listends for incoming connections, if it gets one it forwards this connection to the kernel<br>
modules hidp which adds it to its handlers. From there the kernel module serves the connection and uses the well known input function input_event to get the scancodes into the input system of linux.<br><br>So for a basic support of keyboards I only need hidd and hidp running? <br>
<br>Thanks...<br><br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_12837_22042981.1213168203612--


--===============0967257455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0967257455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0967257455==--
