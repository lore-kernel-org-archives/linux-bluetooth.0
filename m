Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: David Zhu <saki96@yahoo.com>
Cc: Bluez Users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] newbie fedora2 & bluez questions
Message-Id: <20040903094817.58415d1c.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <20040903062825.78019.qmail@web11608.mail.yahoo.com>
References: <20040902125858.43f875b4.Andreas.Gaufer@blue-cell-networks.com>
	<20040903062825.78019.qmail@web11608.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 3 Sep 2004 09:48:17 +0200

Hi David,

As Marcel often wrote in this List:

>Date: Tue, 04 May 2004 18:02:50 +0200
>From: Marcel Holtmann <marcel@holtmann.org>
>To: Riku Voipio <riku.voipio@iki.fi>
>Subject: Re: [Bluez-users] Pairing problems(?)
>
>>         auth enable;
>>         encrypt enable;

>this is security mode 3. Don't do it unless you really want it and
knows>what this implies.

security mode 3 means that your host does almost nothing without 
authentcation. I guess your mobile does not like this in case of the 
sdp-browse (witch is totaly ok).

There is no security problem in this, you can still step up to a
authenticated and encrypted connection if one of the peers requests it.

Greetings

Andy



On Thu, 2 Sep 2004 23:28:25 -0700 (PDT)
David Zhu <saki96@yahoo.com> wrote:

> Hi Andy,
> 
> I did some tweaking to the hcid.conf file after I sent
> out the email and I seem to have it working now.  I
> basically commented out these two lines:
> 
> # Authentication and Encryption
> #auth enable;
> #encrypt enable;
> 
> Is it bad for me to do that?  Am I openning myself up
> to serious security vulnerabilities?
> 
> Thanks!
> David
> 
> --- Andreas Gaufer
> <Andreas.Gaufer@blue-cell-networks.com> wrote:
> 
> > Hi David,
> > 
> > please do "hcidump -w hci.dump" as root while
> > browsing
> > and send us the hci.dump file.
> > 
> > Greetings
> > 
> > Andy
> > 
> > On Wed, 1 Sep 2004 11:33:11 -0700 (PDT)
> > David Zhu <saki96@yahoo.com> wrote:
> > 
> > > Hi All,
> > > 
> > > I tried following the many howto guides on the web
> > but
> > > I always seem to have problems after a certain
> > step. 
> > > So I hope I'm not offending anyone with what may
> > be a
> > > really simple issue.  Here we go...
> > > 
> > > I have a DLink DBT-120 Rev 4 USB Bluetooth
> > adapter,
> > > which I have confirmed is supported on the
> > hardware
> > > page.
> > > 
> > > I've installed the necessary packages from the
> > fedora
> > > core 2:
> > > 
> > > bluez-libs-2.5-2.1
> > > bluez-utils-2.4-3
> > > gnome-bluetooth-0.4.1-7
> > > bluez-sdp-1.5-2.1
> > > 
> > > I'm running kernel 2.6.8
> > > 
> > > so when I do a "hcitool scan" I am able to find:
> > > 00:02:EE:E0:2A:E6       Nokia 6820
> > > 
> > > but when I do a "sdptool browse" I always get 
> > > Inquiring ...
> > > Failed to connect to SDP server on
> > 00:02:EE:E0:2A:E6:
> > > Function not implemented
> > > 
> > > Now I have a ThinkPad T30 which also has
> > bluetooth,
> > > and again the same thing happens.  But if I try to
> > > browse for bluetooth services from the thinkpad, I
> > get
> > > the PIN request, which I enter what I found in
> > > /et/bluetooth/pin.  So after the two devices are
> > > paired, now when I run sdptool browse I can see
> > the
> > > services offered by the thinkpad but still not the
> > > nokia.  
> > > 
> > > Does it seem weird that I have to pair before I
> > can
> > > browse for services?  Or is something else
> > > fundamentally wrong?  The other thing is I can't
> > use
> > > the nokia to browse so I can't get it paired with
> > the
> > > Dlink bluetooth adapter.  Please help!
> > > 
> > > Below is my hcid.conf file:
> > > 
> > > #
> > > # HCI daemon configuration file.
> > > #
> > > # $Id: hcid.conf,v 1.3 2002/07/18 18:12:46 maxk
> > Exp $
> > > #
> > > 
> > > # HCId options
> > > options {
> > >         # Automatically initialize new devices
> > >         autoinit yes;
> > > 
> > >         # Security Manager mode
> > >         #   none - Security manager disabled
> > >         #   auto - Use local PIN for incoming
> > > connections
> > >         #   user - Always ask user for a PIN
> > >         #
> > >         security auto;
> > > 
> > >         # Pairing mode
> > >         #   none  - Pairing disabled
> > >         #   multi - Allow pairing with already
> > paired
> > > devices
> > >         #   once  - Pair once and deny successive
> > > attempts
> > >         pairing multi;
> > > 
> > >         # PIN helper
> > >         pin_helper /usr/bin/bluepin;
> > >         #dbus_pin_helper;
> > > 
> > >         # A dbus PIN daemon can be found at
> > >         #
> > >
> >
> ftp://ftp.handhelds.org/pub/projects/gpe/source/bluez-pin-0.20.tar.gz
> > > }
> > > 
> > > # Default settings for HCI devices
> > > device {
> > >         # Local device name
> > >         #   %d - device id
> > >         #   %h - host name
> > >         name "%h-%d";
> > > 
> > >         # Local device class
> > >         class 0x120104;
> > > 
> > >         # Default packet type
> > >         #pkt_type DH1,DM1,HV1;
> > > 
> > >         # Inquiry and Page scan
> > >         iscan enable; pscan enable;
> > > 
> > >         # Default link mode
> > >         #   none   - no specific policy 
> > >         #   accept - always accept incoming
> > > connections
> > >         #   master - become master on incoming
> > > connections,
> > >         #            deny role switch on outgoing
> > > connections
> > >         #
> > >         #lm accept,master;
> > >         #
> > >         lm accept;
> > > 
> > >         # Default link policy
> > >         #   none    - no specific policy
> > >         #   rswitch - allow role switch
> > >         #   hold    - allow hold mode
> > >         #   sniff   - allow sniff mode
> > >         #   park    - allow park mode
> > >         #
> > >         #lp hold,sniff;
> > >         #
> > >         lp hold,sniff,park;
> > > 
> > >         # Authentication and Encryption
> > >         auth enable;
> > >         encrypt enable;
> > > }
> > > 
> > > 
> > > Thanks in advance!
> > > David
> > > 
> > > 
> > > 		
> > > _______________________________
> > > Do you Yahoo!?
> > > Win 1 of 4,000 free domain names from Yahoo! Enter
> > now.
> > > http://promotions.yahoo.com/goldrush
> > > 
> > > 
> > >
> >
> -------------------------------------------------------
> > > This SF.Net email is sponsored by BEA Weblogic
> > Workshop
> > > FREE Java Enterprise J2EE developer tools!
> > > Get your free copy of BEA WebLogic Workshop 8.1
> > today.
> > >
> >
> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
> > > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > >
> >
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> > 
> > 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 


-- 
Blue Cell Networks GmbH
Industriestraße 1b
96163 Gundelsheim

Tel.: 0951-700 42 891 | Fax.: 0951-700 42 887

Diese Email sowie sämtliche mit ihr übertragenen Dateien enthalten
vertrauliche und/oder rechtlich geschützte Informationen, welche
lediglich für den/die Adressaten bestimmt sind. Sollten Sie nicht der
vorgesehene Empfänger sein, ist Ihnen der Gebrauch, die Verbreitung oder
Vervielfältigung der darin enthaltenen Informationen nicht gestattet.
Sollten Sie nicht der vorgesehene Empfänger sein, benachrichtigen Sie
den Absender bitte umgehend per Email und vernichten Sie die
Originalnachricht einschließlich etwaiger Kopien und angehängter
Dateien. Vielen Dank.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
