Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050131134152.20060.qmail@web60903.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] rfcomm question 1
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107007411.10735.16.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
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
Date: Mon, 31 Jan 2005 21:41:52 +0800 (CST)

Hi Marcel,
    Here is the content of /etc/bluetooth/hcid.conf
#
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
        pin_helper /usr/bin/bluepin;
 
        # D-Bus PIN helper
        #dbus_pin_helper;
}
 
# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        #name "BlueZ (%d)";
        name "cm218-253-8-120.hkcable.com.hk:%d"
        # Local device class
        class 0x3e0100;
 
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
        #auth enable;
        #encrypt enable;
}
How can I modify the Security Mode?
Also, how can I change the PIN of my Linux PC? 
Thank you very much.
Michael

 --- Marcel Holtmann <marcel@holtmann.org> 內容：
> Hi Michael,
> 
> >     Of course, hcid is running. Then when I typed
> > "hcidump -x", and then choose the computer in
> mobile
> > phone, after I entered the PIN, the following
> occurs:
> > [root@cm218-253-8-120 root]# hcidump -x
> > HCIDump - HCI packet analyzer ver 1.16
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > > HCI Event: Connect Request (0x04) plen 10
> >   A8 D8 DD D9 0A 00 04 02 52 01
> > < HCI Command: Accept Connection Request
> (0x01|0x0009)
> > plen 7
> >   A8 D8 DD D9 0A 00 01
> > > HCI Event: Command Status (0x0f) plen 4
> >   00 01 09 04
> > > HCI Event: PIN Code Request (0x16) plen 6
> >   A8 D8 DD D9 0A 00
> > < HCI Command: PIN Code Request Reply
> (0x01|0x000d)
> > plen 23
> >   A8 D8 DD D9 0A 00 05 42 6C 75 65 5A 00 00 00 00
> 00
> > 00 00 00
> >   00 00 00
> > > HCI Event: Command Complete (0x0e) plen 10
> >   01 0D 04 00 A8 D8 DD D9 0A 00
> > > HCI Event: Connect Complete (0x03) plen 11
> >   05 29 00 A8 D8 DD D9 0A 00 01 00
> > But the mobile shows "PIN not match". So how can I
> do?
> 
> run "hcidump -X" and you might see your PIN. I guess
> it is "BlueZ" and
> why are you using security mode 3?
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
> This SF.Net email is sponsored by: IntelliVIEW --
> Interactive Reporting
> Tool for open source databases. Create drag-&-drop
> reports. Save time
> by over 75%! Publish reports on the web. Export to
> DOC, XLS, RTF, etc.
> Download a FREE copy at
> http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
>  

_______________________________________________________________________
新年願望第一位 : 找到友緣人
http://personals.yahoo.com.hk


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
