Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050131143018.21479.qmail@web60910.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] rfcomm question 1
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107181340.7902.9.camel@pegasus>
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
Date: Mon, 31 Jan 2005 22:30:18 +0800 (CST)

Hi Marcel,
    The version of my hcidump is 1.16. Is it related?
And how can I correct it as you said the setting is
fine but the hcidump is strange?
Thanks!
Michael

 --- Marcel Holtmann <marcel@holtmann.org> 內容：
> Hi Michael,
> 
> >     Here is the content of
> /etc/bluetooth/hcid.conf
> > #
> > # HCI daemon configuration file.
> > #
> > # $Id: hcid.conf,v 1.7 2004/12/13 14:16:03
> holtmann
> > Exp $
> > #
> >  
> > # HCId options
> > options {
> >         # Automatically initialize new devices
> >         autoinit yes;
> >  
> >         # Security Manager mode
> >         #   none - Security manager disabled
> >         #   auto - Use local PIN for incoming
> > connections
> >         #   user - Always ask user for a PIN
> >         #
> >         security auto;
> >  
> >         # Pairing mode
> >         #   none  - Pairing disabled
> >         #   multi - Allow pairing with already
> paired
> > devices
> >         #   once  - Pair once and deny successive
> > attempts
> >         pairing multi;
> >  
> >         # PIN helper
> >         pin_helper /usr/bin/bluepin;
> >  
> >         # D-Bus PIN helper
> >         #dbus_pin_helper;
> > }
> >  
> > # Default settings for HCI devices
> > device {
> >         # Local device name
> >         #   %d - device id
> >         #   %h - host name
> >         #name "BlueZ (%d)";
> >         name "cm218-253-8-120.hkcable.com.hk:%d"
> >         # Local device class
> >         class 0x3e0100;
> >  
> >         # Default packet type
> >         #pkt_type DH1,DM1,HV1;
> >  
> >         # Inquiry and Page scan
> >         iscan enable; pscan enable;
> >  
> >         # Default link mode
> >         #   none   - no specific policy
> >         #   accept - always accept incoming
> > connections
> >         #   master - become master on incoming
> > connections,
> >         #            deny role switch on outgoing
> > connections
> >         lm accept;
> >  
> >         # Default link policy
> >         #   none    - no specific policy
> >         #   rswitch - allow role switch
> >         #   hold    - allow hold mode
> >         #   sniff   - allow sniff mode
> >         #   park    - allow park mode
> >         lp rswitch,hold,sniff,park;
> >  
> >         # Authentication and Encryption (Security
> Mode
> > 3)
> >         #auth enable;
> >         #encrypt enable;
> > }
> > How can I modify the Security Mode?
> 
> this setting is fine. It is in security mode 1/2,
> but your hcidump was a
> little bit strange, because it looked like security
> mode 3 and normally
> mobile phones are not in that mode.
> 
> > Also, how can I change the PIN of my Linux PC? 
> 
> For incoming connection the PIN is in
> /etc/bluetooth/pin and you need to
> restart hcid after you changed it.
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
