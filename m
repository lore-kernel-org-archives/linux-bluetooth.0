Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Triona Ryan <triona.ryan@nuigalway.ie>
To: bluez-users@lists.sourceforge.net
Message-id: <01LKWW9DRTXK00DE35@beacon.nuigalway.ie>
MIME-version: 1.0
Content-type: text/plain
Subject: [Bluez-users] local device class...
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
Date: Thu, 17 Feb 2005 13:56:59 +0000

Hi all,

I'm having difficulty transfering files between 2 FC2 Bluez enabled PCs
. I'm using the exact same dongles, but installed the bluez packages on my maste
r PC following a howto as ./configure, make, make install. On the servant I inst
alled them as the README's directed. (with various prefixs etc.) However, on the
 hcid.conf file for the master I originally got local device class as 0x100, and
 on the servant as 0x3e0100. 
As I couldn't establish a connection to transfer f
iles using OBEX, I ploughed through google and saw that local device class must 
be 0x100100 for object trnasfer to work. However, changing this on the master PC
 worked, and change the advertised services in hciconfig -a from nothing to "Obj
ect Transfer", and now I can transfer files to and from my mobile phone. On the 
servant PC however, it had no effect, and just changed the advertised Service cl
asses in the hciconfig -a from "Networking, rendering, Capturing" to nothing. 

Why would these hcid.conf's differ in the first place? And how do I fix it?? rec
onfiguring the bluez packages on the servant?? I was using different dongles but
 getting two the same had no effect. How can I fix this, as I think it is a Blue
z problem rather than an obex or anything else problem.

The following is the ou
tput of my  hciconfig -a on the master, and after that the hcid.conf on the mast
er:

hci0:   Type: USB
        BD Address: 00:0B:0D:33:CE:93 ACL MTU: 120:20  SC
O MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:4605409 acl:18677 sc
o:0 events:22852 errors:0
        TX bytes:5369351 acl:50797 sco:0 commands:188 
errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packe
t type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SN
IFF PARK
        Link mode: MASTER
        Name: 'Trionas PC (0)'
        Class:
 0x100100
        Service Classes: Object Transfer
        Device Class: Compute
r, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP 
Subver: 0x757
        Manufacturer: Silicon Wave (11)
 
[root@lab103-106 root]# 
more /etc/bluetooth/hcid.conf
#
# HCI daemon configuration file.
#
# $Id: hcid.c
onf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
#
 
# HCId options
options {
      
  # Automatically initialize new devices
        autoinit yes;
 
        # Secur
ity Manager mode
        #   none - Security manager disabled
        #   auto -
 Use local PIN for incoming connections
        #   user - Always ask user for a
 PIN
        #
        security auto;
 
        # Pairing mode
        #   none 
 - Pairing disabled
        #   multi - Allow pairing with already paired device
s
        #   once  - Pair once and deny successive attempts
        pairing mul
ti;
                                                                            
    
        # PIN helper
        pin_helper /usr/bin/bluepin;
                 
                                                               
        # D-Bus 
PIN helper
        #dbus_pin_helper;
}
                                         
                                       
# Default settings for HCI devices
devic
e {
        # Local device name
        #   %d - device id
        #   %h - host
 name
        name "Trionas PC (%d)";
                                          
                                      
        # Local device class
        clas
s 0x100100;
                                                                    
            
        # Default packet type
        #pkt_type DH1,DM1,HV1;
      
                                                                          
     
   # Inquiry and Page scan
        iscan enable; pscan enable;
                 
                                                               
        # Defaul
t link mode
        #   none   - no specific policy
        #   accept - always 
accept incoming connections
        #   master - become master on incoming conne
ctions,
        #            deny role switch on outgoing connections
        #
        lm master;
        #
        #lm accept;
                               
                                                 
        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch

        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
  
      #   park    - allow park mode
        #
        #lp hold,sniff;
        #
        lp rswitch,hold,sniff,park;
                                            
                                    
        # Authentication and Encryption
   
     #auth enable;
        #encrypt enable;
}


Please help me if you can. Someb
ody must know!
Thanks very much,
Regards,
Triona




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
