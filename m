Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20061030105610.21038.qmail@maboque.srv.clix.pt>
MIME-Version: 1.0
From: foreveruni@clix.pt
To: bluez-users@lists.sourceforge.net
Date: Mon, 30 Oct 2006 10:56:10 +0000
Subject: [Bluez-users] I can't pair to a H350
Reply-To: foreveruni@clix.pt, BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0837452889=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0837452889==
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary

Hello I'm using ubuntu edgy and tried hcid from bluez-3.7 source(compiled by me) from apt-get(package) and from apt-build.
I can't use the option : pin_helper "/usr/bin/bluez-pin"; anymore hcid gives me a wrong syntax or something and I can't pair my h350 motorola headset.  When I try to use btsco it says cannot connect to rfcomm channe). If I do hcitool cc handsethwaddress , I get a connection but when I try to use btsco the connection is broken. In the moment that btsco tries to connect hcid have a output saying something like: It tried to make a connection with password but wasn't able to(sorry I can't post the outputs for the moment).Anyone has a hint?
My hcid.conf is in attachment.
Best Regards
João Mamede

O Clix quebrou mais uma barreira!

ADSL até 20 Mb + Telefone livre de assinatura  por apenas  € 34,9/mês

Acabe de vez com os € 15 da assinatura telefónica!

Saiba mais em http://acesso.clix.pt




--===============0837452889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0837452889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0837452889==--
