Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: John Gruenenfelder <johng@as.arizona.edu>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050724003016.GA27092@as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Trouble with Plantronics M2500 headset
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
Date: Sat, 23 Jul 2005 17:30:16 -0700

Though I've been using Linux for quite a while, I am completely new to
anything bluetooth.  I am trying to make use of a Plantronics M2500 headset in
Linux using the ALSA btsco program.  But my troubles occur well before that
point.  I'm just trying to connect to the headset and scan it.

I'm using the Linksys USBBT100 bluetooth adapter.  This is with Linux 2.6.12
on an AMD64 machine, if that matters.  I'm running the AMD64 port of Debian
using the Debian bluez packages.

The steps I take are:

* /etc/init.d/bluez-utils start
* Plug in bluetooth adapter
* Turn on headset

Then run:

swordfish:~# hcitool scan
Scanning ...

And I get nothing.  If I first put the headset into pairing mode, I see:

swordfish:~# hcitool scan
Scanning ...
        00:03:89:6E:C9:11       M2500 by Plantronics

Then I try to get info about the headset (while still in pairing mode):

swordfish:~# hcitool info 00:03:89:6E:C9:11
Requesting information ...
Can't create connection: Input/output error


What am I doing wrong?  From /var/log/daemon.log where hcid puts its output:

Jul 23 17:05:00 localhost hcid[3503]: HCI dev 0 registered
Jul 23 17:05:00 localhost hcid[3503]: HCI dev 0 up
Jul 23 17:05:00 localhost hcid[3503]: Starting security manager 0
Jul 23 17:06:17 localhost hcid[3503]: link_key_request (sba=00:0C:41:E1:E2:F1,
dba=00:03:89:6E:C9:11)
Jul 23 17:06:21 localhost hcid[3503]: link_key_request (sba=00:0C:41:E1:E2:F1,
dba=00:03:89:6E:C9:11)


I have setup the pin file so as to give the correct PIN of "0000" to the
device.  My hcid.conf files is as follows:

# HCId options
options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        security auto;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # PIN helper
        pin_helper /usr/bin/bluez-pin;

        # D-Bus PIN helper
        #dbus_pin_helper;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "%h-%d";

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
        lm accept,master;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        lp rswitch,hold,sniff,park;

        # Authentication and Encryption (Security Mode 3)
        auth enable;
        encrypt enable;
}


I am quite at a loss.  Other than the I/O error, I see no error messages in
the logs nor any way to make hcid generate more output.  Please advise.


-- 
--John Gruenenfelder    Research Assistant, Steward Observatory, U of Arizona
                        johng@as.arizona.edu
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
