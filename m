Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0806210213i412a870dnfdde87de30e3ea63@mail.gmail.com>
Date: Sat, 21 Jun 2008 11:13:00 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] problemes using passkeyagent d-bus interface
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0017735452=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0017735452==
Content-Type: multipart/alternative;
	boundary="----=_Part_7038_24441361.1214039580471"

------=_Part_7038_24441361.1214039580471
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

 did everything to implement a passkey-agent. ( using bluez 3.31)
The problem is, althouth I've implemented everything the same way, and it
definitely should be right, only the method "Reqest" gets
called, but the other ones, Keypress. Cancel, Confirm, Complete not?
Using dbus-monitor I can only see Signals but no method-calls, so I dont
know if the method calls get executed.

thanks

This might be the interesting lines of hcidump:

> HCI Event: Command Complete (0x0e) plen 10
  01 0C 04 00 45 61 00 00 18 00
> HCI Event: PIN Code Request (0x16) plen 6
  45 61 00 00 18 00
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  45 61 00 00 18 00 04 31 32 33 34 00 00 00 00 00 00 00 00 00
  00 00 00
> HCI Event: Command Complete (0x0e) plen 10
  01 0D 04 00 45 61 00 00 18 00
> HCI Event: Link Key Notification (0x18) plen 23
  45 61 00 00 18 00 44 79 C3 01 5D 2C CC 3C A6 DC BF D5 C7 DA
  02 54 00
> HCI Event: Auth Complete (0x06) plen 3
  00 29 00
< HCI Command: Disconnect (0x01|0x0006) plen 3
  29 00 13
> HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 16




-- 
Regards,
--Codefritz

------=_Part_7038_24441361.1214039580471
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>&nbsp;did everything to implement a passkey-agent. ( using bluez 3.31)<br>The problem is, althouth I&#39;ve implemented everything the same way, and it definitely should be right, only the method &quot;Reqest&quot; gets<br>
called, but the other ones, Keypress. Cancel, Confirm, Complete not?<br>Using dbus-monitor I can only see Signals but no method-calls, so I dont know if the method calls get executed.<br><br>thanks<br><br>This might be the interesting lines of hcidump:<br>
<br>&gt; HCI Event: Command Complete (0x0e) plen 10<br>&nbsp; 01 0C 04 00 45 61 00 00 18 00<br>&gt; HCI Event: PIN Code Request (0x16) plen 6<br>&nbsp; 45 61 00 00 18 00<br>&lt; HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23<br>
&nbsp; 45 61 00 00 18 00 04 31 32 33 34 00 00 00 00 00 00 00 00 00<br>&nbsp; 00 00 00<br>&gt; HCI Event: Command Complete (0x0e) plen 10<br>&nbsp; 01 0D 04 00 45 61 00 00 18 00<br>&gt; HCI Event: Link Key Notification (0x18) plen 23<br>
&nbsp; 45 61 00 00 18 00 44 79 C3 01 5D 2C CC 3C A6 DC BF D5 C7 DA<br>&nbsp; 02 54 00<br>&gt; HCI Event: Auth Complete (0x06) plen 3<br>&nbsp; 00 29 00<br>&lt; HCI Command: Disconnect (0x01|0x0006) plen 3<br>&nbsp; 29 00 13<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 00 01 06 04<br>&gt; HCI Event: Disconn Complete (0x05) plen 4<br>&nbsp; 00 29 00 16<br><br><br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_7038_24441361.1214039580471--


--===============0017735452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0017735452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0017735452==--
