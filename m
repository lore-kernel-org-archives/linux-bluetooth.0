Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40D6D491.2080307@snapafun.co.nz>
From: Frank <frank@snapafun.co.nz>
Reply-To: frank@snapafun.co.nz
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] kbluetoothd falls over....
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 22 Jun 2004 00:29:05 +1200

As a newbie I tried to get bluetooth up and running. Any suggestions?

[root@localhost Downloads]# urpmi kdebluetooth
One of the following packages is needed:
 1- bluez-sdp-1.5-1mdk.i586
 2- libbluez-sdp2-1.5-1mdk.i586
What is your choice? (1-2) 2
To satisfy dependencies, the following packages are going to be 
installed (4 MB):
bluez-utils-2.4-4mdk.i586
kdebluetooth-0.0.cvs20040302-3mdk.i586
libbluez-sdp2-1.5-1mdk.i586
libopenobex1-1.0.1-1mdk.i586
Is this OK? (Y/n) y
Please insert the medium named "Installation CD 3 (x86) " on device 
[/dev/hdc]
Press Enter when ready...

    
ftp://ftp.proxad.net/pub/Distributions_Linux/Mandrake/official/10.0/contrib/i586/libopenobex1-1.0.1-1mdk.i586.rpm
    
ftp://ftp.proxad.net/pub/Distributions_Linux/Mandrake/official/10.0/contrib/i586/kdebluetooth-0.0.cvs20040302-3mdk.i586.rpm
installing /mnt/cdrom/Mandrake/RPMS3/bluez-utils-2.4-4mdk.i586.rpm 
/mnt/cdrom/Mandrake/RPMS3/libbluez-sdp2-1.5-1mdk.i586.rpm 
/var/cache/urpmi/rpms/libopenobex1-1.0.1-1mdk.i586.rpm 
/var/cache/urpmi/rpms/kdebluetooth-0.0.cvs20040302-3mdk.i586.rpm
Preparing...                
##################################################
   1:libopenobex1           
##################################################
   2:libbluez-sdp2          
##################################################
* w  3:bluez-utils            ################arning: 
/etc/bluetooth/hcid.conf created as /etc/bluetooth/hcid.conf.rpmnew
warning: /etc/bluetooth/pin created as /etc/bluetooth/pin.rpmnew
warnin#############################g: /etc/bluetooth/rfcomm.conf created 
as /etc/bluetooth/rfcomm.conf.rpmnew
warning: /etc/rc.d/init.d/bluetooth created as 
/etc/rc.d/init.d/bluetooth.rpmnew
#####
service bluetooth does not support chkconfig
error: %post(bluez-ut   4:kdebluetooth           ils-2.4-4mdk) scriptlet 
failed, exit status 1*
##################################################

-- 
Regards

Frank

Big or small, a challenge requires the same commitment to resolve.
Registered Linux User # 324213 



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
