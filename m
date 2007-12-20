Return-Path: <cyrus@holtmann.org>
Message-ID: <951351190712200246v72181504u52169ed53a34fcd6@mail.gmail.com>
Date: Thu, 20 Dec 2007 10:46:20 +0000
From: "Jason Zhan" <zhan.jason@gmail.com>
To: Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] link key PIN code authentication
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1889658220=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1889658220==
Content-Type: multipart/alternative;
	boundary="----=_Part_18818_27207754.1198147580098"

------=_Part_18818_27207754.1198147580098
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,

Currently, I am working on a project to handle the pairing procedure. The
aim is quite simple.  If  the authentication is required by the user, the
program will detect whether the link key exists. If not, the program will
print out several lines in the terminal and ask the user entering the PIN
code.  The authentication will perform based on the PIN code which the user
provided and finally the new link key for this connection will be passed to
the host for future connections if the authentication is successful.

The bluez exploits the D-Bus to manage the pin code and link key. Since my
application is very simple, I don't think I need the D-Bus framework.

HCI can send the command to LM by hci_send_cmd() method, but I cannot find
the suitable methods which can read back the request from the LM.

Can anybody give me some expert level suggestions regarding the
authentication?

BTW, Happy Christmas to all bluez developers !

Regards,
Jason

------=_Part_18818_27207754.1198147580098
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear all,<br><br>Currently, I am working on a project to handle the pairing procedure. The aim is quite simple.&nbsp; If&nbsp; the authentication is required by the user, the program will detect whether the link key exists. If not, the program will print out several lines in the terminal and ask the user entering the PIN code.&nbsp; The authentication will perform based on the PIN code which the user provided and finally the new link key for this connection will be passed to the host for future connections if the authentication is successful. 
<br><br>The bluez exploits the D-Bus to manage the pin code and link key. Since my application is very simple, I don&#39;t think I need the D-Bus framework. <br><br>HCI can send the command to LM by hci_send_cmd() method, but I cannot find the suitable methods which can read back the request from the LM.&nbsp; 
<br><br>Can anybody give me some expert level suggestions regarding the authentication? <br><br>BTW, Happy Christmas to all bluez developers !<br><br>Regards,<br>Jason<br><br>&nbsp;<br> <br>&nbsp;<br>

------=_Part_18818_27207754.1198147580098--


--===============1889658220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1889658220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1889658220==--
