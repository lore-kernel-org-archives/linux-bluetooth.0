Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051220100816.22612.qmail@web36115.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource temporarily unavailable
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1134999576.31688.10.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Tue, 20 Dec 2005 02:08:16 -0800 (PST)

Hello Marcel,
Few of the information requested by you as well as
some of the things which  i thought might be helpful
for debugging.

==============================================================
hcid daemon is running on my system. 

[root@localhost /]# /etc/init.d/bluetooth status
hcid (pid 2794) is running...
sdpd (pid 2798) is running...
==============================================================
[root@localhost /]# btsco 00:08:C6:3E:54:2C -v -r
btsco v0.4c
Device is 1:0
Error: Failed to connect to SDP server: Function not
implemented
Assuming channel 2
Voice setting: 0x0060
Can't connect RFCOMM channel: Resource temporarily
unavailable

What does it mean when it says "Function not
implemented" ?
==============================================================

[root@localhost /]# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:08:C6:3E:54:2C
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 41 bdaddr 00:08:C6:3E:54:2C
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:08:C6:3E:54:2C
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 42 bdaddr 00:08:C6:3E:54:2C
type ACL encrypt 0x00
    Error: LMP Response Timeout
==============================================================

/var/log/message has this info when i executed the “
btsco 00:08:C6:3E:54:2C -v -r “
Dec 20 17:29:18 localhost hcid[3144]: Bluetooth HCI
daemon
Dec 20 17:29:18 localhost hcid[3144]: Starting
security manager 0
Dec 20 17:29:18 localhost sdpd[3148]: sdpd v1.5
started
==============================================================

I think my adapter supports Audio transfer, based on
the below information.  Am i correct ?
[root@localhost /]# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:10:60:A5:A7:61 ACL MTU: 192:8
SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI
==============================================================

[root@localhost /]# sdptool browse
Inquiring ...
Failed to connect to SDP server on 00:08:C6:3E:54:2C:
Function not implemented

....”i am able to browse the other devices for the
services offered by them. But for Headset i get the
above message”.
==============================================================

my /etc/bluetooth/hcid.conf has the below information
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann
Exp $
#

# HCId options
options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming
connections
        #   user - Always ask user for a PIN
        #
        security auto;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired
devices
        #   once  - Pair once and deny successive
attempts
        pairing multi;

        # PIN helper
        pin_helper /etc/bluetooth/feed-pin.sh;

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
        class 0x120104;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy
        #   accept - always accept incoming
connections
        #   master - become master on incoming
connections,
        #            deny role switch on outgoing
connections
        lm accept;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        lp rswitch,hold,sniff,park;

        # Authentication and Encryption (Security Mode
3)
        #auth disable;
        #encrypt disable;
        # auth enable;
         #encrypt enable;
}

=====================================================================
my /etc/bluetooth/feed-in.sh has the below info
#!/bin/sh
echo "PIN:0000"
======================================================================
Can you pls help me in getting the audio into my
headset.

Warm Regards,
Swathi

--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Swathi,
> 
> > As a root if i type in hcid. It doesn't give any
> > error. This means hcid is running.
> 
> run "ps x" and look for a hcid process.
> 
> > I am unable to find
> > syslog under /var/log directory. I am running
> Fedora
> > core 4. Some of the syslog listed by sylog are as
> > below. Can you pls  help to find which syslog file
> i
> > am supposed to check.
> > 
> > ====================================
> > /etc/logrotate.d/syslog
> > /etc/syslog.conf
> > /etc/sysconfig/syslog
> > /etc/rc.d/init.d/syslog
> > /usr/lib/perl5/5.8.6/syslog.pl
> >
>
/usr/lib/perl5/5.8.6/i386-linux-thread-multi/syslog.ph
> >
>
/usr/lib/perl5/5.8.6/i386-linux-thread-multi/sys/syslog.ph
> > /root/install.log.syslog
> > /var/lock/subsys/syslog
> > /var/log/anaconda.syslog
> > ====================================
> 
> Then it is maybe /var/log/messages.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do
> you grep through log files
> for problems?  Stop!  Download the new AJAX search
> engine that makes
> searching your log files as easy as surfing the 
> web.  DOWNLOAD SPLUNK!
>
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
