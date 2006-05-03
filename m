Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Skrzypek Piotr" <skrzypek@xl.wp.pl>
To: bluez-users@lists.sourceforge.net
Message-ID: <4458b81c93c93@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Subject: [Bluez-users] bnep not present
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 03 May 2006 16:03:08 +0200

Hello
I`m interested in recent topic - pand created but no bnep interface. I`ve got similar problem but i`ve succesfully established pand connection only once (and no bnep0 found). Now, i can type pand --listen --role NAP but other devices can`t see the PAN service. 

Here are some envirnomental informations:
gentoo, emerge bluez-util and bluez-libs. bnep compiled into kernel (not as a module - maybe that`s wrong?). 
/etc.init.d/bluetooth starts automatically, 
in /etc/i forgot/bluetooth i typed to start pand automatically (pand=true)

For now - other devices can`t see any services (pan) on my bluez device, bnep is never created, even after pand --listen.... About logs - nothing - in fack i haven`t really found any logs. dmesg is silent too. Please help!





-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
