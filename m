Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0805290503g68474663n975cb2d1e7fc8e7a@mail.gmail.com>
Date: Thu, 29 May 2008 14:03:46 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] correlation of hidd, hidp and the service Input
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1264859406=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1264859406==
Content-Type: multipart/alternative;
	boundary="----=_Part_9978_28007372.1212062626625"

------=_Part_9978_28007372.1212062626625
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

since I want to use a bluetooth keyboard in my Kernel 2.4.21 I'm analyzing
hidd, hidp and the Input service.
At the same time I take a look at the alternative bthid from
http://klausler.com/msbtkb-linux.html

bthid consists of a daemon which implements the sdp stuff it establishes
connection to a hid device and send all received data to the kernel modul
fake through a character device.
The kernel module simply forwads the received commands to the input kernel
module to get in keycodes into the kernel. That's it basically.

Well what are the tasks of all the bluez HID parts:  hidd, hidp, the Input
Service, and how to they work/communicate with each other ?
The problem is that I cant make the kernel module hidp run under my 2.4
Kernel, maybe I can adapt it or replace it by another module.

-- 
Regards,
--Codefritz

------=_Part_9978_28007372.1212062626625
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>since I want to use a bluetooth keyboard in my Kernel 2.4.21 I&#39;m analyzing hidd, hidp and the Input service.<br>At the same time I take a look at the alternative bthid from <a href="http://klausler.com/msbtkb-linux.html">http://klausler.com/msbtkb-linux.html</a><br>
<br>bthid consists of a daemon which implements the sdp stuff it establishes connection to a hid device and send all received data to the kernel modul fake through a character device.<br>The kernel module simply forwads the received commands to the input kernel module to get in keycodes into the kernel. That&#39;s it basically.<br>
<br>Well what are the tasks of all the bluez HID parts:&nbsp; hidd, hidp, the Input Service, and how to they work/communicate with each other ?<br>The problem is that I cant make the kernel module hidp run under my 2.4 Kernel, maybe I can adapt it or replace it by another module.<br clear="all">
<br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_9978_28007372.1212062626625--


--===============1264859406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1264859406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1264859406==--
