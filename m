Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200310271958.55594.cijoml@volny.cz>
Subject: [Bluez-users] MS keyboard and mouse problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 27 Oct 2003 19:58:55 +0100

Hi,

today I bought in Germany - hi Marcel :) Microsoft wireless Opticcal desktop 
for bluetooth, but I can't connect it... :(

tata:/home/cijoml# hcitool scan
Scanning ...
        00:50:F2:7F:3A:4C       Microsoft Mouse
        00:50:F2:80:73:92       Microsoft Keyboard
        00:A0:96:1F:B0:0C       Linux

Mouse:
tata:/home/cijoml# hcitool info 00:50:F2:7F:3A:4C
Requesting information ...
Can't create connection: Input/output error

tata:/home/cijoml# hcidump
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: PIN Code Request(0x16) plen 6
< HCI Command: PIN Code Request Negative Reply(0x01|0x000e) plen 6
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: Connect Complete(0x03) plen 11

Keyboard:
tata:/home/cijoml# hcidump
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Link Key Request(0x17) plen 6
< HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: PIN Code Request(0x16) plen 6
< HCI Command: PIN Code Request Negative Reply(0x01|0x000e) plen 6
> HCI Event: Command Complete(0x0e) plen 10
> HCI Event: Connect Complete(0x03) plen 11

tata:/home/cijoml# hcitool info 00:50:F2:80:73:92
Requesting information ...
Can't create connection: Input/output error

Config files:
hcid:
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
        pin_helper /bin/bluepin;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        #name "BlueZ (%d)";
        name "Linux";

        # Local device class
        #class 0x10c;
        class 0x100100;

        # Default packet type
        pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy
        #   accept - always accept incoming connections
        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections
        #
        #lm accept,master;
        #
        lm accept,master;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        #
        #lp hold,sniff;
        #
        lp hold,sniff,park,rswitch;

        # Authentication and Encryption
        auth enable;
        encrypt enable;
}
----

My opinion - bad pairing key - but I never found it - in box there it was'nt 
and Windows tools I can't use because of another language version of  WinXP.

Thanks a lot for reply - pairing key

Michal



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
