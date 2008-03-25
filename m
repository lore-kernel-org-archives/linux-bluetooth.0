Return-Path: <cyrus@holtmann.org>
Message-ID: <8f5c4ad0803250501x51e5cac8m7c21a6e41460c644@mail.gmail.com>
Date: Tue, 25 Mar 2008 17:31:31 +0530
From: Paul <chemvell@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] ACL connection handle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1690698308=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1690698308==
Content-Type: multipart/alternative;
	boundary="----=_Part_10167_12756455.1206446491429"

------=_Part_10167_12756455.1206446491429
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

     I have a bluetooth module in which there is an option  to select the
interface (HCI or PCM) for the next SCO connection.This is done by sending
an HCI command .So I can use hcitool cmd option right? From the manual of
the BT module I figured out the OCF and OGF of the command, now on the
parameter part it requires the ACL connection handle.
How I can I find out the connection handle for a particular connection?
Usually when I do a file transfer or try to play through the HCI
interface,hcidump shows

< ACL data: handle 256 flags 0x02 dlen 8

So can I use 256 in place of the ACL connection handle in the HCI command?
Thank you for your time and consideration,
Regards,
Matt

------=_Part_10167_12756455.1206446491429
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>&nbsp;&nbsp;&nbsp;&nbsp; I have a bluetooth module in which there is an option&nbsp; to select the interface (HCI or PCM) for the next SCO connection.This is done by sending&nbsp; an HCI command .So I can use hcitool cmd option right? From the manual of the BT module I figured out the OCF and OGF of the command, now on the parameter part it requires the ACL connection handle.<br>
How I can I find out the connection handle for a particular connection? Usually when I do a file transfer or try to play through the HCI interface,hcidump shows&nbsp; <br><br><font style="font-family: tahoma; font-size: 10pt;">&lt; ACL data: handle 256 
flags 0x02 dlen 8<br><br></font>So can I use 256 in place of the ACL connection handle in the HCI command?<br>Thank you for your time and consideration,<br>Regards,<br>Matt<br><font style="font-family: tahoma; font-size: 10pt;"><br>
<br><br></font>

------=_Part_10167_12756455.1206446491429--


--===============1690698308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1690698308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1690698308==--
