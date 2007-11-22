Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4745D9EE.4020101@uni-koeln.de>
Date: Thu, 22 Nov 2007 20:35:10 +0100
From: Paul Wachendorf <pwachend@uni-koeln.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] hcitool scan returns wrong bdaddr
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,
I have a strange Problem with hcitool on a ARM CPU based embedded 
system.  I have installed a debian system (tried woody, etch and lenny) 
and tried the bluez-utils from the distribution and self compiled ones. 
The bluetooth device works fine, but when I run a 'hcitool scan' to 
discover the bdaddr of remote devices  it always returns wrong MACs:
# hcitool scan
Scanning ...
        02:01:00:12:EE:58       n/a
        02:02:00:10:C6:81       n/a

on my normal i386 PC running ubuntu linux, using the same bluetooth 
device the output is:
$ hcitool scan
Scanning ...
        00:10:C6:81:48:19       NAME-FB399BACD9
        00:12:EE:58:72:1C       V630i

back again on the ARM box I can successfully l2ping  00:12:EE:58:72:1C 
and an # hcitool name 00:12:EE:58:72:1C
returns "V630i" as suspected , so on I can use ussp-push to send Files 
to my V630i. So the whole bluetooth subsystem seems to work fine, except 
of the discovering of remote MACs.

Does anybody has am idea why this wrong MACs are returned?
Thanks for your help,

Paul


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
