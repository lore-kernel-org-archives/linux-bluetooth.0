Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Bearcat M. Sandor" <Linux@feline-soul.com>
To: Brad Midgley <bmidgley@xmission.com>
Date: Sun, 10 Sep 2006 21:56:16 -0600
References: <200609101824.25866.Linux@feline-soul.com>
	<4504D825.2020109@xmission.com>
In-Reply-To: <4504D825.2020109@xmission.com>
MIME-Version: 1.0
Message-Id: <200609102156.16680.Linux@feline-soul.com>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth headset: Fuction not Implemented?
Reply-To: Linux@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

Thanks Brad. 
If i just turn on the headset and do a "sdptool browse 00:0D:44:4F:37:72"  i 
get "Failed to connect to SDP server on 00:0D:44:4F:37:72: Connection timed 
out".  If i put the headset in pairing mode and do the same thing, i 
get "Failed to connect to SDP server on 00:0D:44:4F:37:72: Function not 
implemented"

I am using the logitech hub/mouse recharger that came with my Logitech 
Cordless Elite keyboard/mouse (the mouse works fine, the keyboard can not be 
found).

I have tried a "rfcomm listen 0 1" and a "rfcomm connect 0 00:0D:44:4F:37:72" 
with similar results to the btsco command.

I don't think the issue is a pin not being received, as hcidump seems to 
indicate that it is accepted.

Thanks for the help. I don't know if trying a different hub would help or what 
kind to try. 
hciconfig -a
hci0:   Type: USB
        BD Address: 00:07:61:1C:9F:D3 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:84009076 acl:6000162 sco:0 events:21403 errors:0
        TX bytes:47745 acl:892 sco:0 commands:3909 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP Subver: 0x34e
        Manufacturer: Cambridge Silicon Radio (10)

hcid.conf:
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
        #passkey "0000";
     #pin_helper /etc/bluetooth/pin_script;
        pin_helper /usr/lib/kdebluetooth/kbluepin;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "BlueZ (%d)";

        # Local device class
        #class 0x3e0100;
     class 0x120104;

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
        auth disable;
        encrypt disable;
}



                                               



On Sunday 10 September 2006 21:29 in an email titled "Re: [Bluez-users] 
bluetooth headset: Fuction not Implemented?" Brad Midgley wrote:
>Bearcat
>
>we all get frustrated with this stuff from time to time. too bad you
>haven't made progress... fwiw, I haven't seen anyone report success with
>the traveler model so it may be doing something wacky.
>
>> I have the pin code being processed now.  When i try to connect it i see
>> the following:
>> btsco 00:0D:44:4F:37:72
>> Error: Failed to connect to SDP server: Function not implemented
>> Assuming channel 2
>
>if you can't run
>
>sdptool browse 00:0D:44:4F:37:72
>
>and get a list of services then you have a problem that is more
>fundamental than just audio. (that is equivalent to what btsco is trying
>to do when it prints the sdp error.)
>
>what distro is it again? and what is in /etc/bluetooth/hcid.conf?
>
>(btw, have you fiddled with setting your pin helper or the pin in
>/etc/bluetooth/pin?)
>
>brad

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
Jabber: bearcat@jabber.feline-soul.net
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
