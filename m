Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Triona Ryan <triona.ryan@nuigalway.ie>
Subject: Re: [Bluez-users] local device class...
To: bluez-users@lists.sourceforge.net
Message-id: <01LKWZXKS40Y00DFK5@beacon.nuigalway.ie>
MIME-version: 1.0
Content-type: text/plain
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
Date: Thu, 17 Feb 2005 15:42:47 +0000

Hi again,

Ok, I've found information on how to set the DIAC or local device cla
ss correctly. But even though I've set it as 0x1e0104, it's still refusing to se
e the obex Service. WHY??

Has this ever happened to anyone else?

Triona


====
==========Original message text===============
On Thu, 17 Feb 2005 13:56:59 +000
0 Triona Ryan wrote:

Hi all,

I'm having difficulty transfering files between 2
 FC2 Bluez enabled PCs
. I'm using the exact same dongles, but installed the blu
ez packages on my maste
r PC following a howto as ./configure, make, make instal
l. On the servant I inst
alled them as the README's directed. (with various pref
ixs etc.) However, on the
 hcid.conf file for the master I originally got local 
device class as 0x100, and
 on the servant as 0x3e0100. 
As I couldn't establish
 a connection to transfer f
iles using OBEX, I ploughed through google and saw t
hat local device class must 
be 0x100100 for object trnasfer to work. However, c
hanging this on the master PC
 worked, and change the advertised services in hci
config -a from nothing to "Obj
ect Transfer", and now I can transfer files to an
d from my mobile phone. On the 
servant PC however, it had no effect, and just c
hanged the advertised Service cl
asses in the hciconfig -a from "Networking, ren
dering, Capturing" to nothing. 

Why would these hcid.conf's differ in the first
 place? And how do I fix it?? rec
onfiguring the bluez packages on the servant??
 I was using different dongles but
 getting two the same had no effect. How can 
I fix this, as I think it is a Blue
z problem rather than an obex or anything el
se problem.

The following is the ou
tput of my  hciconfig -a on the master, and
 after that the hcid.conf on the mast
er:

hci0:   Type: USB
        BD Address:
 00:0B:0D:33:CE:93 ACL MTU: 120:20  SC
O MTU: 64:0
        UP RUNNING PSCAN ISCA
N
        RX bytes:4605409 acl:18677 sc
o:0 events:22852 errors:0
        TX byt
es:5369351 acl:50797 sco:0 commands:188 
errors:0
        Features: 0xff 0xff 0x
05 0x38 0x18 0x18 0x00 0x00
        Packe
t type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV
2 HV3
        Link policy: RSWITCH HOLD SN
IFF PARK
        Link mode: MASTER
  
      Name: 'Trionas PC (0)'
        Class:
 0x100100
        Service Classes: O
bject Transfer
        Device Class: Compute
r, Uncategorized
        HCI Ver: 1
.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP 
Subver: 0x757
        Manufacturer
: Silicon Wave (11)
 
[root@lab103-106 root]# 
more /etc/bluetooth/hcid.conf
#
#
 HCI daemon configuration file.
#
# $Id: hcid.c
onf,v 1.4 2004/04/29 20:14:21 ho
ltmann Exp $
#
 
# HCId options
options {
      
  # Automatically initialize ne
w devices
        autoinit yes;
 
        # Secur
ity Manager mode
        #   n
one - Security manager disabled
        #   auto -
 Use local PIN for incoming c
onnections
        #   user - Always ask user for a
 PIN
        #
        secur
ity auto;
 
        # Pairing mode
        #   none 
 - Pairing disabled
       
 #   multi - Allow pairing with already paired device
s
        #   once  - Pair
 once and deny successive attempts
        pairing mul
ti;
                     
                                                       
    
        # PIN helpe
r
        pin_helper /usr/bin/bluepin;
                 
                       
                                        
        # D-Bus 
PIN helper
        #db
us_pin_helper;
}
                                         
                     
                  
# Default settings for HCI devices
devic
e {
        # Local 
device name
        #   %d - device id
        #   %h - host
 name
        name 
"Trionas PC (%d)";
                                          
                  
                    
        # Local device class
        clas
s 0x100100;
     
                                                               
            
   
     # Default packet type
        #pkt_type DH1,DM1,HV1;
      
               
                                                           
     
   # Inquiry a
nd Page scan
        iscan enable; pscan enable;
                 
             
                                                  
        # Defaul
t link mode
        #   none   - no specific policy
        #   accept - always 
accept inco
ming connections
        #   master - become master on incoming conne
ctions,
  
      #            deny role switch on outgoing connections
        #
        lm
 master;
        #
        #lm accept;
                               
         
                                        
        # Default link policy
        #
   none    - no specific policy
        #   rswitch - allow role switch

       
 #   hold    - allow hold mode
        #   sniff   - allow sniff mode
  
      #
   park    - allow park mode
        #
        #lp hold,sniff;
        #
       
 lp rswitch,hold,sniff,park;
                                            
      
                              
        # Authentication and Encryption
   
     
#auth enable;
        #encrypt enable;
}


Please help me if you can. Someb
ody 
must know!
Thanks very much,
Regards,
Triona




-------------------------------
------------------------
SF email is sponsored by - The IT Product Guide
Read ho
nest & candid reviews on hundreds of IT Products from real users.
Discover which
 products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_
id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourcef
orge.net/lists/listinfo/bluez-users
===========End of original message text=====
======





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
