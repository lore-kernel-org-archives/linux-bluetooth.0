Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Sean Godsell" <sgodsell@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY12-F46k3Y8pEBtKa0004b06c@hotmail.com>
Subject: [Bluez-users] Problem with more than 2 users
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
Date: Tue, 08 Jun 2004 09:14:15 -0400

Hello,

Okay there seems to be a problem with bluez, when more than 2 users try to 
connect at the same time.  I have 4 bluetooth PDA's (2 palms and 2 windows 
pdas).   I tried connecting any combination of three PDA's and only the 
first 2 will connect and work.   I tried a few different kernels as well.   
>From 2.4.25 - 26  --  2.6.3 - 5 and all of which produce the same results 
only 2 PDA's can connect at one time.   I have configured 8 /dev/rfcomm#  
devices starting from 0 to 7.     I have hcid and sdpd running.   Then I run 
dund with --listen.     All the PDA's can see the PC lan server, and can 
connect and work.   The only problem is only 2 will work and no more.   The 
following are the configuration files:

hcid.conf:
options {
        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /etc/bluetooth/givepin;
}

device {
        name "BlueZ";
        class 0x100;
        iscan enable; pscan enable;
        lm accept;
        lp hold,sniff,park;
        auth enable;
        encrypt enable;
}


pin:
bluez


Any help would really be appreciated.
Thank you

Sean  ;)

_________________________________________________________________
STOP MORE SPAM with the MSN Premium and get 2 months FREE*    
http://join.msn.com/?pgmarket=en-ca&page=byoa/prem&xAPID=1994&DI=1034&SU=http://hotmail.com/enca&HL=Market_MSNIS_Taglines



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
