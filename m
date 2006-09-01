Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 01 Sep 2006 10:52:01 -0700
From: David Armour <d.f.armour@shaw.ca>
In-reply-to: <mailman.47971.1157055066.29847.bluez-users@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net, redondos <redondos@gmail.com>
Message-id: <44F87341.1000501@shaw.ca>
MIME-version: 1.0
References: <mailman.47971.1157055066.29847.bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bash: syntax error near unexpected token `newline'
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

hello redondos

thank you for your help!
> > hello Paulo	<snip>
>   
> > now, running:
> > 
> >  >> sudo hcitools auth 00:03:89:53:EC:7F   ## gives:
> >  >> sudo: hcitools: command not found      ## !
> > 
>   
> The program is called 'hcitool' and is probably located in /usr/bin.
> (Please note that you are referring to it as 'hcitools', with a tailing
> 's')
>   
D'oh! talk about an object lesson in failing to see something that's 
right in front of me!
i cut'n'pasted the line but i have NO idea how the 's' got there.

*now* running:

 >> sudo hcitool auth 00:03:89:53:EC:7F    ## gives:
 >> Not connected.                                       ## ???

some of the stuff i've since tried, from:
http://www.think-future.de/wiki/index.php?title=Bluetooth#Connection_Establishing

the someone flailing around impression accurately reflects my current 
'understanding.'
i'm not clear, obviously, which 'address' (MAC or bd_addr) i'm supposed 
to use.

 >> hciconfig
 >> hci0:   Type: USB
        BD Address: 00:0C:76:47:81:CC ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1094 acl:0 sco:0 events:67 errors:0
        TX bytes:588 acl:0 sco:0 commands:40 errors:0

 >> hcitool inq
 >> Inquiring ...
 >>       00:03:89:53:EC:7F       clock offset: 0x4791    class: 0x200404

 >> hcitool dev
 >> Devices:
 >>         hci0    00:0C:76:47:81:CC

 >> hcitool cc 00:0C:76:47:81:CC
 >> Device is not available.                           ## ???

 >> hcitool cc 00:03:89:53:EC:7F
 >> Can't create connection: Operation not permitted

 >> sudo hidd --connect 00:0C:76:47:81:CC
 >> Can't get device information: No route to host
 >> sudo hidd --connect 00:03:89:53:EC:7F
 >> Can't get device information: Permission denied

 >> hcidump -X -V                                          ## gives:
 >> bash: hcidump: command not found    
## ??? whereis, which, locate fail to return anything resembling hcidump.

 >> l2ping 00:03:89:53:EC:7F
 >> Can't create socket: Operation not permitted

from the hcid.conf file:
...
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
    #pin_helper /usr/bin/pinwrapper;
    pin_helper /usr/bin/bluepin;

    # D-Bus PIN helper
    #dbus_pin_helper;
}

....

thanks in advance for any additional tips, clues, recommendations.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
