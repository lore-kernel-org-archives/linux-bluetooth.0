Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Triona Ryan <triona.ryan@nuigalway.ie>
Subject: Re: [Bluez-users] local device class...
To: bluez-users@lists.sourceforge.net
Message-id: <01LKX8B5H2GA00ECYA@beacon.nuigalway.ie>
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
Date: Thu, 17 Feb 2005 19:42:01 +0000

Ok, I seem to be very much ignored. 

Thanks very much 

However, IF there's any
one out there using this list EXCEPT for one on-going thread, could someone plea
se check their hciconfig -a and see if their device class matches their services
. I'm using college lab computers, and I installed BT on one computer a few week
s ago, and it gave me 0x100 as device class, but last week I installed all on an
other computer, and I got 0x3e0100. They're ALL linked to the SAME lan, and SAME
 computers etc. I changed the first computer to ox100100, to set Object Transfer
, which immediately worked, but the other one is set already and isn't registeri
ng the service. Why could one not recognise the bit set for Object transfer? Doe
s it clash with the three other services? I installed on another computer today 
to see was it a PC problem, and got the exact same thing. Have the packages been
 changed recently? Or has this problem been seen before. (I PRESUME so)

The lin
ks for those using this list are:

http://www.comp.lancs.ac.uk/~fittond/bt/bt_co
mms_howto.html

https://www.bluetooth.org/foundry/assignnumb/document/baseband



==============Original message text===============
On Thu, 17 Feb 2005 15:42:4
7 +0000 Triona Ryan wrote:

Hi again,

Ok, I've found information on how to set 
the DIAC or local device class correctly. But even though I've set it as 0x1e010
4, it's still refusing to see the obex Service. WHY??

Has this ever happened to
 anyone else?

Triona


==============Original message text===============
On Th
u, 17 Feb 2005 13:56:59 +0000 Triona Ryan wrote:

Hi all,

I'm having difficulty
 transfering files between 2 FC2 Bluez enabled PCs
. I'm using the exact same do
ngles, but installed the bluez packages on my maste
r PC following a howto as ./
configure, make, make install. On the servant I inst
alled them as the README's 
directed. (with various prefixs etc.) However, on the
 hcid.conf file for the ma
ster I originally got local device class as 0x100, and
 on the servant as 0x3e01
00. 
As I couldn't establish a connection to transfer f
iles using OBEX, I ploug
hed through google and saw that local device class must 
be 0x100100 for object 
trnasfer to work. However, changing this on the master PC
 worked, and change th
e advertised services in hciconfig -a from nothing to "Obj
ect Transfer", and no
w I can transfer files to and from my mobile phone. On the 
servant PC however, 
it had no effect, and just changed the advertised Service cl
asses in the hcicon
fig -a from "Networking, rendering, Capturing" to nothing. 

Why would these hci
d.conf's differ in the first place? And how do I fix it?? rec
onfiguring the blu
ez packages on the servant?? I was using different dongles but
 getting two the 
same had no effect. How can I fix this, as I think it is a Blue
z problem rather
 than an obex or anything else problem.

The following is the ou
tput of my  hci
config -a on the master, and after that the hcid.conf on the mast
er:

hci0:   T
ype: USB
        BD Address: 00:0B:0D:33:CE:93 ACL MTU: 120:20  SC
O MTU: 64:0
 
       UP RUNNING PSCAN ISCAN
        RX bytes:4605409 acl:18677 sc
o:0 events:2
2852 errors:0
        TX bytes:5369351 acl:50797 sco:0 commands:188 
errors:0
  
      Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packe
t type: DM
1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SN
IFF PARK
        Link mode: MASTER
        Name: 'Trionas PC (0)'
        Class:
 0x10010
0
        Service Classes: Object Transfer
        Device Class: Compute
r, Unca
tegorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP 
Subver
: 0x757
        Manufacturer: Silicon Wave (11)
 
[root@lab103-106 root]# 
more 
/etc/bluetooth/hcid.conf
#
# HCI daemon configuration file.
#
# $Id: hcid.c
onf,
v 1.4 2004/04/29 20:14:21 holtmann Exp $
#
 
# HCId options
options {
      
  #
 Automatically initialize new devices
        autoinit yes;
 
        # Secur
it
y Manager mode
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
        #   multi - Allow pairing with already paired devic
e
s
        #   once  - Pair once and deny successive attempts
        pairing m
ul
ti;
                                                                         
   
    
        # PIN helper
        pin_helper /usr/bin/bluepin;
             
    
                                                               
        # D
-Bus 
PIN helper
        #dbus_pin_helper;
}
                                   
      
                                       
# Default settings for HCI device
s
devic
e {
        # Local device name
        #   %d - device id
        #   %
h - host
 name
        name "Trionas PC (%d)";
                                 
         
                                      
        # Local device class
  
      clas
s 0x100100;
                                                         
           
            
        # Default packet type
        #pkt_type DH1,DM1
,HV1;
      
                                                                   
       
     
   # Inquiry and Page scan
        iscan enable; pscan enable;
   
              
                                                               
 
       # Defaul
t link mode
        #   none   - no specific policy
        #   
accept - always 
accept incoming connections
        #   master - become master 
on incoming conne
ctions,
        #            deny role switch on outgoing conn
ections
        #
        lm master;
        #
        #lm accept;
             
                  
                                                 
        # D
efault link policy
        #   none    - no specific policy
        #   rswitch 
- allow role switch

        #   hold    - allow hold mode
        #   sniff   -
 allow sniff mode
  
      #   park    - allow park mode
        #
        #lp h
old,sniff;
        #
        lp rswitch,hold,sniff,park;
                       
                     
                                    
        # Authenticat
ion and Encryption
   
     #auth enable;
        #encrypt enable;
}


Please he
lp me if you can. Someb
ody must know!
Thanks very much,
Regards,
Triona




---
----------------------------------------------------
SF email is sponsored by - 
The IT Product Guide
Read honest & candid reviews on hundreds of IT Products fro
m real users.
Discover which products truly live up to the hype. Start reading n
ow.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
____________________
___________________________
Bluez-users mailing list
Bluez-users@lists.sourcefor
ge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
===========End o
f original message text===========


===========End of original message text====
=======





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
