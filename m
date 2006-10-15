Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4531BD65.1020107@gmail.com>
Date: Sun, 15 Oct 2006 01:47:33 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
Subject: [Bluez-users] PIN Authentication Problems on MDV 2007
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,
I have updated to Mandriva 2007, and I can't figure why, I can't make 
things get back working, when I used mdv 2006 all bluez went on OK.

Here is my hcid.conf:
#
# HCI daemon configuration file.
#

# HCId options
options {
    # Automatically initialize new devices
    autoinit yes;

    # Security Manager mode
    #   none - Security manager disabled
    #   auto - Use local PIN for incoming connections
    #   user - Always ask user for a PIN
    #
    security user;

    # Pairing mode
    #   none  - Pairing disabled
    #   multi - Allow pairing with already paired devices
    #   once  - Pair once and deny successive attempts
    pairing multi;

    # Default PIN code for incoming connections
    passkey "1234";
   
    pin_helper /bin/bluepin;
   
    #dbus_pin_helper;
}

# Default settings for HCI devices
device {
    # Local device name
    #   %d - device id
    #   %h - host name
    name "BlueZ (%d)";

    # Local device class
    class 0x3e0100;

    # Default packet type
    #pkt_type DH1,DM1,HV1;

    # Inquiry and Page scan
    iscan enable; pscan enable;

    # Default link mode
    #   none   - no specific policy
    #   accept - always accept incoming connections
    #   master - become master on incoming connections,
    #            deny role switch on outgoing connections
    lm accept;

    # Default link policy
    #   none    - no specific policy
    #   rswitch - allow role switch
    #   hold    - allow hold mode
    #   sniff   - allow sniff mode
    #   park    - allow park mode
    lp rswitch,hold,sniff,park;
}
---

/bin/bluepin is no more than a link to kbluetooth pin.

The thing is that, when ever I try to establish a connection, it seems 
that BlueZ (or something else) is missing the PIN code.

I'm doing:
hcitool cc 00:50:C2:58:50:00 //To get the connection on
hcitool key 00:50:C2:58:50:00 //To Exchange Link Kety,

I have even tried with hcitool auth 00:50:C2:58:50:00, every time the 
result is the same.

hcidump -X -V shows this:
 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:50:C2:58:50:00
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:50:C2:58:50:00
 > HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:50:C2:58:50:00
 > HCI Event: Auth Complete (0x06) plen 3
    status 0x06 handle 1
    Error: PIN or Key Missing

And I never get a Pin Request from the BlueZ side.

Any ideas?

Cheers,
Manuel

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
