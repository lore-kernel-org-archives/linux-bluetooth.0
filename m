Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060307105813.97181.qmail@web26503.mail.ukl.yahoo.com>
From: BATAILLE Philippe <philbataille@yahoo.fr>
To: BlueZ <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Problem : multi connection with PAN
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
Date: Tue, 7 Mar 2006 11:58:13 +0100 (CET)

Hi,
I would like to use the PAN profile of the BlueZ
stack. I have the 2.22 
version of the PAN code and
my kernel version is 2.6.15 (Fedora 4 distribution).
I would like to create several connections between a
GN and PANUs 
entities. My problem is when I
create only one connection between 2 entities (GN and
PANU)  I can make 
a 'ping' command between
the two devices (in the 2 directions). If I try to
create an other one 
with a second PANU  (GN-PANU connection)
the connection succeeds but the ping command doesn't
work.

I read the PAN Howto in order to configure the PAN
correctly. This howto 
mentions the possibility to
create multiple PAN connections using an ethernet
bridge (see "brctl" 
program) but even if I configure it
according to the PAN howto instructions, the problem
is unresolved. May 
be there is a wrong operation
in the configuration process but I can't find it.

Problem description : A B and C are the 3 Bluetooths
modules on 3 
different PCs
   A= GN   (bdaddr_A)
   B and C =PANU (bdaddr_B,bdaddr_C)
 
   # starting HCI daemon on each PC
    hcid
  
   # network files on each PC:  
/etc/sysconfig/network-script/ifcfg-bnep0
   DEVICE=bnep0
   BOOTPROTO=static
   BROADCAST=10.255.255.255
   HWADDR=00:02:72:C6:6E:89         # specific device
address different 
for each node
   IPADDR=10.0.0.x                            # x= 1,
2 and 3 for A, B 
et C respectively
   NETMASK=255.0.0.0
   NETWORK=10.0.0.0
   ONBOOT=no
   
   # on GN (bdaddr_A) starting  pand
   pand -s  -r GN

   # on each PANU (bdaddr_B, bdaddr_C) creating a
connection with A
   pand -c bdaddr_A (on B)
   pand -c bdaddr_A  (on C)

   # show the connections on A with 'pand --show'
   bnep1:bdaddr_C GN
   bnep0:bdaddr_B GN

   # on A, ping to B (IP:10.0.0.2)
   ping 10.0.0.2   (this command is OK)
  
   # on A ping to C (IP:10.0.0.3)
   ping 10.0.0.3  (this command is not OK : Message
"Host unreachable" )


Next, I try to configure the ethernet bridge exactly
as it is described 
on the PAN howto
but without any improvement.

Is there someone who can help me to resolve this
problem ?

thant you in advance

Regards

Philippe








	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
