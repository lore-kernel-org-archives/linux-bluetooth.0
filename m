Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Benjamin Eikel <benjamin@eikel.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200602022157.52386.benjamin@eikel.org>
Subject: [Bluez-users] Pairing a bluetooth keyboard
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
Date: Thu, 2 Feb 2006 21:57:51 +0100

Hello!

I am trying to pair a Bluetooth keyboard (Logitech Cordless Elite Keyboard for 
Bluetooth, address XX:XX:XX:XX:XX:XX in the following text) with my laptop 
(Bluetooth USB adapter: Belkin F8T008, , address ZZ:ZZ:ZZ:ZZ:ZZ:ZZ in the 
following text) for some time now. 

I am using a Bluetooth mouse (Logitech MX900, address YY:YY:YY:YY:YY:YY in the 
following text) too. I am running Debian GNU/Linux unstable, self-compiled 
Linux kernel 2.6.15.2, bluez-utils package 2.24-1.

My config file '/etc/bluetooth/hcid.conf':
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

        # PIN helper
        #pin_helper /usr/bin/bluez-pin;
        pin_helper /usr/lib/kdebluetooth/kbluepin;

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
        lm accept;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        lp rswitch,hold,sniff,park;

        # Authentication and Encryption (Security Mode 3)
        #auth enable;
        #encrypt enable;
}

What I am doing:

1. I press the "connect" button on the bottom of the keyboard.

2. I run 'hidd --connect XX:XX:XX:XX:XX:XX'.
Output in '/var/log/syslog':
Feb  2 21:21:37 host hidd: New HID device XX:XX:XX:XX:XX:XX (Logitech 
Bluetooth Keyboard)
Feb  2 21:21:37 host kernel: input: Bluetooth HID Boot Protocol Device 
as /class/input/input9

3. I run 'hcitool con'.
Output:
Connections:
        < ACL XX:XX:XX:XX:XX:XX handle 7 state 1 lm MASTER
        > ACL YY:YY:YY:YY:YY:YY handle 6 state 1 lm MASTER

I can use the keyboard now. Everything works.

4. I run 'hcitool auth XX:XX:XX:XX:XX:XX'.
Output:
0000
HCI authentication request failed: Connection timed out

When I enter this command my pinhelper kbluepin shows up and I enter the pin 
0000. I enter the same pin on the keyboard. But as you can see at the output 
above the pin is not used in the correct way but send as keyboard input to 
the laptop. Somehow the keyboard seems not be in pin entry mode.



So I change my approach. I remove the comment in the last lines of my 
'/etc/bluetooth/hcid.conf' so that I have:
auth enable;
encrypt enable;

Then I run '/etc/init.d/bluetooth restart'.
Output: Restarting bluetooth: hidd hcid sdpd hidd rfcomm.

When I enter something on the Bluetooth keyboard now, kbluepin shows up again 
and I enter the same pin on my laptop keyboard and the bluetooth keyboard (I 
tried the normal numeric keys and the keypad). But this does not work 
somehow.
Output from '/var/log/syslog':
Feb  2 21:42:30 belt hcid[9127]: link_key_request (sba=ZZ:ZZ:ZZ:ZZ:ZZ:ZZ, 
dba=XX:XX:XX:XX:XX:XX)
Feb  2 21:42:30 belt hcid[9127]: pin_code_request (sba=ZZ:ZZ:ZZ:ZZ:ZZ:ZZ, 
dba=XX:XX:XX:XX:XX:XX)

Of course the mouse is not working too, because I get the pin entry window 
every time I move it. I already tried another pin helpers, i.e. a script 
which echoes 'PIN:pin'.


What am I doing wrong? Can you please give me some hints? If you need more 
data, please tell me.

Regards,
Benjamin Eikel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
