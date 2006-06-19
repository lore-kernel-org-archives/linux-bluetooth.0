Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4496DADD.5050208@cormack.org>
Date: Mon, 19 Jun 2006 18:11:57 +0100
From: Alec <bluez@cormack.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Bluez NAP refuses connection if PANU clent has
	deleted pairing.
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

I am using openslug 2.7 linux on Linksys NSLU2 server to create a 
Bluetooth NAP.

The packages are a bit out of date but they are the latest available for 
the NSLU2.

bluez-utils-nodbus - 2.21-r0 -
kernel-module-bluetooth - 2.6.12.2-r17.4 -
libbluetooth1 - 2.21-r0 -

The NAP works perfectly allowing clients to connect, enter the PIN and 
gain internet access via tle Bluez NAP.  Once clients have paired once 
they can re-connect without a PIN.

The problem I get is if a client deletes its pairing but the server 
still has its pairing in /var/lib/bluetooth/{ADDR}/linkkeys.  Under 
these circumstances the client is refused access until I delete the 
pairing on the server - at which point the client is prompted to re-pair 
and everything then works fine again.

I assumed there was some combination of settings in hcid.conf that would 
overcome this (pairing multi looked promising! but made no difference) 
and I have tried every variation of  settings I can think of. 

Please can anyone help?

Thanks in advance

Alec

[hcid.conf]

#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
#

# HCId options
options {
    # Automatically initialize new devices
    autoinit yes;

    # Security Manager mode
    #   none - Security manager disabled
    #   auto - Use local PIN for incoming connections
    #   user - Always ask user for a PIN

    security auto;  ## /etc/bluetooth/pin
    #security user; ## calls helper application


    # Pairing mode
    #   none  - Pairing disabled
    #   multi - Allow pairing with already paired devices
    #   once  - Pair once and deny successive attempts
    pairing multi;

    # PIN helper
    # pin_helper /bin/bluepin;
     pin_helper /etc/bluetooth/feed-pin.sh;

    # D-Bus PIN helper
    # dbus_pin_helper;
}

# Default settings for HCI devices
device {
    # Local device name
    #   %d - device id
    #   %h - host name
    name "%h";
   
    # Local device class
    class 0x820100;

    # Default packet type
    #pkt_type DH1,DM1,HV1;

    # Inquiry and Page scan
    iscan enable;
    pscan enable;

    # Default link mode
    #   none   - no specific policy
    #   accept - always accept incoming connections
    #   master - become master on incoming connections,
    #            deny role switch on outgoing connections
    #
    lm accept,master;

    # Default link policy
    #   none    - no specific policy
    #   rswitch - allow role switch
    #   hold    - allow hold mode
    #   sniff   - allow sniff mode
    #   park    - allow park mode
    #
    lp rswitch,hold,sniff,park;

    # Authentication and Encryption
    auth enable;
    encrypt enable;
}


______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
